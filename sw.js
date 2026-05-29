const CACHE = 'athle91-v102';

const ALL_ASSETS = [
  '/',
  '/index.html',
  '/icon-192.png',
  '/icon-512.png',
  '/manifest.json',
  '/screenshot.png',
  'https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2',
  'https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.1/chart.umd.min.js'
];

self.addEventListener('install', e => {
  // Promise.allSettled : l'installation du SW réussit toujours,
  // même si certaines ressources (CDN) ne sont pas joignables.
  // Un SW qui échoue à s'installer empêche Chrome de générer un WebAPK.
  e.waitUntil(
    caches.open(CACHE).then(c =>
      Promise.allSettled(ALL_ASSETS.map(url => c.add(url)))
    )
  );
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
