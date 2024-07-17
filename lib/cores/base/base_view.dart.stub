import 'package:cgen/constants/app_colors.dart';
import 'package:cgen/cores/base/base_controller.dart';
import 'package:cgen/cores/enum/page_state.dart';
import 'package:cgen/cores/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class BaseView<Controller extends BaseController>
    extends GetView<Controller> {
  const BaseView({super.key});

  Widget body(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Stack(
        children: [
          body(context),
          if (controller.pageState == PageState.LOADING) _showLoading(),
        ],
      ),
    );
  }

  Color backgroundColor() {
    return AppColors.background;
  }

  Color statusBarColor() {
    return AppColors.background;
  }

  Widget? floatingActionButton() {
    return null;
  }

  Widget? bottomNavigationBar() {
    return null;
  }

  Widget? drawer() {
    return null;
  }

  Widget _showLoading() {
    return const LoadingWidget();
  }
}
