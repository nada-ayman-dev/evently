import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Add event to Firestore
  Future<void> addEvent({
    required String title,
    required String description,
    required String category,
    required String date,
    required String time,
    required String imagePath,
  }) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) throw Exception('User not logged in');

      await _firestore.collection('events').add({
        'userId': userId,
        'title': title,
        'description': description,
        'category': category,
        'date': date,
        'time': time,
        'imagePath': imagePath,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to add event: $e');
    }
  }

  // Get all events for current user
  Stream<List<Map<String, dynamic>>> getUserEvents() {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) throw Exception('User not logged in');

      return _firestore
          .collection('events')
          .where('userId', isEqualTo: userId)
          .snapshots()
          .map((snapshot) {
            final events = snapshot.docs.map((doc) {
              return {'id': doc.id, ...doc.data()};
            }).toList();

            // Sort by createdAt locally (descending)
            events.sort((a, b) {
              final aTime = a['createdAt'] as Timestamp?;
              final bTime = b['createdAt'] as Timestamp?;
              if (aTime == null || bTime == null) return 0;
              return bTime.compareTo(aTime);
            });

            return events;
          });
    } catch (e) {
      rethrow;
    }
  }

  // Add favorite
  Future<void> addFavorite(String eventId) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) throw Exception('User not logged in');

      await _firestore.collection('favorites').doc('${userId}_$eventId').set({
        'userId': userId,
        'eventId': eventId,
        'addedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to add favorite: $e');
    }
  }

  // Remove favorite
  Future<void> removeFavorite(String eventId) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) throw Exception('User not logged in');

      await _firestore
          .collection('favorites')
          .doc('${userId}_$eventId')
          .delete();
    } catch (e) {
      throw Exception('Failed to remove favorite: $e');
    }
  }

  // Get user favorites
  Stream<List<String>> getUserFavorites() {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) throw Exception('User not logged in');

      return _firestore
          .collection('favorites')
          .where('userId', isEqualTo: userId)
          .snapshots()
          .map((snapshot) {
            return snapshot.docs
                .map((doc) => doc['eventId'] as String)
                .toList();
          });
    } catch (e) {
      throw Exception('Failed to fetch favorites: $e');
    }
  }

  // Delete event
  Future<void> deleteEvent(String eventId) async {
    try {
      await _firestore.collection('events').doc(eventId).delete();
    } catch (e) {
      throw Exception('Failed to delete event: $e');
    }
  }

  // Save user profile to Firestore
  Future<void> saveUserProfile({
    required String name,
    required String email,
  }) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) throw Exception('User not logged in');

      await _firestore.collection('users').doc(userId).set({
        'name': name,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      throw Exception('Failed to save user profile: $e');
    }
  }

  // Get user profile from Firestore
  Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) throw Exception('User not logged in');

      final doc = await _firestore.collection('users').doc(userId).get();
      return doc.data();
    } catch (e) {
      throw Exception('Failed to fetch user profile: $e');
    }
  }

  // Get user profile as Stream (real-time updates)
  Stream<Map<String, dynamic>?> getUserProfileStream() {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) throw Exception('User not logged in');

      return _firestore.collection('users').doc(userId).snapshots().map((doc) {
        return doc.data();
      });
    } catch (e) {
      throw Exception('Failed to fetch user profile: $e');
    }
  }

  // Update event in Firestore
  Future<void> updateEvent({
    required String eventId,
    required String title,
    required String description,
    required String category,
    required String date,
    required String time,
  }) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) throw Exception('User not logged in');

      await _firestore.collection('events').doc(eventId).update({
        'title': title,
        'description': description,
        'category': category,
        'date': date,
        'time': time,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to update event: $e');
    }
  }
}
