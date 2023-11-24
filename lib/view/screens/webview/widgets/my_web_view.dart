import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/constants/theme/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatefulWidget {
  const MyWebView({
    super.key,
    required WebViewController controller,
  }) : _controller = controller;

  final WebViewController _controller;

  @override
  State<MyWebView> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  ValueNotifier<double> progressValueNotifier = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    widget._controller.setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (url) {
          progressValueNotifier.value = 0;
        },
        onProgress: (progress) {
          progressValueNotifier.value = progress / 100;
        },
        onPageFinished: (url) {
          progressValueNotifier.value = 1;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(
          controller: widget._controller,
        ),
        ValueListenableBuilder<double>(
          valueListenable: progressValueNotifier,
          builder: (context, value, child) {
            if (value < 1) {
              return LinearProgressIndicator(
                value: value,
                color: MyColors.primaryLight,
                backgroundColor: Colors.white,
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
