'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "index.html": "d5cf5156f279f90fe43458e41102888f",
"/": "d5cf5156f279f90fe43458e41102888f",
"main.dart.js": "0709656498c48117ebfe118d82a6b149",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "9e282c643a619eb3902619a2b6835e07",
"assets/LICENSE": "c749a804d216e241410fe1a0f674faf7",
"assets/AssetManifest.json": "f084d91c1f11909678a9938d47d3e155",
"assets/FontManifest.json": "580ff1a5d08679ded8fcf5c6848cece7",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/assets/teacher.png": "13a679df16073432c0fc46c7753597f8",
"assets/assets/students.png": "83cbf304f5e1afc88c2c4c2accf9cd93",
"assets/assets/parent2.png": "784852ae6d3e86d0e0f98aff054a9b41",
"assets/assets/addUser@2x.png": "c8fbbccdaf2a3fea6386b25dbc08c708",
"assets/assets/login_image.png": "bcc600d2d9847b94afa754f6492236ca",
"assets/assets/student.png": "35780f0f43fa7bd1555c0515190aeea3",
"assets/assets/no_image_available.png": "2246dc72219bef9c17ed4e5678036e0d",
"assets/assets/parent.png": "79a4ecd7f0d24dc2b29edb881d6d6af8",
"assets/assets/addUser.png": "df3a59f06cdb78d001b1e6f9c7c301c9",
"assets/assets/login_image@2x.png": "a797c633338b4a4d1fb0560eef1907fb"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});
