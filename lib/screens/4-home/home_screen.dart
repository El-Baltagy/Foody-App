import 'dart:async';
import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody/shared/manager/theme/app_theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../controller/Categorie_Data.dart';
import '../../model/Categorie_Modal.dart';
import '../../shared/components.dart';
import '../../shared/manager/color.dart';
import '../../shared/manager/string.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../meals_by_cats/MealsBy_part_Screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int current = 0;
  @override
  Widget build(BuildContext context) {

    return BlocBuilder<homeCubit,homeStates>(
      builder: (context, state) {
        final h=MediaQuery.of(context).size.height;
        final w=MediaQuery.of(context).size.width;
        final cubit =homeCubit.getInstance(context);
        return
          DefaultTabController(
            length:list.length,
            initialIndex: 0,
            child: FutureBuilder<List<Categories>>(
                future: CategorieData.GetCategories(),
                builder: (context, snapshot) {
                  return NestedScrollView(
                      scrollDirection: Axis.vertical,
                      headerSliverBuilder: (context, innerBoxIsScrolled) => [
                        SliverAppBar(backgroundColor: Colors.transparent,
                          leadingWidth: double.maxFinite,
                          expandedHeight: h*0.3,
                          flexibleSpace: FlexibleSpaceBar(
                            background: Column(
                              children: [
                                buildCarouselSlider(),
                                 SizedBox(
                                  height: 5.h,
                                ),
                                AnimatedSmoothIndicator(
                                  activeIndex: current,
                                  count: listImage.length,
                                  effect:  ExpandingDotsEffect(
                                    dotColor: Theme.of(context).textColor1,
                                    activeDotColor: primaryColor,
                                    dotHeight: 10,
                                    expansionFactor: 4,
                                    dotWidth: 10,
                                    spacing: 5.0,
                                  ),
                                ),
                                 SizedBox(
                                  height: 20.h,
                                ),
                                myDivider(),
                              ],
                            ),
                          ),
                        ),
                        SliverAppBar(
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          toolbarHeight: h*0.045,pinned: true,
                          bottom: PreferredSize( preferredSize: Size(double.infinity, h*0.02*0.4),
                            child:  Column(
                              children: [
                                buildTabBar(cubit: cubit),
                                 SizedBox(
                                  height: 7.h,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                      body:
                      Padding(
                        padding: const EdgeInsets.only(bottom: 140.0),
                        child: PageView.builder(
                            physics: const BouncingScrollPhysics(),
                          itemCount: list.length,
                            itemBuilder: (context, index) =>
                            MealsByCatScreen(categoryname: list[cubit.l],),
                            onPageChanged: (value) {
                              DefaultTabController.of(context).animateTo(value);
                              changData(cubit,value);
                            }
                        ),
                      )
                  );
                }
            ),
          );
      },
    );
  }

  CarouselSlider buildCarouselSlider() {
    return CarouselSlider.builder(
                                itemCount: listImage.length,
                                itemBuilder: (BuildContext context, int itemIndex, int i) =>
                                    Container(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                              offset: Offset(0, 2),
                                              blurRadius: 5,
                                              color: Color.fromARGB(117, 0, 0, 0),
                                            )
                                          ],
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(listImage[itemIndex],)
                                          )
                                      ) ,
                                    ),
                                options: CarouselOptions(
                                  onPageChanged: ( int value,carousalChange) {
                                    setState(() {
                                      current= value;
                                      print(value);
                                    });},
                                  viewportFraction: 0.6,
                                  height: 200,
                                  aspectRatio: 0.75,
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 4),
                                  enlargeCenterPage: true,
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                  // enableInfiniteScroll: false,
                                ),
                              );
  }


}

class buildTabBar extends StatelessWidget {
  const buildTabBar({
    super.key,
    required this.cubit,
  });

  final homeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: TabBar(
        indicatorColor: primaryColor,
        labelColor:primaryColor ,
        indicatorWeight: 2,
        unselectedLabelColor: Theme.of(context).textColor1,
        physics: const BouncingScrollPhysics(),
        isScrollable: true,
        tabs: List<Widget>.generate(list.length,
                (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5).copyWith(top: 5),
              child: Text(
                list[index],
                overflow: TextOverflow.ellipsis,
                style:  const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w800,)
                ,),
            )),
        onTap: (index){
          changData(cubit,index);
        },
      ),
    );
  }
}
changData(cubit,index){
  cubit.changIndex(index);
  cubit.listCat.clear();
  cubit.getMealCat( list[cubit.l]);
}



