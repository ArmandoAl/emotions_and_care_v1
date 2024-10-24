enum FlowerState {
  initialFlowet,
  firstStepFlower,
  secondStepFlower,
  thirdStepFlower,
  fourthStepFlower,
  fifthStepFlower,
}

class FlowerModel {
  int? id;
  String? name;
  List<FlowerImageModel>? urls;

  FlowerModel({this.id, this.urls, this.name});

  FlowerModel copyWith({
    int? id,
    String? name,
    List<FlowerImageModel>? urls,
    FlowerState? state,
  }) {
    return FlowerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      urls: urls ?? this.urls,
    );
  }

  FlowerModel.fromJson(Map<String, dynamic> json) {
    id = json['flowerId'] ?? 0;
    name = json['name'] ?? "";
    urls = json['images'] != null
        ? List<FlowerImageModel>.from(
            json['images'].map((x) => FlowerImageModel.fromJson(x)))
        : [];
  }

  Map<String, dynamic> toJson() {
    return {
      'flowerId': id,
      'name': name,
      'urls': urls!.map((e) => e.toJson()).toList(),
    };
  }
}

class FlowerImageModel {
  final int id;
  final String url;

  FlowerImageModel({required this.url, required this.id});

  FlowerImageModel copyWith({
    String? url,
    int? id,
  }) {
    return FlowerImageModel(
      url: url ?? this.url,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'int': id,
    };
  }

  factory FlowerImageModel.fromJson(Map<String, dynamic> json) {
    return FlowerImageModel(
      url: json['url'] ?? "",
      id: json['imageId'] ?? 0,
    );
  }
}
