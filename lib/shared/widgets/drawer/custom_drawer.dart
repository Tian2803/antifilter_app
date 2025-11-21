import 'package:antifilter_app/features/user_actions/presentation/helpers/delete_account_dialog.dart';
import 'package:antifilter_app/shared/themes/app_colors.dart';
import 'package:antifilter_app/shared/widgets/drawer/header.dart';
import 'package:antifilter_app/shared/widgets/layout/custom_list_tile.dart';
import 'package:antifilter_app/shared/widgets/utils/share_utils.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedContainer(
        curve: Curves.easeInOutCubic,
        duration: const Duration(milliseconds: 500),
        width: 300,
        margin: const EdgeInsets.only(bottom: 10, top: 10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
          color: AppColors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomDrawerHeader(),
              CustomListTile(
                title: 'Preguntas frecuentes (FAQ)',
                infoCount: 0,
                onTap: () {
                  launchUrl(
                    Uri.parse("https://mife.app/preguntas-frecuentes"),
                    mode: LaunchMode.externalApplication,
                  );
                },
              ),
              CustomListTile(
                title: 'Contacto',
                infoCount: 0,
                onTap: () async {
                  await ShareUtils.openWhatsAppContact(
                    context: context,
                    phoneNumber: "+57 313 3406056",
                  );
                },
              ),
              CustomListTile(
                title: 'Nuestras políticas',
                infoCount: 0,
                onTap: () {
                  launchUrl(
                    Uri.parse("https://mife.app/politica"),
                    mode: LaunchMode.externalApplication,
                  );
                },
              ),
              CustomListTile(
                title: 'Eliminar cuenta',
                infoCount: 0,
                onTap: () {
                  DeleteAccountDialog.show(context);
                },
              ),
              CustomListTile(
                title: 'Compartir',
                infoCount: 0,
                onTap: () {
                  ShareUtils.shareToWhatsApp(
                    context: context,
                    message:
                        'Estoy usando Mi Fe - Una app increíble para fortalecer mi fe.',
                  );
                },
              ),
              const Spacer(),
              CustomListTile(
                title: 'Cerrar sesión',
                infoCount: 0,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
