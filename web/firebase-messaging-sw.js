// firebase-messaging-sw.js
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts(
  "https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js"
);

firebase.initializeApp({
  apiKey: "AIzaSyDRGlfxdeR22WX4gPF2Im7YLiH9k9QskwA",
  authDomain: "emotionsandcareal.firebaseapp.com",
  projectId: "emotionsandcareal",
  storageBucket: "emotionsandcareal.appspot.com",
  messagingSenderId: "337730650555",
  appId: "1:337730650555:web:f9629f09774e07edbcc49e",
  measurementId: "G-906S1H6J2C",
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});



// web       1:337730650555:web:f9629f09774e07edbcc49e
// android   1:337730650555:android:7219ef3af2acb372bcc49e
// ios       1:337730650555:ios:5705cc499b2040cbbcc49e
