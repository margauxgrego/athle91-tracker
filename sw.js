const CACHE = 'athle91-v65';
const ASSETS = [
  '/',
  '/index.html',
  '/icon-192.png',
  '/manifest.json',
  'https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2'
];

self.addEventListener('install', e => {
  e.waitUntil(caches.open(CACHE).then(c => c.addAll(ASSETS)));
  self.skipWaiting();
});

self.addEventListener('activate', e => {
  e.waitUntil((async () => {
    // 1. Supprimer les anciens caches
    const keys = await caches.keys();
    await Promise.all(keys.filter(k => k !== CACHE).map(k => caches.delete(k)));
    // 2. Prendre le contrôle de tous les clients AVANT d'envoyer le message
    await self.clients.claim();
    // 3. Notifier les onglets ouverts → rechargement
    const clients = await self.clients.matchAll({ includeUncontrolled: true, type: 'window' });
    clients.forEach(c => c.postMessage({ type: 'SW_UPDATED', version: CACHE }));
  })());
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
  // Autres ressources (dont CDN Supabase JS) : cache en priorité
  e.respondWith(
    caches.match(e.request).then(cached => cached || fetch(e.request).then(res => {
      if (res && res.status === 200) {
        caches.open(CACHE).then(c => c.put(e.request, res.clone()));
      }
      return res;
    }))
  );
});
