import 'package:sexeducation/state_management/theme_settings/theme_settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';

import 'assets/sexeducation_theme.dart';
import 'package:sexeducation/state_management/authentication/authentication_cubit.dart';
import 'package:sexeducation/core/router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:permission_handler/permission_handler.dart' as permission_handler;
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await initializeDateFormatting('fr_FR', null);
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainApp();
}

class _MainApp extends State<MainApp> {
  final AuthenticationCubit authenticationCubit = AuthenticationCubit();
  late Future<String?> permissionStatusFuture;


  @override
  void initState() {
    // TODO later for android
    // requestPermissions();
    super.initState();
  }

  Future<void> requestPermissions() async {
    final storagePermission = await permission_handler.Permission.storage.status;
    if (!storagePermission.isGranted) {
      await permission_handler.Permission.storage.request();
    }

    final notifPermission = await permission_handler.Permission.notification.status;
    if (!notifPermission.isGranted) {
      await permission_handler.Permission.storage.request();
    }
  }

  Widget build(BuildContext context) {
    final GoRouter router = AppRouter.routerWithAuthStream(
      authenticationCubit.stream,
    );
    return MultiBlocProvider(
        providers: [
          BlocProvider<ThemeSettingsCubit>(
            create: (context) => ThemeSettingsCubit(),
          ),
          BlocProvider.value(value: authenticationCubit),
        ],
        child: Builder(
          builder: (context) {
            return BlocBuilder<AuthenticationCubit, AuthenticationState>(
                builder: (context, state) {
              return BlocBuilder<ThemeSettingsCubit, ThemeSettingsState>(
                  builder: (context, state) {
                return MaterialApp.router(
                  title: "EliX",
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                      useMaterial3: true, colorScheme: lightColorScheme),
                  darkTheme: ThemeData(
                      useMaterial3: true, colorScheme: darkColorScheme),
                  themeMode: state.themeMode,
                  routerConfig: router,
                  localizationsDelegates: const [
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: const [
                      Locale('fr', 'FR'),
                    ],
                );
              });
            });
          },
        ));
  }
}
