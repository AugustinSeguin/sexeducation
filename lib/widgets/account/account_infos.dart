import 'package:sexeducation/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sexeducation/state_management/authentication/authentication_cubit.dart';

class AccountInfo extends StatefulWidget {
  AccountInfo({super.key, required this.user, required this.isBlocked});

  final UserModel user;
  final bool isBlocked;

  static String name = 'account';

  @override
  _AccountInfo createState() => _AccountInfo();
}

class _AccountInfo extends State<AccountInfo>
    with SingleTickerProviderStateMixin {
  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<void> refreshData() async {
    setState(() {
      // Refresh data
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserModel user = widget.user;
    final bool isBlocked = widget.isBlocked;

    final authenticationState = context.read<AuthenticationCubit>().state;
    final userAuthenticated = authenticationState.user;

    return RefreshIndicator(
      key: refreshIndicatorKey,
      onRefresh: refreshData,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // ... First Bloc: Profil Picture, Username, Location, Badge ...
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 86,
                  height: 86,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: const AssetImage('assets/profile.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.firstname ?? 'Username',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      user.position ?? 'Le Monde',
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Second Bloc: Followings, Followers, Challenges Completed
          ],
        ),
      ),
    );
  }
}
