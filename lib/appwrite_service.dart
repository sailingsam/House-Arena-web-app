// auth.dart
// import 'dart:ffi';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'appwrite_client.dart';

Account account = Account(client);

class AppwriteService {
  final databases = Databases(client);

  // fetch events
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

  Future<Map<String, double>> calculateTotalPoints() async {
    final events = await fetchEvents();
    Map<String, double> housePoints = {
      'House of Phoenix': 0.0,
      'House of Tusker': 0,
      'House of Kong': 0,
      'House of Leo': 0,
    };

    for (var event in events) {
      housePoints['House of Phoenix'] =
          housePoints['House of Phoenix']! + (event.data['pheonix_point'] ?? 0);
      housePoints['House of Tusker'] =
          housePoints['House of Tusker']! + (event.data['tusker_point'] ?? 0);
      housePoints['House of Kong'] =
          housePoints['House of Kong']! + (event.data['kong_point'] ?? 0);
      housePoints['House of Leo'] =
          housePoints['House of Leo']! + (event.data['leo_point'] ?? 0);
    }

    return housePoints;
  }

  // fetch admin email ids
  Future<List<String>> fetchAdminEmails() async {
    try {
      final response = await databases.listDocuments(
        databaseId: 'house-arena-database',
        collectionId: 'admin-emails',
      );
      print(response);

      // Extract emails from each document
      List<String> adminEmails = response.documents
          .map((doc) => doc.data['email'].toString())
          .toList();

      return adminEmails;
    } catch (e) {
      print('Error fetching admin emails: $e');
      return [];
    }
  }

  // create event
  Future<void> createEvent(String eventName, String date, int leoPoints,
      int kongPoints, int phoenixPoints, int tuskerPoints) async {
    try {
      await databases.createDocument(
        documentId: ID.unique(),
        databaseId: 'house-arena-database',
        collectionId: 'event-details',
        data: {
          'event_name': eventName,
          'date': date,
          'kong_point': kongPoints,
          'leo_point': leoPoints,
          'pheonix_point': phoenixPoints,
          'tusker_point': tuskerPoints,
        },
      );
    } catch (e) {
      print('Error creating event: $e');
    }
  }

  // delete event document
  Future<void> deleteEvent(String documentId) async {
    try {
      await databases.deleteDocument(
        databaseId: 'house-arena-database',
        collectionId: 'event-details',
        documentId: documentId,
      );
    } catch (e) {
      print('Error deleting event: $e');
    }
  }

  // update event document
  Future<void> updateEvent(
      String documentId,
      String eventName,
      String? date,
      int leoPoints,
      int kongPoints,
      int phoenixPoints,
      int tuskerPoints) async {
    try {
      await databases.updateDocument(
        databaseId: 'house-arena-database',
        collectionId: 'event-details',
        documentId: documentId,
        data: {
          'event_name': eventName,
          'date': date,
          'kong_point': kongPoints,
          'leo_point': leoPoints,
          'pheonix_point': phoenixPoints,
          'tusker_point': tuskerPoints,
        },
      );
    } catch (e) {
      print('Error updating event: $e');
    }
  }
}
