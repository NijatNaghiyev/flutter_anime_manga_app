import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/constants/theme/colors.dart';
import 'package:flutter_anime_manga_app/view/screens/search/widgets/search_filter_row.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';

import '../../../../constants/enum/search_type.dart';
import '../../../../data/services/firestore_database/search_history_store.dart';
import '../../../../features/state/bloc/search-screen/search/data_search_bloc.dart';
import '../../../../features/state/cubit/search_lists/search_lists_cubit.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
    required this.searchType,
    required this.searchEditingController,
    required this.searchFormKey,
  });

  final ValueNotifier<SearchType> searchType;
  final TextEditingController searchEditingController;
  final GlobalKey<FormState> searchFormKey;
  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  void onSave(String? value) {
    if (widget.searchFormKey.currentState!.validate()) {
      context.read<SearchBloc>().page = 1;
      context.read<SearchListsCubit>().clearLists();
      context.read<SearchBloc>().add(
            DataSearchSearchEvent(
              query: value!.trim(),
              searchType: widget.searchType.value,
            ),
          );

      /// Save to FireStore
      if (value.trim().isNotEmpty) {
        SearchHistoryStore.saveHistory(history: value.trim());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.searchFormKey,
      child: TextFormField(
        controller: widget.searchEditingController,
        cursorColor: MyColors.primary,
        maxLines: 1,
        textInputAction: TextInputAction.search,
        enableSuggestions: true,
        textCapitalization: TextCapitalization.none,
        keyboardType: TextInputType.text,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
          hintText: 'Search',
          prefixIcon: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              FocusScope.of(context).unfocus();
              widget.searchFormKey.currentState!.save();
            },
            child: const Icon(Icons.search),
          ),

          /// ValueListenableBuilder is used to show the clear icon when the text field is not empty
          suffixIcon: ValueListenableBuilder(
            valueListenable: widget.searchEditingController,
            builder: (context, value, _) {
              return Visibility(
                visible: value.text.isNotEmpty,
                child: InkWell(
                  onTap: () {
                    context.read<SearchBloc>().add(
                          SearchInitialEvent(),
                        );
                    widget.searchEditingController.clear();
                    dropDownValue = 'Default';
                    dropDownValueOrderBy = 'Default';
                  },
                  child: const Icon(Icons.clear),
                ),
              );
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          errorStyle: const TextStyle(
            fontSize: 0,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty || value.trim().length < 4) {
            showToast(
              'Enter at least 4 characters',
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textPadding: const EdgeInsets.all(16.0),
              backgroundColor: MyColors.primary.withOpacity(0.6),
              position: ToastPosition.center,
              animationCurve: Curves.fastOutSlowIn,
              animationDuration: const Duration(milliseconds: 600),
              duration: const Duration(seconds: 3),
              dismissOtherToast: true,
            );
            return '';
          }
          return null;
        },
        onFieldSubmitted: onSave,
        onSaved: onSave,
        onTap: () => context.read<SearchBloc>().add(SearchHistoryEvent()),
      ),
    );
  }
}
