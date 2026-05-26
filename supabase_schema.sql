-- ============================================================
-- ATHLÉ 91 — Schéma Supabase
-- Ordre d'exécution : ce fichier EN PREMIER, puis supabase_seed.sql
-- Coller dans : SQL Editor → New query → Run
-- ============================================================

-- Extension pour le hachage SHA-256 côté serveur (utilisée dans le seed)
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- ── Suppression des anciennes tables (ordre inverse des dépendances) ───────
DROP TABLE IF EXISTS athle91_app_state   CASCADE;
DROP TABLE IF EXISTS haies_franchies     CASCADE;
DROP TABLE IF EXISTS records             CASCADE;
DROP TABLE IF EXISTS performances        CASCADE;
DROP TABLE IF EXISTS athlete_disciplines CASCADE;
DROP TABLE IF EXISTS athletes            CASCADE;
DROP TABLE IF EXISTS coaches             CASCADE;

-- ── Table : coaches ────────────────────────────────────────────────────────
CREATE TABLE coaches (
  id            uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  created_at    timestamptz DEFAULT now(),
  prenom        text        NOT NULL,
  nom           text        NOT NULL,
  password_hash text        NOT NULL
);

-- ── Table : athletes ───────────────────────────────────────────────────────
CREATE TABLE athletes (
  id            uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  created_at    timestamptz DEFAULT now(),
  coach_id      uuid        REFERENCES coaches(id) ON DELETE CASCADE,
  prenom        text        NOT NULL,
  nom           text        NOT NULL,
  annee         integer,
  cat           text,
  password_hash text        NOT NULL
);

-- ── Table : athlete_disciplines ────────────────────────────────────────────
-- Disciplines actives d'un athlète (contrôle quels onglets apparaissent)
CREATE TABLE athlete_disciplines (
  id          uuid    PRIMARY KEY DEFAULT gen_random_uuid(),
  athlete_id  uuid    NOT NULL REFERENCES athletes(id)  ON DELETE CASCADE,
  discipline  text    NOT NULL,
  sort_order  integer DEFAULT 0,
  UNIQUE(athlete_id, discipline)
);

-- ── Table : performances ───────────────────────────────────────────────────
-- Toutes disciplines confondues, y compris les disciplines historiques
-- non actives (ex : 100m pour Margaux → apparaît dans Records uniquement)
CREATE TABLE performances (
  id          uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  created_at  timestamptz DEFAULT now(),
  athlete_id  uuid        NOT NULL REFERENCES athletes(id) ON DELETE CASCADE,
  discipline  text        NOT NULL,
  val         numeric     NOT NULL,
  date        date        NOT NULL,
  type        text        NOT NULL DEFAULT 'compet',
  lieu        text        DEFAULT '',
  niveau      text        DEFAULT ''
);

-- ── Table : haies_franchies ────────────────────────────────────────────────
CREATE TABLE haies_franchies (
  id          uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  created_at  timestamptz DEFAULT now(),
  athlete_id  uuid        NOT NULL REFERENCES athletes(id) ON DELETE CASCADE,
  val         integer     NOT NULL DEFAULT 1,
  date        date        NOT NULL,
  type        text        DEFAULT 'entrainement',
  dist        text        DEFAULT '',
  note        text        DEFAULT ''
);

-- ── Table : records ────────────────────────────────────────────────────────
-- Records personnels (affichage curé manuellement via le seed)
CREATE TABLE records (
  id          uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  created_at  timestamptz DEFAULT now(),
  athlete_id  uuid        NOT NULL REFERENCES athletes(id) ON DELETE CASCADE,
  disc        text        NOT NULL,
  perf        text        NOT NULL,
  date        text,
  cat         text
);

-- ── Activation du RLS sur toutes les tables ────────────────────────────────
ALTER TABLE coaches             ENABLE ROW LEVEL SECURITY;
ALTER TABLE athletes            ENABLE ROW LEVEL SECURITY;
ALTER TABLE athlete_disciplines ENABLE ROW LEVEL SECURITY;
ALTER TABLE performances        ENABLE ROW LEVEL SECURITY;
ALTER TABLE haies_franchies     ENABLE ROW LEVEL SECURITY;
ALTER TABLE records             ENABLE ROW LEVEL SECURITY;

-- ── Policies (accès anon complet) ──────────────────────────────────────────
-- L'appli gère l'authentification en comparant le password_hash côté client.
-- Ces policies permettent le fonctionnement avec la clé publique (anon).
-- Pour une sécurité renforcée, migrer vers Supabase Auth (voir guide).

CREATE POLICY "anon_coaches"
  ON coaches FOR ALL TO anon USING (true) WITH CHECK (true);

CREATE POLICY "anon_athletes"
  ON athletes FOR ALL TO anon USING (true) WITH CHECK (true);

CREATE POLICY "anon_athlete_disciplines"
  ON athlete_disciplines FOR ALL TO anon USING (true) WITH CHECK (true);

CREATE POLICY "anon_performances"
  ON performances FOR ALL TO anon USING (true) WITH CHECK (true);

CREATE POLICY "anon_haies_franchies"
  ON haies_franchies FOR ALL TO anon USING (true) WITH CHECK (true);

CREATE POLICY "anon_records"
  ON records FOR ALL TO anon USING (true) WITH CHECK (true);

-- ── Grants (nécessaires quand les tables sont créées via SQL direct) ───────
GRANT SELECT, INSERT, UPDATE, DELETE ON public.coaches             TO anon;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.athletes            TO anon;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.athlete_disciplines TO anon;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.performances        TO anon;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.haies_franchies     TO anon;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.records             TO anon;
