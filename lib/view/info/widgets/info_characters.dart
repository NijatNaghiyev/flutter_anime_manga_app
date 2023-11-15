import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/constants/theme/colors.dart';
import 'package:flutter_anime_manga_app/data/models/info/info_character.dart';
import 'package:flutter_anime_manga_app/data/services/info/character.dart';

import '../../../constants/enum/search_type.dart';

class InfoCharacters extends StatefulWidget {
  const InfoCharacters(
      {super.key, required this.searchType, required this.malId});

  final SearchType searchType;
  final int malId;
  @override
  State<InfoCharacters> createState() => _InfoCharactersState();
}

class _InfoCharactersState extends State<InfoCharacters> {
  ValueNotifier<InfoCharacterModel?> infoCharacterValueNotifier =
      ValueNotifier(null);

  Future<void> initCharacter() async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (infoCharacterValueNotifier.value == null) {
      CharacterService.getCharacter(
        malId: widget.malId,
        searchType: widget.searchType,
      ).then((value) {
        return infoCharacterValueNotifier.value = value;
      });
    }

    while (true) {
      log(infoCharacterValueNotifier.value.toString());
      if (infoCharacterValueNotifier.value == null) {
        log('true');

        await Future.delayed(const Duration(milliseconds: 600));

        infoCharacterValueNotifier.value = await CharacterService.getCharacter(
          malId: widget.malId,
          searchType: widget.searchType,
        );
      } else {
        log('Break');
        break;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    initCharacter();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: infoCharacterValueNotifier,
        builder: (context, value, _) {
          final data = value?.data;
          return value == null
              ? const Center(
                  child: CircularProgressIndicator(
                    color: MyColors.primary,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12, top: 16),
                      child: Text(
                        'Characters',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 4),
                      child: SizedBox(
                        height: widget.searchType == SearchType.anime
                            ? MediaQuery.sizeOf(context).height * 0.4
                            : MediaQuery.sizeOf(context).height * 0.2,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: data?.length ?? 0,
                          itemBuilder: (context, index) {
                            final character = data?[index];
                            return Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.2,
                                  width: MediaQuery.sizeOf(context).width * 0.3,
                                  child: Card(
                                    clipBehavior: Clip.hardEdge,
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Image.network(
                                          character!.character!.images!.jpg!
                                                  .imageUrl ??
                                              '',
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return const Center(
                                              child: Icon(Icons.error),
                                            );
                                          },
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.transparent,
                                                Colors.black.withOpacity(0.6),
                                              ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 5,
                                          left: 5,
                                          child: SizedBox(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.3,
                                            child: Text(
                                              character.character!.name ??
                                                  'N/A',
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (widget.searchType == SearchType.anime)
                                  SizedBox(
                                    height:
                                        MediaQuery.sizeOf(context).height * 0.2,
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.3,
                                    child: Card(
                                      clipBehavior: Clip.hardEdge,
                                      child: character.voiceActors!.isEmpty
                                          ? const SizedBox.shrink()
                                          : Stack(
                                              fit: StackFit.expand,
                                              children: [
                                                Image.network(
                                                  character
                                                          .voiceActors!
                                                          .first
                                                          .person!
                                                          .images!
                                                          .jpg!
                                                          .imageUrl ??
                                                      '',
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return const Center(
                                                      child: Icon(Icons.error),
                                                    );
                                                  },
                                                  loadingBuilder: (context,
                                                      child, loadingProgress) {
                                                    if (loadingProgress ==
                                                        null) {
                                                      return child;
                                                    }
                                                    return const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    );
                                                  },
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Colors.transparent,
                                                        Colors.black
                                                            .withOpacity(0.6),
                                                      ],
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 5,
                                                  left: 5,
                                                  child: SizedBox(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.3,
                                                    child: Text(
                                                      character.voiceActors![0]
                                                              .person!.name ??
                                                          'N/A',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
        });
  }
}
