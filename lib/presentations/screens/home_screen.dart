import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../constants/app_colors.dart';
import '../models/movie_models.dart';
import '../services/api_service.dart';
import '../widgets/movie_grid.dart';
import '../widgets/movie_carousel.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Result>> trendingMoviesFuture;
  late Future<List<Result>> popularMoviesFuture;
  late Future<List<Result>> allMoviesFuture;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    trendingMoviesFuture = ApiService().fetchTrendingMovies();
    popularMoviesFuture = ApiService().fetchPopularMovies();
    allMoviesFuture = ApiService().fetchAllMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 16),
                _buildCarousel(),
                const SizedBox(height: 16),
              ],
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              child: _buildBottomNavBar(),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildMoviesGrid(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      toolbarHeight: 75,
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.primaryColor,
      floating: true,
      pinned: true,
      snap: false,
      title: const Text('Movies App'),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            Get.to(SearchScreen());
          },
        ),
      ],
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      color: AppColors.primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: GNav(
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.grey.shade800,
          padding: const EdgeInsets.all(16.0),
          gap: 8,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          tabs: const [
            GButton(icon: Icons.movie, text: 'All Movies'),
            GButton(icon: Icons.star, text: 'Popular'),
            GButton(icon: Icons.trending_up, text: 'Trending'),
          ],
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    return MovieCarousel(selectedIndex: _selectedIndex);
  }

  Widget _buildMoviesGrid() {
    return MoviesGrid(selectedIndex: _selectedIndex);
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SliverAppBarDelegate({required this.child});

  @override
  double get minExtent => 75.0;
  @override
  double get maxExtent => 75.0;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
