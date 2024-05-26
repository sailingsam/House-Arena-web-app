// auth.dart
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'appwrite_client.dart';

Account account = Account(client);

class AppwriteService {
  final databases = Databases(client);

  Future<List<Document>> fetchEvents() async {
    try {
      final response = await databases.listDocuments(
        databaseId: 'house-arena-database',
        collectionId: 'event-details',
      );
      print(response);
      return response.documents;
    } catch (e) {
      print('Error fetching events: $e');
      return [];
    }
  }
}
