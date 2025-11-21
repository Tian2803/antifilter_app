import 'package:antifilter_app/core/di/injection_container.dart' as di;
import 'package:antifilter_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:antifilter_app/shared/themes/app_colors.dart';
import 'package:antifilter_app/shared/widgets/buttons/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/user_actions_bloc.dart';
import '../bloc/user_actions_event.dart';
import '../bloc/user_actions_state.dart';

class DeleteAccountDialog {
  static Future<void> show(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return BlocProvider(
          create: (context) => di.sl<UserActionsBloc>(),
          child: BlocListener<UserActionsBloc, UserActionsState>(
            listener: (context, state) {
              if (state is AccountDeleted) {
                Navigator.of(context).pop();
                context.read<AuthBloc>().add(SignOutEvent());
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('settings.accountDeleted'.tr())),
                );
                context.go('/login');
              } else if (state is UserActionsError) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 5),
                  ),
                );
              }
            },
            child: BlocBuilder<UserActionsBloc, UserActionsState>(
              builder: (context, state) {
                return Stack(
                  children: [
                    AlertDialog(
                      actionsAlignment: MainAxisAlignment.center,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      backgroundColor: AppColors.white,
                      title: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 2,
                        ),
                        child: Text(
                          'settings.deleteAccountConfirm'.tr(),
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black,
                            height: 1.2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      content: Text(
                        'settings.deleteAccountWarning'.tr(),
                        style: const TextStyle(
                          fontSize: 17,
                          color: AppColors.black,
                          height: 1.3,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      actions: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /* ElevatedButton(
                              onPressed: state is AccountDeleting
                                  ? null
                                  : () {
                                      context.read<UserActionsBloc>().add(const DeleteAccountEvent());
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent.shade200,
                                foregroundColor: AppColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                fixedSize: const Size(190, 50),
                              ),
                              child: Text(
                                'settings.delete'.tr(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 17,
                                  color: AppColors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ), */
                            CustomButton(
                              onTap: state is AccountDeleting
                                  ? null
                                  : () {
                                      context.read<UserActionsBloc>().add(
                                        const DeleteAccountEvent(),
                                      );
                                    },
                              text: 'settings.delete'.tr(),
                              backgroundColor: Colors.redAccent.shade200,
                              height: 45,
                              borderRadius: 2,
                            ),
                            const SizedBox(height: 10),
                            CustomButton(
                              onTap: state is AccountDeleting
                                  ? null
                                  : () {
                                      Navigator.of(context).pop();
                                    },
                              text: 'settings.cancel'.tr(),
                              backgroundColor: AppColors.pacificCyan,
                              height: 45,
                              borderRadius: 2,
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (state is AccountDeleting)
                      Positioned.fill(
                        child: Container(
                          color: Colors.black54,
                          child: const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
