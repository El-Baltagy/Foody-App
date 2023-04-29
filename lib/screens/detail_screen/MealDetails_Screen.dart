import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody/screens/cubit/cubit.dart';
import 'package:foody/shared/components.dart';
import 'package:foody/shared/manager/theme/app_theme.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../shared/manager/color.dart';
import '../../shared/manager/string.dart' as key;
import '../cubit/states.dart';
import '../meals_by_cats/MealsBy_part_Screen.dart';


class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({Key? key, required this.MealID}) : super(key: key);
  final String MealID;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homeCubit()..getMealId(MealID),
      child: BlocBuilder<homeCubit,homeStates>(
        builder: (context, state) {
          final cubit=homeCubit.getInstance(context);
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              toolbarHeight: 5.h,
              elevation: 0,
            ),
            body: Stack(
              children: [
                     cubit.listId.isNotEmpty
                        ? Column(
                      children: [
                        Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            children: [
                              Container(
                                height: 250.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  image:  DecorationImage(
                                      image: NetworkImage(
                                        cubit.listId[0][key.urlImage],
                                      ),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 15.h),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                cubit.listId[0][key.title],
                                                maxLines: 5,
                                                style:  TextStyle(
                                                  color: Colors
                                                      .grey.shade700,
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            ),
                                            ExtraButton(
                                              MealTitle:
                                              cubit.listId[0][key.title],
                                              BrowsLink:
                                              cubit.listId[0][key.strSource]!= null &&
                                              cubit.listId[0][key.strSource]!.isNotEmpty
                                                  ? cubit.listId[0][key.strSource] : '',
                                              isThereBrowserlink:
                                              cubit.listId[0][key.strSource] != null &&
                                              cubit.listId[0][key.strSource].isNotEmpty
                                                  ? true : false,
                                              shareLink:
                                              cubit.listId[0][key.strYoutube],
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                GoPage().pushNavigation(context,path:
                                                    MealsByCatScreen(
                                                      isCat: true,
                                                      categoryname: cubit.listId[0][key.strCategory],
                                                    ));
                                              },
                                              child: Text(
                                                cubit.listId[0][key.strCategory],
                                                style: const TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                             SizedBox(
                                              width: 5.h,
                                            ),
                                            const Text(
                                              '-',
                                              style: TextStyle(
                                                color: primaryColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                             SizedBox(
                                              width: 5.w,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                GoPage().pushNavigation(context,path:
                                                    MealsByAreaScreen(
                                                      areaName: cubit.listId[0][key.strArea],
                                                    ));
                                              },
                                              child: Text(
                                                cubit.listId[0][key.strArea],
                                                style: const TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                         SizedBox(
                                          height: 20.h,
                                        ),
                                        const Text(
                                          'Description',
                                          style: TextStyle(
                                            color: primaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                         SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          cubit.listId[0][key.strInstructions],
                                          style: TextStyle(
                                            color: Theme.of(context).textColor1,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                         SizedBox(
                                          height: 20.h,
                                        ),
                                        Padding(
                                          padding:  EdgeInsets.symmetric(
                                              horizontal: 10.w),
                                          child: Divider(
                                            height: 1.h,
                                            color: Colors.grey.shade300,
                                          ),
                                        ),
                                         SizedBox(
                                          height: 20.h,
                                        ),
                                        const Text(
                                          'Ingredient & Measure',
                                          style: TextStyle(
                                            color: primaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                         SizedBox(
                                          height: 5.h,
                                        ),
                                        ListView.builder(
                                          physics:
                                          const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: 20,
                                          itemBuilder: (context, index) {
                                            return cubit.Ingredient[index] != "" &&
                                                cubit. Ingredient[index] != null
                                                ? Padding(
                                        padding:  EdgeInsets.symmetric(vertical: 5.0.h),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    ' - ',
                                                    style: TextStyle(
                                                      color: primaryColor,
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight.w600,
                                                    ),
                                                  ),
                                                  Text(
                                                        cubit. Ingredient[index],
                                                    style: TextStyle(
                                                      color: Theme.of(context).textColor1,
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight.w600,
                                                    ),
                                                  ),
                                                   SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  cubit. Measure[index] != "" &&
                                                   cubit. Measure[index] !=null
                                                      ? Text(
                                                    ': ' +
                                                        cubit. Measure[index],
                                                    style:
                                                    TextStyle(
                                                      color: Theme.of(context).textColor1,
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight
                                                          .w200,
                                                    ),
                                                  )
                                                      : Container(),
                                                ],
                                              ),
                                            )
                                                : Container();
                                          },
                                        ),
                                         SizedBox(
                                          height: 10.h,
                                        ),
                                        cubit.listId[0][key.strTags] != null
                                            ? Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:  EdgeInsets
                                                    .symmetric(
                                                    horizontal: 20.w),
                                                child: Divider(
                                                  height: 1,
                                                  color: Colors
                                                      .grey.shade200,
                                                ),
                                              ),
                                               SizedBox(
                                                height: 20.h,
                                              ),
                                              const Text(
                                                'Tags',
                                                style: TextStyle(
                                                  color: primaryColor,
                                                  fontSize: 16,
                                                  fontWeight:
                                                  FontWeight.w600,
                                                ),
                                              ),
                                               SizedBox(
                                                height: 5.h,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    ' - '  ,
                                                    style: TextStyle(
                                                      color: primaryColor,
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight.w400,
                                                    ),
                                                  ),
                                                  Text(
                                                     cubit.listId[0][key.strTags] ,
                                                    style: TextStyle(
                                                      color: Colors
                                                          .grey.shade700,
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ])
                                            : Container()
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                        : Container(),
                const ArrowBackButton(),
              ],
            ),
          );
        },
      ),
    );
  }
}




class ArrowBackButton extends StatelessWidget {
  const ArrowBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50.h,
      left: 20.w,
      child: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: primaryColor,
            boxShadow:  [
              BoxShadow(
                offset: Offset(2.h, 2.w),
                blurRadius: 1,
                color: Color.fromARGB(82, 0, 0, 0),
              )
            ]),
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 20,
          ),
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
    );
  }
}

class ExtraButton extends StatelessWidget {
  const ExtraButton({
    Key? key,
    required this.MealTitle,
    required this.shareLink,
    required this.BrowsLink,
    required this.isThereBrowserlink,
  }) : super(key: key);
  final String shareLink;
  final String BrowsLink;
  final String MealTitle;
  final bool isThereBrowserlink;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isThereBrowserlink
            ? IconButton(
                onPressed: (() async {
                  final String url = BrowsLink;

                  await launch(
                    url,
                    forceSafariVC:
                        false, // false : lunching your url in another Browser of iOS
                    forceWebView:
                        false, //  false :lunching your url in another Browser of Android
                    enableJavaScript: true, // Android
                  );
                }),
                icon: const Icon(
                  Icons.language_rounded,
                  size: 25,
                ),
                color: primaryColor,
              )
            : Container(),
         SizedBox(
          width: 5.w,
        ),
        IconButton(
          onPressed: () {
            Share.share(
              'Look How to Cook this $MealTitle ? check it Now $shareLink',
            );
          },
          icon: const Icon(
            Icons.share,
            size: 25,
          ),
          color: primaryColor,
        ),
      ],
    );
  }
}
