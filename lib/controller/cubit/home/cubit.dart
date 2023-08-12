import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody/controller/cubit/home/states.dart';
import 'package:foody/screens/6-countries/count.dart';
import 'package:sqflite/sqflite.dart';

import '../../../screens/4-home/home_screen.dart';
import '../../../screens/5-compo/components.dart';
import '../../../screens/8-search/search.dart';
import '../../../screens/9-favourite/fav.dart';
import '../../../shared/manager/app_methods.dart';
import '../../../shared/manager/app_string.dart'as key;
import '../../../shared/network/local/cash_helper.dart';
import '../../../shared/widget/custom_drawer/home_drawer.dart';









class homeCubit extends Cubit<homeStates> {
  homeCubit() :super(initialState());

  static homeCubit getInstance(context) => BlocProvider.of(context);

  int currentIndex = 0;
  int i = 0;
  int k = 0;
  int l = 0;
  bool connected = true;
  bool multiple = true;
  TextEditingController searchController=TextEditingController();

  bool isColorful=false;
  changeColor(){
    isColorful=!isColorful;
    emit(initialState());
  }

  changIndex(SI) {
    l=SI;
    emit(changIndx());
  }
  clearSearch(){
    searchController.text = '';
    emit(initialState());
  }
  pageView(value,context){
    if (value!=l &&value<13) {
      changIndex(value);
      DefaultTabController.of(context).animateTo(value);
    } else{
      return null;
    }
  }

  List<Widget>pages = [
    const HomeScreen(),
    const Components(),

    const Countries(),
    Search(),
    const FavScreen(),
  ];

  DrawerIndex? drawerIndex;
  changeBottom(index) {
    currentIndex = index;

    switch (index) {
      case 0:
        drawerIndex=DrawerIndex.HOME;
        break;
      case 1:
        drawerIndex=DrawerIndex.Help;
        break;
      case 4:
        drawerIndex=DrawerIndex.fav;
        break;
      case 2:
        drawerIndex=DrawerIndex.FeedBack;
        break;
      case 3:
        drawerIndex=DrawerIndex.Share;
        break;
      default:
        break;
    }

    emit(changeBottomNav());
  }
  init (){
    drawerIndex = DrawerIndex.HOME;
  }
  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      switch (drawerIndex) {
        case DrawerIndex.HOME:
          currentIndex = 0;
          break;
        case DrawerIndex.Help:
          currentIndex = 1;
          break;
      case DrawerIndex.fav:
      currentIndex = 4;
      break;
        case DrawerIndex.FeedBack:
          currentIndex = 2;
          break;
        case DrawerIndex.Share:
          currentIndex = 3;
          break;
        default:
          break;
      }
    }
    emit(initialState());
  }


  gridTab() {
    multiple = !multiple;
    emit(initialState());
  }

  List<dynamic>listSE = [];

  getMealSearche(value) {
    Timer(const Duration(seconds: 0), () {
      getData(
          url: 'https://www.themealdb.com/api/json/v1/1/search.php?f=$value')
          .then((value) {
        listSE = value.data[key.meals];
        print(listSE.length);
        // print(listV[0]['strMeal']);
        emit(initialState());
      });
    });
    emit(initialState());
  }

  List<dynamic>listCat = [];

  getMealCat(CategoryName) {
    Timer(const Duration(seconds: 0), () {
      getData(
          url: 'https://www.themealdb.com/api/json/v1/1/filter.php?c=$CategoryName')
          .then((value) {
        listCat = value.data[key.meals];
        print(listCat.length);
        // print(listV[0]['strMeal']);
        emit(initialState());
      });
    });
    emit(initialState());
  }

  List<dynamic>listArea = [];

  getMealArea(AreaName) {
    Timer(const Duration(seconds: 0), () {
      getData(
          url: 'https://www.themealdb.com/api/json/v1/1/filter.php?a=$AreaName')
          .then((value) {
        listArea = value.data[key.meals];
        print(listArea.length);
        // print(listV[0]['strMeal']);
        emit(initialState());
      });
    });
    emit(initialState());
  }

  List<dynamic>listIng = [];

  getMealIng(ingredientName) {
    Timer(const Duration(seconds: 0), () {
      getData(
          url: 'http://www.themealdb.com/api/json/v1/1/filter.php?i=$ingredientName')
          .then((value) {
        listIng = value.data[key.meals];
        print(listIng.length);
        // print(listV[0]['strMeal']);
        emit(initialState());
      });
    });
    emit(initialState());
  }

  List<String>listComp = [];

  getComp() {
    Timer(const Duration(seconds: 1,milliseconds: 200), () {
      getData(
          url: 'https://www.themealdb.com/api/json/v1/1/list.php?i=list')
          .then((value) {
        for (int i = 0; i < value.data[key.meals].length; i++) {
          listComp .add(value.data[key.meals][i][key.strIngredient].toString());
        }
        print(listComp.length);
        // print(listV[0]['strMeal']);
        emit(initialState());
      });
    });
    emit(initialState());

  }

  List<String>listCount = [];

  getCount() {
    Timer(const Duration(seconds: 1,milliseconds: 200), () {
      getData(
          url: 'https://www.themealdb.com/api/json/v1/1/list.php?a=list')
          .then((value) {
        for (int i = 0; i < value.data[key.meals].length; i++) {
          listCount .add(value.data[key.meals][i][key.strArea].toString());
        }
        print(listCount.length);
        // print(listV[0]['strMeal']);
        emit(initialState());
      });
    });
    emit(initialState());
  }

  List<dynamic>listId = [];
  List<dynamic> Ingredient=[];
  List<dynamic> Measure=[];

  getMealId(ID) {
    listId.clear();
    Ingredient.clear();
    Measure.clear();
    Timer(const Duration(seconds: 0), () {
      getData(
          url: 'https://www.themealdb.com/api/json/v1/1/lookup.php?i=$ID')
          .then((value) {
        listId = value.data[key.meals];
        print(listIng.length);
        // print(listV[0]['strMeal']);
        emit(initialState());
        Ingredient=  [
          listId[0][key.strIngredient1],
          listId[0][key.strIngredient2],
          listId[0][key.strIngredient3],
          listId[0][key.strIngredient4],
          listId[0][key.strIngredient5],
          listId[0][key.strIngredient6],
          listId[0][key.strIngredient7],
          listId[0][key.strIngredient8],
          listId[0][key.strIngredient9],
          listId[0][key.strIngredient10],
          listId[0][key.strIngredient11],
          listId[0][key.strIngredient12],
          listId[0][key.strIngredient13],
          listId[0][key.strIngredient14],
          listId[0][key.strIngredient15],
          listId[0][key.strIngredient16],
          listId[0][key.strIngredient17],
          listId[0][key.strIngredient18],
          listId[0][key.strIngredient19],
          listId[0][key.strIngredient20],
        ] ;
        Measure =  [
          listId[0][key.strMeasure1],
          listId[0][key.strMeasure2],
          listId[0][key.strMeasure3],
          listId[0][key.strMeasure4],
          listId[0][key.strMeasure5],
          listId[0][key.strMeasure6],
          listId[0][key.strMeasure7],
          listId[0][key.strMeasure8],
          listId[0][key.strMeasure9],
          listId[0][key.strMeasure10],
          listId[0][key.strMeasure11],
          listId[0][key.strMeasure12],
          listId[0][key.strMeasure13],
          listId[0][key.strMeasure14],
          listId[0][key.strMeasure15],
          listId[0][key.strMeasure16],
          listId[0][key.strMeasure17],
          listId[0][key.strMeasure18],
          listId[0][key.strMeasure19],
          listId[0][key.strMeasure20],
        ];

      });
    });
    emit(initialState());
    return listId;
  }




  Database? db ;
  List<Map> saveData = [];
clearItem(index){
  saveData.removeAt(index);
  emit(initialState());
}
  void createDatabase() async {
    db = await openDatabase(
        'FOOD.db',
        version: 1,
        onCreate: (database,version)
        {
          database.execute("CREATE TABLE FOOD (idMeal TEXT, strMealThumb TEXT,strMeal TEXT,condition TEXT)").then((value)
          {
            emit(CreateDatabaseState());
            print("News Table created successfully");
          }).catchError((e)=>print("error during create table"));
        },
        onOpen: (database)
        {
          // get Data from Database Method & emit()
          getDatabase(database);
          print("News.db opened successfully");
        }
    );
  }

  // 2. Insert Data to food table
  Future<void> InsertTODatabase(context,{
    required String idMeal,
    required String thumbnail,
    required String textDesc,
  })
  async {
    print('......................'+idMeal.toString());
    print('......................'+thumbnail.toString());
    print('......................'+textDesc.toString());
    try{

      await db?.transaction((txn) async {
        txn.rawInsert('INSERT INTO FOOD(idMeal,strMealThumb,strMeal) VALUES ("$idMeal","$thumbnail","$textDesc")').
        whenComplete((){
          print('...........................................');
          print("Data was inserted to Database where idMeal is .............$idMeal");
          showSnackBar(
            context,"item added to Favourite successfully",
            backgroundColor: Colors.green,
          );
          getDatabase(db!);
        });


      });

    }catch (e){
      print('sssssssssssssssssssssssssssssssssssssssssssss');
      print(e.toString());
    }

    emit(InsertToDatabaseState());
  }

  // 3. get Data form Database
  Future getDatabase(Database database,)
  {
    // saveData.clear();
    return database.rawQuery("SELECT * FROM FOOD").then((value)
    {
      saveData=value;
      print('$value'.toString());
      emit(GetDataFromDatabaseState());
    }).catchError((e)=>print("error during get data from database"));
  }

   Future<void>DeleteDatebase(context,{required String id}) async{
    try{
      await db?.rawUpdate(
          'DELETE FROM FOOD WHERE idMeal = ?',
          [id]
      ).whenComplete((){
        print('deleted..................................  $id');
        showSnackBar(
          context,"item Deleted Successfully" ,
        );
      });
      getDatabase(db!);
    }catch (e){
      print('.....................');
      print(e.toString());
    }

  }


}


Future<Response> getData({
  required String url,
}) async
{
  return await Dio().get(
    url,
  );
}

// Database? db ;
// List<Map> archivedData = [];
//
// void createDatabase() async {
//   db = await openDatabase(
//       'FOOD.db',
//       version: 1,
//       onCreate: (database,version)
//       {
//         database.execute("CREATE TABLE FOOD (id INTEGER PRIMARY KEY, idMeal TEXT)").then((value)
//         {
//           emit(CreateDatabaseState());
//           print("News Table created successfully");
//         }).catchError((e)=>print("error during create table"));
//       },
//       onOpen: (database)
//       {
//         // get Data from Database Method & emit()
//         getDatabase(database);
//         print("News.db opened successfully");
//       }
//   );
// }
//
// // 2. Insert Data to news table
// Future<void> InsertTODatabase(context,{
//   required String idMeal
// })
// async {
//   await db?.transaction((txn) async {
//     txn.rawInsert('INSERT INTO FOOD(idMeal) VALUES ("$idMeal")').whenComplete((){
//       print("Data was inserted to Database are => $idMeal");
//       showSnackBar(
//         context,"item added to Favourite successfully",
//         backgroundColor: Colors.green,
//       );
//       getDatabase(db!);
//     });
//   });
//   emit(InsertToDatabaseState());
// }
//
// // 3. get Data form Database
// Future getDatabase(Database database,)
// {
//   return database.rawQuery("SELECT * FROM FOOD").then((value)
//   {
//     archivedData = value;
//     emit(GetDataFromDatabaseState());
//   }).catchError((e)=>debugPrint("error during get data from database"));
// }
// // 4. delete item from database
// DeleteDatebase(context,{required String id}) async{
//   try{
//     await db?.rawUpdate(
//         'DELETE FROM FOOD WHERE idMeal = ?',
//         [id]
//     ).whenComplete((){
//       print('deleted..................................  $id');
//       showSnackBar(
//         context,"item Deleted Successfully" ,
//       );
//     });
//   }catch (e){
//     print(e.toString());
//   }
//
// }