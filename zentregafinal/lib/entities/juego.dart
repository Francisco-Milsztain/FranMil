import 'package:cloud_firestore/cloud_firestore.dart';

class Juego {
  final String id;         
  final String title;
  final String category;
  final String creator;
  final String posterUrl;
  final String year;

  Juego({
    required this.id,
    required this.title,
    required this.category,
    required this.creator,
    required this.posterUrl,
    required this.year,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'creator': creator,
      'posterUrl': posterUrl,
      'year': year,
    };
  }

  static Juego fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data() ?? {};
    return Juego(
      id: data['id'] ?? snapshot.id, // fallback al id del doc
      title: data['title'] ?? '',
      category: data['category'] ?? '',
      creator: data['creator'] ?? '',
      posterUrl: data['posterUrl'] ?? '',
      year: data['year'] ?? '',
    );
  }
}
