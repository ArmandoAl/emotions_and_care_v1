class StickerModel {
  int? id;
  String? url;

  StickerModel({this.id, this.url});

  StickerModel.fromJson(Map<String, dynamic> json) {
    id = json['stickerId'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    return {
      'stickerId': id,
      'url': url,
    };
  }

  //emtpy
  StickerModel.empty() {
    id = null;
    url = null;
  }
}
