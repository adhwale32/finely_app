import 'package:flutter/material.dart';

Widget greetingHeader() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: SizedBox(
      height: 45,
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Hi, User',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none)),
          CircleAvatar(child: Icon(Icons.person)),
        ],
      ),
    ),
  );
}
