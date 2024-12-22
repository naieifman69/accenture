import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<University>> universities;

  @override
  void initState() {
    super.initState();
    universities = fetchUniversities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Universities in Malaysia'),
      ),
      body: FutureBuilder<List<University>>(
        future: universities,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No universities found.'));
          }

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
                  trailing: IconButton(
                    icon: Icon(Icons.link),
                    onPressed: () {
                      if (university.webpages.isNotEmpty) {
                        final url = university.webpages.first;
                        // Open the webpage
                      }
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
