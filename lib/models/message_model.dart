class MessageModel {
  final String senderId;
  final String receiverId;
  final String dateTime;
  final String text;

  MessageModel(
    this.senderId,
    this.receiverId,
    this.dateTime,
    this.text,
  );
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      json['senderId'],
      json['receiverId'],
      json['dateTime'],
      json['text'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'dateTime': dateTime,
      'text': text,
    };
  }
}
