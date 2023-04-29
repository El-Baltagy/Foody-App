
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody/screens/cubit/cubit.dart';
import 'package:foody/screens/cubit/states.dart';
import 'package:foody/screens/favourite/fav.dart';
import 'package:foody/shared/components.dart';
import 'package:foody/shared/manager/color.dart';
import 'package:foody/shared/manager/theme/app_theme.dart';

import '../../manager/theme/cubit/theme_cubit.dart';
import '../../manager/theme/cubit/theme_state.dart';


class HomeDrawer extends StatefulWidget {
  const HomeDrawer({ this.screenIndex, this.iconAnimationController, this.callBackIndex});

  final AnimationController? iconAnimationController;
  final DrawerIndex? screenIndex;
  final Function(DrawerIndex)? callBackIndex;

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  List<DrawerList>? drawerList;
  @override
  void initState() {
    setDrawerListArray();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var brightness = MediaQuery.of(context).platformBrightness;
    // bool isLightMode = brightness == Brightness.light;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 8,
          ),
          Divider(
            height: 1,
            color: grey.withOpacity(0.6),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(0.0),
              itemCount: drawerList?.length,
              itemBuilder: (BuildContext context, int index) {
                return inkwell(drawerList![index]);
              },
            ),
          ),
          const SizedBox(
            height:15,
          ),
      //      ListTile(
      //         leading: Icon(Icons.favorite,
      //       color:primaryColor),
      //       title:  Text(
      //     'Favourite',
      //     style: TextStyle(
      //       fontWeight: FontWeight.w600,
      //       fontSize: 15,
      //       color:Theme.of(context).textColor1 ,
      //     ),
      //     textAlign: TextAlign.left,
      //   ),
      //        onTap: (){
      //          GoPage().pushNavigation(context, path: FavScreen());
      //        },
      // ),
          Divider(
            height: 2,thickness: 2,
            color: primaryColor.withOpacity(0.6),
          ),
          ListTile(
            leading: Icon(Theme.of(context).iconTh,color:Theme.of(context). iconCo,),
            title:  Text(
              Theme.of(context).textTh,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color:Theme.of(context).textColor1,
              ),
              textAlign: TextAlign.left,
            ),
            trailing: BlocBuilder<ThemeCubit,ThemeState>(
              builder: (context, state) {
                final themeCubit=ThemeCubit.get(context);
                return Switch(
                  value: themeCubit.isDarkTheme,
                  activeColor: primaryColor,
                  inactiveTrackColor: Colors.grey,
                  onChanged: (newValue) {
                    themeCubit.updateTheme(context);
                  },
                );
              },
            ),
          ),
          const SizedBox(
            height:15,
          ),
          BlocBuilder<homeCubit,homeStates>(
            builder: (context, state) {
              final cubit=homeCubit.getInstance(context);
              return ListTile(
                leading: Icon(Icons.bolt_rounded,
                    color:cubit.isColorful?primaryColor:Theme.of(context).textColor1),
                title:  Text(
                  'Nav Color Mode',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color:Theme.of(context).textColor1 ,
                  ),
                  textAlign: TextAlign.left,
                ),
                trailing:Switch(
                  value: cubit.isColorful,
                  activeColor: primaryColor,
                  inactiveTrackColor: Colors.grey,
                  onChanged: (newValue) {
                    cubit.changeColor();
                  },
                ),
              );
            },

          ),
          const SizedBox(
            height: 360,
          )

        ],
      ),
    );

  }
  void setDrawerListArray() {
    drawerList = <DrawerList>[
      DrawerList(
        index: DrawerIndex.HOME,
        labelName: 'Catogeries',
        icon: const Icon(Icons.category),
      ),
      DrawerList(
        index: DrawerIndex.Help,
        labelName: 'Components',
        icon: const Icon(Icons.settings_input_component_sharp)
      ),
      DrawerList(
        index: DrawerIndex.FeedBack,
        labelName: 'Countries',
        icon: const Icon(Icons.language),
      ),
      DrawerList(
        index: DrawerIndex.Share,
        labelName: 'Search',
        icon: const Icon(Icons.search),
      ),
    ];
  }

  Widget inkwell(DrawerList listData) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: primaryColor,
        highlightColor: Colors.transparent,
        onTap: () {
          navigationtoScreen(listData.index!);
        },
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 6.0,
                    height: 46.0,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  listData.isAssetsImage
                      ? Container(
                          width: 24,
                          height: 24,
                          child: Image.asset(listData.imageName,
                              color: widget.screenIndex == listData.index
                                  ? primaryColor
                                  : nearlyBlack),
                        )
                      : Icon(listData.icon?.icon,
                          color: widget.screenIndex == listData.index
                              ? primaryColor
                              : Theme.of(context).textColor1),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  Text(
                    listData.labelName,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: widget.screenIndex == listData.index
                          ? primaryColor
                          : Theme.of(context).textColor1,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            widget.screenIndex == listData.index
                ? AnimatedBuilder(
                    animation: widget.iconAnimationController!,
                    builder: (BuildContext context, Widget? child) {
                      return Transform(
                        transform: Matrix4.translationValues(
                            (MediaQuery.of(context).size.width * 0.75 - 64) *
                                (1.0 -
                                    widget.iconAnimationController!.value -
                                    1.0),
                            0.0,
                            0.0),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Container(
                            width:
                                MediaQuery.of(context).size.width * 0.75 - 64,
                            height: 46,
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(0.3),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(28),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(28),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  Future<void> navigationtoScreen(DrawerIndex indexScreen) async {
    widget.callBackIndex!(indexScreen);
  }

}

enum DrawerIndex {
  HOME,
  FeedBack,
  Help,
  Share,

}

class DrawerList {
  DrawerList({
    this.isAssetsImage = false,
    this.labelName = '',
    this.icon,
    this.index,
    this.imageName = '',
  });

  String labelName;
  Icon? icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex? index;
}
