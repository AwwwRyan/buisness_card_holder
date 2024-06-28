import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class searchbar extends StatefulWidget {
  const searchbar({super.key});

  @override
  State<searchbar> createState() => _searchbarState();
}

class _searchbarState extends State<searchbar> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.05),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search Reminders",
                hintStyle: TextStyle(color: Color(0xffA3A3A3)),
                prefixIcon: Icon(Icons.search, color: Color(0xffA3A3A3)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Color(0xFFE4E9ED)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
