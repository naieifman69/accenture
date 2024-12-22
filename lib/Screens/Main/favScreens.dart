import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Provider/FavouriteProvider.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<FavoritesProvider>(
        builder: (context, favoritesProvider, child) {
          final favorites = favoritesProvider.favorites;

          if (favorites.isEmpty) {
            return Center(
              child: Text('No favorites added.'),
            );
          }

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final favorite = favorites[index];

              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(favorite['name']),
                  subtitle: Text(favorite['domains'].join(', ')),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
