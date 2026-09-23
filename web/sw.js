const CACHE_NAME = "markaz-cache-v1";
const ASSETS_TO_CACHE = [
  "./",
  "index.html",
  "reader.html",
  "admin.html",
  "css/style.css",
  "js/data.js",
  "js/i18n.js",
  "js/storage.js",
  "js/audio-player.js",
  "js/app.js",
  "js/admin.js",
  "manifest.json"
];

self.addEventListener("install", (e) => {
  e.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      return cache.addAll(ASSETS_TO_CACHE);
    })
  );
  self.skipWaiting();
});

self.addEventListener("activate", (e) => {
  e.waitUntil(
    caches.keys().then((keys) => {
      return Promise.all(
        keys.map((key) => {
          if (key !== CACHE_NAME) {
            return caches.delete(key);
          }
        })
      );
    })
  );
  self.clients.claim();
});

self.addEventListener("fetch", (e) => {
  e.respondWith(
    caches.match(e.request).then((res) => {
      return res || fetch(e.request).catch(() => caches.match("index.html"));
    })
  );
});
