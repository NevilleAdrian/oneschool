import 'package:cliqlite/themes/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FutureHelper<T> extends StatelessWidget {
  final Future<T> task;
  final Future<void> Function() onRefresh;
  final Widget whenEmpty;
  final Widget Function(BuildContext context, T data) builder;
  final Function actionWhenData;
  final Widget loader;
  final Widget noData;

  FutureHelper(
      {this.task,
      this.whenEmpty,
      this.builder,
      this.actionWhenData,
      this.onRefresh,
      this.loader,
      this.noData});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: task,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print('data is in the home ${snapshot.data}');
          if (actionWhenData != null) {
            print('something');
            actionWhenData(snapshot.data);
          }
          return onRefresh != null
              ? RefreshIndicator(
                  backgroundColor: secondaryColor,
                  color: Colors.white,
                  onRefresh: onRefresh,
                  child: builder(context, snapshot.data),
                )
              : builder(context, snapshot.data);
        } else if (snapshot.hasError) {
          print('error: ${snapshot.error}');
          print('data: ${snapshot.data}');
          return snapshot.error.toString().startsWith('S')
              ? Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            'No Internet Connection',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 22),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Check your internet connection settings and try again.',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : noData ?? SizedBox();
        }
        // By default, show a loading spinner.
        return loader;
      },
    );
  }
}

class NoItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "No item yet...",
        style: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
