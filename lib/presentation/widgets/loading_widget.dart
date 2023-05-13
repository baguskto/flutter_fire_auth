import 'package:flutter/material.dart';

import '../../domain/theme/theme.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 45,
      child: Center(
        child: CircularProgressIndicator(
          color: CustomTheme.loginGradientStart,
        ),
      ),
    );
  }
}
