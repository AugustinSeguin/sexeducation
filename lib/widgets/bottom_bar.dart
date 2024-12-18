import 'package:sexeducation/views/users/account_view.dart';
import 'package:sexeducation/views/search_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sexeducation/assets/sexeducation_theme.dart';
import 'package:sexeducation/views/home_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sexeducation/state_management/theme_settings/theme_settings_cubit.dart';

class AppBarFooter extends StatelessWidget {
  const AppBarFooter({Key? key});

  String _getCurrentRoute(BuildContext context) {
    return GoRouterState.of(context).uri.toString();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeSettingsCubit, ThemeSettingsState>(
      builder: (context, state) {
        final bool isDarkMode = state.isDarkMode;
        return Container(
          color: isDarkMode ? darkColorScheme.surface : lightColorScheme.surface,
          height: 65.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.home),
                color: (_getCurrentRoute(context) == "/${HomeView.name}"
                    ? isDarkMode
                        ? darkColorScheme.primary
                        : lightColorScheme.primary
                    : isDarkMode
                        ? darkColorScheme.onSurfaceVariant
                        : lightColorScheme.onSurfaceVariant),
                tooltip: 'Home',
                onPressed: () {
                  GoRouter.of(context).pushNamed(HomeView.name);
                },
              ),
              IconButton(
                icon: const Icon(Icons.search),
                color: (_getCurrentRoute(context) == "/${SearchView.name}"
                    ? isDarkMode
                        ? darkColorScheme.primary
                        : lightColorScheme.primary
                    : isDarkMode
                        ? darkColorScheme.onSurfaceVariant
                        : lightColorScheme.onSurfaceVariant),
                tooltip: 'Search',
                onPressed: () {
                  GoRouter.of(context).pushNamed(SearchView.name);
                },
              ),
              IconButton(
                icon: const Icon(Icons.person),
                color: (_getCurrentRoute(context) == "/${AccountView.name}"
                    ? isDarkMode
                        ? darkColorScheme.primary
                        : lightColorScheme.primary
                    : isDarkMode
                        ? darkColorScheme.onSurfaceVariant
                        : lightColorScheme.onSurfaceVariant),
                tooltip: 'Your Account',
                onPressed: () {
                  GoRouter.of(context).pushNamed(AccountView.name);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
