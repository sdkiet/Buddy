import 'package:buddy/user/create_activity/activity_model.dart';
import 'package:flutter/material.dart';

class ActivityItem extends StatefulWidget {
  final ActivityModel dataModel;

  ActivityItem({required this.dataModel});

  @override
  _ActivityItemState createState() => _ActivityItemState();
}

class _ActivityItemState extends State<ActivityItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: ListTile(
                  leading: CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(
                        "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg-1024x683.jpg"),
                  ),
                  title: Text(widget.dataModel.creatorName),
                  subtitle: Text(widget.dataModel.creatorClg),
                )),
              ],
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.dataModel.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.dataModel.startDate,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.dataModel.startTime,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                children: [
                  Flexible(
                    child: Text(widget.dataModel.desc),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.share)),
                IconButton(onPressed: () {}, icon: Icon(Icons.comment)),
                IconButton(onPressed: () {}, icon: Icon(Icons.add))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
