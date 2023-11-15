import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/drop_down_lists/items_order_by.dart';
import '../../../../constants/drop_down_lists/items_parameters_type.dart';
import '../../../../features/state/bloc/search-screen/search/data_search_bloc.dart';
import '../../../../features/state/cubit/search_lists/search_lists_cubit.dart';
import 'custom_app_bar_bottom.dart';

/// It should be global
String dropDownValue = 'Default';
String dropDownValueOrderBy = 'Default';

class SearchFilterRow extends StatelessWidget {
  const SearchFilterRow({super.key});

  @override
  Widget build(BuildContext context) {
    /// OnChanged for the parameter type
    void dropDownOnChangedParameterType(value) {
      dropDownValue = value.toString();
      context.read<SearchBloc>().parameterType = value.toString();
      if (context.read<SearchBloc>().queryBloc.isEmpty ||
          context.read<SearchBloc>().queryBloc.length < 4) {
        return;
      }
      context.read<SearchBloc>().page = 1;
      context.read<SearchListsCubit>().clearLists();
      context.read<SearchBloc>().add(
            DataSearchSearchEvent(
              query: context.read<SearchBloc>().queryBloc,
              searchType: searchTypeValueNotifier.value,
            ),
          );
    }

    /// OnChanged for the order by
    void dropDownOnChangedOrderBy(value) {
      dropDownValueOrderBy = value.toString();
      context.read<SearchBloc>().orderByType = value.toString();
      if (context.read<SearchBloc>().queryBloc.isEmpty ||
          context.read<SearchBloc>().queryBloc.length < 4) {
        return;
      }
      context.read<SearchBloc>().page = 1;
      context.read<SearchListsCubit>().clearLists();
      context.read<SearchBloc>().add(
            DataSearchSearchEvent(
              query: context.read<SearchBloc>().queryBloc,
              searchType: searchTypeValueNotifier.value,
            ),
          );
    }

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              /// Parameter Type
              ValueListenableBuilder(
                valueListenable: searchTypeValueNotifier,
                builder: (context, type, _) {
                  return DropdownButton(
                    key: UniqueKey(),
                    dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                    value: dropDownValue,
                    items: getDropDownItemsParametersType(type),
                    onChanged: dropDownOnChangedParameterType,
                  );
                },
              ),

              const Spacer(),

              /// Order By
              ValueListenableBuilder(
                  valueListenable: searchTypeValueNotifier,
                  builder: (context, type, _) {
                    return DropdownButton(
                      key: UniqueKey(),
                      value: dropDownValueOrderBy,
                      items: getDropDownItemsOrderBy(type),
                      onChanged: dropDownOnChangedOrderBy,
                    );
                  }),
            ],
          ),
        );
      },
    );
  }
}
