import 'package:antifilter_app/features/onboard/data/sources/onboard_items.dart';
import 'package:antifilter_app/features/onboard/domain/entities/onboard_item.dart';
import 'package:antifilter_app/features/onboard/presentation/widgets/onboard_card.dart';
import 'package:antifilter_app/shared/themes/app_colors.dart';
import 'package:antifilter_app/shared/widgets/buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardItem> _onboardItems = onboardItems;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _goToLogin() {
    context.go('/login');
  }

  void _nextPage() {
    if (_currentPage < _onboardItems.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 1500),
        curve: Curves.easeInOut,
      );
    } else {
      _goToLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _goToLogin,
                child: const Text(
                  'Omitir',
                  style: TextStyle(color: AppColors.pacificCyan),
                ),
              ),
            ),
            // Page view
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _onboardItems.length,
                itemBuilder: (context, index) {
                  return OnboardCard(item: _onboardItems[index]);
                },
              ),
            ),
            // Page indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _onboardItems.length,
                (index) => _PageIndicator(isActive: index == _currentPage),
              ),
            ),
            const SizedBox(height: 32),
            // Next/Start button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: CustomButton(
                onTap: _nextPage,
                text: _currentPage == _onboardItems.length - 1
                    ? 'Comenzar'
                    : 'Siguiente',
                fontWeight: FontWeight.w700,
                size: 20,
                height: 56,
                width: 250,
                elevation: 3,
                textColor: AppColors.pacificCyan,
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  final bool isActive;

  const _PageIndicator({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1500),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.pacificCyan
            : AppColors.white.withAlpha((255 * 0.7).toInt()),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
