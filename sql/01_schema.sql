
-- ==========================================
-- PHASE 2: YOUTUBE DATABASE SCHEMA
-- ==========================================

CREATE SCHEMA IF NOT EXISTS youtube;
SET search_path TO youtube;

-- 1. USERS
CREATE TABLE users (
    user_id BIGINT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    display_name VARCHAR(255) NOT NULL,
    country_code CHAR(2),
    birth_year INTEGER,
    premium_until TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL
);

-- 2. CHANNELS
CREATE TABLE channels (
    channel_id BIGINT PRIMARY KEY,
    owner_user_id BIGINT NOT NULL REFERENCES users(user_id),
    handle VARCHAR(100) NOT NULL UNIQUE,
    channel_name VARCHAR(255) NOT NULL,
    country_code CHAR(2),
    is_verified BOOLEAN NOT NULL,
    monetization_status VARCHAR(30) NOT NULL,
    subscriber_count BIGINT NOT NULL CHECK (subscriber_count >= 0),
    created_at TIMESTAMPTZ NOT NULL
);

-- 3. VIDEOS
CREATE TABLE videos (
    video_id VARCHAR(11) PRIMARY KEY
        CHECK (LENGTH(video_id) = 11),
    channel_id BIGINT NOT NULL REFERENCES channels(channel_id),
    title VARCHAR(500) NOT NULL,
    description TEXT,
    category VARCHAR(100) NOT NULL,
    duration_sec INTEGER NOT NULL CHECK (duration_sec > 0),
    is_short BOOLEAN NOT NULL,
    is_made_for_kids BOOLEAN NOT NULL,
    visibility VARCHAR(20) NOT NULL
        CHECK (visibility IN ('PUBLIC', 'UNLISTED', 'PRIVATE', 'SCHEDULED')),
    uploaded_at TIMESTAMPTZ NOT NULL,
    published_at TIMESTAMPTZ,
    view_count BIGINT NOT NULL CHECK (view_count >= 0)
);

-- 4. SUBSCRIPTIONS
CREATE TABLE subscriptions (
    user_id BIGINT NOT NULL REFERENCES users(user_id),
    channel_id BIGINT NOT NULL REFERENCES channels(channel_id),
    notifications VARCHAR(20) NOT NULL,
    subscribed_at TIMESTAMPTZ NOT NULL,
    PRIMARY KEY (user_id, channel_id)
);

-- 5. WATCH EVENTS
CREATE TABLE watch_events (
    watch_id BIGINT PRIMARY KEY,
    user_id BIGINT REFERENCES users(user_id),
    video_id VARCHAR(11) NOT NULL REFERENCES videos(video_id),
    started_at TIMESTAMPTZ NOT NULL,
    watch_seconds INTEGER NOT NULL CHECK (watch_seconds >= 0),
    device VARCHAR(30) NOT NULL,
    traffic_source VARCHAR(50) NOT NULL
);

-- 6. VIDEO REACTIONS
CREATE TABLE video_reactions (
    user_id BIGINT NOT NULL REFERENCES users(user_id),
    video_id VARCHAR(11) NOT NULL REFERENCES videos(video_id),
    reaction VARCHAR(10) NOT NULL
        CHECK (reaction IN ('LIKE', 'DISLIKE')),
    reacted_at TIMESTAMPTZ NOT NULL,
    PRIMARY KEY (user_id, video_id)
);

-- 7. COMMENTS
CREATE TABLE comments (
    comment_id BIGINT PRIMARY KEY,
    video_id VARCHAR(11) NOT NULL REFERENCES videos(video_id),
    user_id BIGINT NOT NULL REFERENCES users(user_id),
    parent_comment_id BIGINT REFERENCES comments(comment_id),
    body TEXT NOT NULL,
    like_count BIGINT NOT NULL CHECK (like_count >= 0),
    is_pinned BOOLEAN NOT NULL,
    created_at TIMESTAMPTZ NOT NULL
);

-- 8. PLAYLISTS
CREATE TABLE playlists (
    playlist_id BIGINT PRIMARY KEY,
    owner_user_id BIGINT NOT NULL REFERENCES users(user_id),
    title VARCHAR(255) NOT NULL,
    visibility VARCHAR(20) NOT NULL
        CHECK (visibility IN ('PUBLIC', 'UNLISTED', 'PRIVATE')),
    created_at TIMESTAMPTZ NOT NULL
);

-- 9. PLAYLIST ITEMS
CREATE TABLE playlist_items (
    playlist_id BIGINT NOT NULL REFERENCES playlists(playlist_id),
    position INTEGER NOT NULL CHECK (position > 0),
    video_id VARCHAR(11) NOT NULL REFERENCES videos(video_id),
    added_at TIMESTAMPTZ NOT NULL,
    PRIMARY KEY (playlist_id, position)
);

-- 10. AD IMPRESSIONS
CREATE TABLE ad_impressions (
    impression_id BIGINT PRIMARY KEY,
    watch_id BIGINT NOT NULL REFERENCES watch_events(watch_id),
    ad_format VARCHAR(30) NOT NULL,
    revenue_inr NUMERIC(12,4) NOT NULL CHECK (revenue_inr >= 0),
    shown_at TIMESTAMPTZ NOT NULL
);
