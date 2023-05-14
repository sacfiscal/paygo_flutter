import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:paygo_app/commons/style/application_colors.dart';
import 'package:paygo_app/presentation/views/loading/loading_controller.dart';

enum LoadingActionModeType {
  toNamed,
  offAllNamed,
}

class LoadingView extends StatefulWidget {
  final Duration? duration;
  final String? nextRoute;
  final LoadingActionModeType? loadingActionMode;
  final Future<void> Function(
    void Function(
      String,
      bool,
      bool,
    ),
  )? loadingActionFunction;

  const LoadingView({
    Key? key,
    this.duration = const Duration(seconds: 5),
    this.nextRoute,
    this.loadingActionMode = LoadingActionModeType.toNamed,
    this.loadingActionFunction,
  }) : super(key: key);

  @override
  LoadingViewState createState() => LoadingViewState();
}

class LoadingViewState extends State<LoadingView> {
  LoadingController controller = Get.put(LoadingController());
  late Timer timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        if (controller.isLoading == false) {
          timer.cancel();

          if (controller.status == false) {
            Get.back();
          } else {
            Future.delayed(
              widget.duration!,
              () {
                if (widget.nextRoute != null) {
                  switch (widget.loadingActionMode) {
                    case LoadingActionModeType.toNamed:
                      Get.toNamed(widget.nextRoute!);
                      break;
                    case LoadingActionModeType.offAllNamed:
                      Get.offAllNamed(widget.nextRoute!);
                      break;
                    default:
                      Get.toNamed(widget.nextRoute!);
                      break;
                  }
                }
              },
            );
          }
        }
      },
    );

    if (widget.loadingActionFunction != null) {
      widget.loadingActionFunction!(controller.setLoadingText);
    } else {
      Future.delayed(
        widget.duration!,
        () {
          if (widget.nextRoute != null) {
            switch (widget.loadingActionMode) {
              case LoadingActionModeType.toNamed:
                Get.toNamed(widget.nextRoute!);

                break;
              case LoadingActionModeType.offAllNamed:
                Get.offAllNamed(widget.nextRoute!);
                break;
              default:
                Get.toNamed(widget.nextRoute!);
                break;
            }
          }
        },
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: LoadingBouncingGrid.circle(
                    backgroundColor: ApplicationColors.paygoDark,
                    size: 150,
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Container(
                height: 65,
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  child: Obx(
                    () {
                      return Text(
                        controller.loadingText,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        style: TextStyle(
                          color: controller.status == true ? ApplicationColors.paygoDark : Colors.red[900],
                          fontSize: 14,
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
