import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/shared/network/local/cach_helper.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(
        email: email,
        name: name,
        phone: phone,
        uId: value.user!.uid,
      );
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uId,
  }) {
    UserModel model = UserModel(
      name,
      email,
      phone,
      uId,
      false,
      'https://images.pexels.com/photos/1374510/pexels-photo-1374510.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      'write your bio ...',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSI_xMc-DtA50YGsy2Skp-1jhk8nqyberYNAdZM2bXVPWfGs356oiAeOtVHaA&s',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      CacheHelper.saveData(
        key: 'uId',
        value: uId,
      ).then((value) {
        print(value);
        emit(CreateUserSuccessState());
      });
    }).catchError((error) {
      emit(CreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }
}
