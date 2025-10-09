import 'package:cloud_firestore/cloud_firestore.dart';

class Games 
{
  String? id;
  String title;
  String category;
  String posterUrl;
  String creator;
  String year;

  //Constructor
  Games(
    {
      this.id,
      required this.title,
      required this.category,
      required this.posterUrl,
      required this.creator,
      required this.year,
    }
  );

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'category': category,
      'creator': creator,
      'year': year,
      'posterUrl': posterUrl,
    };
  }

  static Games fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Games(
      id: snapshot.id,
      title: data?['title'],
      category: data?['category'],
      creator: data?['creator'],
      year: data?['year'],
      posterUrl: data?['posterUrl'],
    );
  }

}