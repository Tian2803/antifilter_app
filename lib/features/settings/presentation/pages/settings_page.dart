import 'package:antifilter_app/features/user_actions/presentation/helpers/delete_account_dialog.dart';
import 'package:antifilter_app/shared/themes/app_colors.dart';
import 'package:antifilter_app/shared/themes/app_text_style.dart';
import 'package:antifilter_app/shared/widgets/buttons/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SettingsView();
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.language,
              size: 30,
              color: AppColors.black,
            ),
            title: Text('settings.language'.tr(), style: AppTextStyle.listTile),
            trailing: DropdownButton<Locale>(
              value: context.locale,
              underline: const SizedBox(),
              items: const [
                DropdownMenuItem(
                  value: Locale('es'),
                  child: Text('🇪🇸 Español'),
                ),
                DropdownMenuItem(
                  value: Locale('en'),
                  child: Text('🇺🇸 English'),
                ),
              ],
              onChanged: (Locale? locale) {
                if (locale != null) {
                  context.setLocale(locale);
                }
              },
            ),
          ),
          const Divider(),

          const SizedBox(height: 20),

          // Eliminar cuenta
          ListTile(
            leading: Icon(
              FontAwesomeIcons.trash,
              size: 30,
              color: Colors.redAccent[200],
            ),
            title: Text(
              'settings.deleteAccount'.tr(),
              style: AppTextStyle.listTile.copyWith(color: AppColors.black),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 25,
              color: AppColors.black,
            ),
            onTap: () => DeleteAccountDialog.show(context),
          ),
          const Divider(),
          const SizedBox(height: 30),
          Center(
            child: CustomButton(
              onTap: () => context.pop(),
              text: 'settings.back'.tr(),
              width: 200,
            ),
          ),
        ],
      ),
    );
  }
}
