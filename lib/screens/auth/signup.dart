import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 80, right: 30, left: 30),
          child: Form(
            child: Column(
              children: [
                const Text(
                  'Register',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.w700),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 120),
                  child: Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: null,
                          decoration: const InputDecoration(
                            hintText: 'First name',
                            labelText: 'First name',
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 30),
                      ),
                      Flexible(
                        child: TextFormField(
                          controller: null,
                          decoration: const InputDecoration(
                            hintText: 'Last name',
                            labelText: 'Last name',
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: TextFormField(
                    controller: null,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      labelText: 'Email',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: TextFormField(
                    controller: null,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      labelText: 'Password',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: TextFormField(
                    controller: null,
                    decoration: const InputDecoration(
                      hintText: 'Repeat password',
                      labelText: 'Repeat password',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Signup'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
