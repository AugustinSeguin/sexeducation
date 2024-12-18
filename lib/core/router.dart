import 'dart:async';

import 'package:sexeducation/views/legal/legal_notices_view.dart';
import 'package:sexeducation/views/legal/privacy_policy_view.dart';
import 'package:sexeducation/views/notifications_view.dart';
import 'package:sexeducation/views/errors/error404_view.dart';
import 'package:sexeducation/views/users/account_view.dart';
import 'package:sexeducation/views/settings_view.dart';
import 'package:sexeducation/views/search_view.dart';
import 'package:sexeducation/state_management/authentication/authentication_cubit.dart';
import 'package:sexeducation/views/auth/register_view.dart';
import 'package:sexeducation/views/auth/login_view.dart';
import 'package:sexeducation/views/home_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/web.dart';

abstract class AppRouter {
  /// Public routes
  static List<String> get publicRoutes => [
        '/login',
        '/register',
      ];

  /// Creates a [GoRouter] with a [GoRouterRefreshStream] that listens to the
  /// [AuthenticationCubit] stream.
  static GoRouter routerWithAuthStream(Stream<AuthenticationState> stream) {
    return GoRouter(
      errorBuilder: (context, state) => const Error404View(),
      routes: [
        GoRoute(
          path: '/login',
          name: LoginView.name,
          builder: (context, state) => LoginView(),
        ),
        GoRoute(
          path: '/register',
          name: RegisterView.name,
          builder: (context, state) => RegisterView(),
        ),
        GoRoute(
          path: '/home',
          name: HomeView.name,
          builder: (context, state) => HomeView(),
        ),
        GoRoute(
          path: '/account',
          name: AccountView.name,
          builder: (context, state) => const AccountView(),
        ),
        GoRoute(
          path: '/search',
          name: SearchView.name,
          builder: (context, state) => SearchView(),
        ),
        GoRoute(
          path: '/settings',
          name: SettingsView.name,
          builder: (context, state) => const SettingsView(),
        ),
        GoRoute(
          path: '/notifications',
          name: NotificationsView.name,
          builder: (context, state) => NotificationsView(),
        ),
        GoRoute(
          path: '/legal-notices',
          name: LegalNoticesView.name,
          builder: (context, state) => const LegalNoticesView(),
        ),
        GoRoute(
          path: '/privacy-policy',
          name: PrivacyPolicyView.name,
          builder: (context, state) => const PrivacyPolicyView(),
        ),

      ],
      refreshListenable: GoRouterRefreshStream(stream),
      redirect: (context, state) async {
        // If the user is not authenticated, redirect to the login page.
        final status = context.read<AuthenticationCubit>().state;

        // Vérifier si l'onboarding a déjà été vu (exemple avec SharedPreferences)
        final prefs = await SharedPreferences.getInstance();
        // final onboardingSeen = prefs.getBool('onboardingSeen') ?? false;

        // Rediriger vers l'onboarding si ce n'est pas encore vu
        // if (!onboardingSeen) {
        //   return '/onboarding';
//         // }

        // If the user is authenticated, redirect to the home page (only if
        // the current location is public page)
        if (publicRoutes.contains(state.uri.toString()) &&
            status is AuthenticationAuthenticated) {
          return '/home';
        }
        // If the user is not authenticated, redirect to the login page.
        // (only if the current location is not a public page).
        if (!publicRoutes.contains(state.uri.toString()) &&
          status is AuthenticationUnauthenticated || status is AuthenticationInitial) {

            debugPrint(state.uri.toString());
            debugPrint(status.toString());


          return '/login';
        }

        return null;
      },
    );
  }
}

/// A [ChangeNotifier] that listens to a [Stream] and notifies listeners when
/// the stream emits an event.
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
