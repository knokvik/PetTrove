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
import 'package:pettrove/presentation/screens/pages/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure initialization before using shared preferences
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;
  bool _isFirstLaunch = true; // Track first launch state
  final AuthRepository _authRepository = AuthRepository();
  final ProductRepository _productRepository = ProductRepository();
  final BlogRepository blogRepository = BlogRepository();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    _checkFirstLaunch();
  }

  void _checkLoginStatus() async {
    bool isLoggedIn = await _authRepository.isLoggedIn();
    setState(() {
      _isLoggedIn = isLoggedIn;
    });
  }

  Future<void> _checkFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final hasLaunchedBefore = prefs.getBool('hasLaunched') ?? false;

    if (!hasLaunchedBefore) {
      // Mark as launched for the next time
      await prefs.setBool('hasLaunched', true);
    }

    setState(() {
      _isFirstLaunch = !hasLaunchedBefore;
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
        BlocProvider(create: (context) => ProductCubit(_productRepository)),
        BlocProvider<CartCubit>(
          create: (context) => CartCubit(),
          child: CartScreen(), // Your CartScreen widget
        ),
        BlocProvider(create: (context) => BlogCubit(blogRepository)),
      ],
      child: MaterialApp(
        title: 'PetTrove',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(22, 51, 0, 1)),
          useMaterial3: true,
        ),
        home: _isFirstLaunch
            ? const OnboardingScreen()
            : (_isLoggedIn ?  CurrentPage() : const SignInScreen()),
      ),
    );
  }
}
