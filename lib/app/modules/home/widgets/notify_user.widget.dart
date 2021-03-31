import 'package:flutter/material.dart';
import 'package:get/get.dart';



import 'package:ru_agenda/app/data/models/assignment.model.dart';
import 'package:ru_agenda/app/modules/home/widgets/assignment_card.widget.dart';
import 'package:ru_agenda/app/modules/home/widgets/dialog_button.widget.dart';

class NotifyUser extends StatelessWidget {
  const NotifyUser({
    Key key,
    @required this.notifyAssignments,
  }) : super(key: key);

  final List<AssignmentModel> notifyAssignments;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        actions: [
          DialogButton(
              onPressed: () {
                Get.back();
              },
              text: 'Close')
        ],
        contentPadding: const EdgeInsets.all(0),
        insetPadding: const EdgeInsets.symmetric(horizontal: 15),
        title: Row(
          children: [
            Icon(Icons.notifications_rounded),
            SizedBox(width: 5),
            Text('Notification'),
          ],
        ),
        content: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              Text(' Assignments is close to its due date: '),
              SizedBox(
                height: 400,
                width: Get.width,
                child: ListView.builder(
                  itemCount: notifyAssignments.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 1),
                      child: AssignmentCard(
                        assignment: notifyAssignments[index],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10)
            ],
          ),
        ));
  }
}
