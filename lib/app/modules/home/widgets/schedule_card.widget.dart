import 'package:flutter/material.dart';


import 'package:ru_agenda/app/theme/color_theme.dart';
import 'package:ru_agenda/app/data/models/class.model.dart';


class ScheduleCard extends StatelessWidget {
  const ScheduleCard({
    Key key,
    this.classModel,
  }) : super(key: key);

  final ClassModel classModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 15, right: 15, left: 15),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  classModel.courseTitle,
                  style: TextStyle(
                      color: textPrimaryColor, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Days/Time: ${classModel.dateMeet}',
                  style: TextStyle(
                    color: textPrimaryColor,
                  ),
                ),
                Text(
                  'Location: ${classModel.location}',
                  style: TextStyle(
                    color: textPrimaryColor,
                  ),
                ),
                Text(
                  'Instructor: ${classModel.instructorName}',
                  style: TextStyle(
                    color: textPrimaryColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
