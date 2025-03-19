import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectedButtonNavbar extends StatefulWidget {
  const SelectedButtonNavbar({super.key});

  @override
  State<SelectedButtonNavbar> createState() => _SelectedButtonNavbarState();
}

class _SelectedButtonNavbarState extends State<SelectedButtonNavbar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  List<QueryDocumentSnapshot>data=[];
  getData()async{
    QuerySnapshot querySnapshot= await FirebaseFirestore.instance.collection('notes').get();
    setState(() {
      data=querySnapshot.docs;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Flexible(
      child: Container(
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNavItem(Icons.check_circle, "Finished", 0),
                SizedBox(width: 16,),
                InkWell(
                    onTap: (){

                    },

                    child: _buildNavItem(Icons.delete, "Delete", 1),
                ),
              ],
            ),
          ],
        ),
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
