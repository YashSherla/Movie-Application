import 'package:flutter/material.dart';

class TV extends StatelessWidget {
  final List tv;
  const TV({super.key, required this.tv});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Popular TV Shows",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: tv.length,
            itemBuilder: (context, index) {
              return tv[index]['backdrop_path'] == null
                  ? const CircularProgressIndicator()
                  : Container(
                      padding: const EdgeInsets.all(5),
                      width: 250,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              height: 140,
                              'https://image.tmdb.org/t/p/w500' +
                                  tv[index]['backdrop_path'],
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(tv[index]['original_name'] ?? 'Loading')
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
