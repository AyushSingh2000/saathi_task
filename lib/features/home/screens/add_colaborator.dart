import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saathi_task/features/home/provider/create_checklist.dart';
import 'package:saathi_task/features/home/screens/home_screen.dart';
import 'package:saathi_task/utils/constants/box_constants.dart';
import 'package:saathi_task/utils/constants/textstyles.dart';
import 'package:saathi_task/utils/global_widgets/baseScaffold.dart';
import 'package:saathi_task/utils/global_widgets/primary_button.dart';
import 'package:saathi_task/utils/global_widgets/textfield.dart';

class AddCollab extends StatelessWidget {
  AddCollab({super.key});
  final TextEditingController _email = TextEditingController();
  final List<Color> colors = [
    Colors.black,
    Colors.amber,
    Colors.orange,
    Colors.blue,
    Colors.red,
    Colors.green
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateChecklistProvider>(builder: (context, provider, __) {
      return BasewithAppBar(
        action: [
          IconButton(onPressed: () {
            provider.saveChecklist(context);
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> const HomeScreen() ), (route) => false);
          }, icon:const Icon(Icons.save))],
        title: provider.name,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add Collaborators',
              style: TT.f20w800,
            ),
            const Text('Optional*'),
            Box.box24h,
            CustomTextField(
              labelText: 'Email Id',
              controller: _email,
              validator:(v)=> provider.verifyEmail(v??""),
              suffix: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PrimaryButton(
                    isSmall: true,
                    label: 'Add',
                    onTap: () {
                      provider.addCollab(_email.text);
                      _email.clear();
                    },
                  ),
                  Box.box4w
                ],
              ),
            ),
            Box.box16h,
            Expanded(
              child: ListView.builder(
                itemCount: provider.collaborators.length,
                itemBuilder: (_, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: colors[index % colors.length],
                            child: Text(
                              provider.collaborators[index][0].toUpperCase(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          Box.box8w,
                          Text(provider.collaborators[index]),
                        ],
                      ),
                      IconButton(
                          onPressed: () {
                            provider.removeCollab(provider.collaborators[index]);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
