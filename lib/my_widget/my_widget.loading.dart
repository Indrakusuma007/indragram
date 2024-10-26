import 'package:flutter/material.dart';

class MyWidgetLoading extends StatelessWidget {
  const MyWidgetLoading({super.key, required this.child, required this.loading, this.percent});
  final Widget child;
  final bool loading;
  final int? percent;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !loading,
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              child,
              loading
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(color: Colors.grey.shade200.withOpacity(.7)),
                      child: Center(child: Text(percent != null ? 'Loading (${percent}%)' : 'Loading..', style: TextStyle(fontWeight: FontWeight.bold))))
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
