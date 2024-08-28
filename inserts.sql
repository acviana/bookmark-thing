---
--- Insert Data
---


-- Sample Data Insert
begin transaction;
insert into bookmarks (id, ctime, mtime, url, title, is_read)
values (
    uuid(),
    get_current_timestamp(), 
    get_current_timestamp(),
    'https://www.wired.com/story/how-30-lines-of-code-blew-up-27-ton-generator/',
    'How 30 Lines of Code Blew Up a 27-Ton Generator', 
    false,
),
(
    uuid(),
    get_current_timestamp(),
    get_current_timestamp(),
    'https://open.spotify.com/episode/2EGyoSBSsuEnah0CYFTQiF?si=e7ca90633b0e49ad',
    'My Climate Journey: Advancing Nuclear Innovation with INL''s Dr. John Wagner',
    true,
);
 
insert into tags (id, ctime, mtime, tag)
values(
    uuid(),
    get_current_timestamp(),
    get_current_timestamp(),
    'physical-infrastructure'
),
(
    uuid(),
    get_current_timestamp(),
    get_current_timestamp(),
    'hacking'
),
(
    uuid(),
    get_current_timestamp(),
    get_current_timestamp(),
    'nuclear-energy'
);
 
insert into bookmarks_tags (id, bookmarks_id, tags_id)
values (
    uuid(),
    (select id from bookmarks where url = 'https://www.wired.com/story/how-30-lines-of-code-blew-up-27-ton-generator/'),
    (select id from tags where tag = 'physical-infrastructure')
),
(
    uuid(),
    (select id from bookmarks where url = 'https://www.wired.com/story/how-30-lines-of-code-blew-up-27-ton-generator/'),
    (select id from tags where tag = 'hacking')    
),
(
    uuid(),
    (select id from bookmarks where url = 'https://open.spotify.com/episode/2EGyoSBSsuEnah0CYFTQiF?si=e7ca90633b0e49ad'),
    (select id from tags where tag = 'physical-infrastructure')    
),
(
    uuid(),
    (select id from bookmarks where url = 'https://open.spotify.com/episode/2EGyoSBSsuEnah0CYFTQiF?si=e7ca90633b0e49ad'),
    (select id from tags where tag = 'nuclear-energy')    
);
commit;
 
---
--- Query the data
---
 
--- Basic query
SELECT * from bookmarks;
SELECT * from tags;
SELECT * from bookmarks_tags;
SELECT * from main;
