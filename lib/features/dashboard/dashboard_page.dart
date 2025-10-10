import 'package:finely_app/core/helpers/bottom_navigation_items.dart';
import 'package:finely_app/core/helpers/snackbar_helper.dart';
import 'package:finely_app/core/utility/curve_container.dart';
import 'package:finely_app/features/greeting/widget/GreetingHeader.dart';
import 'package:finely_app/features/spending_dashboard/presentation/widget/spending_category.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/constant.dart';
import '../../core/helpers/location_helper.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String _location = 'Unknown';
  bool _loading = false;

  int _currentIndex = 2; // Spending tab active (index 2)
  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  void _getLocation() async {
    setState(() => _loading = true);
    try {
      final city = await LocationHelper.getCityName();
      setState(() => _location = city);
    } catch (exception) {
      setState(() => _location = exception.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  Widget _topAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          Expanded(child: SizedBox()),
          Text(''),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.copy, color: Colors.grey[800]),
          onPressed: () {
            SnackBarHelper.show(
              context,
              'Clicked on Copy Icon',
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.share, color: Colors.grey[800]),
          onPressed: () {
            SnackBarHelper.show(
              context,
              'Clicked on Share Icon',
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.lock, color: Colors.grey[800]),
          onPressed: () {
            SnackBarHelper.show(
              context,
              'Clicked on Lock Icon',
            );
          },
        ),
      ],
    );
  }

  _bottomNavigation() {
    var navList = BottomNavItem.navItems;
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (i) {
        if (i == 2) {
          setState(() => _currentIndex = 2);
        } else {
          SnackBarHelper.show(
            context,
            'Placeholder for tab ${navList[i].label}',
          );
        }
      },
      items: navList
          .map(
            (item) =>
            BottomNavigationBarItem(
              icon: Icon(item.icon),
              label: item.label,
        ),
      ).toList(),
      selectedItemColor: Color(0xFF00C853),
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: _topAppBar(),
      ),
      bottomNavigationBar: _bottomNavigation(),
      body: ListView(
        children: [
          greetingHeader(context),
          _locationInsight(),
          spendingByCategory()
        ],
      ),
    );
  }

  Widget _locationInsight() {
    return CurvedWhiteContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Icon(Icons.location_on, color: Colors.grey[700]),
            const SizedBox(width: 8),

            Expanded(
              child: _loading
                  ? Row(
                      children: const [
                        SizedBox(
                          width: 12,
                          height: 12,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        SizedBox(width: 8),
                        Text('Getting location...'),
                      ],
                    )
                  : Text(
                      _location,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
            ),
            _location == PERMISSION_PERMANENT_DENIED
                ? ElevatedButton(
                    onPressed: () async {
                      await openAppSettings();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      textStyle: const TextStyle(fontSize: 12),
                    ),
                    child: const Text('Open Settings'),
                  )
                : IconButton(
                    onPressed: _getLocation,
                    icon: const Icon(Icons.refresh),
                  ),
          ],
        ),
      ),
    );
  }
}
