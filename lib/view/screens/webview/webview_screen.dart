import 'package:flutter/material.dart';
import 'package:flutter_anime_manga_app/constants/theme/colors.dart';
import 'package:flutter_anime_manga_app/view/screens/webview/widgets/my_web_view.dart';
import 'package:oktoast/oktoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatefulWidget {
  const WebviewScreen({super.key, required this.url});

  final String url;

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  late WebViewController _controller;

  Future<void> goBack() async {
    if (await _controller.canGoBack()) {
      await _controller.goBack();
    } else {
      showToast(
        'No more history items',
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
    }
  }

  Future<void> goForward() async {
    if (await _controller.canGoForward()) {
      await _controller.goForward();
    } else {
      showToast(
        'No more history items',
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
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..enableZoom(true)
      ..loadRequest(
        Uri.parse(
          widget.url,
        ),
      );
  }

  Future<void> getScroll() async {
    print('*' * 50);
    print(await _controller.getScrollPosition());
    print('*' * 50);
  }

  @override
  Widget build(BuildContext context) {
    getScroll();
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        backgroundColor: MyColors.primary,
        title: Text(
          widget.url,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await Share.shareUri(
                Uri.parse(widget.url),
              );
            },
            icon: const Icon(
              Icons.ios_share,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: MyWebView(controller: _controller),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        color: MyColors.primary,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () async {
                goBack();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                _controller.reload();
              },
              icon: const Icon(
                Icons.refresh,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () async {
                goForward();
              },
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
