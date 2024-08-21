import 'package:expense_tracker/services/auth.dart';
import 'package:expense_tracker/services/database.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key, required this.toggle});

  final Function toggle;

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String error = '';

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordCOntroller = TextEditingController();

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordCOntroller.dispose();
    super.dispose();
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
          "SignUp",
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
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("First Name"),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? "Enter your first name" : null,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Last Name"),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? "Enter your last name" : null,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Email"),
                      ),
                      validator: (value) =>
                          value!.isEmpty ? "Enter Email" : null,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      controller: _passwordCOntroller,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        // hintText: 'Password',
                        label: Text("Password"),
                        suffix: Icon(Icons.visibility),
                      ),
                      validator: (value) => value!.length < 8
                          ? "Enter 8 char long password"
                          : null,
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
                          dynamic result = await _auth.signUp(
                              email: _emailController.text,
                              password: _passwordCOntroller.text);
                          final String uid = _auth.getCurrentUid();
                          final Database dataBase = Database(uid: uid);
                          await dataBase.addUser(
                              _firstNameController.text,
                              _lastNameController.text,
                              _emailController.text,
                              uid);

                          if (result == null) {
                            setState(() {
                              error = "Please enter a valid email";
                            });
                          }

                          setState(() {
                            _firstNameController.clear();
                            _lastNameController.clear();
                            _emailController.clear();
                            _passwordCOntroller.clear();
                          });
                        }
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
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
                          "Already have an account ?",
                          style: TextStyle(fontSize: 18),
                        ),
                        TextButton(
                          onPressed: () {
                            widget.toggle();
                          },
                          child: const Text(
                            'Login',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
