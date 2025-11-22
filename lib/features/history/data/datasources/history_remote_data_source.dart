import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/exceptions/exceptions.dart';
import '../models/history_photo_model.dart';

abstract class HistoryRemoteDataSource {
  Future<List<HistoryPhotoModel>> getAllPhotos();
}

class HistoryRemoteDataSourceImpl implements HistoryRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  HistoryRemoteDataSourceImpl(this.firestore, this.auth);

  @override
  Future<List<HistoryPhotoModel>> getAllPhotos() async {
    try {
      final currentUser = auth.currentUser;
      if (currentUser == null) {
        throw AuthException('User not authenticated');
      }
      
      final String userId = currentUser.uid;
      
      final querySnapshot = await firestore
          .collection('history')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return HistoryPhotoModel.fromJson(data);
      }).toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Failed to get photos');
    } catch (e) {
      throw ServerException('An error occurred while fetching photos: $e');
    }
  }
}
