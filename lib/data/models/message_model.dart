class MessageModel {
  final String messageId;
  final String messageText;
  final bool isFile;
  final DateTime createdTime;
  final String contactId;
  final bool status;

  MessageModel({
    required this.messageId,
    required this.messageText,
    required this.isFile,
    required this.createdTime,
    required this.contactId,
    required this.status,
  });

  factory MessageModel.fromJson(Map<String, dynamic> mp) {
    return MessageModel(
      messageId: mp['messageId'],
      messageText: mp['messageText'],
      isFile: bool.parse(mp['isFile']),
      createdTime: DateTime.parse(mp['createdTime']),
      contactId: mp['contactId'],
      status: bool.parse(mp['status']),
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'messageId': messageId,
      'messageText': messageText,
      'isFile': isFile,
      'createdTime': createdTime.toString(),
      'contactId': contactId,
      'status': status,
    };
  }
}
