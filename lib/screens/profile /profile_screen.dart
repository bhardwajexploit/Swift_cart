import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colours.dart';
import '../dashboard /dashboard_controller.dart';

class ProfileScreen extends GetView<DashboardController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final DashboardController controller = Get.find<DashboardController>();

    return CupertinoPageScaffold(
      backgroundColor: AppColours.bG,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: AppColours.bG,
        middle: const Text(
          "Profile",
          style: TextStyle(
            color: CupertinoColors.white,
            fontWeight: FontWeight.w600,
            fontSize: 25,
          ),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(
            CupertinoIcons.square_arrow_right,
            color: CupertinoColors.white,
          ),
          onPressed: () {
            controller.logout();
          },
        ),
      ),
      child: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CupertinoActivityIndicator(
                    radius: 15,
                    color: CupertinoColors.white,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Loading Profile...",
                    style: TextStyle(
                      color: CupertinoColors.white.withValues(alpha: 0.8),
                      fontSize: 14,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            );
          }

          if (controller.user.value == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.person_crop_circle_badge_xmark,
                    size: 64,
                    color: CupertinoColors.white.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "User not found",
                    style: TextStyle(
                      fontSize: 16,
                      color: CupertinoColors.white.withValues(alpha: 0.8),
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            );
          }

          final user = controller.user.value!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: CupertinoColors.white,
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: CupertinoColors.white,
                        child: Icon(
                          CupertinoIcons.person_solid,
                          size: 40,
                          color: AppColours.kPrimaryPurple,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: CupertinoColors.white,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user.email,
                            style: TextStyle(
                              color: CupertinoColors.white.withValues(alpha: 0.8),
                              fontSize: 14,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Member since ${DateTime.now().year}",
                            style: TextStyle(
                              color: CupertinoColors.white.withValues(alpha: 0.6),
                              fontSize: 14,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                _buildSection(
                  title: "Account Information",
                  icon: CupertinoIcons.person_circle,
                  children: [
                    _buildLabel("Name"),
                    const SizedBox(height: 8),
                    CupertinoTextField(
                      controller: controller.nameTextController,
                      onChanged: (v) => controller.nameController.value = v,
                      placeholder: "Enter Name",
                      placeholderStyle: const TextStyle(
                        color: CupertinoColors.black,
                      ),
                      style: const TextStyle(color: CupertinoColors.black),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: CupertinoColors.extraLightBackgroundGray,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffix: const Padding(
                        padding: EdgeInsets.only(right: 12.0),
                        child: Icon(
                          CupertinoIcons.pencil,
                          color: CupertinoColors.systemGrey,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: CupertinoButton.filled(
                        onPressed: controller.updateName,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        borderRadius: BorderRadius.circular(12),
                        color: AppColours.kPrimaryPurple,
                        child: const Text(
                          "Update Name",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                _buildSection(
                  title: "Security",
                  icon: CupertinoIcons.lock_shield,
                  children: [
                    _buildLabel("Current Password"),
                    const SizedBox(height: 8),
                    CupertinoTextField(
                      controller: controller.currentPasswordTextController,
                      obscureText: !controller.isPasswordVisible.value,
                      placeholder: "••••••",
                      placeholderStyle: const TextStyle(
                        color: CupertinoColors.black,
                      ),
                      style: const TextStyle(color: CupertinoColors.black),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: CupertinoColors.extraLightBackgroundGray,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffix: CupertinoButton(
                        padding: const EdgeInsets.only(right: 12),
                        onPressed: () => controller.isPasswordVisible.toggle(),
                        child: Icon(
                          controller.isPasswordVisible.value
                              ? CupertinoIcons.eye
                              : CupertinoIcons.eye_slash,
                          color: AppColours.bG,
                          size: 20,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    _buildLabel("New Password"),
                    const SizedBox(height: 8),

                    CupertinoTextField(
                      controller: controller.passwordTextController,
                      onChanged: (v) => controller.passwordController.value = v,
                      obscureText: !controller.isPasswordVisible.value,
                      placeholder: "••••••",
                      placeholderStyle: const TextStyle(
                        color: CupertinoColors.black,
                      ),
                      style: const TextStyle(color: CupertinoColors.black),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: CupertinoColors.extraLightBackgroundGray,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffix: CupertinoButton(
                        padding: const EdgeInsets.only(right: 12),
                        onPressed: () => controller.isPasswordVisible.toggle(),
                        child: Icon(
                          controller.isPasswordVisible.value
                              ? CupertinoIcons.eye
                              : CupertinoIcons.eye_slash,
                          color: AppColours.bG,
                          size: 20,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      child: CupertinoButton.filled(
                        onPressed: controller.changePassword,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        borderRadius: BorderRadius.circular(12),
                        color: AppColours.kPrimaryPurple,
                        child: const Text(
                          "Change Password",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Text(
        text,
        style: const TextStyle(
          color: CupertinoColors.systemGrey,
          fontSize: 13,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColours.kPrimaryPurple.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: AppColours.kPrimaryPurple, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: CupertinoColors.black,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }
}
