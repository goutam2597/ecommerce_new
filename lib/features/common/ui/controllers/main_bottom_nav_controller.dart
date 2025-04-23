import 'package:get/get.dart';

class MainBottomNavController extends GetxController{
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void changedIndex(int index){
    if(index == _selectedIndex){
      return;
    }
    _selectedIndex = index;
    update();
  }

  void backToHome(){
    changedIndex(0);
  }
  void moveToCategory(){
    changedIndex(1);
  }
}
