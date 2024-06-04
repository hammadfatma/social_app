class PostModel {
  final String name;
  final String uId;
  final String image;
  final String dateTime;
  final String text;
  final String postImage;

  PostModel(
    this.name,
    this.uId,
    this.image,
    this.dateTime,
    this.text,
    this.postImage,
  );
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      json['name'],
      json['uId'],
      json['image'],
      json['dateTime'],
      json['text'],
      json['postImage'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'dateTime': dateTime,
      'text': text,
      'postImage': postImage,
    };
  }
}
