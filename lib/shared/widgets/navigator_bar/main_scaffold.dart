import 'package:antifilter_app/shared/themes/app_colors.dart';
import 'package:antifilter_app/shared/widgets/drawer/custom_drawer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class MainScaffold extends StatefulWidget {
  final Widget child;

  const MainScaffold({
    super.key,
    required this.child,
  });

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/history');
        break;
      case 2:
        context.go('/favorites');
        break;
      case 3:
        context.go('/profile');
        break;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateCurrentIndex();
  }

  void _updateCurrentIndex() {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/home')) {
      _currentIndex = 0;
    } else if (location.startsWith('/history')) {
      _currentIndex = 1;
    } else if (location.startsWith('/favorites')) {
      _currentIndex = 2;
    } else if (location.startsWith('/profile')) {
      _currentIndex = 3;
    }
  }

  String _getTitle() {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/home')) {
      return 'ZEROFILTER';
    } else if (location.startsWith('/history')) {
      return 'history.title'.tr();
    } else if (location.startsWith('/favorites')) {
      return 'favorites.title'.tr();
    } else if (location.startsWith('/profile')) {
      return 'profile.title'.tr();
    } else if (location.startsWith('/settings')) {
      return 'settings.title'.tr();
    }else if(location.startsWith('/photo-detail')){
      return 'photoDetail.title'.tr();
    }else if(location.startsWith('/photo-editor')){
      return 'photoEditor.title'.tr();
    }
    return 'ZEROFILTER';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          _getTitle(),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(FontAwesomeIcons.bars),
              color: AppColors.black,
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
            ),
          ),
        ],
      ),
      endDrawer: const CustomDrawer(),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.black,
        currentIndex: _currentIndex,
        iconSize: 30,
        selectedLabelStyle: const TextStyle(color: AppColors.white),
        unselectedLabelStyle: const TextStyle(color: AppColors.white),
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined, color: AppColors.white),
            activeIcon: const Icon(Icons.home, color: AppColors.pacificCyan),
            label: 'navigation.home'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.history_outlined, color: AppColors.white),
            activeIcon: const Icon(Icons.history, color: AppColors.pacificCyan),
            label: 'navigation.history'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.star_border, color: AppColors.white),
            activeIcon: const Icon(Icons.star, color: AppColors.pacificCyan),
            label: 'navigation.favorites'.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline, color: AppColors.white),
            activeIcon: const Icon(Icons.person, color: AppColors.pacificCyan),
            label: 'navigation.profile'.tr(),
          ),
        ],
      ),
    );
  }
}
