import 'dart:async';

import 'package:flutter/material.dart';
import 'package:web_app_house_arena_basic/auth.dart';
import 'package:web_app_house_arena_basic/home.dart';
import 'package:web_app_house_arena_basic/appwrite_service.dart';

class LoginSignupPage extends StatefulWidget {
  const LoginSignupPage({super.key});

  @override
  _LoginSignupPageState createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  final PageController _pageController = PageController();
  final _loginFormKey = GlobalKey<FormState>();
  final _signupFormKey = GlobalKey<FormState>();
  final AppwriteService appwriteService = AppwriteService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }
    return null;
  }

  void handleLogin() {
    if (_loginFormKey.currentState!.validate()) {
      // Handle login action
      loginUser(emailController.text, passwordController.text).then((value) {
        if (value == 'User logged in successfully') {
          // Handle successful login
          showDialog(
            context: context,
            builder: (BuildContext context) {
              Future.delayed(const Duration(seconds: 3), () {
                Navigator.of(context).pushAndRemoveUntil(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const MyHomePage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0);
                      const end = Offset.zero;
                      const curve = Curves.easeInOut;

                      final tween = Tween(begin: begin, end: end);
                      final curvedAnimation = CurvedAnimation(
                        parent: animation,
                        curve: curve,
                      );

                      return SlideTransition(
                        position: tween.animate(curvedAnimation),
                        child: child,
                      );
                    },
                  ),
                  (Route<dynamic> route) => false,
                );
              });

              return AlertDialog(
                title: Text('Hey there! ${emailController.text}'),
                content: const Text('You just unlocked \'Developers Mode\' ;)'),
              );
            },
          );

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Login successful!',
                  style: TextStyle(
                    color: Colors.white,
                  )),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          // Handle login error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(value,
                  style: TextStyle(
                    color: Colors.white,
                  )),
              backgroundColor: Colors.red,
            ),
          );
        }
      });
    }
  }

  Future<String> adminVerify(String email) async {
    final adminEmails = await appwriteService.fetchAdminEmails();
    if (adminEmails.contains(email)) {
      return 'User is an admin';
    } else {
      return 'You are not verified admin! Contact the admin for access';
    }
  }

  void handleSignup() {
    if (_signupFormKey.currentState!.validate()) {
      adminVerify(emailController.text).then((value) {
        if (value != 'User is an admin') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(value,
                  style: TextStyle(
                    color: Colors.white,
                  )),
              backgroundColor: Colors.red,
            ),
          );
          return;
        } else {
          // Handle signup action
          createUser(emailController.text, passwordController.text,
                  usernameController.text)
              .then((value) {
            if (value == 'User created successfully') {
              // Handle successful signup
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('User created successfully',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LoginSignupPage()),
              );
            } else {
              // Handle signup error
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(value,
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  backgroundColor: Colors.red,
                ),
              );
            }
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: Colors.white,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/stadiumbg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: FadeTransition(
              opacity: _animation,
              child: Card(
                color: Color.fromARGB(255, 255, 255, 255),
                elevation: 30,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Row(
                                children: [
                                  Icon(Icons.arrow_back, color: Colors.black),
                                  Text('Back',
                                      style: TextStyle(color: Colors.black)),
                                ],
                              )),
                          Text(
                            'Welcome',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                          ),
                          SizedBox(width: 48), // Placeholder for alignment
                        ],
                      ),
                      const SizedBox(height: 20),
                      Flexible(
                        child: PageView(
                          controller: _pageController,
                          children: [
                            buildLoginForm(context),
                            buildSignupForm(context),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoginForm(BuildContext context) {
    return Container(
      height: 100,
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email, color: Colors.black),
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black)),
              ),
              validator: emailValidator,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock, color: Colors.black),
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
              obscureText: true,
              validator: passwordValidator,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: handleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                _pageController.animateToPage(
                  1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: const Text(
                'Logging in for first time? Sign up',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSignupForm(BuildContext context) {
    return Form(
      key: _signupFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: usernameController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.account_circle),
              labelText: 'Username',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: usernameValidator,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email),
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: emailValidator,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
              labelText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            obscureText: true,
            validator: passwordValidator,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: handleSignup,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 15,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Sign Up',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              _pageController.animateToPage(
                0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: const Text(
              'Already have an account? Login',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
