import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(
      {this.nickname, this.profileImage, this.points, this.firebaseToken});

  final String? nickname;
  final String? profileImage;
  final int? points;
  final String? firebaseToken;

  @override
  List<Object?> get props => [nickname, profileImage, points, firebaseToken];

  User copyWith(
      {String? nickname,
      String? profileImage,
      int? points,
      String? firebaseToken}) {
    return User(
      nickname: nickname ?? this.nickname,
      profileImage: profileImage ?? this.profileImage,
      points: points ?? this.points,
      firebaseToken: firebaseToken ?? this.firebaseToken,
    );
  }

  static const empty = User();
}
