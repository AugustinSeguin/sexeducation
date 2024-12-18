import 'package:sexeducation/models/comment_model.dart';
import 'package:sexeducation/models/user_model.dart';

class PostModel {
  final int? id;
  final int? categoryId;
  final int? authorId;
  final String? title;
  final String? description;
  final String? type;
  final String? image;
  final String? createdAt;
  final String? updatedAt;
  final UserModel? user;

  const PostModel({
    this.id,
    required this.categoryId,
    this.authorId,
    this.title,
    this.image,
    this.description,
    required this.type,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  PostModel copyWith(categoryId, authorId, type) {
    return PostModel(
      categoryId: categoryId ?? this.categoryId,
      type: type ?? this.type,
    );
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] != null ? int.parse(json['id'].toString()) : null,
      categoryId: json['category_id'] != null
          ? int.parse(json['category_id'].toString())
          : null,
      authorId: json['author_id'] != null
          ? int.parse(json['author_id'].toString())
          : null,
      title: json['title']?.toString(),
      description: json['description']?.toString(),
      type: json['type']?.toString() ?? "",
      image: json['image']?.toString() ?? "",
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
      user: json['user'] != null
          ? UserModel.fromJson(json['user'] as Map<String, Object?>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'author_id': authorId,
      'title': title,
      'description': description,
      'type': type,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  static List<CommentModel?>? commentList(List<dynamic> responseList) {
    return responseList.map((comment) {
      return CommentModel.fromJson(comment as Map<String, dynamic>);
    }).toList();
  }
}
