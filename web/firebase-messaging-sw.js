importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-messaging.js");
firebase.initializeApp({
//    apiKey: "AIzaSyD8GamJ6XqqsNm4SUCOkajPOVEXayiKymc",
//    authDomain: "ustain-bafc6.firebaseapp.com",
//    projectId: "ustain-bafc6",
//    storageBucket: "ustain-bafc6.appspot.com",
//    messagingSenderId: "1097012875305",
//    appId: "1:1097012875305:web:e6428ee43c5fcb9c9bcc38",
//    measurementId: "G-HHS460QPEW"
});

const messaging = firebase.messaging();

messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            return registration.showNotification("New Message");
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});
