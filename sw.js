const CACHE = 'athle91-v33';
const ASSETS = ['/', '/index.html', '/icon-192.png', '/manifest.json'];

self.addEventListener('install', e => {
  e.waitUntil(caches.open(CACHE).then(c => c.addAll(ASSETS)));
  self.skipWaiting();
});

self.addEventListener('activate', e => {
  e.waitUntil(
    caches.keys()
      .then(keys => Promise.all(keys.filter(k => k !== CACHE).map(k => caches.delete(k))))
      .then(() => {
        // Notifier tous les onglets ouverts : nouvelle version détectée → rechargement
        return self.clients.matchAll({ includeUncontrolled: true, type: 'window' })
          .then(clients => clients.forEach(c => c.postMessage({ type: 'SW_UPDATED', version: CACHE })));
      })
  );
  self.clients.claim();
});

self.addEventListener('fetch', e => {
  // Supabase : toujours réseau
  if (e.request.url.includes('supabase.co')) {
    e.respondWith(fetch(e.request));
    return;
  }
  // Documents HTML : réseau en priorité → toujours la dernière version déployée
  if (e.request.destination === 'document') {
    e.respondWith(
      fetch(e.request)
        .then(response => {
          caches.open(CACHE).then(c => c.put(e.request, response.clone()));
          return response;
        })
        .catch(() => caches.match(e.request))
    );
    return;
  }
  // Autres ressources statiques : cache en priorité
  e.respondWith(
    caches.match(e.request).then(cached => cached || fetch(e.request))
  );
});
