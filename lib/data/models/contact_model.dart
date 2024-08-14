class ContactModel {
  final String contactId;
  final String contactName;
  final String contactLastName;
  final bool isOnline;
  final String imageUrl;
  final DateTime lastOnlineTime;

  ContactModel({
    required this.contactId,
    required this.contactLastName,
    required this.contactName,
    required this.isOnline,
    required this.imageUrl,
    required this.lastOnlineTime,
  });

  factory ContactModel.fromJson(Map<String, dynamic> mp,String id) {
    return ContactModel(
      contactId: id,
      contactLastName: mp['contactLastName'],
      contactName: mp['contactName'],
      isOnline: bool.parse(mp['isOnline'].toString()),
      imageUrl: mp['imageUrl'],
      lastOnlineTime: DateTime.parse(mp['lastOnlineTime'].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "contactId": contactId,
      "contactName": contactName,
      "contactLastName": contactLastName,
      "isOnline": isOnline,
      "imageUrl": imageUrl,
      "lastOnlineTime": lastOnlineTime.toString()
    };
  }
}
