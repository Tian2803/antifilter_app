import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/exceptions/exceptions.dart';
import '../models/photo_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<PhotoModel>> getRecentPhotos(int limit);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  HomeRemoteDataSourceImpl(this._firestore, this._auth);

  @override
  Future<List<PhotoModel>> getRecentPhotos(int limit) async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw AuthException('User not authenticated');
      }
      
      final String userId = currentUser.uid;
      
      final querySnapshot = await _firestore
          .collection('history')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .limit(limit)
          .get();

      log('Found ${querySnapshot.docs.length} photos');

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return PhotoModel.fromJson(data);
      }).toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Failed to get photos');
    } catch (e) {
      throw ServerException('An error occurred while fetching photos: $e');
    }
  }
}