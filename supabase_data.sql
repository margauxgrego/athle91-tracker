-- Récupère les IDs des athlètes
DO $$
DECLARE
  margaux_id uuid;
  maria_id uuid;
BEGIN
  SELECT id INTO margaux_id FROM athletes WHERE prenom='Margaux' AND nom='GREGO';
  SELECT id INTO maria_id FROM athletes WHERE prenom='Maria' AND nom='KANTE';

  -- MARGAUX : Hauteur
  INSERT INTO performances (athlete_id, discipline, val, date, type, lieu, niveau) VALUES
    (margaux_id, 'Hauteur', 130, '2025-05-03', 'compet', 'Mantes La Jolie', 'D3'),
    (margaux_id, 'Hauteur', 140, '2025-05-17', 'compet', 'Savigny Sur Orge', 'R5'),
    (margaux_id, 'Hauteur', 140, '2025-05-24', 'compet', 'Montgeron', 'R5'),
    (margaux_id, 'Hauteur', 132, '2025-06-21', 'compet', 'Viry Chatillon', 'D2'),
    (margaux_id, 'Hauteur', 133, '2025-06-28', 'compet', 'Ivry Sur Seine', 'D2'),
    (margaux_id, 'Hauteur', 135, '2025-12-07', 'compet', 'Viry Chatillon', 'D1');

  -- MARGAUX : Haies franchies
  INSERT INTO haies_franchies (athlete_id, val, date, type, dist, note) VALUES
    (margaux_id, 1, '2025-05-22', 'entrainement', '100m', '1ère haie franchie');

  -- MARGAUX : Records
  INSERT INTO records (athlete_id, disc, perf, date, cat) VALUES
    (margaux_id, '50m', '7"99', '4 Juin 2017', 'MI'),
    (margaux_id, '100m', '14"30', '23 Juin 2022', 'ES'),
    (margaux_id, '200m', '29"36', '29 Juin 2023', 'ES'),
    (margaux_id, '400m', '69"01', '22 Juin 2023', 'ES'),
    (margaux_id, '80m Haies', '17"02', '1 Mai 2017', 'MI'),
    (margaux_id, 'Hauteur', '1m40', '17 Mai 2025', 'SE'),
    (margaux_id, 'Longueur', '4m60', '28 Mai 2023', 'ES'),
    (margaux_id, 'Triple saut', '9m29', '6 Juin 2024', 'ES'),
    (margaux_id, 'Poids 3kg', '7m32', '4 Juin 2017', 'MI'),
    (margaux_id, 'Disque 1kg', '25m79', '28 Mai 2023', 'ES');

  -- MARIA : Hauteur
  INSERT INTO performances (athlete_id, discipline, val, date, type, lieu, niveau) VALUES
    (maria_id, 'Hauteur', 140, '2026-01-14', 'compet', 'Paris', 'R5'),
    (maria_id, 'Hauteur', 143, '2026-02-04', 'compet', 'Paris', 'R4'),
    (maria_id, 'Hauteur', 149, '2026-02-06', 'compet', 'Eaubonne', ''),
    (maria_id, 'Hauteur', 146, '2026-04-25', 'compet', 'Villejuif', 'R3'),
    (maria_id, 'Hauteur', 145, '2026-05-02', 'compet', 'Noisy Le Grand', 'R3'),
    (maria_id, 'Hauteur', 150, '2026-05-17', 'compet', 'Caen', 'R1'),
    (maria_id, 'Hauteur', 110, '2025-06-19', 'compet', 'Viry Chatillon', 'D7'),
    (maria_id, 'Hauteur', 132, '2025-06-21', 'compet', 'Viry Chatillon', 'D2'),
    (maria_id, 'Hauteur', 133, '2025-07-12', 'compet', 'Ivry Sur Seine', 'D2'),
    (maria_id, 'Hauteur', 135, '2025-12-07', 'compet', 'Viry Chatillon', 'D1');

  -- MARIA : Longueur
  INSERT INTO performances (athlete_id, discipline, val, date, type, lieu, niveau) VALUES
    (maria_id, 'Longueur', 411, '2024-12-14', 'compet', 'Viry Chatillon', 'D3'),
    (maria_id, 'Longueur', 409, '2025-06-12', 'compet', 'Savigny Sur Orge', 'D3'),
    (maria_id, 'Longueur', 402, '2025-06-21', 'compet', 'Viry Chatillon', 'D3'),
    (maria_id, 'Longueur', 432, '2025-12-06', 'compet', 'Viry Chatillon', 'D1'),
    (maria_id, 'Longueur', 450, '2026-02-06', 'compet', 'Eaubonne', 'R6'),
    (maria_id, 'Longueur', 467, '2026-04-25', 'compet', 'Villejuif', 'R5');

  -- MARIA : Records
  INSERT INTO records (athlete_id, disc, perf, date, cat) VALUES
    (maria_id, '200m', '28"56', '25 Avr. 2026', 'ES'),
    (maria_id, 'Hauteur', '1m50', '17 Mai 2026', 'ES'),
    (maria_id, 'Longueur', '4m67', '25 Avr. 2026', 'ES');

END $$;
