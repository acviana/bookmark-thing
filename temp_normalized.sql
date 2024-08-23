---
--- Create tables
---

--- Bookmarks table
create or replace table bookmarks (
    id uuid primary key,
    ctime timestamptz NOT NULL,
    mtime timestamptz NOT NULL,
    url varchar UNIQUE NOT NULL,
    title varchar NOT NULL,
    author varchar,
    is_read boolean NOT NULL,
    notes varchar,
);

--- many-to-many join-table
create or replace table tags (
    id uuid primary key,
    ctime timestamptz NOT NULL,
    mtime timestamptz NOT NULL,
    tag varchar,
);

-- Tags table
create or replace table bookmarks_tags(
    id uuid primary key,
    bookmarks_id uuid NOT NULL,
    tags_id uuid NOT NULL,
    foreign key (bookmarks_id) references bookmarks (id),
    foreign key (tags_id) references tags (id),
);

---
--- Insert Data
---

insert into bookmarks (id, ctime, mtime, url, title, is_read)
values (
    uuid(),
    get_current_timestamp(), 
    get_current_timestamp(),
    'https://www.wired.com/story/how-30-lines-of-code-blew-up-27-ton-generator/',
    'How 30 Lines of Code Blew Up a 27-Ton Generator', 
    false,
--    ['physical-infrastructure', 'hacking'], 
 ),
 (
    uuid(),
    get_current_timestamp(),
    get_current_timestamp(),
    'https://open.spotify.com/episode/2EGyoSBSsuEnah0CYFTQiF?si=e7ca90633b0e49ad',
    'My Climate Journey: Advancing Nuclear Innovation with INL''s Dr. John Wagner',
    true,
--    ['physical-infrastructure', 'nuclear-energy']
 )
 ;
 
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
 
 ---
 --- Query the data
 ---
 
 --- Basic query
 SELECT * from bookmarks;
 SELECT * from tags;
 SELECT * from bookmarks_tags;
 
 --- Master View
 CREATE OR REPLACE VIEW main AS 
 SELECT
    bookmarks.title,
    string_agg(tags.tag, ', ') as tag_list,
    bookmarks.ctime,
    bookmarks.url,
 from bookmarks_tags
 join bookmarks on bookmarks_tags.bookmarks_id = bookmarks.id 
 join tags on bookmarks_tags.tags_id = tags.id
 GROUP BY url, title, bookmarks.ctime
 ORDER BY url, title, bookmarks.ctime;
 
 select * from main;