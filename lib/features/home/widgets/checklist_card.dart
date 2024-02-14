import 'package:flutter/material.dart';

import '../../../utils/constants/textstyles.dart';
import '../models/checklist.dart';
import '../screens/update_checklist/update.dart';

class ChecklistCard extends StatelessWidget {
  final Checklist checklist;
  const ChecklistCard({super.key, required this.checklist});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => UpdateChecklist(checklist: checklist),
            ),
          );
        },
        child: Container(
          height: 58,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1.5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(Icons.format_list_bulleted_rounded),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 4),
                child: Text(
                  checklist.name ?? "Name",
                  style: TT.f18w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
