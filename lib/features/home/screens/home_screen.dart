import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saathi_task/features/home/provider/create_checklist.dart';
import 'package:saathi_task/features/home/provider/home_provider.dart';
import 'package:saathi_task/features/home/screens/create_checklist.dart';
import 'package:saathi_task/features/home/widgets/checklist_card.dart';
import 'package:saathi_task/utils/constants/textstyles.dart';
import 'package:saathi_task/utils/global_widgets/baseScaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<HomeProvider>().getCheckList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BasewithFloatingButton(
      onTap: () {
        context.read<CreateChecklistProvider>().init();
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => CreateChecklist()));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Your CheckLists",
            style: TT.f24w900,
          ),
          Consumer<HomeProvider>(builder: (context, provider, __) {
            return provider.isLoading
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    context.read<HomeProvider>().getCheckList();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top:16.0),
                    child: ListView.builder(
                        itemCount: provider.listOfCheckList.length,
                        itemBuilder: (_, i) =>
                            ChecklistCard(checklist: provider.listOfCheckList[i])),
                  ),
                ));
          })
        ],
      ),
    );
  }
}
