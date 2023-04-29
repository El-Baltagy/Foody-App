import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../shared/components.dart';
import '../../shared/widget/itemBox.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class Countries extends StatelessWidget {
  const Countries({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homeCubit()..getCount(),
      child: BlocBuilder<homeCubit,homeStates>(
        builder: (context, state) {
          final cubit=homeCubit.getInstance(context);
          return  cubit.listCount.isNotEmpty? ItemShapePart(
            filterTypeArea: true,
            listPart: cubit.listCount,
          )
              :Container();
        },
      ),
    );
  }
}

