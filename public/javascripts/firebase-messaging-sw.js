importScripts('https://www.gstatic.com/firebasejs/4.8.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/4.8.1/firebase-auth.js');
importScripts('https://www.gstatic.com/firebasejs/4.8.1/firebase-messaging.js');
importScripts('/firebase/init.js');

console.log(">>> firebase.auth(): ");
firebase.auth();
console.log(">>> firebase.messaging(): ");
firebase.messaging();
