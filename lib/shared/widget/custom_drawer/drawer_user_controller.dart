import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../controller/cubit/home/cubit.dart';
import '../../../controller/cubit/home/states.dart';
import '../../manager/app_assets.dart';
import '../../manager/app_color.dart';
import 'home_drawer.dart';

class DrawerUserController extends StatefulWidget {
  const DrawerUserController({
    Key? key,
    this.drawerWidth = 100,
    this.onDrawerCall,
    this.screenView,
    this.animatedIconData = AnimatedIcons.arrow_menu,
    this.menuView,
    this.drawerIsOpen,
    this.screenIndex,
  }) : super(key: key);

  final double drawerWidth;
  final Function(DrawerIndex)? onDrawerCall;
  final Widget? screenView;
  final Function(bool)? drawerIsOpen;
  final AnimatedIconData? animatedIconData;
  final Widget? menuView;
  final DrawerIndex? screenIndex;

  @override
  _DrawerUserControllerState createState() => _DrawerUserControllerState();
}

class _DrawerUserControllerState extends State<DrawerUserController>
    with TickerProviderStateMixin {
  ScrollController? scrollController;
  AnimationController? iconAnimationController;
  AnimationController? animationController;

  double scrolloffset = 0.0;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    iconAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 0));
    iconAnimationController
      ?.animateTo(1.0,
          duration: const Duration(milliseconds: 0),
          curve: Curves.fastOutSlowIn);
    scrollController =
        ScrollController(initialScrollOffset: widget.drawerWidth);
    scrollController!
      .addListener(() {
        if (scrollController!.offset <= 0) {
          if (scrolloffset != 1.0) {
            setState(() {
              scrolloffset = 1.0;
              try {
                widget.drawerIsOpen!(true);
              } catch (_) {}
            });
          }
          iconAnimationController?.animateTo(0.0,
              duration: const Duration(milliseconds: 0),
              curve: Curves.fastOutSlowIn);
        } else if (scrollController!.offset > 0 &&
            scrollController!.offset < widget.drawerWidth.floor()) {
          iconAnimationController?.animateTo(
              (scrollController!.offset * 100 / (widget.drawerWidth)) / 100,
              duration: const Duration(milliseconds: 0),
              curve: Curves.fastOutSlowIn);
        } else {
          if (scrolloffset != 0.0) {
            setState(() {
              scrolloffset = 0.0;
              try {
                widget.drawerIsOpen!(false);
              } catch (_) {}
            });
          }
          iconAnimationController?.animateTo(1.0,
              duration: const Duration(milliseconds: 0),
              curve: Curves.fastOutSlowIn);
        }
      });
    WidgetsBinding.instance.addPostFrameCallback((_) => getInitState());
    super.initState();
  }

  Future<bool> getInitState() async {
    scrollController?.jumpTo(
      widget.drawerWidth,
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // var brightness = MediaQuery.of(context).platformBrightness;
    // bool isLightMode = brightness == Brightness.light;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        leading: Container(
          padding: EdgeInsets.only(left: 8,),
          child: SizedBox(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(
                    AppBar().preferredSize.height),
                child: Center(
                  // if you use your own menu view UI you add form initialization
                  child: widget.menuView ?? AnimatedIcon(
                      color: primaryColor,
                      icon: widget.animatedIconData ??
                          AnimatedIcons.arrow_menu,
                      progress: iconAnimationController!),
                ),
                onTap: () {
                  FocusScope.of(context)
                      .requestFocus(FocusNode());
                  onDrawerClick();
                },
              ),
            ),
          ),
        ),
        title:
        // Image.asset(AppAsset.logo,
        // height: 1.25.h,
        // )
        Text(
            'Foody App',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 26,color: primaryColor,fontFamily: 'James Stroker',
              letterSpacing: 2,height: 1.25.h
            ))
        , centerTitle: true,
        actions: [
          Padding(
            padding:  EdgeInsets.only(right: 15.0.w),
            child: BlocBuilder<homeCubit,homeStates>(
              builder: (context, state) {
                final cubit=homeCubit.getInstance(context);
                return cubit.currentIndex==0||cubit.currentIndex==4?
                InkWell(
                  borderRadius:
                  BorderRadius.circular(5),
                  onTap: cubit.gridTab,
                  child: Icon(
                    cubit.multiple ? Icons.dashboard : Icons.view_agenda,
                    color: primaryColor,
                  )
                )
                    :Container();
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const PageScrollPhysics(parent: PageScrollPhysics()),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [

              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width + widget.drawerWidth,
                //we use with as screen width and add drawerWidth (from navigation_home_screen)
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: widget.drawerWidth,
                      //we divided first drawer Width with HomeDrawer and second full-screen Width with all home screen, we called screen View
                      height: MediaQuery.of(context).size.height,
                      child: AnimatedBuilder(
                        animation: iconAnimationController!,
                        builder: (BuildContext context, Widget? child) {
                          return Transform(
                            //transform we use for the stable drawer  we, not need to move with scroll view
                            transform: Matrix4.translationValues(
                                scrollController!.offset, 0.0, 0.0),
                            child: HomeDrawer(
                              screenIndex: widget.screenIndex ?? DrawerIndex.HOME,
                              iconAnimationController: iconAnimationController,
                              callBackIndex: (DrawerIndex indexType) {
                                onDrawerClick();
                                try {
                                  widget.onDrawerCall!(indexType);
                                } catch (e) {
                                  print(e.toString());
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ),

                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: grey.withOpacity(0.6),
                              blurRadius: 24),
                        ],
                      ),
                      child: Stack(
                        children: <Widget>[
                          //this IgnorePointer we use as touch(user Interface) widget.screen View, for example scrolloffset == 1 means drawer is close we just allow touching all widget.screen View
                          IgnorePointer(
                            ignoring: scrolloffset == 1 || false,
                            child: widget.screenView,
                          ),
                          //alternative touch(user Interface) for widget.screen, for example, drawer is close we need to tap on a few home screen area and close the drawer
                          if (scrolloffset == 1.0)
                            InkWell(
                              onTap: () {
                                onDrawerClick();
                              },
                            ),
                          // this just menu and arrow icon animation

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onDrawerClick() {
    //if scrollcontroller.offset != 0.0 then we set to closed the drawer(with animation to offset zero position) if is not 1 then open the drawer
    if (scrollController!.offset != 0.0) {
      scrollController?.animateTo(
        0.0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );
    } else {
      scrollController?.animateTo(
        widget.drawerWidth,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );
    }
  }
}
