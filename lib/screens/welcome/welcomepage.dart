import 'package:flutter/cupertino.dart';
import 'package:foodify/core/theme/app_colours.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/core/assets/5179557.jpg'),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        child: SafeArea(
          top: true,
          bottom: false,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final h = constraints.maxHeight;
              final isSmall = h < 650;

              return Column(
                children: [
                  Spacer(flex: isSmall ? 2 : 3),
                  ClipPath(
                    clipper: WaveClipper(),
                    child: Container(
                      width: double.infinity,
                      color: CupertinoColors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: isSmall ? 20 : 32,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: isSmall ? 24 : 40),
                          Text(
                            'Welcome',
                            style: TextStyle(
                              fontSize: isSmall ? 28 : 32,
                              color: CupertinoColors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: isSmall ? 4 : 6),
                          Text(
                            'Get amazing Streetwear',
                            style: TextStyle(
                              color: CupertinoColors.black,
                              height: 1.4,
                              fontSize: isSmall ? 14 : 16,
                            ),
                          ),
                          SizedBox(height: isSmall ? 40 : 60),

                          // ✅ Sign In (white bg + purple border)
                          SizedBox(
                            width: double.infinity,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                border: Border.all(
                                  color: AppColours.kPrimaryPurple,
                                  width: 1.5,
                                ),
                              ),
                              child: CupertinoButton(
                                padding: EdgeInsets.symmetric(vertical: isSmall ? 10 : 12),
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                color: CupertinoColors.white,
                                onPressed: () => Get.toNamed('/login'),
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                    color: AppColours.kPrimaryPurple,
                                    fontWeight: FontWeight.w600,
                                    fontSize: isSmall ? 16 : 17,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: isSmall ? 4 : 6),

                          // ✅ Sign Up (filled purple)
                          SizedBox(
                            width: double.infinity,
                            child: CupertinoButton.filled(
                              padding: EdgeInsets.symmetric(vertical: isSmall ? 10 : 12),
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                              color: AppColours.kPrimaryPurple,
                              onPressed: () => Get.toNamed('/register'),
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: CupertinoColors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: isSmall ? 16 : 17,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: isSmall ? 12 : 16),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
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

    final cp1 = Offset(size.width * 0.25, -10);
    final ep1 = Offset(size.width * 0.5, 40);
    path.quadraticBezierTo(cp1.dx, cp1.dy, ep1.dx, ep1.dy);

    final cp2 = Offset(size.width * 0.75, 80);
    final ep2 = Offset(size.width, 10);
    path.quadraticBezierTo(cp2.dx, cp2.dy, ep2.dx, ep2.dy);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
