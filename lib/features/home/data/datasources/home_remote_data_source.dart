import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../../core/exceptions/exceptions.dart';
import '../models/photo_model.dart';

abstract class HomeRemoteDataSource {
  Future<PhotoModel> uploadPhoto(String filePath, String userId);
  Future<List<PhotoModel>> getRecentPhotos(String userId);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  HomeRemoteDataSourceImpl(this._firestore, this._storage);

  @override
  Future<PhotoModel> uploadPhoto(String filePath, String userId) async {
    try {
      final file = File(filePath);
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final ref = _storage.ref().child('photos/$userId/$fileName');

      await ref.putFile(file);
      final downloadUrl = await ref.getDownloadURL();

      final photoData = {
        'userId': userId,
        'originalUrl': downloadUrl,
        'processedUrl': null,
        'createdAt': DateTime.now().toIso8601String(),
        'isFavorite': false,
      };

      final docRef = await _firestore.collection('photos').add(photoData);
      photoData['id'] = docRef.id;

      return PhotoModel.fromJson(photoData);
    } on FirebaseException catch (e) {
      throw StorageException(e.message ?? 'Failed to upload photo');
    } catch (e) {
      throw StorageException('An error occurred while uploading');
    }
  }

  @override
  Future<List<PhotoModel>> getRecentPhotos(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection('photos')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .limit(10)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return PhotoModel.fromJson(data);
      }).toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Failed to get photos');
    } catch (e) {
      throw ServerException('An error occurred while fetching photos');
    }
  }
}
