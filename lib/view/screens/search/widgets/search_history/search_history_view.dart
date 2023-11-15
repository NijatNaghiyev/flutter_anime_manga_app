import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/view/screens/search/widgets/custom_app_bar_bottom.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/models/search_history/history_model.dart';
import '../../../../../data/services/firestore_database/search_history_store.dart';
import '../../../../../features/state/bloc/search-screen/search/data_search_bloc.dart';
import '../../../../../features/state/cubit/search_lists/search_lists_cubit.dart';

class SearchHistoryView extends StatefulWidget {
  const SearchHistoryView({super.key, required this.searchEditingController});

  final TextEditingController searchEditingController;

  @override
  State<SearchHistoryView> createState() => _SearchHistoryViewState();
}

class _SearchHistoryViewState extends State<SearchHistoryView> {
  ValueNotifier<List<SearchHistoryModel>> historyList = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    SearchHistoryStore.getHistory().then((value) {
      value.sort((a, b) => b.time.compareTo(a.time));
      return historyList.value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              historyList.value = [];
              await SearchHistoryStore.clearHistory();
            },
            child: Text(
              'Clear history',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodySmall!.color,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        ValueListenableBuilder(
            valueListenable: historyList,
            builder: (context, value, _) {
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      splashColor: Colors.grey,
                      onTap: () {
                        /// SearchEditingController
                        widget.searchEditingController.text =
                            value[index].history;

                        /// DataSearchSearchEvent
                        context.read<SearchBloc>().page = 1;
                        context.read<SearchListsCubit>().clearLists();
                        context.read<SearchBloc>().add(
                              DataSearchSearchEvent(
                                query: value[index].history.trim(),
                                searchType: searchTypeValueNotifier.value,
                              ),
                            );

                        /// Save to FireStore
                        SearchHistoryStore.saveHistory(
                          history: value[index].history,
                        );
                      },
                      leading: Icon(
                        Icons.history,
                        color: Theme.of(context).textTheme.bodySmall!.color,
                      ),
                      title: Text(value[index].history,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodySmall!.color,
                          )),
                    );
                  },
                ),
              );
            }),
      ],
    );
  }
}
