import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../repositories/remote/firestore.dart';
import '../../../utils/helpers/base_provider.dart';
import '../models/checklist.dart';

class CreateChecklistProvider extends BaseViewModel {
  String name = 'Untitled';
  String doc = '';
  List<String> items = [];
  List<String> collaborators = [];
  Map<String, bool> itemMap = {};

  init(
      {String? name,
      List<String>? collaborators,
      Map<String, bool>? itemMap,
      String? docId}) {
    this.name = name ?? 'Untitled';
    items = itemMap?.keys.toList() ?? [];
    this.collaborators = collaborators ?? [];
    this.itemMap = itemMap ?? {};
    doc = docId ?? "";
  }

  checkItem(String key) {
    itemMap[key] = !(itemMap[key] ?? false);
    notifyListeners();
  }

  saveName(String val) {
    if (val.isEmpty) {
      throw 'Name can\'t be empty';
    }
    name = val;
    notifyListeners();
  }

  addItem(String val) {
    if (items.contains(val)) {
      throw 'Already Present';
    }
    if (val.isEmpty) {
      throw 'Item can\'t be empty';
    }
    items.add(val);
    notifyListeners();
  }

  removeItem(String val) {
    items.remove(val);
    itemMap.remove(val);
    notifyListeners();
  }

  addCollab(String val) {
    if (collaborators.contains(val)) {
      throw 'ALready Present';
    }
    if (verifyEmail(val) == null) {
      collaborators.add(val);
      notifyListeners();
    }
  }

  removeCollab(String val) {
    collaborators.remove(val);
    notifyListeners();
  }

  String? verifyEmail(String email) {
    if (email.isEmpty) {
      return 'Email Can\'t be Empty';
    }
    RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (emailRegex.hasMatch(email)) {
      return null;
    } else {
      return 'Invalid Email';
    }
  }

  checkNext() {
    if (name == 'Untitled') {
      throw 'Name can\'t be Untitled';
    }
    if (items.isEmpty) {
      throw 'Items List can\'t be Empty';
    }
  }

  saveChecklist(BuildContext context) async {
    for (var element in items) {
      if (!itemMap.containsKey(element)) {
        itemMap[element] = false;
      }
    }
    Checklist checklist = Checklist(
        collaborators: [
          FirebaseAuth.instance.currentUser!.email!,
          ...collaborators
        ],
        createdBy: FirebaseAuth.instance.currentUser!.email,
        items: itemMap,
        name: name);
    await FirestoreHelper()
        .setData(collection: 'Checklists', data: checklist.toJson());
  }

  updateChecklist(BuildContext context) async {
    for (var element in items) {
      if (!itemMap.containsKey(element)) {
        itemMap[element] = false;
      }
    }
    Checklist checklist = Checklist(
        collaborators: [...collaborators],
        createdBy: FirebaseAuth.instance.currentUser!.email,
        items: itemMap,
        name: name);
    await FirestoreHelper()
        .setData(collection: 'Checklists', doc: doc, data: checklist.toJson());
  }

  delete() {
    FirestoreHelper().deleteData(collection: 'Checklists', doc: doc);
  }
}
