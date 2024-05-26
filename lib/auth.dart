import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

Client client = Client()
    .setEndpoint('https://cloud.appwrite.io/v1')
    .setProject('house-arena-web-app')
    .setSelfSigned(status: true);

Account account = Account(client);

//creating new user using mail
Future<String> createUser(String email, String password, String name) async {
  try {
    await account.create(
        userId: ID.unique(), email: email, password: password, name: name);
    return 'User created successfully';
  } on AppwriteException catch (e) {
    print(e.message);
    return e.message.toString();
  }
}

//login user using mail
Future<String> loginUser(String email, String password) async {
  try {
    await account.createEmailPasswordSession(email: email, password: password);
    print('User logged in successfully');
    return 'User logged in successfully';
  } on AppwriteException catch (e) {
    print(e.message);
    return e.message.toString();
  }
}

// check if user is logged in
Future<bool> checkSessions() async {
  try {
    User user = await account.get();
    print(user);
    print('User is logged in');
    return true;
  } on AppwriteException catch (e) {
    print('User is not logged in');
    print(e.message);
    return false;
  }
}

//logout user
Future<String> logoutUser() async {
  try {
    await account.deleteSession(sessionId: 'current');
    print('User logged out successfully');
    return 'User logged out successfully';
  } on AppwriteException catch (e) {
    print(e.message);
    return e.message.toString();
  }
}

//get details of logged in user
Future<User?> getUserDetails() async {
  try {
    final user = await account.get();
    return user;
  } catch (e) {
    print(e);
    return null;
  }
}
