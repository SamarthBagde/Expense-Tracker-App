import 'package:expense_tracker/services/auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key, required this.toggle});
  final Function toggle;
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '';
  String password = '';
  String error = '';
  bool obsPassword = true;

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  void showPassword() {
    setState(() {
      obsPassword = !obsPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 75, 125, 251),
        leading: const Icon(
          Icons.money,
          color: Colors.white,
        ),
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Container(
                padding: const EdgeInsetsDirectional.all(20),
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        // hintText: 'Username',
                        label: Text("Username"),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? "Enter your email" : null,
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      obscureText: obsPassword,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        // hintText: 'Password',
                        label: const Text("Password"),
                        suffix: InkWell(
                          onTap: showPassword,
                          child: obsPassword
                              ? const Icon(
                                  Icons.visibility,
                                )
                              : const Icon(
                                  Icons.visibility_off,
                                ),
                        ),
                      ),
                      validator: (value) => value!.length < 8
                          ? "Enter 8 char long password"
                          : null,
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 75, 125, 251),
                        minimumSize: const Size(150, 50),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          dynamic result = await _auth.Login(
                              email: email, password: password);
                          if (result == null) {
                            setState(() {
                              error = "please enter vaild email and password";
                            });
                          }
                        }
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      error,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account ?",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            widget.toggle();
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 75, 125, 251),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
