import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do/features/Add_Note/presentation/Add_Note.dart';

class ButtonNavbar extends StatefulWidget {
  const ButtonNavbar({super.key});

  @override
  State<ButtonNavbar> createState() => _ButtonNavbarState();
}

class _ButtonNavbarState extends State<ButtonNavbar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: MediaQuery.sizeOf(context).height*.1,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(Icons.home, "Home", 0),
              _buildNavItem(Icons.checklist, "Finished", 1),
              SizedBox(width: 56),
              _buildNavItem(Icons.search, "Search", 2),
              _buildNavItem(Icons.settings, "Settings", 3),
            ],
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, AddNote.id);
            },
            backgroundColor: Colors.purple,
            elevation: 2.0,
            shape: CircleBorder(),
            child: Icon(Icons.add, size: 32,color: Colors.white,),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(

        children: [
          Icon(
            icon,
            color: _selectedIndex == index ? Colors.purple : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: _selectedIndex == index ? Colors.purple : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
