import 'package:ecommerce/app/urls.dart';
import 'package:ecommerce/features/common/data/models/product_model.dart';
import 'package:ecommerce/features/common/data/models/products_list_model.dart';
import 'package:ecommerce/services/network_caller/network_caller.dart';
import 'package:get/get.dart';

class PopularProductListController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  ProductListModel? _popularProductListModel;

  List<ProductModel> get popularProductList => _popularProductListModel?.productList ?? [];

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> getPopularProductList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      Urls.productListByRemarkUrl('popular'),
    );
    if (response.isSuccess) {
      _popularProductListModel = ProductListModel.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
