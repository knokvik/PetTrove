import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pettrove/cubit/products.dart';
import 'package:pettrove/data/repository/auth_repository.dart';
import 'package:pettrove/data/repository/product_repository.dart';
import 'package:pettrove/presentation/screens/auth/login.dart';
import 'package:pettrove/presentation/screens/current_page.dart';
import 'package:pettrove/bloc/auth/auth_bloc.dart';

void main () async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;
  final AuthRepository _authRepository = AuthRepository();
  final ProductRepository _productRepository = ProductRepository();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    
  }

  void _checkLoginStatus() async {
    bool isLoggedIn = await _authRepository.isLoggedIn();
    setState(() {
      _isLoggedIn = isLoggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(authRepository: _authRepository),
        ),
        BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(authRepository: AuthRepository()),
        ),
        BlocProvider(create: (context) => ProductCubit( _productRepository )),
      ],
      child: MaterialApp(
        title: 'PetShop App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: _isLoggedIn ? CurrentPage() : const SignInScreen(),
      ),
    );
  }
}
