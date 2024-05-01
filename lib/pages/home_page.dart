import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_application/widgets/toprated.dart';
import 'package:movie_application/widgets/trending.dart';
import 'package:movie_application/widgets/tv.dart';
import 'package:tmdb_api/tmdb_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List trendinglist = [];
  List topratedlist = [];
  List tvlist = [];
  final String apikey = '5657850b09ada5ef759eb60270da0f36';
  final String apiToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1NjU3ODUwYjA5YWRhNWVmNzU5ZWI2MDI3MGRhMGYzNiIsInN1YiI6IjY2MzBmNWVjNTU0NWNhMDEyZDQzYjZmNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.0Bh0S9UReMSNx-oGP4XidZ2NN7ELkptkYllCedSabDs';

  // trendingMovie() async {
  //   final url = Uri.parse('https://api.themoviedb.org/3/trending/movie/day');
  //   final response = await http
  //       .get(url, headers: {'Authorization': 'Bearer $apiToken'}).then((value) {
  //     if (value.statusCode == 200) {
  //       Map result = jsonDecode(value.body);
  //       setState(() {
  //         trending = result['results'];
  //         log(trending[0].toString());
  //       });
  //     }
  //   });
  // }

  fetchdataformtdmbapi() async {
    TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apikey, apiToken),
        logConfig: const ConfigLogger(
          showLogs: true,
          showErrorLogs: true,
        ));
    Map trending = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map toprated = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map tv = await tmdbWithCustomLogs.v3.tv.getPopular();

    setState(() {
      trendinglist = trending['results'];
      topratedlist = toprated['results'];
      tvlist = tv['results'];
    });
    log("This image path is " + tvlist[0]['backdrop_path'].toString());
    log(tvlist.length.toString());
  }

  @override
  void initState() {
    super.initState();
    // trendingMovie();
    fetchdataformtdmbapi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Movie App ❤️'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TV(tv: tvlist),
                TrendingMovies(trending: trendinglist),
                TopRatedMovies(toprated: topratedlist),
              ],
            ),
          ),
        ));
  }
}
