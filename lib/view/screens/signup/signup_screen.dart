import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/constants/theme/colors.dart';
import 'package:flutter_anime_manga_app/data/services/auth/auth_service.dart';
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart';

import '../../widgets/center_loading_indicator.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  ValueNotifier<bool> isObscureValueNotifier = ValueNotifier(true);

  SMIInput<bool>? isChecking;
  SMIInput? numLook;
  SMIInput<bool>? isHandsUp;
  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;

  void _onRiveInit(Artboard artboard) {
    final controllerRive = StateMachineController.fromArtboard(
      artboard,
      'Login Machine',
    );
    if (controllerRive != null) {
      artboard.addController(controllerRive);
      isChecking = controllerRive.findInput('isChecking');
      numLook = controllerRive.inputs.toList()[1];
      isHandsUp = controllerRive.findInput('isHandsUp');
      trigSuccess = controllerRive.findInput('trigSuccess');
      trigFail = controllerRive.findInput('trigFail');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _formKey.currentState?.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isChecking?.value = false;
    isHandsUp?.value = false;

    return Scaffold(
      backgroundColor: MyColors.scaffoldBackground,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.4,
              width: MediaQuery.sizeOf(context).width,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: RiveAnimation.asset(
                      'assets/rive/animated-login-character.riv',
                      onInit: _onRiveInit,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SafeArea(
                    child: BackButton(
                      color: MyColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            // const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    /// Username
                    TextFormField(
                      onTap: () {
                        isChecking?.value = true;
                        isHandsUp?.value = false;

                        numLook?.value = 0.0;
                      },
                      textInputAction: TextInputAction.next,

                      /// For All
                      onTapOutside: (event) {
                        isChecking?.value = false;
                        isHandsUp?.value = false;

                        FocusScope.of(context).unfocus();
                      },
                      onChanged: (value) {
                        isChecking?.value = true;
                        isHandsUp?.value = false;

                        numLook?.value = value.length.toDouble();
                      },
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        labelText: 'Username',
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 4) {
                          return 'Please enter valid username';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    /// Email
                    TextFormField(
                      onTap: () {
                        isChecking?.value = true;
                        isHandsUp?.value = false;

                        numLook?.value = 0.0;
                      },
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        isChecking?.value = true;
                        isHandsUp?.value = false;

                        numLook?.value = value.length.toDouble();
                      },
                      controller: _emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !value.contains('@') ||
                            !value.contains('.')) {
                          return 'Please enter valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    /// Password
                    ValueListenableBuilder(
                        valueListenable: isObscureValueNotifier,
                        builder: (context, value, _) {
                          return TextFormField(
                            onTap: () {
                              isHandsUp?.value = isObscureValueNotifier.value;

                              isChecking?.value = true;

                              numLook?.value = 0.0;
                            },
                            onChanged: (value) {
                              isChecking?.value = true;

                              isHandsUp?.value = isObscureValueNotifier.value;
                              numLook?.value = value.length.toDouble();
                            },
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (newValue) {
                              signUp();
                            },
                            controller: _passwordController,
                            obscureText: value,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              labelText: 'Password',
                              suffixIcon: IconButton(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onPressed: () {
                                    isObscureValueNotifier.value =
                                        !isObscureValueNotifier.value;
                                    isHandsUp?.value =
                                        isObscureValueNotifier.value;
                                  },
                                  icon: value
                                      ? const Icon(Icons.visibility_off_sharp)
                                      : const Icon(Icons.remove_red_eye)),
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 6) {
                                return 'Please enter valid password';
                              }
                              return null;
                            },
                          );
                        }),
                    const SizedBox(height: 36),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.primary,
                      ),
                      onPressed: signUp,
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Lottie.asset(
              'assets/lottie/purple_lines.json',
              // fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }

  void signUp() async {
    if (!_formKey.currentState!.validate()) {
      trigFail?.value = true;

      return;
    }

    /// Success
    trigSuccess?.value = true;

    FocusScope.of(context).unfocus();
    showGeneralDialog(
      barrierDismissible: false,
      useRootNavigator: false,
      barrierLabel: 'Login',
      barrierColor: Colors.transparent,
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          const CenterLoadingIndicator(),
    );

    await AuthService.firebaseSignUp(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      displayName: _usernameController.text,
    );
    mounted ? Navigator.of(context).pop() : null;
  }
}
