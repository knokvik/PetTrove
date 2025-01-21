import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pettrove/cubit/blog_cubit.dart';
import 'package:pettrove/cubit/cart_cubit.dart';
import 'package:pettrove/cubit/products.dart';
import 'package:pettrove/data/repository/auth_repository.dart';
import 'package:pettrove/data/repository/blog_repository.dart';
import 'package:pettrove/data/repository/product_repository.dart';
import 'package:pettrove/presentation/screens/auth/login.dart';
import 'package:pettrove/presentation/screens/current_page.dart';
import 'package:pettrove/bloc/auth/auth_bloc.dart';
import 'package:pettrove/presentation/screens/pages/cart.dart';

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
  final BlogRepository blogRepository = BlogRepository();

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
        BlocProvider<CartCubit>(
        create: (context) => CartCubit(),
        child: CartScreen(), // Your CartScreen widget
      ),
        BlocProvider(create: (context) => BlogCubit( blogRepository )),
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
