import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/presentations/screens/search_screen.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_style.dart';
import '../widgets/movie_carousel.dart';
import '../widgets/movie_gride.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies', style: TextStyles.titleStyle),
        backgroundColor: AppColors.primaryColor,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: AppColors.whiteColor),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search Movies...',
                  hintStyle: TextStyles.searchHintStyle,
                  prefixIcon:
                      const Icon(Icons.search, color: AppColors.greyColor),
                  filled: true,
                  fillColor: AppColors.whiteColor.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                onTap: () {
                  Get.to(() => const SearchScreen());
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Popular Movies', style: TextStyles.titleStyle),
            ),
            const SizedBox(height: 16),
            MovieCarousel(),
            MovieGrid(),
          ],
        ),
      ),
    );
  }
}
