import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:web_app_house_arena_basic/auth.dart';
import 'dart:ui';
import 'login_signup.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoggedIn = false;
  late User currentUser;

  @override
  void initState() {
    super.initState();
    checkSession();
    if (isLoggedIn) {
      getUserDetails().then((value) {
        setState(() {
          currentUser = value!;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              bar(),
            ],
          ),
        ],
      ),
    );
  }

  ClipRect bar() {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          color: Colors.black.withOpacity(0.2),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 450) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'HOUSE ARENA',
                        style: GoogleFonts.iceberg(
                          fontSize: 40,
                          color: Color.fromARGB(255, 249, 174, 130),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: isLoggedIn
                            ? () {
                                logoutUser().then((value) {
                                  if (value == 'User logged out successfully') {
                                    // Handle successful signup
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Logged out successfully',
                                            style: TextStyle(
                                              color: Colors.white,
                                            )),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MyHomePage()),
                                    );
                                  } else {
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
                                setState(() {
                                  isLoggedIn = false;
                                });
                              }
                            : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginSignupPage()),
                                );
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 162, 100, 64),
                          foregroundColor: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Icon(isLoggedIn
                                ? Icons.logout_outlined
                                : Icons.account_circle_sharp),
                            Text(isLoggedIn ? ' Logout' : 'Admin Login'),
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (constraints.maxWidth > 350) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'HOUSE ARENA',
                        style: GoogleFonts.iceberg(
                          fontSize: 30,
                          color: Color.fromARGB(255, 249, 174, 130),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: isLoggedIn
                            ? () {
                                logoutUser().then((value) {
                                  if (value == 'User logged out successfully') {
                                    // Handle successful signup
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Logged out successfully',
                                            style: TextStyle(
                                              color: Colors.white,
                                            )),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MyHomePage()),
                                    );
                                  } else {
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
                                setState(() {
                                  isLoggedIn = false;
                                });
                              }
                            : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginSignupPage()),
                                );
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 162, 100, 64),
                          foregroundColor: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Icon(isLoggedIn
                                ? Icons.logout_outlined
                                : Icons.account_circle_sharp),
                            Text(isLoggedIn ? ' Logout' : 'Admin Login'),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          'HOUSE ARENA',
                          style: GoogleFonts.iceberg(
                            fontSize: 30,
                            color: Color.fromARGB(255, 249, 174, 130),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isLoggedIn
                              ? Icons.logout_outlined
                              : Icons.account_circle_sharp,
                          color: const Color.fromARGB(255, 155, 93, 0),
                        ),
                        onPressed: isLoggedIn
                            ? () {
                                logoutUser().then((value) {
                                  if (value == 'User logged out successfully') {
                                    // Handle successful signup
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Logged out successfully',
                                            style: TextStyle(
                                              color: Colors.white,
                                            )),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MyHomePage()),
                                    );
                                  } else {
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
                                setState(() {
                                  isLoggedIn = false;
                                });
                              }
                            : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginSignupPage()),
                                );
                              },
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> checkSession() async {
    try {
      // Check if user is logged in
      bool loggedIn = await checkSessions();
      setState(() {
        isLoggedIn = loggedIn;
      });
    } catch (e) {
      print('Error while checking session: $e');
    }
  }
}