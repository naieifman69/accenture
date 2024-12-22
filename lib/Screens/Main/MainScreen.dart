
import 'package:accenture/Screens/Main/favScreens.dart';
import 'package:accenture/Screens/Main/profileScreen.dart';
import 'package:accenture/Screens/Main/uniScreen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchUniversities();
  }

  Future<void> _fetchUniversities() async {
/*
    String universityApi = ApiService().api_url;
*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          _selectedIndex == 0
              ? 'Universities in Malaysia'
              : _selectedIndex == 1
              ? 'Favorited Universities'
              : 'Profile',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[600],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children:  [
          UniScreen(),
          FavScreen(),
          ProfileScreen()

        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.blue[600],
        unselectedItemColor: Colors.grey[600],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
