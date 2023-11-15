import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_anime_manga_app/constants/theme/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../data/models/anime/anime_full_model.dart';

class InfoYoutubeVideo extends StatefulWidget {
  const InfoYoutubeVideo({
    super.key,
    required this.data,
  });

  final Data data;

  @override
  State<InfoYoutubeVideo> createState() => _InfoYoutubeVideoState();
}

class _InfoYoutubeVideoState extends State<InfoYoutubeVideo> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.data.trailer!.youtubeId.toString(),
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
    if (_controller.value.isFullScreen) {
      _controller.toggleFullScreenMode();
    }
  }

  // @override
  // void deactivate() {
  //   super.deactivate();
  //   _controller.pause();
  // }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        aspectRatio: 16 / 9,
        width: MediaQuery.sizeOf(context).width,
        onReady: () {
          log('ready');
        },
        progressColors: const ProgressBarColors(
          playedColor: MyColors.primary,
          handleColor: MyColors.primary,
          backgroundColor: Colors.grey,
        ),
        onEnded: (data) {
          _controller.pause();
          // SystemChrome.setPreferredOrientations(
          //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
        },
        progressIndicatorColor: MyColors.primary,
        thumbnail: Image.network(
          widget.data.trailer!.images!.maximumImageUrl.toString(),
          fit: BoxFit.cover,
        ),
      ),
      builder: (context, p1) {
        return GestureDetector(
          onTap: () {
            showGeneralDialog(
              barrierDismissible: true,
              useRootNavigator: true,
              barrierLabel: 'Youtube Video',
              barrierColor: Colors.black.withOpacity(0.7),
              context: context,
              pageBuilder: (context, animation, secondaryAnimation) {
                return FittedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (!_controller.value.isFullScreen)
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CloseButton(),
                        ),
                      p1,
                    ],
                  ),
                );
              },
            );
          },
          child: Container(
            margin: const EdgeInsets.all(12),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.sizeOf(context).height * 0.25,
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).textTheme.bodySmall!.color!,
                width: 2,
              ),
            ),
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: [
                Image.network(
                  widget.data.trailer!.images!.maximumImageUrl.toString(),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: SizedBox(),
                    );
                  },
                ),
                const Icon(
                  Icons.play_circle_fill,
                  size: 54,
                  color: MyColors.primary,
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.sizeOf(context).height * 0.04,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 5,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 10,
                  left: 10,
                  child: Text(
                    'Teaser',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
