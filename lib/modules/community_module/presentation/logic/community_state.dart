import 'package:equatable/equatable.dart';

import '../../../../helpers/paths.dart';

enum CommunityStatus { initial, loading, loaded, error, success }

class CommunityState extends Equatable {
  // final List<PostModel> posts;
  final List<CartModel> cartFromCommunity;
  final List<CartModel> cartFromUser;
  final CommunityStatus status;

  const CommunityState({
    //  this.posts = const [],
    this.cartFromCommunity = const [],
    this.cartFromUser = const [],
    this.status = CommunityStatus.initial,
  });

  CommunityState copyWith({
    //  List<PostModel>? posts,
    List<CartModel>? cartFromCommunity,
    List<CartModel>? cartFromUser,
    CommunityStatus? status,
  }) {
    return CommunityState(
      //  posts: posts ?? this.posts,
      cartFromCommunity: cartFromCommunity ?? this.cartFromCommunity,
      cartFromUser: cartFromUser ?? this.cartFromUser,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        //   posts,
        cartFromCommunity,
        cartFromUser,
        status,
      ];
}
