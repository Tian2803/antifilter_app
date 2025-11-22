import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/exceptions/exceptions.dart';
import '../models/favorite_photo_model.dart';

abstract class FavoriteRemoteDataSource {
  Future<List<FavoritePhotoModel>> getAllPhotos();
}

class FavoriteRemoteDataSourceImpl implements FavoriteRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  FavoriteRemoteDataSourceImpl(this.firestore, this.auth);

  @override
  Future<List<FavoritePhotoModel>> getAllPhotos() async {
    try {
      final currentUser = auth.currentUser;
      if (currentUser == null) {
        throw AuthException('User not authenticated');
      }

      final String userId = currentUser.uid;

      final querySnapshot = await firestore
          .collection('favorites')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return FavoritePhotoModel.fromJson(data);
      }).toList();
    } on FirebaseException catch (e) {
      throw ServerException(e.message ?? 'Failed to get photos');
    } catch (e) {
      throw ServerException('An error occurred while fetching photos: $e');
    }
  }
}
