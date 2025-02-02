import 'package:diode_test/view/authenticationpages/Login_Page.dart';
import 'package:diode_test/view/mainpages/Splash_Page.dart';
import 'package:diode_test/viewmodel/cubit%20and%20state%20files/productordercubitandstate/productorder_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'viewmodel/cubit and state files/allcubitandstate/all_cubit.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AllCubit(context)),
        BlocProvider(create: (context) => ProductorderCubit(context)),
      ],
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false
        ,
        title: 'Flutter Demo',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplashPage()
    );
  }
}

