import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody/screens/cubit/cubit.dart';
import 'package:foody/screens/cubit/states.dart';
import 'package:foody/shared/manager/color.dart';
import '../../shared/widget/build_cat_item.dart';


// class MealsByCategotrieScreen extends StatelessWidget {
//   const MealsByCategotrieScreen(
//       {Key? key, required this.categoryname, required this.filterType,required this.isCat})
//       : super(key: key);
//   final String categoryname,filterType;
//   final bool isCat;
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<homeCubit,homeStates>(
//         builder: (context, state) {
//           final cubit=homeCubit.getInstance(context);
//           return Scaffold(
//               backgroundColor:  Theme
//                   .of(context)
//                   .scaffoldBackgroundColor,
//               appBar: !isCat ? AppBar(
//                 backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//                 iconTheme:  IconThemeData(color: primaryColor),
//                 elevation: 0,
//                 titleSpacing: 0,
//                 title: Text(
//                   categoryname + ' Meals',
//                   style: const TextStyle(
//                       color: primaryColor, fontWeight: FontWeight.bold),
//                 ),
//               ) : null,
//               body: FutureBuilder<List<MealsByCategorie>>(
//                 future: filterType == 'Categorie'
//                     ? MealByData.GetMealByCategory(categoryname)
//                     : filterType == 'Area'
//                     ? MealByData.GetMealByArea(categoryname)
//                     : filterType == 'Ingredient'
//                     ? MealByData.GetMealByCIntegration(categoryname)
//                     : null,
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     return Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10.0).copyWith(
//                             top: 10),
//                         child:
//                         GridView.builder(
//                           shrinkWrap: true,
//                             physics: const BouncingScrollPhysics(),
//                             gridDelegate:
//                             SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: cubit.multiple?2:1,
//                               mainAxisSpacing: 10,
//                               crossAxisSpacing: 10,
//                             ),
//                             itemCount:snapshot.data!.length,
//                             itemBuilder: (context, index) {
//                             return BuildStackItem(
//                               cubit: cubit,
//                               index:index ,
//                               categoryname:categoryname,
//                               snapshot:snapshot ,multiple: cubit.multiple,
//                             );
//                             })
//                     );
//                   } else {
//                     return LoadingSkItem(multiple: cubit.multiple,);
//                   }
//                 },
//               ));
//         });
//   }
//
// }


class MealsByCatScreen extends StatelessWidget {
   MealsByCatScreen(
        { this.isCat=false,required this.categoryname});
  final String categoryname;
  bool isCat;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<homeCubit,homeStates>(
        builder: (context, state) {
          final cubit=homeCubit.getInstance(context);
          return Scaffold(
              backgroundColor:  Theme.of(context).scaffoldBackgroundColor,
              appBar: isCat? buildBar(context,categoryname):null,
              body:listItemCo(
                context,
                cubit,
                cubit.listCat
              )
          );
  }
    );
}}

class MealsByAreaScreen extends StatelessWidget {
  const MealsByAreaScreen(
      {Key? key, required this.areaName})
      : super(key: key);
  final String areaName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homeCubit()..listArea.clear()..getMealArea(areaName),
      child: BlocBuilder<homeCubit,homeStates>(
          builder: (context, state) {
            final cubit=homeCubit.getInstance(context);
            return Scaffold(
                backgroundColor:  Theme
                    .of(context)
                    .scaffoldBackgroundColor,
                appBar: buildBar(context,areaName),
                body: listItemCo(
                    context,
                    cubit,
                    cubit.listArea
                )
            );
          }),
    );
  }

}

class MealsByIngredientScreen extends StatelessWidget {
  const MealsByIngredientScreen(
      {Key? key, required this.ingredient})
      : super(key: key);
  final String ingredient;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homeCubit()..listIng.clear()..getMealIng(ingredient),
      child: BlocBuilder<homeCubit,homeStates>(
          builder: (context, state) {
            final cubit=homeCubit.getInstance(context);
            return Scaffold(
                backgroundColor:  Theme.of(context).scaffoldBackgroundColor,
                appBar: buildBar(context,ingredient),
                body: listItemCo(
                    context,
                    cubit,
                    cubit.listIng
                )
            );
          }),
    );
  }
}



PreferredSizeWidget buildBar(context,categoryname)=> AppBar(
  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
  iconTheme:  IconThemeData(color: primaryColor),
  elevation: 0,
  titleSpacing: 0,
  title: Text(
    categoryname + ' Meals',
    style: const TextStyle(
        color: primaryColor, fontWeight: FontWeight.bold),
  ),
);