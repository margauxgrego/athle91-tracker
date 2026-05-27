-- ============================================================
-- MIGRATION : table coach_observations
-- Coller dans : Supabase → SQL Editor → New query → Run
-- ============================================================

CREATE TABLE IF NOT EXISTS coach_observations (
  id          uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  created_at  timestamptz DEFAULT now(),
  updated_at  timestamptz DEFAULT now(),
  athlete_id  uuid        NOT NULL REFERENCES athletes(id) ON DELETE CASCADE,
  coach_id    uuid        NOT NULL REFERENCES coaches(id)  ON DELETE CASCADE,
  date        date        NOT NULL,
  texte       text        NOT NULL DEFAULT '',
  UNIQUE(athlete_id, coach_id, date)
);

ALTER TABLE coach_observations ENABLE ROW LEVEL SECURITY;

CREATE POLICY "anon_coach_observations"
  ON coach_observations FOR ALL TO anon USING (true) WITH CHECK (true);

GRANT SELECT, INSERT, UPDATE, DELETE ON public.coach_observations TO anon;
