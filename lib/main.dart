import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_doc_savimex/feature/repositories/employee_repo.dart';
import 'package:online_doc_savimex/feature/screen/Login/login_screen.dart';
import 'package:online_doc_savimex/feature/screen/register/register_bloc/bloc.dart';
import 'package:online_doc_savimex/feature/screen/register/register_bloc/event.dart';
import 'feature/repositories/auth_repo.dart';
import 'feature/repositories/department_repo.dart';

void main() {
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthRepository(),
        ),
        RepositoryProvider<DepartmentRepository>(
          create: (_) => DepartmentRepository(),
        ),
        RepositoryProvider<EmployeeRepository>(create: (_) => EmployeeRepository())
      ],
      child: MultiBlocProvider(
        providers: [
          // Registration Bloc (loads departments up-front)
          BlocProvider<RegisterBloc>(
            create: (ctx) => RegisterBloc(
              depRepo:  ctx.read<DepartmentRepository>(),
              authRepo: ctx.read<AuthRepository>(),
            )
              ..add(LoadDepartments()),
          ),

          // (You can add other Blocs here, e.g. AuthBloc, EmployeeBloc, etc.)
        ],
        child: const MyApp(),
      ),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/' : (context) => LoginScreen(),
      },
    );
  }
}