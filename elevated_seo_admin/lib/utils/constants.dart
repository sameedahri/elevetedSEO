import 'package:cloud_firestore/cloud_firestore.dart';

/// Firestore Refrences
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference userRef = _firestore.collection('users');
final CollectionReference adminRef = _firestore.collection('admins');
