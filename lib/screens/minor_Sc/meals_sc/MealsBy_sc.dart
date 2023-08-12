import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../controller/cubit/home/cubit.dart';
import '../../../controller/cubit/home/states.dart';
import 'package:foody/shared/manager/app_color.dart';
import '../../../shared/widget/build_cat_item.dart';



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
                backgroundColor:  Theme.of(context).scaffoldBackgroundColor,
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