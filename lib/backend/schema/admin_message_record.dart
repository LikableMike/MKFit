import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AdminMessageRecord extends FirestoreRecord {
  AdminMessageRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "time_posted" field.
  DateTime? _timePosted;
  DateTime? get timePosted => _timePosted;
  bool hasTimePosted() => _timePosted != null;

  // "message" field.
  String? _message;
  String get message => _message ?? '';
  bool hasMessage() => _message != null;

  void _initializeFields() {
    _timePosted = snapshotData['time_posted'] as DateTime?;
    _message = snapshotData['message'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Admin_Message');

  static Stream<AdminMessageRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AdminMessageRecord.fromSnapshot(s));

  static Future<AdminMessageRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AdminMessageRecord.fromSnapshot(s));

  static AdminMessageRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AdminMessageRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AdminMessageRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AdminMessageRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AdminMessageRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AdminMessageRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAdminMessageRecordData({
  DateTime? timePosted,
  String? message,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'time_posted': timePosted,
      'message': message,
    }.withoutNulls,
  );

  return firestoreData;
}

class AdminMessageRecordDocumentEquality
    implements Equality<AdminMessageRecord> {
  const AdminMessageRecordDocumentEquality();

  @override
  bool equals(AdminMessageRecord? e1, AdminMessageRecord? e2) {
    return e1?.timePosted == e2?.timePosted && e1?.message == e2?.message;
  }

  @override
  int hash(AdminMessageRecord? e) =>
      const ListEquality().hash([e?.timePosted, e?.message]);

  @override
  bool isValidKey(Object? o) => o is AdminMessageRecord;
}
