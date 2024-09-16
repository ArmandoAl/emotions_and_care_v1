class StickerModel {
  int? id;
  String? url;

  StickerModel({this.id, this.url});

  StickerModel.fromJson(Map<String, dynamic> json) {
    id = json['idSticker'];
    url = json['imagen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idSticker'] = id;
    data['imagen'] = url;
    return data;
  }

  //emtpy
  StickerModel.empty() {
    id = null;
    url = null;
  }
}
