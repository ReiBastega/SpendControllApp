import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:spend_controll/shared/widgets/button.dart';
import 'package:spend_controll/shared/widgets/form_input_and_title.dart';
import 'Controller/login_controller.dart';

class LoginPage extends StatefulWidget {
  final LoginController loginController;
  const LoginPage({super.key, required this.loginController});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final List<FocusNode> _focusNodes = List<FocusNode>.generate(
    2,
    (_) => FocusNode(),
    growable: false,
  );
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Login',
          ),
        ),
      ),
      body: BlocConsumer<LoginController, LoginState>(
          bloc: widget.loginController,
          listener: (context, state) {
            if (state.status == LoginStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Falha no login')));
            } else if (state.status == LoginStatus.success) {
              Modular.to.navigate('/home');
            }
          },
          builder: (context, state) {
            if (state.status == LoginStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                children: [
                  FormInputAndTitle(
                    focus: _focusNodes[0],
                    title: 'E-mail',
                    hintText: 'Informe',
                    controller: emailController,
                    maskFormatter: const [],
                    onSaved: (p0) {},
                    validator: (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return 'Campo vazio';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  FormInputAndTitle(
                    focus: _focusNodes[1],
                    title: 'Senha',
                    hintText: 'Informe',
                    controller: senhaController,
                    maskFormatter: const [],
                    onSaved: (p0) {},
                    validator: (p0) {
                      if (p0 == null || p0.isEmpty) {
                        return 'Campo vazio';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  const SizedBox(height: 24),
                  Button(
                    onPressed: () {
                      widget.loginController.login(email!, password!);
                      // Modular.to.pushNamed('/home');
                    },
                    text: 'Cadastro',
                  ),
                  const SizedBox(height: 24),
                  Button(
                      onPressed: () {
                        Modular.to.pushNamed('/home');
                      },
                      text: 'Esqueci minha senha'),
                ],
              ),
            );
          }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: BlocBuilder<LoginController, LoginState>(
            bloc: widget.loginController,
            builder: (context, state) {
              return Button(
                onPressed: () {
                  Modular.to.pushNamed('/home');
                },
                text: 'Entrar',
              );
            }),
      ),
    );
  }
}
