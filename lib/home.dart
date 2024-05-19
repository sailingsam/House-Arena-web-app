import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        //   title: Text('House Arena'),
        // ),
        body: Stack(
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
    ));
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
                        'HOUSE  ARENA',
                        style: GoogleFonts.iceberg(
                          fontSize: 40,
                          color: Color.fromARGB(255, 249, 174, 130),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Add your admin login action here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 162, 100, 64),
                          foregroundColor: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.account_circle_sharp),
                            Text('Admin Login'),
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
                        'HOUSE  ARENA',
                        style: GoogleFonts.iceberg(
                          fontSize: 30,
                          color: Color.fromARGB(255, 249, 174, 130),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Add your admin login action here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 162, 100, 64),
                          foregroundColor: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.account_circle_sharp),
                            Text('Admin Login'),
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
                          'HOUSE  ARENA',
                          style: GoogleFonts.iceberg(
                            fontSize: 30,
                            color: Color.fromARGB(255, 249, 174, 130),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.account_circle_sharp,
                            color: Color.fromARGB(255, 172, 95, 51)),
                        onPressed: () {
                          // Add your admin login action here
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
}
