import 'package:flutter/cupertino.dart';
import '../models/menu_model.dart';

class MenuViewModel {
  List<MenuModel> getMenus() {
    return [
      MenuModel(
        icon: CupertinoIcons.house,
        iconSelected: CupertinoIcons.house_fill,
        label: "Home",
      ),
      MenuModel(
        icon: CupertinoIcons.bag,
        iconSelected: CupertinoIcons.bag_fill,
        label: "Category",
      ),
      MenuModel(
        icon: CupertinoIcons.bubble_left_bubble_right,
        iconSelected: CupertinoIcons.bubble_left_bubble_right_fill,
        label: "Messages",
      ),
      MenuModel(
        icon: CupertinoIcons.person_crop_circle,
        iconSelected: CupertinoIcons.person_crop_circle_fill,
        label: "Profile",
      ),
    ];
  }
}
