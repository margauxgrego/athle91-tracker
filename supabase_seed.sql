-- ============================================================
-- ATHLÉ 91 — Données initiales (seed)
-- Ordre d'exécution : supabase_schema.sql EN PREMIER, puis ce fichier
-- Coller dans : SQL Editor → New query → Run
-- ============================================================
-- Les mots de passe sont hachés en SHA-256 via pgcrypto.
-- Mots de passe initiaux : coach91 / margaux91 / maria91
-- ============================================================

-- UUIDs fixes pour faciliter les références croisées
-- Coach  : c0000000-0000-0000-0000-000000000001
-- Margaux: a0000000-0000-0000-0000-000000000001
-- Maria  : a0000000-0000-0000-0000-000000000002

-- ── Coach ──────────────────────────────────────────────────────────────────
INSERT INTO coaches (id, prenom, nom, password_hash) VALUES
  ('c0000000-0000-0000-0000-000000000001',
   'Kevin', 'DEI',
   encode(digest('coach91', 'sha256'), 'hex'));

-- ── Athlètes ───────────────────────────────────────────────────────────────
INSERT INTO athletes (id, coach_id, prenom, nom, annee, cat, password_hash) VALUES
  ('a0000000-0000-0000-0000-000000000001',
   'c0000000-0000-0000-0000-000000000001',
   'Margaux', 'GREGO', 2002, 'SE',
   encode(digest('margaux91', 'sha256'), 'hex')),

  ('a0000000-0000-0000-0000-000000000002',
   'c0000000-0000-0000-0000-000000000001',
   'Maria', 'KANTE', 2006, 'ES',
   encode(digest('maria91', 'sha256'), 'hex'));

-- ── Disciplines actives ────────────────────────────────────────────────────
-- (contrôlent quels onglets apparaissent dans l'appli)
INSERT INTO athlete_disciplines (athlete_id, discipline, sort_order) VALUES
  -- Margaux : Hauteur + 400m Haies
  ('a0000000-0000-0000-0000-000000000001', 'Hauteur',    0),
  ('a0000000-0000-0000-0000-000000000001', '400m Haies', 1),
  -- Maria : Hauteur + Longueur
  ('a0000000-0000-0000-0000-000000000002', 'Hauteur',  0),
  ('a0000000-0000-0000-0000-000000000002', 'Longueur', 1);

-- ── Performances — Margaux ─────────────────────────────────────────────────

-- Hauteur
INSERT INTO performances (athlete_id, discipline, val, date, type, lieu, niveau) VALUES
  ('a0000000-0000-0000-0000-000000000001','Hauteur',130,'2024-04-27','compet','Noisy Le Grand','D3'),
  ('a0000000-0000-0000-0000-000000000001','Hauteur',130,'2024-05-11','compet','Savigny Sur Orge','D3'),
  ('a0000000-0000-0000-0000-000000000001','Hauteur',135,'2024-06-27','compet','Viry Chatillon','D1'),
  ('a0000000-0000-0000-0000-000000000001','Hauteur',130,'2025-05-03','compet','Mantes La Jolie','D3'),
  ('a0000000-0000-0000-0000-000000000001','Hauteur',140,'2025-05-17','compet','Savigny Sur Orge','R5'),
  ('a0000000-0000-0000-0000-000000000001','Hauteur',140,'2025-05-24','compet','Montgeron','R5'),
  ('a0000000-0000-0000-0000-000000000001','Hauteur',132,'2025-06-21','compet','Viry Chatillon','D2'),
  ('a0000000-0000-0000-0000-000000000001','Hauteur',133,'2025-06-28','compet','Ivry Sur Seine','D2'),
  ('a0000000-0000-0000-0000-000000000001','Hauteur',135,'2025-12-07','compet','Viry Chatillon','D1');

-- Longueur (historique — discipline non active, visible dans Records)
INSERT INTO performances (athlete_id, discipline, val, date, type, lieu, niveau) VALUES
  ('a0000000-0000-0000-0000-000000000001','Longueur',359,'2017-05-01','compet','Le Plessis Robinson','MI'),
  ('a0000000-0000-0000-0000-000000000001','Longueur',348,'2017-06-04','compet','Vanves','MI'),
  ('a0000000-0000-0000-0000-000000000001','Longueur',379,'2017-06-25','compet','Le Plessis Robinson','MI'),
  ('a0000000-0000-0000-0000-000000000001','Longueur',400,'2022-05-14','compet','Savigny Sur Orge','D5'),
  ('a0000000-0000-0000-0000-000000000001','Longueur',400,'2022-05-21','compet','Savigny Sur Orge','D4'),
  ('a0000000-0000-0000-0000-000000000001','Longueur',400,'2022-05-29','compet','Lisses','D1'),
  ('a0000000-0000-0000-0000-000000000001','Longueur',460,'2023-05-08','compet','Savigny Sur Orge','R5'),
  ('a0000000-0000-0000-0000-000000000001','Longueur',460,'2023-05-13','compet','Savigny Sur Orge','R5'),
  ('a0000000-0000-0000-0000-000000000001','Longueur',460,'2023-05-28','compet','Lisses','R5'),
  ('a0000000-0000-0000-0000-000000000001','Longueur',447,'2023-06-08','compet','Savigny Sur Orge','R6'),
  ('a0000000-0000-0000-0000-000000000001','Longueur',469,'2023-06-28','compet','Lisses','R5'),
  ('a0000000-0000-0000-0000-000000000001','Longueur',457,'2024-05-26','compet','Lisses','R6'),
  ('a0000000-0000-0000-0000-000000000001','Longueur',446,'2024-05-30','compet','Bondoufle','R6'),
  ('a0000000-0000-0000-0000-000000000001','Longueur',448,'2024-06-06','compet','Saint Michel Sur Orge','R6'),
  ('a0000000-0000-0000-0000-000000000001','Longueur',448,'2024-07-06','compet','Saint Michel Sur Orge','R6');

-- Triple Saut
INSERT INTO performances (athlete_id, discipline, val, date, type, lieu, niveau) VALUES
  ('a0000000-0000-0000-0000-000000000001','Triple Saut',929,'2024-06-06','compet','Savigny sur Orge','D1'),
  ('a0000000-0000-0000-0000-000000000001','Triple Saut',865,'2024-06-13','compet','Bretigny Sur Orge','D3');

-- 50m
INSERT INTO performances (athlete_id, discipline, val, date, type, lieu, niveau) VALUES
  ('a0000000-0000-0000-0000-000000000001','50m',7.99,'2017-06-04','compet','Vanves','MI'),
  ('a0000000-0000-0000-0000-000000000001','50m',8.17,'2017-06-25','compet','Le Plessis Robinson','MI');

-- 100m
INSERT INTO performances (athlete_id, discipline, val, date, type, lieu, niveau) VALUES
  ('a0000000-0000-0000-0000-000000000001','100m',15.64,'2017-06-25','compet','Le Plessis Robinson','MI'),
  ('a0000000-0000-0000-0000-000000000001','100m',14.44,'2022-05-14','compet','Lisses','D1'),
  ('a0000000-0000-0000-0000-000000000001','100m',14.44,'2022-05-28','compet','Lisses','D1'),
  ('a0000000-0000-0000-0000-000000000001','100m',14.30,'2022-06-23','compet','Bretigny sur Orge','D1');

-- 200m
INSERT INTO performances (athlete_id, discipline, val, date, type, lieu, niveau) VALUES
  ('a0000000-0000-0000-0000-000000000001','200m',29.76,'2022-05-16','compet','Lisses','R6'),
  ('a0000000-0000-0000-0000-000000000001','200m',30.56,'2022-06-30','compet','Longjumeau','D1'),
  ('a0000000-0000-0000-0000-000000000001','200m',30.27,'2023-05-08','compet','Savigny Sur Orge','R6'),
  ('a0000000-0000-0000-0000-000000000001','200m',29.47,'2023-05-13','compet','Savigny Sur Orge','R5'),
  ('a0000000-0000-0000-0000-000000000001','200m',29.81,'2023-05-28','compet','Lisses','R6'),
  ('a0000000-0000-0000-0000-000000000001','200m',30.57,'2023-05-28','compet','Lisses','D1'),
  ('a0000000-0000-0000-0000-000000000001','200m',29.47,'2023-06-08','compet','Savigny Sur Orge','R5'),
  ('a0000000-0000-0000-0000-000000000001','200m',29.36,'2023-06-29','compet','Longjumeau','R5');

-- 400m
INSERT INTO performances (athlete_id, discipline, val, date, type, lieu, niveau) VALUES
  ('a0000000-0000-0000-0000-000000000001','400m',69.44,'2023-06-15','compet','Lisses','R6'),
  ('a0000000-0000-0000-0000-000000000001','400m',69.01,'2023-06-22','compet','Savigny sur Orge','R5');

-- 80m Haies
INSERT INTO performances (athlete_id, discipline, val, date, type, lieu, niveau) VALUES
  ('a0000000-0000-0000-0000-000000000001','80m Haies',17.02,'2017-05-01','compet','Le Plessis Robinson','MI');

-- Poids
INSERT INTO performances (athlete_id, discipline, val, date, type, lieu, niveau) VALUES
  ('a0000000-0000-0000-0000-000000000001','Poids',729,'2017-05-01','compet','Le Plessis Robinson','MI'),
  ('a0000000-0000-0000-0000-000000000001','Poids',732,'2017-06-04','compet','Vanves','MI');

-- Disque
INSERT INTO performances (athlete_id, discipline, val, date, type, lieu, niveau) VALUES
  ('a0000000-0000-0000-0000-000000000001','Disque',1857,'2022-04-14','compet','Savigny Sur Orge','D5'),
  ('a0000000-0000-0000-0000-000000000001','Disque',1900,'2022-05-14','compet','Savigny Sur Orge','D4'),
  ('a0000000-0000-0000-0000-000000000001','Disque',1900,'2022-05-21','compet','Savigny Sur Orge','D4'),
  ('a0000000-0000-0000-0000-000000000001','Disque',2317,'2022-05-29','compet','Lisses','D2'),
  ('a0000000-0000-0000-0000-000000000001','Disque',2011,'2022-06-05','compet','Antony','D4'),
  ('a0000000-0000-0000-0000-000000000001','Disque',1971,'2023-01-08','compet','Montgeron','D4'),
  ('a0000000-0000-0000-0000-000000000001','Disque',1314,'2023-05-06','compet','Noisy Le Grand','D7'),
  ('a0000000-0000-0000-0000-000000000001','Disque',2195,'2023-05-13','compet','Savigny Sur Orge','D3'),
  ('a0000000-0000-0000-0000-000000000001','Disque',2231,'2023-05-15','compet','Lisses','D3'),
  ('a0000000-0000-0000-0000-000000000001','Disque',2579,'2023-05-28','compet','Lisses','D1'),
  ('a0000000-0000-0000-0000-000000000001','Disque',2244,'2023-06-08','compet','Savigny Sur Orge','D3'),
  ('a0000000-0000-0000-0000-000000000001','Disque',2231,'2023-06-15','compet','Lisses','D3'),
  ('a0000000-0000-0000-0000-000000000001','Disque',2244,'2023-06-17','compet','Pontoise','D3'),
  ('a0000000-0000-0000-0000-000000000001','Disque',1951,'2024-04-27','compet','Noisy Le Grand','D4'),
  ('a0000000-0000-0000-0000-000000000001','Disque',2441,'2024-05-11','compet','Savigny Sur Orge','D2'),
  ('a0000000-0000-0000-0000-000000000001','Disque',2348,'2025-05-17','compet','Savigny Sur Orge','D2');

-- ── Performances — Maria ───────────────────────────────────────────────────

-- Hauteur
INSERT INTO performances (athlete_id, discipline, val, date, type, lieu, niveau) VALUES
  ('a0000000-0000-0000-0000-000000000002','Hauteur',110,'2025-06-12','compet','Viry Chatillon','D7'),
  ('a0000000-0000-0000-0000-000000000002','Hauteur',110,'2025-06-19','compet','Viry Chatillon','D7'),
  ('a0000000-0000-0000-0000-000000000002','Hauteur',132,'2025-06-21','compet','Viry Chatillon','D2'),
  ('a0000000-0000-0000-0000-000000000002','Hauteur',133,'2025-07-12','compet','Ivry Sur Seine','D2'),
  ('a0000000-0000-0000-0000-000000000002','Hauteur',135,'2025-12-07','compet','Viry Chatillon','D1'),
  ('a0000000-0000-0000-0000-000000000002','Hauteur',140,'2026-01-14','compet','Paris','R5'),
  ('a0000000-0000-0000-0000-000000000002','Hauteur',143,'2026-02-04','compet','Paris','R4'),
  ('a0000000-0000-0000-0000-000000000002','Hauteur',149,'2026-02-06','compet','Eaubonne',''),
  ('a0000000-0000-0000-0000-000000000002','Hauteur',146,'2026-04-25','compet','Villejuif','R3'),
  ('a0000000-0000-0000-0000-000000000002','Hauteur',145,'2026-05-02','compet','Noisy Le Grand','R3'),
  ('a0000000-0000-0000-0000-000000000002','Hauteur',150,'2026-05-17','compet','Caen','R1');

-- Longueur
INSERT INTO performances (athlete_id, discipline, val, date, type, lieu, niveau) VALUES
  ('a0000000-0000-0000-0000-000000000002','Longueur',411,'2024-12-14','compet','Viry Chatillon','D3'),
  ('a0000000-0000-0000-0000-000000000002','Longueur',409,'2025-06-12','compet','Savigny Sur Orge','D3'),
  ('a0000000-0000-0000-0000-000000000002','Longueur',402,'2025-06-21','compet','Viry Chatillon','D3'),
  ('a0000000-0000-0000-0000-000000000002','Longueur',432,'2025-12-06','compet','Viry Chatillon','D1'),
  ('a0000000-0000-0000-0000-000000000002','Longueur',450,'2026-02-06','compet','Eaubonne','R6'),
  ('a0000000-0000-0000-0000-000000000002','Longueur',467,'2026-04-25','compet','Villejuif','R5'),
  ('a0000000-0000-0000-0000-000000000002','Longueur',445,'2026-05-02','compet','Noisy Le Grand','R3');

-- 200m (historique — discipline non active, visible dans Records)
INSERT INTO performances (athlete_id, discipline, val, date, type, lieu, niveau) VALUES
  ('a0000000-0000-0000-0000-000000000002','200m',28.56,'2026-04-25','compet','Villejuif','R3');

-- ── Haies franchies — Margaux ──────────────────────────────────────────────
INSERT INTO haies_franchies (athlete_id, val, date, type, dist, note) VALUES
  ('a0000000-0000-0000-0000-000000000001', 1, '2025-05-22', 'entrainement', '100m', '1ère haie franchie');

-- ── Records personnels — Margaux ───────────────────────────────────────────
INSERT INTO records (athlete_id, disc, perf, date, cat) VALUES
  ('a0000000-0000-0000-0000-000000000001','50m',      '7"99',  '4 Juin 2017',   'MI'),
  ('a0000000-0000-0000-0000-000000000001','100m',     '14"30', '23 Juin 2022',  'ES'),
  ('a0000000-0000-0000-0000-000000000001','200m',     '29"36', '29 Juin 2023',  'ES'),
  ('a0000000-0000-0000-0000-000000000001','400m',     '69"01', '22 Juin 2023',  'ES'),
  ('a0000000-0000-0000-0000-000000000001','80m Haies','17"02', '1 Mai 2017',    'MI'),
  ('a0000000-0000-0000-0000-000000000001','Hauteur',  '1m40',  '17 Mai 2025',   'SE'),
  ('a0000000-0000-0000-0000-000000000001','Longueur', '4m69',  '28 Juin 2023',  'ES'),
  ('a0000000-0000-0000-0000-000000000001','Triple Saut','9m29','6 Juin 2024',   'ES'),
  ('a0000000-0000-0000-0000-000000000001','Poids',    '7m32',  '4 Juin 2017',   'MI'),
  ('a0000000-0000-0000-0000-000000000001','Disque',   '25m79', '28 Mai 2023',   'ES');

-- ── Records personnels — Maria ─────────────────────────────────────────────
INSERT INTO records (athlete_id, disc, perf, date, cat) VALUES
  ('a0000000-0000-0000-0000-000000000002','200m',    '28"56', '25 Avr. 2026', 'ES'),
  ('a0000000-0000-0000-0000-000000000002','Hauteur', '1m50',  '17 Mai 2026',  'ES'),
  ('a0000000-0000-0000-0000-000000000002','Longueur','4m67',  '25 Avr. 2026', 'ES');
