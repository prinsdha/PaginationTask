import 'dart:async';

import 'package:demotask/core/constant/app_icons.dart';
import 'package:demotask/ui/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

class FaceAuth extends StatefulWidget {
  static const String routeName = "/faceAuth";

  const FaceAuth({Key? key}) : super(key: key);

  @override
  State<FaceAuth> createState() => _FaceAuthState();
}

class _FaceAuthState extends State<FaceAuth> {
  final LocalAuthentication auth = LocalAuthentication();

  String _authorized = 'Not Authorized';
  @override
  void initState() {
    hasBiometrics().then(
      (value) => value
          ? _authenticate()
          : showDialog(
              context: context,
              builder: (context) {
                return alertDialog();
              },
            ),
    );

    super.initState();
  }

  AlertDialog alertDialog() {
    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Icon(
            Icons.error,
            color: Colors.red,
          ),
          Text(
            "Required security features not available [FeaturesType face & fingerprint]",
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Text(
            "Ok",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Future<bool> hasBiometrics() async {
    try {
      return await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      return false;
    }
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _authorized = 'Authenticating';
      });

      authenticated = await auth.authenticate(
          biometricOnly: false,
          sensitiveTransaction: false,
          localizedReason: 'Let OS determine authentication method',
          useErrorDialogs: true);
    } on PlatformException catch (e) {
      setState(() {
        _authorized = "Error - ${e.message}";
      });
      return;
    }
    if (!mounted) return;

    setState(() {
      _authorized;
      if (authenticated) {
        _authorized = 'Authorized';
        Get.offAndToNamed(HomeScreen.routeName);
      } else {
        _authorized = "Not Authorized";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 230,
            child: Center(
              child: SafeArea(
                child: Column(
                  children: const [
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Welcome Back!",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Fast and Secure Login",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(40),
                bottomLeft: Radius.circular(40),
              ),
            ),
          ),
          const SizedBox(
            height: 90,
          ),
          GestureDetector(
            onTap: () {
              hasBiometrics().then(
                (value) => value
                    ? _authenticate()
                    : showDialog(
                        context: context,
                        builder: (context) {
                          return alertDialog();
                        },
                      ),
              );
            },
            child: Image.asset(
              AppIcons.authentication,
              height: 120,
            ),
          ),
          Center(child: Text(_authorized)),
        ],
      ),
    );
  }
}
