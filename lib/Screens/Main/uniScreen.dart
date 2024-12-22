import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import '../../Provider/FavouriteProvider.dart';




class University {
  final String stateProvince;
  final String alphaTwoCode;
  final String name;
  final List<String> domains;
  final List<String> webpages;
  final String country;

  University({
    required this.stateProvince,
    required this.alphaTwoCode,
    required this.name,
    required this.domains,
    required this.webpages,
    required this.country,
  });

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      stateProvince: json['state-province'] ?? '',
      alphaTwoCode: json['alpha_two_code'],
      name: json['name'],
      domains: List<String>.from(json['domains']),
      webpages: List<String>.from(json['web_pages']),
      country: json['country'],
    );
  }
}

Future<List<University>> fetchUniversities() async {
  final response = await http.get(Uri.parse('http://universities.hipolabs.com/search?country=Malaysia'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((json) => University.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load universities');
  }
}


class UniScreen extends StatefulWidget {
  UniScreen({super.key});

  @override
  State<UniScreen> createState() => _UniScreenState();
}

class _UniScreenState extends State<UniScreen> {
  late Future<List<University>> universities;

  @override
  void initState() {
    super.initState();
    universities = fetchUniversities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<University>>(
        future: universities,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while the data is being fetched
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Show an error message if something goes wrong
            return Center(child: Text('Failed to load universities: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Show a message if the data is empty
            return Center(child: Text('No universities found.'));
          } else {
            // Use the fetched data to display the list
            final universityList = snapshot.data!;
            return ListView.builder(
              itemCount: universityList.length,
              itemBuilder: (context, index) {
                final university = universityList[index];

                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(university.name),
                    subtitle: Text(university.domains.join(', ')),
                    trailing: Consumer<FavoritesProvider>(
                      builder: (context, favoritesProvider, child) {
                        final isFav = favoritesProvider.isFavorite(university.name);

                        return IconButton(
                          icon: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border_outlined,
                            color: isFav ? Colors.red : null,
                          ),
                          onPressed: () {
                            favoritesProvider.toggleFavorite({
                              'name': university.name,
                              'domains': university.domains,
                              'webpages': university.webpages,
                              'country': university.country,
                            });
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
