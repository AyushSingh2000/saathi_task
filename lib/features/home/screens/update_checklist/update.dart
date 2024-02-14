import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saathi_task/features/home/models/checklist.dart';
import 'package:saathi_task/features/home/provider/create_checklist.dart';
import 'package:saathi_task/features/home/screens/update_checklist/add_collaborator.dart';
import 'package:saathi_task/utils/constants/box_constants.dart';
import 'package:saathi_task/utils/constants/textstyles.dart';
import 'package:saathi_task/utils/global_widgets/baseScaffold.dart';
import 'package:saathi_task/utils/global_widgets/primary_button.dart';
import 'package:saathi_task/utils/global_widgets/textfield.dart';

class UpdateChecklist extends StatefulWidget {
  const UpdateChecklist({super.key, required this.checklist});
  final Checklist checklist;

  @override
  State<UpdateChecklist> createState() => _UpdateChecklistState();
}

class _UpdateChecklistState extends State<UpdateChecklist> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _item = TextEditingController();

  @override
  void initState() {
    context.read<CreateChecklistProvider>().init(
        collaborators: widget.checklist.collaborators,
        itemMap: widget.checklist.items,
        name: widget.checklist.name,
        docId: widget.checklist.docId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateChecklistProvider>(builder: (_, provider, __) {
      return BasewithAppBar(
          title: provider.name,
          action: [
            IconButton(
                onPressed: () {
                  provider.delete();
                  Navigator.pop(
                    context,
                  );
                },
                icon: const Icon(
                  Icons.delete,
                  size: 28,
                  color: Colors.red,
                )),
            IconButton(
                onPressed: () {
                  provider.checkNext();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => UpdateCollab(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.navigate_next_rounded,
                  size: 30,
                ))
          ],
          child: Column(
            children: [
              CustomTextField(
                labelText: 'Name',
                controller: _name,
                suffix: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PrimaryButton(
                      isSmall: true,
                      label: 'save',
                      onTap: () {
                        provider.saveName(_name.text);
                        _name.clear();
                      },
                    ),
                    Box.box4w
                  ],
                ),
              ),
              const Text(
                'Items',
                style: TT.f20w800,
              ),
              CustomTextField(
                labelText: 'Add an Item',
                controller: _item,
                suffix: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    PrimaryButton(
                      isSmall: true,
                      label: 'add',
                      onTap: () {
                        provider.addItem(_item.text);
                        _item.clear();
                      },
                    ),
                    Box.box4w
                  ],
                ),
              ),
              Box.box12h,
              Expanded(
                  child: ListView.builder(
                      itemCount: provider.items.length,
                      itemBuilder: (_, i) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                    checkColor: Colors.white,
                                    hoverColor: Colors.orange,
                                    activeColor: Colors.deepOrange,
                                    value:
                                        provider.itemMap[provider.items[i]] ??
                                            false,
                                    onChanged: (val) {
                                      provider.checkItem(provider.items[i]);
                                    }),
                                Box.box8w,
                                Text(provider.items[i], style: TT.f14w400)
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  provider.removeItem(provider.items[i]);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ))
                          ],
                        );
                      }))
            ],
          ));
    });
  }
}
