import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../constants/theme/colors.dart';

class InfoCarousel extends StatefulWidget {
  const InfoCarousel({super.key, required this.imagesList});

  final List<String> imagesList;

  @override
  State<InfoCarousel> createState() => _InfoCarouselState();
}

class _InfoCarouselState extends State<InfoCarousel> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 16,
        left: 16,
      ),
      height: MediaQuery.sizeOf(context).height * 0.4,
      width: MediaQuery.sizeOf(context).width * 0.55,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).textTheme.bodySmall!.color!,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: CarouselSlider.builder(
              itemCount: widget.imagesList.length,
              options: CarouselOptions(
                aspectRatio: 1.35,
                viewportFraction: 1,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                autoPlay: true,
                clipBehavior: Clip.hardEdge,
                autoPlayAnimationDuration: const Duration(seconds: 2),
                autoPlayInterval: const Duration(seconds: 8),
                onPageChanged: (index, reason) {
                  setState(() {
                    activeIndex = index;
                  });
                },
              ),
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return Image.network(
                  widget.imagesList[index],
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return const Center(
                      child: CircularProgressIndicator(
                        color: MyColors.primary,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            children: [
              AnimatedSmoothIndicator(
                activeIndex: activeIndex,
                count: widget.imagesList.length,
                curve: Curves.bounceInOut,
                effect: ScrollingDotsEffect(
                  maxVisibleDots: 9,
                  spacing: 4,
                  dotHeight: 8,
                  dotWidth: 8,
                  dotColor: Theme.of(context).textTheme.bodySmall!.color!,
                  activeDotColor: MyColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
