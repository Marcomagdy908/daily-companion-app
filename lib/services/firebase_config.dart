// ─── services/firebase_config.dart ─────────────────────────────────────
// Daily Companion (رفيق يومي) — Firebase initialization & configuration
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../firebase_options.dart';

class FirebaseConfig {
  static final FirebaseConfig _instance = FirebaseConfig._();
  factory FirebaseConfig() => _instance;
  FirebaseConfig._();

  FirebaseAuth get auth => FirebaseAuth.instance;
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  static Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Enable Firestore offline persistence
    FirebaseFirestore.instance.settings =
        const Settings(persistenceEnabled: true, cacheSizeBytes: 100 * 1024 * 1024);
  }

  /// Collection references
  CollectionReference<Map<String, dynamic>> get usersCollection =>
      firestore.collection('users');

  CollectionReference<Map<String, dynamic>> get giftsCollection =>
      firestore.collection('daily_gifts');

  CollectionReference<Map<String, dynamic>> get commitmentsCollection =>
      firestore.collection('commitments');

  CollectionReference<Map<String, dynamic>> get growthCollection =>
      firestore.collection('growth_states');

  CollectionReference<Map<String, dynamic>> get challengesCollection =>
      firestore.collection('challenges');
}
