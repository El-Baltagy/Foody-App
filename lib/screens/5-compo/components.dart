import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/widget/itemBox.dart';
import '../../../controller/cubit/home/cubit.dart';
import '../../../controller/cubit/home/states.dart';

class Components extends StatelessWidget {
  const Components({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   BlocProvider(
      create: (context) => homeCubit()..getComp(),
      child: BlocBuilder<homeCubit,homeStates>(
        builder: (context, state) {
          final cubit=homeCubit.getInstance(context);
          return  ItemShapePart(
            filterTypeArea: false,
            listPart: cubit.listComp,
          );
        },
      ),
    );
  }
}
