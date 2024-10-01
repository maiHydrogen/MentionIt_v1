class ChatUser {
  ChatUser({
    required this.createdAt,
    required this.isOnline,
    required this.lastActive,
    required this.id,
    required this.email,
    required this.Image,
    required this.pushToken,
    required this.Name,
    required this.About,
  });
  late final String createdAt;
  late final bool isOnline;
  late final String lastActive;
  late final String id;
  late final String Image;
  late final String pushToken;
  late final String Name;
  late final String About;
  late final String email;

  ChatUser.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'] ?? '';
    isOnline = json['is_online'] ?? '';
    lastActive = json['last_active'] ?? '';
    id = json['id'] ?? '';
    email = json['email'] ?? '';
    Image = json['Image'] ?? '';
    pushToken = json['push_token'] ?? '';
    Name = json['Name'] ?? '';
    About = json['About'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['created_at'] = createdAt;
    _data['is_online'] = isOnline;
    _data['last_active'] = lastActive;
    _data['id'] = id;
    _data['Image'] = Image;
    _data['push_token'] = pushToken;
    _data['Name'] = Name;
    _data['email'] = email;
    _data['About'] = About;
    return _data;
  }
}
