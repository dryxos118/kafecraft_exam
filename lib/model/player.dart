class Player {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final int deeVee;
  final int goldSeed;

  Player({
    this.id,
    this.firstName,
    this.lastName,
    required this.email,
    this.deeVee = 10,
    this.goldSeed = 0,
  });

  factory Player.fromMap(Map<String, dynamic> data) {
    return Player(
      id: data['id'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      email: data['email'],
      deeVee: data['deeVee'] ?? 10,
      goldSeed: data['goldSeed'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'deeVee': deeVee,
      'goldSeed': goldSeed
    };
  }

  Player copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    int? deeVee,
    int? goldSeed,
  }) {
    return Player(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      deeVee: deeVee ?? this.deeVee,
      goldSeed: goldSeed ?? this.goldSeed,
    );
  }
}
