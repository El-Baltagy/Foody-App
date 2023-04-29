import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:foody/shared/manager/color.dart';
import '../../screens/meals_by_cats/MealsBy_part_Screen.dart';
import '../components.dart';


class ItemShapePart extends StatelessWidget {
  const ItemShapePart({
    Key? key,
    required this.filterTypeArea, required this.listPart,
  }) : super(key: key);
  final bool filterTypeArea;
  final List<String> listPart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right:8,bottom: 135),
      child: AnimationLimiter(
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 8,
          children: List.generate( listPart.length , (index) {
            return AnimationConfiguration.staggeredGrid(
                position: index,
                columnCount: 3,
                child: ScaleAnimation(
                  duration: Duration(milliseconds: 2000),
                  child: FadeInAnimation(
                    child: GestureDetector(
                      onTap: () {
                        GoPage().pushNavigation(context, path:
                        filterTypeArea? MealsByAreaScreen(
                          areaName:listPart[index].toString() ,
                        ):
                        MealsByIngredientScreen(
                          ingredient: listPart[index].toString(),
                        )
                        );
                      },
                      child: Container(
                        padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        margin: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: primaryColor
                        ),
                        child: AutoSizeText(
                          listPart[index].toString(),
                          maxLines: 3,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style:  TextStyle(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ));
          }),
        ),
      ),


      // GridView.builder(
      //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 3,
      //     mainAxisSpacing: 8,
      //     crossAxisSpacing: 10,
      //   ),
      //   physics: const BouncingScrollPhysics(),
      //   // shrinkWrap: true,
      //   scrollDirection: Axis.vertical,
      //   itemCount: AreaList.isNotEmpty ? AreaList.length : 15,
      //   itemBuilder: (context, index) {
      //     return
      //       GestureDetector(
      //       onTap: () {
      //         Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => MealsByCategotrieScreen(
      //                 isCat: isCAt,
      //                 categoryname: AreaList[index].toString(),
      //                 filterType: filterType,
      //               ),
      //             ));
      //       },
      //       child: Container(
      //         padding:
      //         const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      //         margin: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
      //         alignment: Alignment.center,
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(40),
      //           color: bkg,
      //         ),
      //         child: AutoSizeText(
      //           AreaList[index].toString(),
      //           maxLines: 3,
      //           textAlign: TextAlign.center,
      //           overflow: TextOverflow.ellipsis,
      //           style:  TextStyle(
      //             color: Theme.of(context).scaffoldBackgroundColor,
      //             fontSize: 13,
      //             fontWeight: FontWeight.w600,
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}