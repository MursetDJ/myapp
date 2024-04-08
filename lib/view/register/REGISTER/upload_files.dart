import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

uploadFiles(Uint8List file, String filename, String email, String type) async {
  const String registerRef = 'http://127.0.0.1:8000/api/';
  http.MultipartFile multipartFile =
      http.MultipartFile.fromBytes('document', file, filename: filename);
  try {
    final request =
        http.MultipartRequest('POST', Uri.parse("${registerRef}userdocument"));
    request.files.add(multipartFile);
    request.fields['email'] = email;
    request.fields['pre'] = type;
    await request.send();
  } catch (e) {
    return e;
  }
}
/*
FirebaseStorage storage = FirebaseStorage.instance;
  Reference ref =
      storage.ref(university).child("$name $lastname").child("$type $filename");
  try {
    await ref.putData(file);
  } on FirebaseException catch (e) {
    return e;
  }
 */