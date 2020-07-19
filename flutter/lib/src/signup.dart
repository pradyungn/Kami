import 'package:Kami/src/provider_api.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupView extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<SignupView> {
  TextEditingController _email;
  TextEditingController _password;
  TextEditingController _confirmPassword;
  final _formKey = GlobalKey<FormState>(debugLabel: 'form');

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
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
                    validator: (value) => value.isNotEmpty
                        ? value != _confirmPassword.text
                            ? 'Passwords do not match'
                            : null
                        : 'Please enter a password',
                    maxLines: 1,
                    controller: _password,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    autofocus: true,
                    obscureText: true,
                    validator: (value) => value != _password.text
                        ? 'Passwords do not match'
                        : null,
                    maxLines: 1,
                    controller: _confirmPassword,
                    decoration: InputDecoration(
                      labelText: 'Confirm password',
                    ),
                  ),
                  const SizedBox(height: 50),
                  RaisedButton(
                    child: const Text('Sign up'),
                    onPressed: () async {
                      _formKey.currentState.validate();
                      final api = Provider.of<ProviderAPI>(context, listen: false);
                      final r = await api.signup(_email.text, _password.text);
                      if (!r) {
                        print('failed to sign up');
                      }
                      Navigator.pop(context, r);
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
