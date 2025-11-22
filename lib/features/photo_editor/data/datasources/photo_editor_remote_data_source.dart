import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class PhotoEditorRemoteDataSource {
  Future<String> uploadPhoto(File imageFile);
  Future<String> saveToFavorites(File imageFile);
}

class PhotoEditorRemoteDataSourceImpl implements PhotoEditorRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;
  final FirebaseAuth auth;

  PhotoEditorRemoteDataSourceImpl({
    required this.firestore,
    required this.storage,
    required this.auth,
  });

  @override
  Future<String> uploadPhoto(File imageFile) async {
    try {
      final currentUser = auth.currentUser;
      if (currentUser == null) {
        throw Exception('User not authenticated');
      }
      
      final String userId = currentUser.uid;
      final int timestamp = DateTime.now().millisecondsSinceEpoch;
      final String fileName = '${timestamp}_$userId.jpg';

      // Guarda la imagen en firebase Storage carpeta /history
      final Reference ref = storage.ref().child('history/$fileName');
      final UploadTask uploadTask = ref.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      // Guarda la data en Firestore colección history
      final docRef = await firestore.collection('history').add({
        'userId': userId,
        'photoUrl': downloadUrl,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return docRef.id;
    } catch (e) {
      throw Exception('Error uploading photo to history: $e');
    }
  }

  @override
  Future<String> saveToFavorites(File imageFile) async {
    try {
      final currentUser = auth.currentUser;
      if (currentUser == null) {
        throw Exception('User not authenticated');
      }
      
      final String userId = currentUser.uid;
      final int timestamp = DateTime.now().millisecondsSinceEpoch;
      final String fileName = '${timestamp}_$userId.jpg';

      // Guarda la imagen en firebase Storage carpeta /favorites
      final Reference ref = storage.ref().child('favorites/$fileName');
      final UploadTask uploadTask = ref.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      // Guarda la data en Firestore colección favorites
      final docRef = await firestore.collection('favorites').add({
        'userId': userId,
        'photoUrl': downloadUrl,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return docRef.id;
    } catch (e) {
      throw Exception('Error uploading photo to history: $e');
    }
  }
}
