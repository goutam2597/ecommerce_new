import 'package:ecommerce/app/urls.dart';
import 'package:ecommerce/features/product/data/models/cart_list_model.dart';
import 'package:ecommerce/services/network_caller/network_caller.dart';
import 'package:get/get.dart';

class CartListController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  CartListModel _cartListModel = CartListModel();
  CartListModel get cartListModel => _cartListModel;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> getCartList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final response = await Get.find<NetworkCaller>().getRequest(Urls.getCartList);

    if (response.isSuccess && response.responseJson != null) {
      _cartListModel = CartListModel.fromJson(response.responseJson!);
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
