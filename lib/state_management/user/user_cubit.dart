import 'package:sexeducation/models/user_model.dart';
import 'package:sexeducation/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<void> getUser(int userId) async {
    try {
      emit(UserLoading());
      final user = await UserService.getUser(userId);
      final userAuthenticated = await UserService.getCurrentUser();

      emit(UserSuccess(user));
    } catch (error) {
      emit(UserError(error.toString()));
    }
  }

  Future<void> updateUserAccount({
    required String firstname,
    required String lastname,
    String? biography,
    DateTime? birthdate,
    String? position,
  }) async {
    final user = UserModel(
      lastname: lastname,
      firstname: firstname,
      position: position,
      biography: biography,
      birthdate: birthdate?.toIso8601String(),
    );

    try {
      emit(UserLoading());
      await UserService.updateUserAccount(user);
      emit(UserAccountSuccess(user));
    } catch (error) {
      emit(UserError(
          "Erreur rencontrée pour la mise à jour de vos données. Veuillez réessayer."));
    }
  }

  Future<void> submitReport(int userId, String result) async {
    try {
      emit(UserLoading());
      await UserService.submitReport(userId, result);
      final user = await UserService.getUser(userId);

      emit(UserSuccess(user));
    } catch (error) {
      emit(UserError(
          "Erreur rencontrée lors du signalement. Veuillez réessayer."));
    }
  }

  Future<void> changePassword(
      {required String oldPassword,
      required String password,
      required String passwordRepeated}) async {
    try {
      emit(UserLoading());
      await UserService.changePassword(
          oldPassword: oldPassword,
          password: password,
          passwordRepeated: passwordRepeated);
      final user = await UserService.getCurrentUser();
      emit(UserSuccess(user));
    } catch (error) {
      emit(UserError(
          "Erreur rencontrée lors du changement de mot de passe. Veuillez réessayer."));
    }
  }
}
