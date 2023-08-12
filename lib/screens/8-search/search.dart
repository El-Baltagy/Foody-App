import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../controller/cubit/home/cubit.dart';
import '../../../controller/cubit/home/states.dart';
import '../../shared/manager/app_methods.dart';
import '../../shared/network/local/cash_helper.dart';
import '../../shared/widget/built_search_Item.dart';


class Search extends StatefulWidget {
   Search() ;

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<homeCubit>(context).getMealSearche(CashHelper.getData(key: 'search key')??'k');
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<homeCubit,homeStates>(
      builder: (context, state) {

        final cubit=BlocProvider.of<homeCubit>(context);

        return Scaffold(
          appBar: PreferredSize( preferredSize:  Size(double.maxFinite, 80.h),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0).copyWith(top: 5),
              child: buildTextFormField(
                padding: const EdgeInsets.all(0),
                controller: cubit.searchController,
                Type: TextInputType.text,
                suffix: cubit.searchController.text != '' ? Icons.clear : null,
                prefix: Icons.search,
                labelTitle: 'Search By First Ch',
                suffixPressed: (){
                  cubit.clearSearch();
                  cubit.listSE.clear();
                },
                onChange: (value) {
                  // searchController.text != '';
                  cubit.listSE.clear();
                  cubit.getMealSearche(value.toUpperCase());
                  CashHelper.saveData(key: 'search key', value: value);
                },

              ),
            )),
          body: Padding(
            padding: const EdgeInsets.only(bottom: 142),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: listItem(context,cubit.listSE),
            ),
          ),
        );
      }
    );
  }
}