import 'package:buddy/components/custom_snackbar.dart';

import 'package:buddy/user/create_activity/activity_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PopUp extends StatefulWidget {
  const PopUp({Key? key}) : super(key: key);

  @override
  _PopUpState createState() => _PopUpState();
}

class _PopUpState extends State<PopUp> {
  late DateTime _fromDate = DateTime.now();
  late TimeOfDay _fromTime = TimeOfDay.now();
  late DateTime _toDate = DateTime.now();
  late TimeOfDay _toTime = TimeOfDay.now();
  final _descriptionController = TextEditingController();
  final _titleController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firebaseDatabase = FirebaseDatabase.instance;

  void _fromTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((timePicked) {
      if (timePicked == null) {
        return;
      }
      setState(() {
        _fromTime = timePicked;
      });
    });
  }

  void _toTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((timePicked) {
      if (timePicked == null) {
        return;
      }
      setState(() {
        _toTime = timePicked;
      });
    });
  }

  void _fromDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime(2022))
        .then((datePicked) {
      if (datePicked == null) {
        return;
      }
      setState(() {
        _fromDate = datePicked;
      });
    });
  }

  void _toDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime(2022))
        .then((datePicked) {
      if (datePicked == null) {
        return;
      }
      setState(() {
        _toDate = datePicked;
      });
    });
  }

  void _createActivity() async {
    //----( Variables Input )-------//
    final _title = _titleController.text.toString();
    final _desc = _descriptionController.text.toString();
    final _startDate = _fromDate.toString();
    final _startTime = _fromTime.toString();
    final _endDate = _toDate.toString();
    final _endTime = _toTime.toString();

    //---( Validation Strings )----//
    if (_title.isEmpty || _desc.isEmpty) {
      CustomSnackbar().showFloatingFlushbar(
        context: context,
        message: 'Please provide Proper Details!',
        color: Colors.black87,
      );
      return;
    }

    final _uid = _auth.currentUser!.uid;
    final _refUser = _firebaseDatabase.reference().child('Activity');
    String _kid = _refUser.push().key;

    ActivityModel model = ActivityModel(
      id: _kid,
      title: _title,
      desc: _desc,
      startDate: _startDate,
      startTime: _startTime,
      endDate: _endDate,
      endTime: _endTime,
      creatorId: _uid,
    );

    await _refUser.child(_kid).set(model.toJson());

    Navigator.pop(context);
    CustomSnackbar().showFloatingFlushbar(
      context: context,
      message: 'Activity Created Successfully!',
      color: Colors.green,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      title: Text("Create"),
      content: SingleChildScrollView(
        child: Container(
          height: size.height * 0.5,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  hintText: "Title",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black87),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black87),
                  ),
                ),
                cursorColor: Colors.black87,
                controller: _titleController,
                autofocus: true,
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "From:",
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    "Start Time",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    // ignore: unnecessary_null_comparison
                    onPressed: _fromDatePicker,
                    child: Text(DateFormat.yMd().format(_fromDate)),
                  ),
                  SizedBox(
                    width: size.width * 0.2,
                  ),
                  TextButton(
                    child:
                        // ignore: unnecessary_null_comparison
                        Text(_fromTime.toString().substring(10, 15)),
                    onPressed: _fromTimePicker,
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "To:",
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    "End Time",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    // ignore: unnecessary_null_comparison
                    onPressed: _toDatePicker,
                    child: Text(DateFormat.yMd().format(_toDate)),
                  ),
                  SizedBox(
                    width: size.width * 0.2,
                  ),
                  TextButton(
                    child:
                        // ignore: unnecessary_null_comparison
                        Text(_toTime.toString().substring(10, 15)),
                    onPressed: _toTimePicker,
                  )
                ],
              ),
              TextField(
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal)),
                  hintText: 'Tell us about yourself',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black87),
                  ),
                ),
                minLines:
                    6, // any number you need (It works as the rows for the textarea)
                keyboardType: TextInputType.multiline,
                maxLines: null,
                cursorColor: Colors.black87,
                controller: _descriptionController,
                autofocus: true,
              ),
            ],
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black87,
                ),
                onPressed: () {
                  _createActivity();
                },
                child: Text(
                  "Create",
                  style: TextStyle(color: Colors.white),
                )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black87,
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Close",
                  style: TextStyle(color: Colors.white),
                )),
          ],
        )
      ],
    );
  }
}