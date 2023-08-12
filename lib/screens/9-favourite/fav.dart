import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody/shared/widget/build_cat_item.dart';
import '../../../controller/cubit/home/cubit.dart';
import '../../../controller/cubit/home/states.dart';
import '../../shared/widget/empty_data.dart';


class FavScreen extends StatelessWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<homeCubit,homeStates>(
      builder: (context, state) {
        final cubit=BlocProvider.of<homeCubit>(context);

        return Scaffold(
            body: cubit.saveData.isEmpty ?
            const emptyDataItem(isFAvSC: true) :
            Padding(
              padding:  EdgeInsets.only(bottom: 130.h),
              child: listItemCo(
                  context,
                  cubit,
                  cubit.saveData,
                  isFavSC: true
              ),
            )
        );
      },
    );
  }

}
