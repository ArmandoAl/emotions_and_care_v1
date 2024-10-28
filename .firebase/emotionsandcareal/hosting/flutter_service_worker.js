'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "7bda5378ceea225c9a6ec6befe0adc71",
"version.json": "5ab64f40a4eb7ec58c931e59f0b8f79f",
"index.html": "ba26a2f96c63625468917d1b5df73424",
"/": "ba26a2f96c63625468917d1b5df73424",
"main.dart.js": "2fd04ac1665a9dacafc32db05d725862",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "79ae460a0d80abb7954c459657f6593b",
"assets/AssetManifest.json": "7c191bcfaa872fbdb2610d3023af847a",
"assets/NOTICES": "d023b4851c37fe2183c47b5fd7d80146",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "d85fe1db7713d195788b3f30a6f3659b",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/lib/config/assets/images/menu_carta.png": "c32e24f694da98d9bf9c89c5736ad7c3",
"assets/lib/config/assets/images/menu_post.png": "7ee437538065a19dda0fedac66629a1a",
"assets/lib/config/assets/images/paper.png": "18aff19db4e4b4ccf9c014b9e6ad0657",
"assets/lib/config/assets/images/sobre.png": "bfa1c4a88fe748084fd2b209a5ab5f63",
"assets/lib/config/assets/images/maceta.png": "93ef00dffaa785530d0701aa0c2ed068",
"assets/lib/config/assets/images/brain.png": "372a79d13f3d1d74f1a8a64b5e11f12f",
"assets/lib/config/assets/images/background1.svg": "4cf09006f37bc89d9685bc4833de7edc",
"assets/lib/config/assets/images/background3.svg": "6d234fc904d49ee12a7603c84891c9f0",
"assets/lib/config/assets/images/background2.svg": "a4f8ee64155103b6cfff6402cfe75863",
"assets/lib/config/assets/images/background_pick.png": "b729e3da6f51c854ef72292cd6ccf4a2",
"assets/lib/config/assets/images/joven_universitario_hover.png": "61ca68ad0da87b6467d00311508a2b99",
"assets/lib/config/assets/images/background4.svg": "3a2b1d0976415502f94b20d7550942c8",
"assets/lib/config/assets/images/patio_icon.png": "b0bf34b23865b9a1a4ef9af3a8f24202",
"assets/lib/config/assets/images/cat.png": "773524d3b7af1b1f7b316eac09ad25d2",
"assets/lib/config/assets/images/planta.png": "bb60fe998eb187c47de477882b5dfad0",
"assets/lib/config/assets/images/color_palette.png": "b96db85e62405ae6e237d965ecd0cec8",
"assets/lib/config/assets/images/flower.png": "3a8db4062e782778d61743ea80e5a24b",
"assets/lib/config/assets/images/especialista_hover.png": "e2250b1d721d532c36573cd55f07c0ee",
"assets/lib/config/assets/images/madera.png": "b9bf7d9aa397906672ca6423bc3b59dc",
"assets/lib/config/assets/images/especialista.png": "d7c1849efa4cb4d74df58e3e7788c6d7",
"assets/lib/config/assets/images/scroll.png": "d71b0657fe98e74ae70eb05c360f921e",
"assets/lib/config/assets/images/bear.png": "30033515879bd64f5457d3d9383db052",
"assets/lib/config/assets/images/joven_universitario.png": "4aca7657505f8892bcfc37e84dacb3b3",
"assets/lib/config/assets/animations/paper_plane_animation.json": "c8ab9d57cd3b45c871d04cb57f90be97",
"assets/lib/config/assets/animations/loading_brain.json": "08d79ccc2dee17401bfe2091491be9c7",
"assets/lib/config/assets/animations/brain_animation.json": "e8840bb07e4700878eb04bc8814cedd6",
"assets/AssetManifest.bin": "5ea2ca4266f5eae39cd4933dd3fedd4d",
"assets/fonts/MaterialIcons-Regular.otf": "e8dbcb229f5fd5fde6cba1f6be051b36",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
