import 'package:e_commerce_app/core/utils/typedefs.dart';
import 'package:e_commerce_app/src/authentication/domain/entities/user_entity.dart';

class LocalUserModel extends LocalUser {
  const LocalUserModel({
    required super.uid,
    required super.email,
    required super.fullName,
    super.profilePic,
  });

  const LocalUserModel.empty()
    : this(email: "", fullName: "", uid: "", profilePic: "");

  LocalUserModel.fromMap(DataMap map)
    : super(
        uid: map['uid'] as String,
        email: map['email'] as String,
        fullName: map['fullName'] as String,
        profilePic: map['profilePic'] as String?,
      );

  DataMap toMap() => {
    'uid': uid,
    'email': email,
    'fullName': fullName,
    'profilePic': profilePic,
  };

  LocalUserModel copyWith({
    String? uid,
    String? email,
    String? fullName,
    String? profilePic,
  }) {
    return LocalUserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      profilePic: profilePic ?? this.profilePic,
    );
  }
}
