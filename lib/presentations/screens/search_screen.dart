import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_style.dart';
import '../models/movie_models.dart';
import '../services/movie_service.dart';
import '../widgets/movie_search_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Future<MovieModel?>? searchResults;

  void _performSearch(String query) {
    setState(() {
      searchResults = MovieService.searchMovies(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Movies'),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search Movies...',
                hintStyle: TextStyles.searchHintStyle,
                prefixIcon: const Icon(Icons.search, color: AppColors.greyColor),
                filled: true,
                fillColor: AppColors.whiteColor.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: (query) {
                if (query.isNotEmpty) {
                  _performSearch(query);
                }
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<MovieModel?>(
              future: searchResults,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.results.isEmpty) {
                  return const Center(child: Text('No movies found.'));
                }

                List<Result> movies = snapshot.data!.results;

                return ListView.builder(
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    return MovieSearchItem(movie: movies[index]);
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
