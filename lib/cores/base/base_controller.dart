import 'package:cgen/cores/enum/page_state.dart';
import 'package:cgen/cores/utils/helper.dart';
import 'package:get/get.dart';

abstract class BaseController extends GetxController {
  //Controls page state
  final _pageSateController = PageState.DEFAULT.obs;

  PageState get pageState => _pageSateController.value;

  updatePageState(PageState state) => _pageSateController(state);

  resetPageState() => _pageSateController(PageState.DEFAULT);

  showLoading() => updatePageState(PageState.LOADING);

  hideLoading() => resetPageState();

  final _messageController = ''.obs;

  String get message => _messageController.value;

  showMessage(String msg) => _messageController(msg);

  final _errorMessageController = ''.obs;

  String get errorMessage => _errorMessageController.value;

  showErrorMessage(String msg) {
    _errorMessageController(msg);
  }

  final _successMessageController = ''.obs;

  String get successMessage => _messageController.value;

  showSuccessMessage(String msg) => _successMessageController(msg);

  // ignore: long-parameter-list
  dynamic callDataService<T>(
    Future<T> future, {
    Function(T response)? onSuccess,
    Function? onStart,
    Function? onComplete,
  }) async {
    onStart == null ? showLoading() : onStart();

    try {
      final T response = await future;

      if (onSuccess != null) onSuccess(response);

      onComplete == null ? hideLoading() : onComplete();

      return response;
    } catch (error) {
      showSnackbar(
        message: error.toString(),
      );
    }

    onComplete == null ? hideLoading() : onComplete();
  }

  @override
  void onClose() {
    _messageController.close();
    _pageSateController.close();
    super.onClose();
  }
}
