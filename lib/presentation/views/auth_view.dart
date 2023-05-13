import 'package:flutter/material.dart';
import 'package:flutter_fire_auth/presentation/controllers/auth_controller.dart';
import 'package:get/get.dart';

import '../../domain/theme/theme.dart';
import '../../domain/utils/bubble_indicator_painter.dart';
import 'login_view.dart';
import 'register_view.dart';

// import 'package:the_gorgeous_login/pages/widgets/sign_in.dart';
// import 'package:the_gorgeous_login/pages/widgets/sign_up.dart';
// import 'package:the_gorgeous_login/theme.dart';
// import 'package:the_gorgeous_login/utils/bubble_indicator_painter.dart';

class AuthenticationView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: <Color>[
                  CustomTheme.loginGradientStart,
                  CustomTheme.loginGradientEnd
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 1.0),
                stops: <double>[0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const SizedBox(
                height: 75.0,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: _buildMenuBar(context),
              ),
              Expanded(
                flex: 2,
                child: PageView(
                  controller: controller.pageController,
                  physics: const ClampingScrollPhysics(),
                  onPageChanged: (int i) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    controller.changeColor(i);
                  },
                  children: <Widget>[
                    ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child: SignIn(),
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child: SignUp(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _buildMenuBar(
    BuildContext context,
  ) {
    return Obx(() => Container(
          width: 300.0,
          height: 50.0,
          decoration: const BoxDecoration(
            color: Color(0x552B2B2B),
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          child: CustomPaint(
            painter: BubbleIndicatorPainter(
                pageController: controller.pageController),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: TextButton(
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: _onSignInButtonPress,
                    child: Text(
                      'Existing',
                      style: TextStyle(
                          color: controller.isLeft.isFalse
                              ? Colors.white
                              : Colors.black,
                          fontSize: 16.0,
                          fontFamily: 'WorkSansSemiBold'),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    onPressed: _onSignUpButtonPress,
                    child: Text(
                      'New',
                      style: TextStyle(
                          color: controller.isLeft.isTrue
                              ? Colors.white
                              : Colors.black,
                          fontSize: 16.0,
                          fontFamily: 'WorkSansSemiBold'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void _onSignInButtonPress() {
    controller.pageController.animateToPage(0,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onSignUpButtonPress() {
    controller.pageController?.animateToPage(1,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }
}
