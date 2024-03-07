// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserProfile {
  final String? name;
  final String? userId;
  final String? profileAvatar;
  final String? coins;
  final String? allTimeRank;
  final String? allTimeScore;
  UserProfile({
    this.name,
    this.userId,
    this.profileAvatar,
    this.coins,
    this.allTimeRank,
    this.allTimeScore,
  });

  UserProfile copyWith({
    String? name,
    String? userId,
    String? profileAvatar,
    String? coins,
    String? allTimeRank,
    String? allTimeScore,
  }) {
    return UserProfile(
      name: name ?? this.name,
      userId: userId ?? this.userId,
      profileAvatar: profileAvatar ?? this.profileAvatar,
      coins: coins ?? this.coins,
      allTimeRank: allTimeRank ?? this.allTimeRank,
      allTimeScore: allTimeScore ?? this.allTimeScore,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'userId': userId,
      'profileAvatar': profileAvatar,
      'coins': coins,
      'allTimeRank': allTimeRank,
      'allTimeScore': allTimeScore,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      name: map['name'] != null ? map['name'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      profileAvatar:
          map['profileAvatar'] != null ? map['profileAvatar'] as String : null,
      coins: map['coins'] != null ? map['coins'] as String : null,
      allTimeRank:
          map['allTimeRank'] != null ? map['allTimeRank'] as String : null,
      allTimeScore:
          map['allTimeScore'] != null ? map['allTimeScore'] as String : null,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory UserProfile.fromJson(String source) => UserProfile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserProfile(name: $name, userId: $userId, profileAvatar: $profileAvatar, coins: $coins, allTimeRank: $allTimeRank, allTimeScore: $allTimeScore)';
  }
}
