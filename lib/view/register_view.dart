// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../controller/register_controller.dart';
import '../widget/textformfield_widget.dart';
import '../widget/button_widget.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _controller = RegisterController();
  final _pageController = PageController(initialPage: 0);
  final formKeyPageOne = GlobalKey<FormState>();
  final formKeyPageTwo = GlobalKey<FormState>();
  final txtEmail = TextEditingController();
  final txtPassword = TextEditingController();
  final txtConfirmPassword = TextEditingController();
  final txtName = TextEditingController();
  final txtBirthDate = TextEditingController();
  var gender = Gender.male;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => _pageController.page == 1
              ? setState(() {
                  _pageController.animateToPage(0,
                      duration: Durations.short4, curve: Curves.easeOut);
                })
              : Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text('Cadastro'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 160.0,
              child: FlutterLogo(size: 80.0),
            ),
            Form(
              child: Expanded(
                child: PageView(
                  controller: _pageController,
                  children: [
                    _pageOne(),
                    _pageTwo(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pageOne() {
    return Form(
      key: formKeyPageOne,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
          SizedBox(height: 16.0),
          TextFormFieldWidget(
            label: 'confirmar senha',
            obscureText: true,
            controller: txtConfirmPassword,
            validator: (value) =>
                _controller.validateConfirmPassword(value, txtPassword.text),
          ),
          Spacer(),
          ButtonWidget(
            text: 'Continuar',
            color: Colors.blueGrey,
            textColor: Colors.white,
            onPressed: () {
              if (formKeyPageOne.currentState!.validate()) {
                setState(
                  () {
                    _pageController.animateToPage(
                      1,
                      duration: Durations.short3,
                      curve: Curves.easeIn,
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _pageTwo() {
    return Form(
      key: formKeyPageTwo,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 16.0),
          TextFormFieldWidget(
            label: 'nome',
            controller: txtName,
            validator: (value) => _controller.validateName(value),
          ),
          SizedBox(height: 16.0),
          TextFormFieldWidget(
            label: 'data de nascimento',
            controller: txtBirthDate,
            validator: (value) => _controller.validateBirthDate(value),
            onTap: () async {
              final selectedDate = await showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );

              if (selectedDate != null) {
                setState(() {
                  txtBirthDate.text =
                      DateFormat('dd/MM/yyy').format(selectedDate).toString();
                });
              }
            },
          ),
          SizedBox(height: 24.0),
          Row(
            children: [
              Text(
                'Genero',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Radio<Gender>(
                    value: Gender.male,
                    groupValue: gender,
                    onChanged: (value) => setState(() => gender = value!),
                  ),
                  SizedBox(width: 8.0),
                  Text('Masculino'),
                ],
              ),
              SizedBox(height: 4.0),
              Row(
                children: [
                  Radio<Gender>(
                    value: Gender.female,
                    groupValue: gender,
                    onChanged: (value) => setState(() => gender = value!),
                  ),
                  SizedBox(width: 8.0),
                  Text('Feminino'),
                ],
              ),
            ],
          ),
          SizedBox(height: 32.0),
          Spacer(flex: 3),
          SizedBox(height: 8.0),
          ButtonWidget(
            text: 'Criar nova conta',
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: () {
              if (formKeyPageTwo.currentState!.validate()) {
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
