import 'package:flutter/material.dart';

import '../constants/textstyles.dart';

class Base extends StatelessWidget {
  final Widget child;
  const Base({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      )),
    );
  }
}

class BasewithFloatingButton extends StatelessWidget {
  final String label;
  final Widget child;
  final void Function()? onTap;
  const BasewithFloatingButton(
      {super.key,
      required this.child,
      this.label = 'New',
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        width: 150,
        child: FloatingActionButton.extended(
          onPressed: onTap,
          label: Text(
            label,
            style: TT.f18w400,
          ),
          backgroundColor: Colors.orange,
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      )),
    );
  }
}

class BasewithAppBar extends StatelessWidget {
  final String title;
  final Widget child;
  final List<Widget>? action;
  const BasewithAppBar(
      {super.key, required this.child, this.title = 'New', this.action});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: action,
        title: Text(
          title,
          style: TT.f28w400,
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      )),
    );
  }
}
