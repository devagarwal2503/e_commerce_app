import 'package:equatable/equatable.dart';

class LocalUser extends Equatable {
  const LocalUser({
    required this.uid,
    required this.email,
    this.profilePic,
    required this.fullName,
  });

  const LocalUser.empty()
    : this(email: "", fullName: "", uid: "", profilePic: "");

  final String uid;
  final String email;
  final String? profilePic;
  final String fullName;

  @override
  List<Object?> get props => [uid, email];
}
