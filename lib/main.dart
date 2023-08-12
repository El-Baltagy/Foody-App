import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody/screens/2-on_boarding_sc/on_boarding.dart';
import 'package:foody/screens/3-layout/layout.dart';
import '../../../controller/cubit/home/cubit.dart';
import 'package:foody/shared/manager/app_theme.dart';
import 'package:foody/shared/network/local/cash_helper.dart';

import 'controller/cubit/bloc_observe.dart';
import 'controller/cubit/theme/theme_cubit.dart';
import 'controller/cubit/theme/theme_state.dart';
import 'shared/widget/restart.dart';


 main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await CashHelper.init();
  // await DioHelper.init();
  Bloc.observer = MyBlocObserver();
  bool onBoarding=CashHelper.getBoolean(key:'onBoarding')??false;
  runApp(RestartWidget(
    child: MultiBlocProvider(
      child: MyApp(onBoarding:onBoarding),
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => homeCubit()..init()..createDatabase()),

      ],
    ) ,
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.onBoarding});
final bool onBoarding;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit,ThemeState>(
      builder: (context, state) {
        final cubit=ThemeCubit.get(context);
        return ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) =>MaterialApp(
            title: 'Foody App',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: cubit.isDarkTheme? ThemeMode.dark: ThemeMode.light,
            home:  onBoarding? const LayOut():OnBoardingSC(),
          ) ,
        );
      } ,

    );
  }
}
