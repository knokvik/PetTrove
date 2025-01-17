import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pettrove/data/repository/auth_repository.dart';
import 'package:pettrove/presentation/screens/auth/login.dart';
import 'package:pettrove/presentation/screens/home.dart';
import 'package:pettrove/bloc/auth/auth_bloc.dart';

void main () async {
  WidgetsFlutterBinding.ensureInitialized();
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

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    
  }

  void _checkLoginStatus() async {
    await _authRepository.logout();
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
      ],
      child: MaterialApp(
        title: 'PetShop App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: _isLoggedIn ? Home() : const SignInScreen(),
      ),
    );
  }
}
