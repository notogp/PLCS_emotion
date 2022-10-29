import 'package:flutter/material.dart';

const mobileWidth = 650;
const tabletWidth = 1200;

class ResponsiveLayout extends StatelessWidget {
  final Widget? mobileBody;
  final Widget? tabletBody;
  final Widget desktopBody;

  const ResponsiveLayout({
    Key? key,
    required this.desktopBody,
    this.tabletBody,
    this.mobileBody,
  }) : super(key: key);

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileWidth;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= mobileWidth &&
        MediaQuery.of(context).size.width <= tabletWidth;
  }

  static bool isBigScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > tabletWidth;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= mobileWidth) {
          return mobileBody ?? desktopBody;
        } else if (constraints.maxWidth <= tabletWidth) {
          return tabletBody ?? desktopBody;
        } else {
          return desktopBody;
        }
      },
    );
  }
}
