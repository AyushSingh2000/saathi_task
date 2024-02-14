import 'package:firebase_auth/firebase_auth.dart';
import 'package:saathi_task/features/home/models/checklist.dart';
import 'package:saathi_task/repositories/remote/firestore.dart';
import 'package:saathi_task/utils/helpers/base_provider.dart';

class HomeProvider extends BaseViewModel {
  List<Checklist> listOfCheckList = [];
  getCheckList() async {
    try {
      setLoading(true);
      final data = await FirestoreHelper().getList('Checklists');
      List<Checklist> list = data.docs.map((e) {
        final val = e.data();
        val['items'] = Map<String, bool>.from(val['items']);
        Checklist checklist =  Checklist.fromJson(val);
        checklist = checklist.copyWith(docId: e.id);
        return checklist;
      }).toList();
      list = list
          .where((element) => element.collaborators!
          .contains(FirebaseAuth.instance.currentUser!.email!))
          .toList();
      listOfCheckList = list;
    } catch (e) {
      print(e);
    } finally {
      setLoading(false);
    }
  }
}
