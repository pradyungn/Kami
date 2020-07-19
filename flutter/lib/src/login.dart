import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController _email;
  TextEditingController _password;
  final _formKey = GlobalKey<FormState>(debugLabel: 'form');

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: _getBody(context),
    );
  }

  Widget _getBody(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    autofocus: true,
                    validator: (value) => EmailValidator.validate(value)
                        ? null
                        : 'Please enter a valid email',
                    maxLines: 1,
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    autofocus: true,
                    obscureText: true,
                    validator: (value) =>
                        value.isNotEmpty ? null : 'Please enter a password',
                    maxLines: 1,
                    controller: _password,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                  const SizedBox(height: 50),
                  RaisedButton(
                    child: const Text('Login'),
                    onPressed: () {
                      _formKey.currentState.validate();
                      print('login');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
