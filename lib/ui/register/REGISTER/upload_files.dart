import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

uploadFiles(String university, String filename, Uint8List file, String name,
    String lastname, String type) async {
  FirebaseStorage storage = FirebaseStorage.instance;
  Reference ref =
      storage.ref(university).child("$name $lastname").child("$type $filename");
  try {
    await ref.putData(file);
  } on FirebaseException catch (e) {
    return e;
  }
}
