import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:igcloneapp/responsive/mobile_screen_layout.dart';
import 'package:igcloneapp/responsive/web_screen_layout.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget web_screen_layout;
  final Widget mobile_screen_layout;
  
  const ResponsiveLayout({super.key,required this.web_screen_layout,required this.mobile_screen_layout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
    builder: (context,constraints){
      if(constraints.maxWidth > 600){
        return web_screen_layout;
      }
      return mobile_screen_layout;
    });
  }
}