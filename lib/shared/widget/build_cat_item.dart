import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody/shared/manager/theme/app_theme.dart';
import 'package:lottie/lottie.dart';
import '../../screens/cubit/cubit.dart';
import '../../screens/cubit/states.dart';
import '../../screens/detail_screen/MealDetails_Screen.dart';
import '../components.dart';
import '../manager/color.dart';
import '../manager/string.dart' as key;
import '../network/cash_helper.dart';

class BuildStackItem extends StatefulWidget {
  BuildStackItem({
required this.article, required this.isFavSC,
  });
  final dynamic article;
   final bool isFavSC;

  @override
  State<BuildStackItem> createState() => _BuildStackItemState();
}
class _BuildStackItemState extends State<BuildStackItem> {
  late bool isFav;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isFav=CashHelper.getBoolean(key: '${widget.article[key.id]} isSaved')??false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<homeCubit,homeStates>(
      builder: (context, state) {
        final cubit=homeCubit.getInstance(context);
        chaneData(){
          if (!isFav) {
            CashHelper.saveData(key: '${widget.article[key.id]} isSaved', value: true);
            cubit.InsertTODatabase(
                idMeal: widget.article[key.id].toString()
            ).then((value){
              showSnackBar(
                  context,"item added to Favourite successfully",
                  backgroundColor: Colors.green,sec: 2
              );
            });
          }else{
            CashHelper.saveData(key: '${widget.article[key.id]} isSaved', value: false);
            showSnackBar(
                context,"item Deleted Successfully" ,sec: 2
            );
            // cubit.DeleteDatebase(id:cubit.archivedData[0]['id']).then((value) {
              // showSnackBar(
              //     context,"item Deleted Successfully" ,sec: 2
              // )
            // }
            // );

          }
          setState(() {
            isFav=CashHelper.getBoolean(key: '${widget.article[key.id]} isSaved')!;
          });
        }
        return Stack(
          alignment: AlignmentDirectional.bottomEnd,
          fit: cubit.multiple?StackFit.loose:StackFit.passthrough,
          children: [
            GestureDetector(
              onTap: () {
                GoPage().pushNavigation(context, path: MealDetailScreen(
                    MealID: !widget.isFavSC?widget.article[key.id]:
                    widget.article['meals'][0][key.id]
                ));
              },
              onLongPress: () {
                chaneData();
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
                               !widget.isFavSC? widget.article[key.urlImage] :
                               widget.article['meals'][0][key.urlImage],
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
                          !widget.isFavSC? widget.article[key.title]:
                          widget.article['meals'][0][key.title],
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
                  if (isFav)
                    Lottie.asset('assets/VUixmm05XV (1).json',
                        fit: BoxFit.cover,width: 35,height: 40,
                        repeat: true,frameRate: FrameRate(60),alignment: AlignmentDirectional.center
                    ),
                ],
              ),
            ),
            Padding(
              padding:EdgeInsets.only(bottom: 40.0,right:cubit.multiple?10:0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(isFav?Icons.favorite:Icons.heart_broken_outlined
                      ,color:isFav?primaryColor:nearlyBlack ,),
                    onPressed: (){
                      chaneData();
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


class LoadingSkItem extends StatelessWidget {
  LoadingSkItem();
  @override
  Widget build(BuildContext context) {
    return Container(
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
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Theme.of(context).shadowSk,

              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .start,
              children: [
                Container(
                  height: 15,
                  width: 130,
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(7),
                    color: Theme.of(context).shadowSk,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}


Widget listItemCo(context,cubit,list,{isFavSC=false})=>ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) =>
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0).copyWith(top: 10),
            child:
            GridView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cubit.multiple?2:1,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount:list.length,
                itemBuilder: (context, index) {
                  return BuildStackItem(
                    article: list[index],
                    isFavSC: isFavSC,
                  );
                })
        ),
    fallback: (context) =>Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0).copyWith(
            top: 10),
        child: GridView.builder(
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cubit.multiple?2:1,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: 20,
            itemBuilder: (context, index) {
              return LoadingSkItem();
            }))

);