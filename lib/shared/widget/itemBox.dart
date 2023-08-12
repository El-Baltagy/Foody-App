import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../screens/minor_Sc/meals_sc/MealsBy_sc.dart';
import '../manager/app_color.dart';
import '../manager/app_methods.dart';
import 'empty_data.dart';


class ItemShapePart extends StatelessWidget {
  const ItemShapePart({
    Key? key,
    required this.filterTypeArea, required this.listPart,
  }) : super(key: key);
  final bool filterTypeArea;
  final List<String> listPart;

  @override
  Widget build(BuildContext context) {
    return listPart.isNotEmpty?Padding(
      padding:  const EdgeInsets.symmetric(horizontal:8 ).copyWith(bottom: 5.h,top: 15.h),
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
                  duration: const Duration(milliseconds: 2000),
                  child: FadeInAnimation(
                    child: GestureDetector(
                      onTap: () {
                        GoPage.push(context, path:
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

    ):
    const emptyDataItem();
  }
}