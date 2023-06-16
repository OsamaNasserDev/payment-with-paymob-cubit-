import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_webview/fwfh_webview.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
   WebViewScreen({Key? key,required this.url}) : super(key: key);
   String? url = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Container(
        width: double.infinity,
        child: HtmlWidget(
          '<iframe src="${url}"></iframe>',
          factoryBuilder: () => MyWidgetFactory(),

        ),
      ),

    );
  }
}
class MyWidgetFactory extends WidgetFactory with WebViewFactory {}
