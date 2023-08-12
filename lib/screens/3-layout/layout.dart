import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody/shared/manager/app_theme.dart';
import 'package:lottie/lottie.dart';
import '../../controller/cubit/home/cubit.dart';
import '../../controller/cubit/home/states.dart';
import '../../shared/manager/app_color.dart';
import '../../shared/manager/app_string.dart';
import '../../shared/widget/custom_drawer/drawer_user_controller.dart';
import '../../shared/widget/custom_drawer/home_drawer.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'package:badges/badges.dart' as badges;

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
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: badges.Badge(

              showBadge: cubit.saveData.isEmpty ? false : true,
              alignment: AlignmentDirectional.bottomEnd,
              stackFit: StackFit.loose,
              badgeColor: Theme.of(context).scaffoldBackgroundColor,
              badgeContent: Text(
                cubit.saveData.length.toString(),
                style: const TextStyle(
                    fontSize: 22,
                    color: primaryColor,
                    fontWeight: FontWeight.w600),
              ),
              child: InkWell(
                  onTap: () {
                    cubit.changeBottom(4);
                  },
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        cubit.currentIndex==4?Colors.transparent:Colors.grey,
                        BlendMode.srcATop),
                    child: Lottie.asset('assets/animation_love.json',
                        // width: 35,
                        height: 40.h,
                        fit: BoxFit.cover,
                        // frameRate: FrameRate(60),
                        repeat: true,
                        alignment: AlignmentDirectional.center
                    ),
                  ))),

          body:DrawerUserController(
            screenIndex: cubit.drawerIndex,
            drawerWidth: S.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {

              cubit.changeIndex(drawerIndexdata);
            },
            screenView: cubit.pages[cubit.currentIndex],
          ),
          bottomNavigationBar: cubit.isColorful
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

}

