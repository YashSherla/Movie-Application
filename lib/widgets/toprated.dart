import 'package:flutter/material.dart';

class TopRatedMovies extends StatelessWidget {
  final List toprated;
  const TopRatedMovies({super.key, required this.toprated});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Top10 Rated Movies",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return toprated[index]['poster_path'] == null
                  ? const CircularProgressIndicator()
                  : Container(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              height: 240,
                              'https://image.tmdb.org/t/p/w500' +
                                  toprated[index]['poster_path'],
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 120,
                            child: Text(
                              " ${index + 1}. " + toprated[index]['title'] ??
                                  'Loading',
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    );
            },
          ),
        ),
      ],
    );
  }
}
