import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_style.dart';
import '../models/movie_model.dart';
import '../services/api_service.dart';
import 'movie_details_screen.dart';
import 'dart:async';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  List<MovieModel>? movieResults;
  Timer? _debounce;

  void searchMovies(String query) async {
    if (query.isNotEmpty) {
      final formattedQuery = query.trim().toLowerCase();

      if (_debounce?.isActive ?? false) _debounce!.cancel();

      _debounce = Timer(const Duration(milliseconds: 300), () async {
        final results = await ApiService().searchMovies(formattedQuery);
        setState(() {
          movieResults = results;
        });
      });
    } else {
      setState(() {
        movieResults = null;
      });
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: const Text('Search Movies'),
        backgroundColor: AppColors.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              searchMovies(searchController.text);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              style: TextStyles.searchFieldStyle,
              decoration: const InputDecoration(
                hintText: 'Search Movies',
                hintStyle: TextStyle(color: AppColors.greyColor),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                filled: true,
                fillColor: AppColors.textFieldColor,
              ),
              onChanged: (value) => searchMovies(value),
            ),
          ),
          Expanded(
            child: movieResults == null
                ? const Center(
                    child: Text(
                      'Search for movies',
                      style: TextStyles.subtitleStyle,
                    ),
                  )
                : movieResults!.isEmpty
                    ? const Center(
                        child: Text(
                          'No results found',
                          style: TextStyles.subtitleStyle,
                        ),
                      )
                    : ListView.builder(
                        itemCount: movieResults!.length,
                        itemBuilder: (context, index) {
                          final movie = movieResults![index];
                          return ListTile(
                            leading: SizedBox(
                              height: double.infinity,
                              width: 50,
                              child: Image.network(
                                  ApiService().getImageUrl(movie.posterPath)),
                            ),
                            title: Text(
                              movie.title,
                              style: TextStyles.titleStyle,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                              movie.releaseDate
                                  .toLocal()
                                  .toString()
                                  .split(' ')[0],
                              style: TextStyles.subtitleStyle,
                            ),
                            onTap: () {
                              Get.to(MovieDetailsScreen(movie: movie));
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
