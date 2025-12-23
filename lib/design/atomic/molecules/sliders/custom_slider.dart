import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({
    super.key,
    required this.sliderItems,
    required CarouselSliderController controller,
    required int current,
    required this.onPageChanged,
  }) : _controller = controller,
       _current = current;

  final List<Widget> sliderItems;
  final CarouselSliderController _controller;
  final int _current;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: _controller,
          options: CarouselOptions(
            viewportFraction: 1.0,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) => onPageChanged(index),
          ),
          itemCount: sliderItems.length,
          itemBuilder: (context, itemIndex, pageViewIndex) =>
              sliderItems[itemIndex],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: sliderItems.asMap().entries.map((entry) {
            final isCurrentSlide = _current == entry.key;

            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: isCurrentSlide ? 14 : 10,
                height: isCurrentSlide ? 14 : 10,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorFoundation.text.saLight.withOpacity(
                    isCurrentSlide ? 1 : 0.6,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
