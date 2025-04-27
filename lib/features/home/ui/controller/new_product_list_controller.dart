import 'package:ecommerce/app/urls.dart';
import 'package:ecommerce/features/common/data/models/product_model.dart';
import 'package:ecommerce/features/common/data/models/products_list_model.dart';
import 'package:ecommerce/services/network_caller/network_caller.dart';
import 'package:get/get.dart';

class NewProductListController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  ProductListModel? _newProductListModel;

  List<ProductModel> get newProductList => _newProductListModel?.productList ?? [];

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> getNewProductList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      Urls.productListByRemarkUrl('new'),
    );
    if (response.isSuccess) {
      _newProductListModel = ProductListModel.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
