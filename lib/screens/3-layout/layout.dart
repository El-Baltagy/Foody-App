import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody/shared/manager/color.dart';
import 'package:foody/shared/manager/theme/app_theme.dart';
import '../../shared/manager/string.dart';
import '../../shared/widget/custom_drawer/drawer_user_controller.dart';
import '../../shared/widget/custom_drawer/home_drawer.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class LayOut extends StatefulWidget {
  const LayOut({Key? key}) : super(key: key);

  @override
  State<LayOut> createState() => _LayOutState();
}

class _LayOutState extends State<LayOut> {

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<homeCubit,homeStates>(
      builder: (context, state) {
        final S=MediaQuery.of(context).size;
        final cubit=homeCubit.getInstance(context);
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 1,backgroundColor: Colors.transparent,elevation: 0,
          ),
          body:DrawerUserController(
            screenIndex: cubit.drawerIndex,
            drawerWidth: S.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {

              cubit.changeIndex(drawerIndexdata);
            },
            screenView: cubit.pages[cubit.currentIndex],
          ),
          // cubit.pages[cubit.currentIndex] ,
          bottomNavigationBar:
          cubit.isColorful
              ? SlidingClippedNavBar.colorful(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            onButtonPressed: (index) {
              cubit.changeBottom(index);
            },
            iconSize: 30,
            selectedIndex: cubit.currentIndex,
            barItems: buildList1(),
          )
              : SlidingClippedNavBar(
            backgroundColor:Theme.of(context).scaffoldBackgroundColor,
            onButtonPressed: (index) {
              cubit.changeBottom(index);
            },
            iconSize: 30,
            activeColor: primaryColor,
            inactiveColor: Theme.of(context).textColor1,
            selectedIndex: cubit.currentIndex,
            barItems: buildList2(),
          ),
        );
      },
    );
  }
  List<BarItem> buildList1() {
    return List<BarItem>.generate(
        NavBarUtils.names.length,
            (index) => BarItem(icon:NavBarUtils.icons[index] ,title:NavBarUtils.names[index],
              activeColor: NavBarUtils.activeColor[index],inactiveColor: NavBarUtils.unActiveColor[index]
            )
    );
  }
  List<BarItem> buildList2() {
    return List<BarItem>.generate(
        NavBarUtils.names.length,
            (index) => BarItem(icon:NavBarUtils.icons[index] ,title:NavBarUtils.names[index])
    );
  }
  // List<GButton> buildList() {
  //   return List<GButton>.generate(
  //       NavBarUtils.names.length,
  //           (index) => GButton(icon:NavBarUtils.icons[index] ,text:NavBarUtils.names[index])
  //   );
  // }
  // List<FloatingNavbarItem> buildListe() {
  //   return List<FloatingNavbarItem>.generate(
  //       NavBarUtils.names.length,
  //           (index) => FloatingNavbarItem(icon:NavBarUtils.icons[index] ,title:NavBarUtils.names[index])
  //   );
  // }

}

