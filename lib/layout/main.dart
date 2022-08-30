import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/styles/themes.dart';
import '../shared/network/remote/dio_helper.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  bool isDark = CacheHelper.getData(key: 'isDark');
  isDark = false;

  Widget widget;

  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token'); // عمله في ملف ال constant

  if(onBoarding != null)
  {
    if(token != null) widget = ShopLayout(); // معناها اني عديت من البوردينج و اللوجين
    else widget = ShopLoginScreen(); // عديت من البوردينج لكن لسة معملتش تسجيل دخول
  }
  else
  {
    widget = OnBoardingScreen(); // معدتش من حاجه لسة
  }

  BlocOverrides.runZoned(
        () {
      runApp(MyApp(
        isDark: isDark,
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {

  final bool isDark;
  final Widget startWidget;

  MyApp({
    this.isDark,
    this.startWidget,
  });

  // ال cubit طلاما هيستخدم في اكتر من مكان في الابلكيشن ساعتها هحطه في MultiBlocProvider

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers:
        [
          BlocProvider(
            create: (BuildContext context) => AppCubit()
              ..changeAppMode(
                fromShared: isDark,
              ),
          ),
          BlocProvider(
            create: (BuildContext context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
          ),
        ],
        child: BlocConsumer<AppCubit,AppStates> (
          listener: (context,state) {},
          builder: (context,state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
              home: startWidget,
        );
      },
    ),
    );
  }
}
