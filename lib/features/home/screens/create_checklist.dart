import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saathi_task/features/home/provider/create_checklist.dart';
import 'package:saathi_task/features/home/screens/add_colaborator.dart';
import 'package:saathi_task/utils/constants/box_constants.dart';
import 'package:saathi_task/utils/constants/textstyles.dart';
import 'package:saathi_task/utils/global_widgets/baseScaffold.dart';
import 'package:saathi_task/utils/global_widgets/primary_button.dart';
import 'package:saathi_task/utils/global_widgets/textfield.dart';

class CreateChecklist extends StatelessWidget {
  CreateChecklist({super.key});

  final TextEditingController _name = TextEditingController();

  final TextEditingController _item = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateChecklistProvider>(builder: (_, provider, __) {
      return BasewithAppBar(
          title: provider.name,
          action: [
            IconButton(
                onPressed: () {
                  provider.checkNext();
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => AddCollab()));
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
              Box.box12h,
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
              Box.box16h,
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
