
-- ==========================================
-- PHASE 2: LOAD YOUTUBE SEED DATA
-- File: sql/02_load_data.sql
-- ==========================================

\set ON_ERROR_STOP on

SET search_path TO youtube;

BEGIN;

-- 1. Parent table
\copy users FROM 'seed_data/users.csv' WITH (FORMAT csv, HEADER true);

-- 2. Channels depend on users
\copy channels FROM 'seed_data/channels.csv' WITH (FORMAT csv, HEADER true);

-- 3. Videos depend on channels
\copy videos FROM 'seed_data/videos.csv' WITH (FORMAT csv, HEADER true);

-- 4. Subscriptions depend on users and channels
\copy subscriptions FROM 'seed_data/subscriptions.csv' WITH (FORMAT csv, HEADER true);

-- 5. Watch events depend on users and videos
\copy watch_events FROM 'seed_data/watch_events.csv' WITH (FORMAT csv, HEADER true);

-- 6. Reactions depend on users and videos
\copy video_reactions FROM 'seed_data/video_reactions.csv' WITH (FORMAT csv, HEADER true);

-- 7. Comments depend on users, videos and parent comments
-- Parent-comment FK should be DEFERRABLE INITIALLY DEFERRED
-- if the CSV does not guarantee parent-before-child ordering.
\copy comments FROM 'seed_data/comments.csv' WITH (FORMAT csv, HEADER true);

-- 8. Playlists depend on users
\copy playlists FROM 'seed_data/playlists.csv' WITH (FORMAT csv, HEADER true);

-- 9. Playlist items depend on playlists and videos
\copy playlist_items FROM 'seed_data/playlist_items.csv' WITH (FORMAT csv, HEADER true);

-- 10. Ad impressions depend on watch events
\copy ad_impressions FROM 'seed_data/ad_impressions.csv' WITH (FORMAT csv, HEADER true);

COMMIT;

-- Update query planner statistics
ANALYZE;
