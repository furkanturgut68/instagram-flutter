class User{
  final String email;
  final String uid;
  final String bio;
  final String photoUrl;
  final String username;
  final List followers;
  final List following;

  const User({
    required this.email,
    required this.uid,
    required this.bio,
    required this.photoUrl,
    required this.username,
    required this.followers,
    required this.following

  });

  Map<String,dynamic> toJson() =>{
    'email':email,
    'username':username,
    'bio':bio,
    'photoUrl':photoUrl,
    'uid':uid,
    'followers':followers,
    'following':following
  };
}