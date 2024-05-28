import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:appwrite/appwrite.dart';
import 'package:web_app_house_arena_basic/appwrite_service.dart';

void showAddEventDialog(BuildContext context, Function onEventAdded) {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _kongPointsController = TextEditingController();
  final TextEditingController _leoPointsController = TextEditingController();
  final TextEditingController _phoenixPointsController =
      TextEditingController();
  final TextEditingController _tuskerPointsController = TextEditingController();
  final AppwriteService appwriteService = AppwriteService();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Add Event'),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _eventNameController,
                  decoration: InputDecoration(labelText: 'Event Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter event name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(labelText: 'Date (DD-MM-YYYY)'),
                  onTap: () async {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(pickedDate);
                      _dateController.text = formattedDate;
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a date';
                    }
                    if (!RegExp(r'^\d{2}-\d{2}-\d{4}$').hasMatch(value)) {
                      return 'Please enter a valid date (DD-MM-YYYY)';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _kongPointsController,
                  decoration: InputDecoration(labelText: 'Kong Points'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Kong points';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _leoPointsController,
                  decoration: InputDecoration(labelText: 'Leo Points'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Leo points';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _phoenixPointsController,
                  decoration: InputDecoration(labelText: 'Phoenix Points'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Phoenix points';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _tuskerPointsController,
                  decoration: InputDecoration(labelText: 'Tusker Points'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Tusker points';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: Text('Add Event'),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final eventName = _eventNameController.text;
                final date = _dateController.text;
                final kongPoints = int.parse(_kongPointsController.text);
                final leoPoints = int.parse(_leoPointsController.text);
                final phoenixPoints = int.parse(_phoenixPointsController.text);
                final tuskerPoints = int.parse(_tuskerPointsController.text);

                try {
                  await appwriteService.createEvent(eventName, date, leoPoints,
                      kongPoints, phoenixPoints, tuskerPoints);
                  onEventAdded();
                  Navigator.of(context).pop();
                } catch (e) {
                  // Handle the error
                  print('Error adding event: $e');
                }
              }
            },
          ),
        ],
      );
    },
  );
}
