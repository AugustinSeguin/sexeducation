import 'dart:io';
import 'package:date_field/date_field.dart';
import 'package:sexeducation/models/user_model.dart';
import 'package:sexeducation/state_management/user/user_cubit.dart';
import 'package:sexeducation/views/users/account_view.dart';
import 'package:flutter/material.dart';
import 'package:sexeducation/assets/sexeducation_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:intl/intl.dart';
import 'package:image/image.dart' as img;
import 'dart:typed_data';

class UpdateAccountWidget extends StatefulWidget {
  UpdateAccountWidget({super.key, required this.user});
  final UserModel user;

  @override
  _UpdateAccountWidget createState() => _UpdateAccountWidget();
}

class _UpdateAccountWidget extends State<UpdateAccountWidget> {
  final formKey = GlobalKey<FormState>();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final positionController = TextEditingController();
  final biographyController = TextEditingController();
  DateTime? birthdate;

  Future<File> compressImage(File imageFile) async {
    Uint8List imageBytes = await imageFile.readAsBytes();
    img.Image? image = img.decodeImage(imageBytes);

    if (image != null) {
      img.Image resizedImage = img.copyResize(image, width: 800);
      Uint8List compressedImage =
          Uint8List.fromList(img.encodeJpg(resizedImage, quality: 85));

      final tempDir = Directory.systemTemp;
      final tempFile = File('${tempDir.path}/temp_image.jpg');
      await tempFile.writeAsBytes(compressedImage);

      return tempFile;
    } else {
      throw Exception('Error processing the image');
    }
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = widget.user;
    firstnameController.text = user.firstname ?? "";
    lastnameController.text = user.lastname ?? "";
    positionController.text = user.position ?? "";
    biographyController.text = user.biography ?? "";
    birthdate = user.birthdate == '' || user.birthdate == null
        ? null
        : DateTime.parse(user.birthdate!);

    final DateTime defaultDate =
        DateTime.now().subtract(Duration(days: 365 * 20));

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            BlocProvider(
              create: (context) => UserCubit(),
              child: Builder(
                builder: (context) {
                  return BlocListener<UserCubit, UserState>(
                    listener: (context, state) {
                      if (state is UserError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Erreur lors de la mise à jour de vos données.')),
                        );
                      }
                      if (state is UserAccountSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Mise à jour réussie')),
                        );
                      }
                    },
                    child: Form(
                      key: formKey,
                      child: Column(children: <Widget>[
                        const SizedBox(height: 20),
                        BlocBuilder<UserCubit, UserState>(
                          builder: (BuildContext context, UserState state) {
                            return Column(
                              children: [
                                Container(
                                  alignment: Alignment.topCenter,
                                  padding: const EdgeInsets.all(10),
                                  child: TextFormField(
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    controller: firstnameController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Prenom',
                                      hintText: user.firstname ?? '',
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topCenter,
                                  padding: const EdgeInsets.all(10),
                                  child: TextFormField(
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    controller: lastnameController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Nom',
                                      hintText: user.lastname ?? '',
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topCenter,
                                  padding: const EdgeInsets.all(10),
                                  child: TextFormField(
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    controller: biographyController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Biographie',
                                      hintText: user.biography ?? '',
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topCenter,
                                  padding: const EdgeInsets.all(10),
                                  child: TextFormField(
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    controller: positionController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Géolocalisation',
                                      hintText: user.position ?? '',
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  constraints: BoxConstraints(
                                    minWidth:
                                        (MediaQuery.of(context).size.width -
                                            36),
                                  ),
                                  child: DateTimeFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    initialValue: birthdate ?? defaultDate,
                                    initialPickerDateTime:
                                        birthdate ?? defaultDate,
                                    mode: DateTimeFieldPickerMode.date,
                                    dateFormat: DateFormat.yMMMd('fr_FR'),
                                    decoration: const InputDecoration(
                                      hintStyle:
                                          TextStyle(color: Colors.black45),
                                      errorStyle:
                                          TextStyle(color: Colors.redAccent),
                                      border: OutlineInputBorder(),
                                      suffixIcon: Icon(Icons.event_note),
                                      labelText: 'Date d\'anniversaire',
                                    ),
                                    onChanged: (DateTime? value) {
                                      birthdate = value;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: SizedBox(
                                    width: (MediaQuery.of(context).size.width +
                                            60) /
                                        2,
                                    height: 50.0,
                                    child: FilledButton(
                                      onPressed: () async {
                                        if (formKey.currentState!.validate()) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'Mise à jour des données en cours...')),
                                          );
                                          context
                                              .read<UserCubit>()
                                              .updateUserAccount(
                                                firstname:
                                                    firstnameController.text,
                                                lastname:
                                                    lastnameController.text,
                                                position:
                                                    positionController.text,
                                                biography:
                                                    biographyController.text,
                                                birthdate: birthdate,
                                              );
                                          GoRouter.of(context)
                                              .pushNamed(AccountView.name);
                                        }
                                      },
                                      child: const Text(
                                          'Mettre à jour mon profil'),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
