importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts(
  "https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js"
);

firebase.initializeApp({
  apiKey: "AIzaSyDRGlfxdeR22WX4gPF2Im7YLiH9k9QskwA",
  appId: "1:337730650555:web:f9629f09774e07edbcc49e",
  messagingSenderId: "337730650555",
  projectId: "emotionsandcareal",
  authDomain: "emotionsandcareal.firebaseapp.com",
  storageBucket: "emotionsandcareal.appspot.com",
  measurementId: "G-906S1H6J2C",
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});
