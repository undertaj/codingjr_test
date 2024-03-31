import 'package:project_m/ext_package/hidden_drawer_menu/controllers/simple_hidden_drawer_controller.dart';
import 'package:project_m/ext_package/hidden_drawer_menu/menu/hidden_menu_item.dart';
import 'package:project_m/ext_package/hidden_drawer_menu/model/item_hidden_menu.dart';
import 'package:project_m/ext_package/hidden_drawer_menu/simple_hidden_drawer/animated_drawer_content.dart';
import 'package:flutter/material.dart';

class HiddenMenu extends StatefulWidget {
  /// Decocator that allows us to add backgroud in the menu(img)
  final DecorationImage? background;

  /// that allows us to add shadow above menu items
  final bool enableShadowItemsMenu;

  /// that allows us to add backgroud in the menu(color)
  final Color? backgroundColorMenu;

  /// Items of the menu
  final List<ItemHiddenMenu> items;

  /// Callback to receive item selected for user
  final Function(int)? selectedListen;

  /// position to set initial item selected in menu
  final int initPositionSelected;

  final TypeOpen typeOpen;

  const HiddenMenu(
      {Key? key,
      required this.background,
      required this.items,
      this.selectedListen,
      required this.initPositionSelected,
      this.backgroundColorMenu,
      this.enableShadowItemsMenu = false,
      this.typeOpen = TypeOpen.FROM_LEFT})
      : super(key: key);

  @override
  State<HiddenMenu> createState() => _HiddenMenuState();
}

class _HiddenMenuState extends State<HiddenMenu> {
  late int _indexSelected;
  late SimpleHiddenDrawerController controller;

  @override
  void initState() {
    _indexSelected = widget.initPositionSelected;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    controller = SimpleHiddenDrawerController.of(context);
    controller.addListener(_listenerController);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controller.removeListener(_listenerController);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: widget.background,
          color: const Color(0xffffffff),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.only(top: 40.0, bottom: 40.0),
            decoration: BoxDecoration(
              boxShadow: widget.enableShadowItemsMenu
                  ? [
                      const BoxShadow(
                        color: Color(0x44000000),
                        offset: Offset(0.0, 5.0),
                        blurRadius: 50.0,
                        spreadRadius: 30.0,
                      ),
                    ]
                  : [],
            ),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(0.0),
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                return HiddenMenuItem(
                  name: widget.items[index].name,
                  selected: index == _indexSelected,
                  colorLineSelected: widget.items[index].colorLineSelected,
                  baseStyle: widget.items[index].baseStyle,
                  selectedStyle: widget.items[index].selectedStyle,
                  typeOpen: widget.typeOpen,
                  onTap: () {
                    if (widget.items[index].onTap != null) {
                      widget.items[index].onTap!();
                    }
                    controller.setSelectedMenuPosition(index);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _listenerController() {
    setState(() {
      _indexSelected = controller.position;
    });
  }
}
