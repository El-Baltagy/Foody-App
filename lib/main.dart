
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody/screens/1-splach_screen/splach_sc.dart';
import 'package:foody/screens/3-layout/layout.dart';
import 'package:foody/screens/cubit/bloc_observe.dart';
import 'package:foody/screens/cubit/cubit.dart';
import 'package:foody/shared/manager/theme/app_theme.dart';
import 'package:foody/shared/manager/theme/cubit/theme_cubit.dart';
import 'package:foody/shared/manager/theme/cubit/theme_state.dart';
import 'package:foody/shared/network/cash_helper.dart';


import 'shared/widget/restart.dart';


 main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await CashHelper.init();
  // await DioHelper.init();
  Bloc.observer = MyBlocObserver();

  runApp(RestartWidget(
    child:MyApp() ,
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => homeCubit()..getMealCat('Beef')..init()..createDatabase()),
      ],
      child: BlocBuilder<ThemeCubit,ThemeState>(
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
              initialRoute: 'layout',
              routes: {
                '/': (context) =>  SplashSc(),
                'layout': (context) => const LayOut(),
              },
            ) ,
          );
        } ,

      ),
    );
  }
}
