import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:web_app_house_arena_basic/auth.dart';
import 'dart:ui';
import 'login_signup.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_app_house_arena_basic/appwrite_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoggedIn = false;
  late User currentUser;
  final AppwriteService appwriteService = AppwriteService();
  final yourScrollController = ScrollController();

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
  void dispose() {
    // _scrollController.dispose();
    super.dispose();
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
                image: AssetImage('assets/stadiumbg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              bar(),
              Expanded(child: LayoutBuilder(builder: (context, constraints) {
                if (constraints.maxWidth > 800) {
                  return Container(
                    padding: const EdgeInsets.only(
                        top: 50.0, left: 20.0, right: 20, bottom: 80.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(flex: 6, child: leaderBoardSection()),
                        Expanded(flex: 1, child: SizedBox()),
                        Expanded(flex: 9, child: eventsSection()),
                      ],
                    ),
                  );
                } else {
                  return SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 20.0, left: 20.0, right: 20, bottom: 50.0),
                      child: Column(
                        children: [
                          leaderBoardSection(),
                          SizedBox(
                            height: 10,
                          ),
                          eventsSection(),
                        ],
                      ),
                    ),
                  );
                }
              })),
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
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 5.0,
                                color: Colors.black,
                                offset: Offset(5.0, 5.0),
                              ),
                            ]),
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
                          backgroundColor: Color.fromARGB(255, 0, 0, 0),
                          foregroundColor: Color.fromARGB(255, 252, 252, 252),
                        ),
                        child: Row(
                          children: [
                            Icon(isLoggedIn
                                ? Icons.logout_outlined
                                : Icons.account_circle_sharp),
                            Text(isLoggedIn ? ' Logout' : ' Admin Login'),
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
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 5.0,
                                color: Colors.black,
                                offset: Offset(5.0, 5.0),
                              ),
                            ]),
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
                          backgroundColor: Color.fromARGB(255, 0, 0, 0),
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
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 5.0,
                                  color: Colors.black,
                                  offset: Offset(5.0, 5.0),
                                ),
                              ]),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isLoggedIn
                              ? Icons.logout_outlined
                              : Icons.account_circle_sharp,
                          color: Color.fromARGB(255, 0, 0, 0),
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

  Widget leaderBoardSection() {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          // height: 400,
          color: Colors.black.withOpacity(0.2),
          margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.all(16.0),
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Leaderboard',
                  style: TextStyle(
                    fontFamily: GoogleFonts.play().fontFamily,
                    //shoadow
                    shadows: [
                      Shadow(
                        blurRadius: 5.0,
                        color: Colors.black,
                        offset: Offset(3.0, 3.0),
                      ),
                    ],
                    fontSize: 28,
                    // fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                const SizedBox(height: 16.0),
                // Leaderboard content
                leaderboardRow(
                    'assets/phoenix_circle_ai.png', 'House of Phoenix', 31),
                leaderboardRow(
                    'assets/tusker_circle_ai.png', 'House of Tusker', 23),
                leaderboardRow(
                    'assets/kong_circle_ai.png', 'House of Kong', 20),
                leaderboardRow('assets/leo_circle_ai.png', 'House of Leo', 19),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget leaderboardRow(String logoPath, String houseName, int points) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(logoPath),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Text(
              houseName,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            '$points',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget eventsSection() {
    return FutureBuilder<List<Document>>(
      future: appwriteService.fetchEvents(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No events found.'));
        } else {
          final events = snapshot.data!;
          return ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                height: 600,
                color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
                margin: const EdgeInsets.all(16.0),
                padding: const EdgeInsets.only(
                    top: 16.0, left: 30.0, right: 16.0, bottom: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Past Events',
                          style: TextStyle(
                            fontFamily: GoogleFonts.play().fontFamily,
                            shadows: [
                              Shadow(
                                blurRadius: 5.0,
                                color: Colors.black,
                                offset: Offset(3.0, 3.0),
                              ),
                            ],
                            fontSize: 28,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, right: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              'Event',
                              style: TextStyle(
                                fontFamily: GoogleFonts.play().fontFamily,
                                fontSize: 20,
                                shadows: [
                                  Shadow(
                                    blurRadius: 5.0,
                                    color: Colors.black,
                                    offset: Offset(2.0, 2.0),
                                  ),
                                ],
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage('assets/kong_circle_ai.png'),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage('assets/leo_circle_ai.png'),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: AssetImage(
                                      'assets/phoenix_circle_ai.png'),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage('assets/tusker_circle_ai.png'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Scrollbar(
                        trackVisibility: true,
                        thumbVisibility: true,
                        interactive: true,
                        controller: yourScrollController,
                        child: SingleChildScrollView(
                          controller: yourScrollController,
                          scrollDirection: Axis.vertical,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: events.map((event) {
                                final eventName =
                                    event.data['event_name'] ?? 'No Name';
                                final dateTime =
                                    event.data['date'] ?? 'No Date';
                                final kongPoints =
                                    event.data['kong_point'] ?? 0;
                                final leoPoints = event.data['leo_point'] ?? 0;
                                final phoenixPoints =
                                    event.data['pheonix_point'] ?? 0;
                                final tuskerPoints =
                                    event.data['tusker_point'] ?? 0;
                                return eventRow(eventName, dateTime, kongPoints,
                                    leoPoints, phoenixPoints, tuskerPoints);
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Scroll for more...',
                              style: TextStyle(color: Colors.white)),
                          Icon(Icons.arrow_downward,
                              color: Colors.white, size: 15),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget eventRow(String eventName, String eventDate, int kongPoints,
      int leoPoints, int phoenixPoints, int tuskerPoints) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    eventName,
                    style: TextStyle(
                      fontFamily: GoogleFonts.play().fontFamily,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    eventDate,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 152, 149, 149),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  border: Border(
                      left: BorderSide(color: Colors.blue),
                      right: BorderSide(color: Colors.blue),
                      top: BorderSide(color: Colors.blue),
                      bottom: BorderSide(color: Colors.blue))),
              child: Text(
                '$kongPoints',
                style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 2.0,
                        color: Color.fromARGB(255, 45, 65, 82),
                        offset: Offset(2.0, 2.0),
                      ),
                    ]),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                    left: BorderSide(color: Color.fromARGB(255, 222, 200, 4)),
                    right: BorderSide(color: Color.fromARGB(255, 222, 200, 4)),
                    top: BorderSide(color: Color.fromARGB(255, 222, 200, 4)),
                    bottom:
                        BorderSide(color: Color.fromARGB(255, 222, 200, 4))),
              ),
              child: Text(
                '$leoPoints',
                style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 2.0,
                        color: Color.fromARGB(255, 45, 65, 82),
                        offset: Offset(2.0, 2.0),
                      ),
                    ]),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                    left: BorderSide(color: Colors.red),
                    right: BorderSide(color: Colors.red),
                    top: BorderSide(color: Colors.red),
                    bottom: BorderSide(color: Colors.red)),
              ),
              child: Text(
                '$phoenixPoints',
                style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 2.0,
                        color: Color.fromARGB(255, 45, 65, 82),
                        offset: Offset(2.0, 2.0),
                      ),
                    ]),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                    left: BorderSide(color: Colors.green),
                    right: BorderSide(color: Colors.green),
                    top: BorderSide(color: Colors.green),
                    bottom: BorderSide(color: Colors.green)),
              ),
              child: Text(
                '$tuskerPoints',
                style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 2.0,
                        color: Color.fromARGB(255, 45, 65, 82),
                        offset: Offset(2.0, 2.0),
                      ),
                    ]),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
