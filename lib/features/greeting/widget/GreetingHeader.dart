import 'package:finely_app/core/helpers/snackbar_helper.dart';
import 'package:flutter/material.dart';

Widget greetingHeader(BuildContext context) {
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
          IconButton(onPressed: () {
            SnackBarHelper.show(
              context,
              'Clicked on Notification Icon',
            );
          }, icon: Icon(Icons.notifications_none)),

          CircleAvatar(
              child: IconButton(onPressed: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(
                    SnackBar(content: Text('Clicked on Profile Icon')));
              }, icon: Icon(Icons.person))
          ),
        ],
      ),
    ),
  );
}
