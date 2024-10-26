import 'package:flutter/material.dart';

import '../../../common_widgets/common_widget.index.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonPage(
      appBar: AppBar(title: const Text('Sign In')),
      body: const Center(
        child: Text('Sign in Page'),
      ),
    );
  }
}
