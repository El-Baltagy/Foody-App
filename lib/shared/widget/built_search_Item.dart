import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody/controller/cubit/home/states.dart';
import 'package:foody/shared/manager/app_theme.dart';
import 'package:lottie/lottie.dart';
import 'package:share/share.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import '../../controller/cubit/home/cubit.dart';
import '../../screens/minor_Sc/detail_screen/MealDetails_Screen.dart';
import '../../shared/manager/app_string.dart' as key;
import '../manager/app_assets.dart';
import '../manager/app_color.dart';
import '../manager/app_methods.dart';
import '../network/local/cash_helper.dart';

class BuiltItem extends StatefulWidget {
   BuiltItem({
     required this.article,
});
final dynamic article;

  @override
  State<BuiltItem> createState() => _BuiltItemState();
}

class _BuiltItemState extends State<BuiltItem> {
  late bool isFav;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isFav=CashHelper.getBoolean(key: '${widget.article[key.id]} isSaved')??false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<homeCubit, homeStates>(

    builder: (context, state) {
      final cubit=homeCubit.getInstance(context);
      chaneData()async{
        if (!isFav) {
          CashHelper.saveData(key: '${widget.article[key.id]} isSaved', value: true);
          await cubit.InsertTODatabase(context,
              idMeal: widget.article[key.id],
              thumbnail: widget.article[key.urlImage],
              textDesc:  widget.article[key.title]);
          // showSnackBar(context,'added success',backgroundColor: Colors.green);

        }else{
          CashHelper.saveData(key: '${widget.article[key.id]} isSaved', value: false);
          await cubit.DeleteDatebase(context,id:(widget.article[key.id]).toString());


        }
        setState(() {
          isFav=CashHelper.getBoolean(key: '${widget.article[key.id]} isSaved')!;
        });
      }
      return Container(
        padding: const EdgeInsets.symmetric(
            vertical: 10),
        height: 120,
        width: double.infinity,
        child:  Row(
          crossAxisAlignment: CrossAxisAlignment
              .center,
          children: [
            GestureDetector(
              onTap: () async {
                final String url =
                widget.article['strYoutube'];

                await launch(
                  url,
                  forceSafariVC:
                  false,
                  // false : lunching your url in another Browser of iOS
                  forceWebView:
                  false,
                  //  false :lunching your url in another Browser of Android
                  enableJavaScript: true, // Android
                );
              },
              child: Container(
                width: 105,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius
                        .only(
                      topLeft: Radius.zero,
                      bottomLeft: Radius.zero,
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(
                          10),
                    ),
                    color: Colors.white,

                    image: DecorationImage(
                        image: NetworkImage(
                          widget.article['strMealThumb'],
                        ),
                        fit: BoxFit.cover)
                        ,
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(2, 2),
                        blurRadius: 5,
                        color: Color.fromARGB(
                            59, 0, 0, 0),
                      )
                    ]),
                child: const Icon(
                  Icons.play_circle_outline_rounded,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: GestureDetector(
                  onTap: (){
                    GoPage.push(context, path: MealDetailScreen(
                        MealID: widget.article[key.id]));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.article['strMeal'],
                        maxLines: 1,
                        overflow: TextOverflow
                            .ellipsis,
                        style:  TextStyle(
                          color: Theme.of(context).textColor2.withOpacity(0.8),
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          Text(
                            widget.article['strCategory'] + ' - ' + widget.article['strArea'],
                            overflow: TextOverflow
                                .ellipsis,
                            style: TextStyle(
                              color: Colors.grey
                                  .shade500,
                              fontSize: 14,
                              fontWeight: FontWeight
                                  .w400,
                            ),
                          )

                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.article['strInstructions'],
                        maxLines: 2,
                        overflow: TextOverflow
                            .ellipsis,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                )),
            const SizedBox(
              width: 10,
            ),
            Container(
              width: 1,
              height: 65,
              color: Colors.grey.shade300,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0,right: 10,left:15 ),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        print('share');
                        Share.share(
                          'Look How to Cook this ${widget.article['strMeal']} ? check it Now ${
                              widget.article['strYoutube'] }',
                        );
                      },
                      child:  Icon(
                        Icons.share_rounded,
                        size: 25,
                        color: Theme.of(context).textColor2.withOpacity(0.8),
                      ),
                    ),
                    const Divider(),
                    Stack(
                      children: [

                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (isFav)
                              ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                    Colors.red, BlendMode.srcATop),
                                child: Lottie.asset(AppAsset.lovsStack,
                                    fit: BoxFit.cover,width: 35,height: 40,
                                    repeat: true,frameRate: FrameRate(60),alignment: AlignmentDirectional.center
                                ),
                              ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(isFav?Icons.favorite:Icons.heart_broken_outlined,
                                color:isFav?Colors.red:nearlyBlack ,),
                              onPressed: ()async{
                                await chaneData();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
);
  }
}

Widget listItem(context,List list)=>ConditionalBuilder(
    condition: list.isNotEmpty,
    builder: (context) =>
        ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => BuiltItem(article: list[index]),
          itemCount: list.length
            ),
    fallback: (context) =>
        ListView.separated(
          itemCount: 8,
          separatorBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 50),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey.shade200,
              ),
            );
          },
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => const BuildLoadingSkelton(),

        )
);




class BuildLoadingSkelton extends StatelessWidget {
  const BuildLoadingSkelton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Card(
        elevation: 8,
        child:   Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children:
            [
              Shimmer.fromColors(
                highlightColor:Theme.of(context).highlightColor ,
                baseColor: Theme.of(context).baseColor,
                child: Container(
                  width: 120.0,
                  height: 120.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0,),
                      color: Theme.of(context).baseColor
                  ),
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Container(
                  height: 120.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:
                    [
                      Shimmer.fromColors(
                          highlightColor:Theme.of(context).highlightColor ,
                          baseColor: Theme.of(context).baseColor,
                          child: myDivider(color: Theme.of(context).baseColor,height: 60)),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Shimmer.fromColors(
                          highlightColor:Theme.of(context).highlightColor ,
                          baseColor: Theme.of(context).baseColor,
                          child: myDivider(color: Theme.of(context).baseColor,height: 20))
                    ],
                  ),
                ),
              ),
              // const SizedBox(
              //   width: 8.0,
              // ),
            ],
          ),

        ),
      ),
    );
  }
}

