import 'package:antifilter_app/shared/themes/app_colors.dart';
import 'package:antifilter_app/shared/themes/app_text_style.dart';
import 'package:antifilter_app/shared/widgets/buttons/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(context.locale),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is Authenticated) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: state.user.photoUrl != null
                        ? NetworkImage(state.user.photoUrl!)
                        : null,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.user.displayName ?? 'User',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    state.user.email,
                    style: TextStyle(fontSize: 16, color: AppColors.black.withAlpha((255 * 0.7).toInt()), fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 40),
                  ListTile(
                    leading: const Icon(FontAwesomeIcons.gear, size: 30, color: AppColors.black,),
                    title: Text('profile.settings'.tr(), style: AppTextStyle.listTile,),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 25, color: AppColors.black,),
                    onTap: () {
                      context.push('/settings');
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(FontAwesomeIcons.circleQuestion, size: 30, color: AppColors.black,),
                    title: Text('profile.help'.tr(), style: AppTextStyle.listTile,),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 25, color: AppColors.black,),
                    onTap: () {},
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(FontAwesomeIcons.circleInfo, size: 30, color: AppColors.black,),
                    title: Text('profile.about'.tr(), style: AppTextStyle.listTile,),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 25, color: AppColors.black),
                    onTap: () {},
                  ),
                  const Divider(),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'profile.logout'.tr(),
                    onTap: () {
                      context.read<AuthBloc>().add(SignOutEvent());
                    },
                    height: 50,
                    width: 250,
                  ),
                ],
              ),
            );
          }
          return Center(child: Text('profile.notAuthenticated'.tr()));
        },
      ),
    );
  }
}
