import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:appwrite/appwrite.dart';
import 'package:web_app_house_arena_basic/appwrite_service.dart';
import 'package:web_app_house_arena_basic/home.dart';

Future<void> showUpdateEventDialog(
    BuildContext context,
    String documentId,
    String eventName,
    String eventDate,
    int kongPoints,
    int leoPoints,
    int phoenixPoints,
    int tuskerPoints) {
  final _eventNameController = TextEditingController(text: eventName);
  final _eventDateController = TextEditingController(text: eventDate);
  final _kongPointsController =
      TextEditingController(text: kongPoints.toString());
  final _leoPointsController =
      TextEditingController(text: leoPoints.toString());
  final _phoenixPointsController =
      TextEditingController(text: phoenixPoints.toString());
  final _tuskerPointsController =
      TextEditingController(text: tuskerPoints.toString());
  final AppwriteService appwriteService = AppwriteService();

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Update Event'),
            IconButton(
                onPressed: () async {
                  try {
                    await appwriteService.deleteEvent(documentId);
                    //
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
                    //
                  } catch (e) {
                    print('Error deleting event: $e');
                  }
                },
                icon: Icon(Icons.delete))
          ],
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                controller: _eventNameController,
                decoration: InputDecoration(labelText: 'Event Name'),
              ),
              TextField(
                controller: _eventDateController,
                decoration: InputDecoration(labelText: 'Date (DD-MM-YYYY)'),
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('dd-MM-yyyy').format(pickedDate);
                    _eventDateController.text = formattedDate;
                  }
                },
              ),
              TextField(
                controller: _kongPointsController,
                decoration: InputDecoration(labelText: 'Kong Points'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _leoPointsController,
                decoration: InputDecoration(labelText: 'Leo Points'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _phoenixPointsController,
                decoration: InputDecoration(labelText: 'Phoenix Points'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _tuskerPointsController,
                decoration: InputDecoration(labelText: 'Tusker Points'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Update'),
            onPressed: () async {
              final updatedEventName = _eventNameController.text;
              final updatedEventDate = _eventDateController.text.isEmpty
                  ? null
                  : _eventDateController.text;
              final updatedKongPoints = int.parse(_kongPointsController.text);
              final updatedLeoPoints = int.parse(_leoPointsController.text);
              final updatedPhoenixPoints =
                  int.parse(_phoenixPointsController.text);
              final updatedTuskerPoints =
                  int.parse(_tuskerPointsController.text);

              try {
                await appwriteService.updateEvent(
                    documentId,
                    updatedEventName,
                    updatedEventDate,
                    updatedKongPoints,
                    updatedLeoPoints,
                    updatedPhoenixPoints,
                    updatedTuskerPoints);
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
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      'Error updating event: $e | Try later or Contact Developer'),
                ));
                print('Error updating event: $e');
              }
            },
          ),
        ],
      );
    },
  );
}
