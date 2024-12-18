import 'package:sexeducation/state_management/notifications/notifications_cubit.dart';
import 'package:sexeducation/widgets/app_bar.dart';
import 'package:sexeducation/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NotificationsView extends StatelessWidget {
  static String name = 'notifications';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ThemeAppBar(title: 'Notifications'),
      bottomNavigationBar: const AppBarFooter(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            BlocProvider<NotificationsCubit>(
              create: (context) {
                final cubit = NotificationsCubit();
                cubit.getNotifications();
                return cubit;
              },
              child: BlocBuilder<NotificationsCubit, NotificationsState>(
                  builder: (context, state) {
                if (state is NotificationsStateInitial ||
                    state is NotificationsStateLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NotificationsStateError) {
                  return Center(child: Text(state.message));
                } else if (state is NotificationsStateSuccess) {
                  if (state.notifications!.isEmpty) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      child: const Center(
                        child: Text('Pas de notifications pour le moment'),
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.notifications!.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(state.notifications!.elementAt(index).title!),
                      onTap: () {
                      },
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),
            )
          ],
        ),
      ),
    );
  }
}
