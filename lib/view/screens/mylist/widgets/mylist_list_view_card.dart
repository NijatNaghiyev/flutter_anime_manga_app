import 'dart:developer';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/edit_list_bottom_sheet/status_anime.dart';
import '../../../../constants/edit_list_bottom_sheet/status_colors.dart';
import '../../../../constants/edit_list_bottom_sheet/status_manga.dart';
import '../../../../constants/enum/search_type.dart';
import '../../../../data/models/mylist/mylist_model.dart';
import '../../../../features/state/bloc/mylist_screen/anime_list/mylist_anime_bloc.dart';
import '../../../../features/state/bloc/mylist_screen/manga_list/mylist_manga_bloc.dart';
import '../../../info/info_screen.dart';
import '../../../widgets/edit_list_bottom_sheet.dart';
import 'mylist_image.dart';

class MylistListViewCard extends StatefulWidget {
  const MylistListViewCard({super.key, required this.data, required this.type});

  final MylistModel data;
  final SearchType type;

  @override
  State<MylistListViewCard> createState() => _MylistListViewCardState();
}

class _MylistListViewCardState extends State<MylistListViewCard> {
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionDuration: const Duration(milliseconds: 500),
      openBuilder: (context, action) {
        return InfoScreen(
          malId: widget.data.malId,
          type: widget.type,
        );
      },
      clipBehavior: Clip.hardEdge,
      closedColor: Colors.transparent,
      closedElevation: 0,
      // * important
      useRootNavigator: true,
      onClosed: (data) {
        SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      },
      closedBuilder: (context, action) => Card(
        clipBehavior: Clip.hardEdge,
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.16,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /// Image
              MylistImage(data: widget.data),
              const SizedBox(width: 10),

              /// Title
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${widget.data.type}, ${widget.data.airingStart}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      minHeight: 10,
                      value: widget.data.episodesOrChapters == null
                          ? 0.5
                          : widget.data.userProgress /
                              widget.data.episodesOrChapters!,
                      backgroundColor: Colors.grey[300],
                      color: StatusColors.statusColors[
                          widget.type == SearchType.anime
                              ? StatusAnime.statusList
                                  .indexOf(widget.data.userStatus!)
                              : StatusManga.statusList
                                  .indexOf(widget.data.userStatus!)],
                    ),
                    Row(
                      children: [
                        if (widget.data.userScore != null)
                          Row(
                            children: [
                              Text(
                                widget.data.userScore.toString(),
                              ),
                              const Icon(
                                Icons.star,
                                size: 14,
                              ),
                            ],
                          ),
                        const Spacer(),
                        Text(
                          '${widget.data.userProgress}/${widget.data.episodesOrChapters ?? '??'} ${widget.type == SearchType.anime ? 'ep' : 'chp'}',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      showEditListBottomSheet(
                        type: widget.type,
                        mylistModel: widget.data,
                        context: context,
                      );
                    },
                    icon: Icon(
                      color: StatusColors.statusColors[
                          widget.type == SearchType.anime
                              ? StatusAnime.statusList
                                  .indexOf(widget.data.userStatus!)
                              : StatusManga.statusList
                                  .indexOf(widget.data.userStatus!)],
                      Icons.edit_note,
                      size: 32,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      if (widget.data.userProgress ==
                          widget.data.episodesOrChapters) {
                        return;
                      }

                      /// Add 1 to userProgress
                      if (widget.type == SearchType.anime) {
                        log('anime add');
                        setState(() {});
                        context.read<MylistAnimeBloc>().add(
                              MylistAnimeAddEvent(mylistModel: widget.data),
                            );
                      } else if (widget.type == SearchType.manga) {
                        log('manga add');

                        context.read<MylistMangaBloc>().add(
                              MylistMangaAddEvent(mylistModel: widget.data),
                            );
                      }
                    },
                    icon: const Icon(
                      Icons.add_box_outlined,
                      size: 32,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
