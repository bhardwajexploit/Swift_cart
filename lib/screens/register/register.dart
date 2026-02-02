import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:foodify/screens/Register/register_controller.dart';
import '../../core/theme/app_colours.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

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
          child: Column(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,child:ClipPath(
                  clipper: WaveClipper(),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.60,
                    color: CupertinoColors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 32,
                    ),
                    // 4. Added SingleChildScrollView to prevent RenderFlex Overflow when keyboard opens
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: CupertinoColors.black,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          const SizedBox(height: 20),
                
                          // --- Email Input (Cupertino Style) ---
                          _buildLabel("Email"),
                          const SizedBox(height: 8),
                          CupertinoTextField(
                            controller: controller.email,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            placeholder: 'demo@email.com',
                            placeholderStyle: TextStyle(
                              color: CupertinoColors.black,
                            ),
                            style: const TextStyle(color: CupertinoColors.black),
                            prefix: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Icon(CupertinoIcons.mail, color: AppColours.bG),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            decoration: BoxDecoration(
                              color:  CupertinoColors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: CupertinoColors.systemGrey4),
                            ),
                          ),
                
                          const SizedBox(height: 20),
                
                          // --- Name Input (Cupertino Style) ---
                          _buildLabel("Full Name"),
                          const SizedBox(height: 8),
                          CupertinoTextField(
                            placeholderStyle: TextStyle(
                              color: CupertinoColors.black,
                            ),
                            controller: controller.name,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            placeholder: 'Enter your name',

                            style: const TextStyle(color: CupertinoColors.black),
                            prefix: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Icon(CupertinoIcons.person, color: AppColours.bG),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            decoration: BoxDecoration(
                              color:  CupertinoColors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: CupertinoColors.systemGrey4),
                            ),
                          ),
                
                          const SizedBox(height: 20),
                
                          // --- Password Input (Cupertino Style with Obx) ---
                          _buildLabel("Password"),
                          const SizedBox(height: 8),
                          Obx(() => CupertinoTextField(
                            placeholderStyle: TextStyle(
                              color: CupertinoColors.black,
                            ),
                            style: const TextStyle(color: CupertinoColors.black),
                            controller: controller.password,
                            obscureText: !controller.isPasswordVisible.value,
                            keyboardType: TextInputType.visiblePassword,
                            placeholder: "Enter Password",
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
                                color: CupertinoColors.systemPurple,
                                size: 20,
                              ),
                              onPressed: () => controller.isPasswordVisible.toggle(),
                            ),
                          )),
                
                          const SizedBox(height: 40),
                
                          // --- Button (Cupertino Style) ---
                          SizedBox(
                            width: double.infinity,
                            child: CupertinoButton.filled(
                              borderRadius: BorderRadius.circular(20),
                             color: AppColours.bG,
                              onPressed: () {
                                controller.createUser();
                              },
                              child: const Text(
                                "Continue",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          // Add extra padding at bottom so keyboard doesn't cover button immediately
                          SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 20),
                        ],
                      ),
                    ),
                  ),
                ),),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper for labels to keep code clean
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

    // First curve
    final firstControlPoint = Offset(size.width * 0.25, -10);
    final firstEndPoint = Offset(size.width * 0.5, 40);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    // Second curve
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