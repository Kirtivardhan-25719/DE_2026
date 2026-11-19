# Phase 1: Problem Understanding

## 1. Understanding the Business Problems

The current YouTube database has performance and reporting issues because its schema and data organization are not properly designed. The goal is to build a well-structured database that supports fast user operations, accurate analytics, and future growth.

| Problem | Business Need | Affected Stakeholders | Classification |
|---|---|---|---|
| **P1** | Channel pages, video watch pages, and playlists should load quickly so viewers can access content without delays. | Viewers, Creators | Customer-facing / Real-time |
| **P2** | Subscription feeds and watch history should load quickly, even for users with large amounts of activity. | Viewers, Signed-in Users | Customer-facing / Real-time |
| **P3** | Searching videos by title should return relevant results quickly. | Viewers, Search Team | Customer-facing / Real-time |
| **P4** | YouTube Studio should provide accurate and timely charts for views, traffic sources, audience retention, likes, and subscriber growth. | Creators, YouTube Studio Team | Reporting / Analytics |
| **P5** | Creators should be able to identify subscribers who have never watched their channel. | Creators, YouTube Studio Team | Reporting / Analytics |
| **P6** | Shorts recommendations and Trending lists should be updated efficiently to show relevant and popular content. | Viewers, Trending / Recommendations Team | Customer-facing / Real-time |
| **P7** | Scheduled videos must be published at the correct time. Uploads and view counters must also work efficiently under heavy traffic. | Creators, Viewers, Publishing Team | Customer-facing / Real-time |
| **P8** | Financial reports should calculate ad revenue, partner-program eligibility, and Premium ad compliance accurately without timeouts. | Finance Team, Partner Program, Premium Subscribers | Reporting / Analytics |
| **P9** | The database should support child-safety, copyright, moderation, logged-out viewer, and watch-time reports while handling significant traffic growth. | Child Safety, Copyright, Moderation, Growth Team | Reporting / Analytics |

## 2. Assumptions

1. Every channel has a unique channel ID and can upload multiple videos.
2. Every video has a unique 11-character video ID, a category, and a visibility status.
3. Videos can be public, unlisted, private, or scheduled for future publishing.
4. Both signed-in and logged-out viewers can generate watch events.
5. Only signed-in users can subscribe, like, dislike, comment, and create playlists.
6. YouTube Premium subscribers should not receive advertisements during video playback.
7. Only eligible and monetized channels can earn advertising revenue.
8. Watch events should store enough information to calculate views, watch time, and audience retention.
9. Scheduled videos should automatically become public when their scheduled publishing time arrives.
10. The database should support future traffic growth of up to 20 times the current volume without affecting data accuracy.

## 3. Overall Objective

The main objective is to redesign the existing YouTube database into a properly structured, reliable, and scalable system. It should support fast customer-facing operations, accurate analytical reporting, correct business rules, and future traffic growth without changing the results of existing queries.
