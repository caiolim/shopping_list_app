// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../controller/login_controller.dart';
import '../widget/button_widget.dart';
import '../widget/textformfield_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _controller = LoginController();
  final formKeyLogin = GlobalKey<FormState>();
  final formKeyRecoveryPassword = GlobalKey<FormState>();
  final txtEmail = TextEditingController();
  final txtPassword = TextEditingController();
  final txtEmailRecoveryPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/about'),
            icon: Icon(
              Icons.info_outline,
              color: Colors.blue,
            ),
          ),
          SizedBox(width: 16.0),
        ],
      ),
      body: Form(
        key: formKeyLogin,
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              FlutterLogo(size: 80.0),
              Spacer(flex: 2),
              SizedBox(height: 16.0),
              TextFormFieldWidget(
                label: 'e-mail',
                controller: txtEmail,
                validator: (value) => _controller.validateEmail(value),
              ),
              SizedBox(height: 16.0),
              TextFormFieldWidget(
                label: 'senha',
                obscureText: true,
                controller: txtPassword,
                validator: (value) => _controller.validatePassword(value),
              ),
              SizedBox(height: 8.0),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (ctx) => _modalRecoveryPassword(),
                    );
                  },
                  child: const Text('Esqueci minha senha'),
                ),
              ),
              SizedBox(height: 32.0),
              Spacer(flex: 3),
              SizedBox(height: 8.0),
              ButtonWidget(
                text: 'Entrar',
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  if (formKeyLogin.currentState!.validate()) {
                    Navigator.pushReplacementNamed(
                      context,
                      '/shopping_lists',
                    );
                  }
                },
              ),
              SizedBox(height: 8.0),
              ButtonWidget(
                text: 'Criar nova conta',
                color: Colors.blueGrey,
                textColor: Colors.white,
                onPressed: () => Navigator.pushNamed(context, '/register'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _modalRecoveryPassword() {
    txtEmailRecoveryPassword.text = '';

    return Container(
      width: double.infinity,
      height: 380.0,
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: formKeyRecoveryPassword,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Esqueci minha senha',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 32.0),
            TextFormFieldWidget(
              label: 'e-mail',
              controller: txtEmailRecoveryPassword,
              validator: (value) => _controller.validateEmail(value),
            ),
            SizedBox(height: 16.0),
            Text(
              'Dolores quia placeat repellat quo magnam ab aut eveniet. Animi ut omnis et optio. Autem est ad dignissimos ipsum. Dignissimos id quae minima ut.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 11.0,
              ),
            ),
            Spacer(),
            ButtonWidget(
              text: 'Recuperar senha',
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () {
                if (formKeyRecoveryPassword.currentState!.validate()) {
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
