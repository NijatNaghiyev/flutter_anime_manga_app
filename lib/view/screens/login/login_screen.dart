import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/constants/theme/colors.dart';
import 'package:flutter_anime_manga_app/view/screens/login/widgets/shader_arrows.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';
import 'package:rive/rive.dart';

import '../../../data/services/auth/auth_service.dart';
import '../../widgets/center_loading_indicator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  ValueNotifier<bool> isObscure = ValueNotifier(true);
  SMIInput<bool>? toggle;

  ValueNotifier<bool> isInVisibleTitle = ValueNotifier(true);

  void _onRiveInit(Artboard artboard) {
    final controllerRive = StateMachineController.fromArtboard(
      artboard,
      'State Machine 1',
    );
    if (controllerRive != null) {
      artboard.addController(controllerRive);
      toggle = controllerRive.findInput('toggle');
    }
  }

  /// When keyboard is closed, show title
  void inVisibleKeyboard() {
    if (MediaQuery.viewInsetsOf(context).bottom == 0) {
      isInVisibleTitle.value = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    inVisibleKeyboard();

    return Scaffold(
      key: scaffoldKey,
      body: ValueListenableBuilder(
          valueListenable: isObscure,
          builder: (context, value, _) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: IgnorePointer(
                    ignoring: true,
                    child: RiveAnimation.asset(
                      'assets/rive/site_rive.riv',
                      fit: BoxFit.cover,
                      onInit: _onRiveInit,
                    ),
                  ),
                ),
                const Positioned(
                  top: 50,
                  child: ShaderArrows(),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ValueListenableBuilder(
                        valueListenable: isInVisibleTitle,
                        builder: (context, inVisible, _) {
                          return inVisible
                              ? Text(
                                  'FAM',
                                  style: GoogleFonts.kdamThmorPro(
                                    fontSize: 60,
                                    fontWeight: FontWeight.w500,
                                    color: MyColors.primary,
                                  ),
                                )
                              : const SizedBox.shrink();
                        },
                      ),
                      TextField(
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        textInputAction: TextInputAction.next,
                        onTap: () {
                          isInVisibleTitle.value = false;
                        },
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            borderSide: BorderSide(
                              color: MyColors.primary,
                            ),
                          ),
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        controller: _emailController,
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => _login(),
                        onTap: () {
                          isInVisibleTitle.value = false;
                        },
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            borderSide: BorderSide(
                              color: MyColors.primary,
                            ),
                          ),
                          labelText: 'Password',
                          labelStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          suffixIcon: IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              isObscure.value = !isObscure.value;
                              setState(() {
                                toggle?.value = !toggle!.value;
                              });
                            },
                            icon: value
                                ? const Icon(
                                    Icons.visibility_off_sharp,
                                    color: Colors.white,
                                  )
                                : const Icon(
                                    Icons.remove_red_eye,
                                    color: Colors.white,
                                  ),
                          ),
                        ),
                        obscureText: value,
                        controller: _passwordController,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: _login,
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }

  void _login() async {
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _emailController.text.contains('@') == false ||
        _emailController.text.contains('.') == false ||
        _emailController.text.length < 4 ||
        _passwordController.text.length < 6) {
      showToast(
        'Invalid Email or Password',
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        textPadding: const EdgeInsets.all(16.0),
        backgroundColor: MyColors.primary.withOpacity(0.6),
        position: ToastPosition.center,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: const Duration(milliseconds: 600),
        duration: const Duration(seconds: 3),
        dismissOtherToast: true,
      );
      return;
    }
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
    await AuthService.firebaseLogIn(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );

    mounted ? Navigator.of(context).pop() : null;
  }
}
