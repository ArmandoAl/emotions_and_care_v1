// ignore_for_file: avoid_print
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class FirebaseNotificationsCubit extends Cubit<NotificationState> {
  FirebaseNotificationsCubit() : super(const NotificationState());

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    final String os = getPlattform();
    final NotificationSettings res = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (res.authorizationStatus == AuthorizationStatus.authorized) {
      _firebaseMessaging.onTokenRefresh.listen((token) {
        // print('FirebaseMessaging token refreshed: $token');
        print("token refreshed: $token");
        emit(state.copyWith(token: token));
      });

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // print('Got a message while in the foreground!');
        print('Message data: $message');
        emit(state.copyWith(message: message.data));
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('A new onMessageOpenedApp event was published!');
      });

      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);

      String token = "";
      if (os == 'ios') {
        token = await _firebaseMessaging.getAPNSToken() ?? "";
      } else {
        if (os == 'android') {
          token = await _firebaseMessaging.getToken() ?? "";
        } else {
          token = await _firebaseMessaging.getToken(
                  vapidKey:
                      'BFNqfSXGTG1S09jgTrnKezuMoeIm4YKTmGpj-pSJ3I_bdJmwMjukbbo9y0DZ-LhU29hdKi1DWMhR4R8GDNTLlVA') ??
              "";

          print('Token: $token');
        }
      }

      emit(state.copyWith(token: token));
    } else {
      print('User declined or has not accepted permission');
      emit(state.copyWith(token: ''));
    }
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

class NotificationState extends Equatable {
  final Map<String, dynamic> message;
  final String token;
  final bool uploadingToken;
  final bool tokenUploaded;
  final bool uploadError;

  const NotificationState({
    this.message = const {},
    this.token = '',
    this.uploadingToken = false,
    this.tokenUploaded = false,
    this.uploadError = false,
  });

  NotificationState copyWith({
    Map<String, dynamic>? message,
    String? token,
    bool? uploadingToken,
    bool? tokenUploaded,
    bool? uploadError,
  }) {
    return NotificationState(
      message: message ?? this.message,
      token: token ?? this.token,
      uploadingToken: uploadingToken ?? this.uploadingToken,
      tokenUploaded: tokenUploaded ?? this.tokenUploaded,
      uploadError: uploadError ?? this.uploadError,
    );
  }

  @override
  List<Object> get props => [
        message,
        token,
        uploadingToken,
        tokenUploaded,
        uploadError,
      ];
}

String getPlattform() {
  if (kIsWeb) {
    return "web";
  } else if (Platform.isAndroid) {
    return "android";
  } else if (Platform.isIOS) {
    return "ios";
  } else {
    return "desconocido";
  }
}

// web       1:337730650555:web:f9629f09774e07edbcc49e
// android   1:337730650555:android:0223342204b1cf2ebcc49e
// ios       1:337730650555:ios:94bbde6931b348cebcc49e
