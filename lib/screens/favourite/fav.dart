
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody/shared/manager/theme/app_theme.dart';
import 'package:foody/shared/widget/build_cat_item.dart';
import 'package:lottie/lottie.dart';

import '../../shared/components.dart';
import '../../shared/manager/color.dart';
import '../../shared/network/cash_helper.dart';
import '../detail_screen/MealDetails_Screen.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';


class FavScreen extends StatelessWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<homeCubit,homeStates>(
      builder: (context,state){
        // store data from database on variable data
        return BlocBuilder<homeCubit,homeStates>(
          builder: (context, state) {
            final cubit=homeCubit.getInstance(context);
            return Scaffold(
              appBar: AppBar(
            elevation: 0,
                actions: [
                  Text(
                      cubit.archivedData.isNotEmpty ?"${cubit.archivedData.length} items":""
                  )
                ],
              ),
                body: Container(
                  width: double.infinity,
                  height: double.infinity,
                  margin: EdgeInsets.all(10.0.h),
                  child: cubit.archivedData.isEmpty ?
                  emptyDataItem(context: context) :
                  listItemCo(
                      context,
                      cubit,
                      cubit.fav,
                    isFavSC: true
                  ),
                )
            );
          },
        );
      },
    );
  }

  Widget emptyDataItem({required BuildContext context}){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:
        [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                // Image.asset('assets/images/Asset 1.png',height: 130.h,width: 150.w,),
                SizedBox(height: 15.h,),
                Center(
                  child: Text("No Favourite Items"
                      ,style: Theme.of(context).textTheme.headlineSmall!
                          .copyWith(fontSize: 18.5.sp,fontWeight: FontWeight.w500,)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BuildFavItem extends StatefulWidget {
  BuildFavItem({
    required this.index,required this.cubit,required this.multiple,required this.article
  });
 final dynamic article;
  final int index;
  final homeCubit cubit;
  final bool multiple;

  @override
  State<BuildFavItem> createState() => _BuildFavItemState();
}

class _BuildFavItemState extends State<BuildFavItem> {
  bool isFav=true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<homeCubit,homeStates>(
      builder: (context, state) {
        final cubit=homeCubit.getInstance(context);
        deleteData(){
          CashHelper.saveData(key: '${widget.article['id']} isSaved', value: false);
          cubit.DeleteDatebase(id:cubit.archivedData[0]['id']);
          showSnackBar(
              context,"item Deleted Succeffully" );
        }
        return Stack(
          alignment: AlignmentDirectional.bottomEnd,
          fit: widget.multiple?StackFit.loose:StackFit.passthrough,
          children: [
            GestureDetector(
              onTap: () {
                GoPage().pushNavigation(context, path: MealDetailScreen(
                    MealID: widget.article['MealID']));
              },
              onLongPress: () {
                deleteData();
              },
              child: Container(
                margin: const EdgeInsets.only(
                    left: 5, top: 5, bottom: 5, right: 5),
                width: 160,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).scaffoldBackgroundColor,
                    boxShadow:  [
                      BoxShadow(
                        offset: Offset(0, 2),
                        blurRadius: 5,
                        color: Theme.of(context).shadow,
                      )
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.grey.shade300,
                          image:  DecorationImage(
                              image: NetworkImage(
                                widget.article['urlToImage'],
                              ),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child:  Container(
                        width: double.maxFinite,
                        height: 25,
                        child: AutoSizeText(
                          widget.article['title'],
                          maxLines: 2,
                          maxFontSize: 16,
                          minFontSize: 10,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style:  const TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding:  const EdgeInsets.only(bottom: 50.0,right:30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                    Lottie.asset('assets/VUixmm05XV (1).json',
                        fit: BoxFit.cover,width: 35,height: 40,
                        repeat: true,frameRate: FrameRate(60),alignment: AlignmentDirectional.center
                    ),
                ],
              ),
            ),
            Padding(
              padding:EdgeInsets.only(bottom: 40.0,right:widget.multiple?10:0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.favorite
                      ,color:primaryColor),
                    onPressed: (){
                      deleteData();
                    },
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}