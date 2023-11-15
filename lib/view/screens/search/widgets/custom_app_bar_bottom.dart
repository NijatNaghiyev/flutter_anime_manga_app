import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/extensions/string.dart';
import 'package:flutter_anime_manga_app/view/screens/search/widgets/search_field.dart';
import 'package:flutter_anime_manga_app/view/screens/search/widgets/search_filter_row.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/enum/search_type.dart';
import '../../../../features/state/bloc/search-screen/search/data_search_bloc.dart';

ValueNotifier<SearchType> searchTypeValueNotifier =
    ValueNotifier<SearchType>(SearchType.anime);

class CustomAppBarBottom extends StatefulWidget {
  const CustomAppBarBottom({
    super.key,
    required this.searchEditingController,
    required this.searchFormKey,
  });

  final TextEditingController searchEditingController;
  final GlobalKey<FormState> searchFormKey;

  @override
  State<CustomAppBarBottom> createState() => _CustomAppBarBottomState();
}

class _CustomAppBarBottomState extends State<CustomAppBarBottom> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SearchField(
                searchType: searchTypeValueNotifier,
                searchEditingController: widget.searchEditingController,
                searchFormKey: widget.searchFormKey,
              ),
            ),
            const SizedBox(width: 10),
            ValueListenableBuilder(
              valueListenable: searchTypeValueNotifier,
              builder: (context, type, _) {
                context.read<SearchBloc>().parameterType = 'Default';
                dropDownValue = 'Default';
                context.read<SearchBloc>().orderByType = 'Default';
                dropDownValueOrderBy = 'Default';
                return DropdownButton(
                  iconEnabledColor:
                      Theme.of(context).textTheme.bodySmall!.color,
                  dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                  value: type,
                  onChanged: (value) {
                    searchTypeValueNotifier.value = value!;
                  },
                  items: [
                    DropdownMenuItem(
                      value: SearchType.anime,
                      child: Text(
                        SearchType.anime.name.capitalize(),
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodySmall!.color,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: SearchType.manga,
                      child: Text(
                        SearchType.manga.name.capitalize(),
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodySmall!.color,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: SearchType.characters,
                      child: Text(
                        SearchType.characters.name.capitalize(),
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodySmall!.color,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: SearchType.people,
                      child: Text(
                        SearchType.people.name.capitalize(),
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodySmall!.color,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: SearchType.users,
                      child: Text(
                        SearchType.users.name.capitalize(),
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodySmall!.color,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
