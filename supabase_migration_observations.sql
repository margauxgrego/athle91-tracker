-- ============================================================
-- MIGRATION : table coach_observations (v2 — avec colonne discipline)
-- Coller dans : Supabase → SQL Editor → New query → Run
-- ============================================================

-- ── Si la table n'existe PAS encore : création complète ───────────────────
CREATE TABLE IF NOT EXISTS coach_observations (
  id          uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  created_at  timestamptz DEFAULT now(),
  updated_at  timestamptz DEFAULT now(),
  athlete_id  uuid        NOT NULL REFERENCES athletes(id) ON DELETE CASCADE,
  coach_id    uuid        NOT NULL REFERENCES coaches(id)  ON DELETE CASCADE,
  date        date        NOT NULL,
  discipline  text        NOT NULL DEFAULT '',
  texte       text        NOT NULL DEFAULT '',
  UNIQUE(athlete_id, coach_id, date, discipline)
);

-- ── Si la table EXISTE déjà (migration v1 → v2) : ajout de la colonne ─────
ALTER TABLE coach_observations ADD COLUMN IF NOT EXISTS discipline text NOT NULL DEFAULT '';

-- Supprimer l'ancienne contrainte unique (sans discipline) si elle existe
ALTER TABLE coach_observations DROP CONSTRAINT IF EXISTS coach_observations_athlete_id_coach_id_date_key;

-- Ajouter la nouvelle contrainte incluant discipline
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint WHERE conname = 'coach_observations_unique'
  ) THEN
    ALTER TABLE coach_observations
      ADD CONSTRAINT coach_observations_unique
      UNIQUE(athlete_id, coach_id, date, discipline);
  END IF;
END $$;

-- ── Sécurité ──────────────────────────────────────────────────────────────
ALTER TABLE coach_observations ENABLE ROW LEVEL SECURITY;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_policies WHERE tablename = 'coach_observations' AND policyname = 'anon_coach_observations'
  ) THEN
    CREATE POLICY "anon_coach_observations"
      ON coach_observations FOR ALL TO anon USING (true) WITH CHECK (true);
  END IF;
END $$;

GRANT SELECT, INSERT, UPDATE, DELETE ON public.coach_observations TO anon;
