import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';

class LoopingCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 2.0,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            initialPage: 1,
            autoPlay: true,
          ),
          items: [
            GestureDetector(
              onTap: () {
                Get.toNamed('/results', arguments: {
                  'category': null,
                  'lowestPrice': null,
                  'highestPrice': null,
                  'searchTerm': '100-10',
                });
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: double.infinity,
                  child: FadeInImage.memoryNetwork(
                      fit: BoxFit.cover,
                      placeholder: kTransparentImage,
                      image: 'https://i.imgur.com/xcLrJUx.jpg'
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed('/results', arguments: {
                  'category': null,
                  'lowestPrice': null,
                  'highestPrice': null,
                  'searchTerm': '600-1',
                });
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14.0),
                child: Container(
                  width: double.infinity,
                  child: FadeInImage.memoryNetwork(
                      fit: BoxFit.cover,
                      placeholder: kTransparentImage,
                      image: 'https://i.imgur.com/Qh5Ypwz.png'
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}