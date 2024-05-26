// appwrite_client.dart
import 'package:appwrite/appwrite.dart';

final Client client = Client()
    .setEndpoint('https://cloud.appwrite.io/v1') // Your Appwrite Endpoint
    .setProject('house-arena-web-app') // Your Project ID
    .setSelfSigned(status: true);
