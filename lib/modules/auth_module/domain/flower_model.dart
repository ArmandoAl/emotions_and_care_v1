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
  List<String>? urls;
  FlowerState? state = FlowerState.initialFlowet;

  FlowerModel({this.id, this.urls, this.state});

  FlowerModel copyWith({
    int? id,
    List<String>? urls,
    FlowerState? state,
  }) {
    return FlowerModel(
      id: id ?? this.id,
      urls: urls ?? this.urls,
      state: state ?? this.state,
    );
  }

  FlowerModel.fromJson(Map<String, dynamic> json) {
    id = json['flowerId'];
    urls = json['urls'].cast<String>();
    state = FlowerState.values[json['state']];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['flowerId'] = id;
    data['urls'] = urls;
    data['state'] = state!.index;
    return data;
  }
}
