class UserCredential {
  // AdditionalUserInfo? additionalUserInfo;
  // AuthCredential? credential;
  User? user;

//   UserCredential({
//     this.additionalUserInfo,
//     this.credential,
//     this.user,
//   });

//   factory UserCredential.fromMap(Map<String, dynamic> map) {
//     return UserCredential(
//       additionalUserInfo: AdditionalUserInfo.fromMap(map['additionalUserInfo']),
//       credential: AuthCredential.fromMap(map['credential']),
//       user: User.fromMap(map['user']),
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'additionalUserInfo': additionalUserInfo?.toMap(),
//       'credential': credential?.toMap(),
//       'user': user?.toMap(),
//     };
//   }
// }

// class AdditionalUserInfo {
//   bool? isNewUser;
//   Map<String, dynamic>? profile;
//   String? providerId;
//   String? username;
//   String? authorizationCode;

//   AdditionalUserInfo({
//     this.isNewUser,
//     this.profile,
//     this.providerId,
//     this.username,
//     this.authorizationCode,
//   });

//   factory AdditionalUserInfo.fromMap(Map<String, dynamic> map) {
//     return AdditionalUserInfo(
//       isNewUser: map['isNewUser'],
//       profile: Map<String, dynamic>.from(map['profile']),
//       providerId: map['providerId'],
//       username: map['username'],
//       authorizationCode: map['authorizationCode'],
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'isNewUser': isNewUser,
//       'profile': profile,
//       'providerId': providerId,
//       'username': username,
//       'authorizationCode': authorizationCode,
//     };
//   }
// }

// class AuthCredential {
//   String? providerId;
//   String? signInMethod;
//   int? token;
//   String? accessToken;

//   AuthCredential({
//     this.providerId,
//     this.signInMethod,
//     this.token,
//     this.accessToken,
//   });

//   factory AuthCredential.fromMap(Map<String, dynamic> map) {
//     return AuthCredential(
//       providerId: map['providerId'],
//       signInMethod: map['signInMethod'],
//       token: map['token'],
//       accessToken: map['accessToken'],
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'providerId': providerId,
//       'signInMethod': signInMethod,
//       'token': token,
//       'accessToken': accessToken,
//     };
//   }
}

class User {
  String? displayName;
  String? email;
  bool? isEmailVerified;
  bool? isAnonymous;
  UserMetadata? metadata;
  String? phoneNumber;
  String? photoURL;
  List<UserInfo>? providerDatas;
  String? refreshToken;
  String? tenantId;
  String? uid;

  User({
    this.displayName,
    this.email,
    this.isEmailVerified,
    this.isAnonymous,
    this.metadata,
    this.phoneNumber,
    this.photoURL,
    this.providerDatas,
    this.refreshToken,
    this.tenantId,
    this.uid,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      displayName: map['displayName'],
      email: map['email'],
      isEmailVerified: map['isEmailVerified'],
      isAnonymous: map['isAnonymous'],
      metadata: UserMetadata.fromMap(map['metadata']),
      phoneNumber: map['phoneNumber'],
      photoURL: map['photoURL'],
      providerDatas: List<UserInfo>.from(
          map['providerDatas']?.map((x) => UserInfo.fromMap(x)) ?? []),
      refreshToken: map['refreshToken'],
      tenantId: map['tenantId'],
      uid: map['uid'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'email': email,
      'isEmailVerified': isEmailVerified,
      'isAnonymous': isAnonymous,
      'metadata': metadata?.toMap(),
      'phoneNumber': phoneNumber,
      'photoURL': photoURL,
      'providerDatas': providerDatas?.map((x) => x.toMap()).toList(),
      'refreshToken': refreshToken,
      'tenantId': tenantId,
      'uid': uid,
    };
  }
}

class UserMetadata {
  DateTime? creationTime;
  DateTime? lastSignInTime;

  UserMetadata({
    this.creationTime,
    this.lastSignInTime,
  });

  factory UserMetadata.fromMap(Map<String, dynamic> map) {
    return UserMetadata(
      creationTime: DateTime.parse(map['creationTime']),
      lastSignInTime: DateTime.parse(map['lastSignInTime']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'creationTime': creationTime?.toIso8601String(),
      'lastSignInTime': lastSignInTime?.toIso8601String(),
    };
  }
}

class UserInfo {
  String? displayName;
  String? email;
  String? phoneNumber;
  String? photoURL;
  String? providerId;
  String? uid;
  String? bio;

  UserInfo({
    this.displayName,
    this.email,
    this.phoneNumber,
    this.photoURL,
    this.providerId,
    this.uid,
    this.bio,
  });

  factory UserInfo.fromMap(Map<String, dynamic> map) {
    return UserInfo(
        displayName: map['displayName'],
        email: map['email'],
        phoneNumber: map['phoneNumber'],
        photoURL: map['photoURL'],
        providerId: map['providerId'],
        uid: map['uid'],
        bio: map['bio']);
  }

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'email': email,
      'phoneNumber': phoneNumber,
      'photoURL': photoURL,
      'providerId': providerId,
      'uid': uid,
    };
  }
}
