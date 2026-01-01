import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/theme/app_colours.dart';
import 'login_controller.dart';

class LoginPage extends GetView<Logincontroller> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/core/assets/5179557.jpg'),
            filterQuality: FilterQuality.high,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const Spacer(flex: 3),
              Expanded(
                flex:3 ,
                child: ClipPath(
                  clipper: WaveClipper(),
                  child: Container(
                    width: double.infinity,
                    color: CupertinoColors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 32,
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            "Sign In",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: CupertinoColors.black,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // --- Email Input ---
                          _buildLabel("Email"),
                          const SizedBox(height: 8),
                          CupertinoTextField(
                            controller: controller.emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            placeholder: 'demo@email.com',
                            placeholderStyle: TextStyle(
                              color: CupertinoColors.black,
                            ),
                            style: const TextStyle(color: CupertinoColors.black),  // Added for consistency
                            prefix: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Icon(CupertinoIcons.mail, color: AppColours.bG),

                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            decoration: BoxDecoration(

                              color: CupertinoColors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: CupertinoColors.systemGrey4),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // --- Password Input ---
                          _buildLabel("Password"),
                          const SizedBox(height: 8),
                          Obx(() => CupertinoTextField(

                            controller: controller.passwordController,
                            obscureText: !controller.isPasswordVisible.value,
                            keyboardType: TextInputType.visiblePassword,
                            placeholder: "Enter Password",
                            placeholderStyle: TextStyle(
                              color: CupertinoColors.black,
                            ),
                            style: const TextStyle(color: CupertinoColors.black),
                            prefix: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Icon(CupertinoIcons.lock, color: AppColours.bG),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            decoration: BoxDecoration(
                              color: CupertinoColors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: CupertinoColors.systemGrey4),
                            ),
                            suffix: CupertinoButton(
                              padding: const EdgeInsets.only(right: 12),
                              child: Icon(
                                controller.isPasswordVisible.value
                                    ? CupertinoIcons.eye
                                    : CupertinoIcons.eye_slash,
                                color: AppColours.bG,
                                size: 20,
                              ),
                              onPressed: () => controller.isPasswordVisible.toggle(),  // Cleaner toggle
                            ),
                          )),

                          const SizedBox(height: 40),

                          // --- Button ---
                          SizedBox(
                            width: double.infinity,
                            child: CupertinoButton.filled(
                              color: AppColours.bG,
                              borderRadius: BorderRadius.circular(20),
                              onPressed: () => controller.loginUser(),
                              child: const Text(
                                "Continue",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for iOS style top-labels
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          color: CupertinoColors.systemGrey,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 3);

    final firstControlPoint = Offset(size.width * 0.25, -10);
    final firstEndPoint = Offset(size.width * 0.5, 40);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    final secondControlPoint = Offset(size.width * 0.75, 80);
    final secondEndPoint = Offset(size.width, 10);
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
