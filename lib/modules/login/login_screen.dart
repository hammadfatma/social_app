import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layouts/social_layout.dart';
import 'package:social_app/modules/login/cubit/login_cubit.dart';
import 'package:social_app/modules/register/register_screen.dart';
import 'package:social_app/shared/components/components.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) async {
          if (state is LoginErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.error,
            );
          }
          if (state is LoginSuccessState) {
            navigateAndFinish(context, const SocialLayout());
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: Colors.black),
                        ),
                        Text(
                          'Login now to communicate with friends',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your email address';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'password is too short';
                            }
                            return null;
                          },
                          isPassword: LoginCubit.get(context).isPassword,
                          suffixPressed: () {
                            LoginCubit.get(context).changePasswordVisibility();
                          },
                          label: 'Password',
                          prefix: Icons.lock_outlined,
                          suffix: LoginCubit.get(context).suffix,
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) {
                            return defaultButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              text: 'login',
                              isUpperCase: true,
                            );
                          },
                          fallback: (context) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account?'),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, const RegisterScreen());
                              },
                              child: const Text('register'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
