--- Cascading delete to reset everything
drop table bookmarks_tags cascade;

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

-- Tags table
create or replace table tags (
    id uuid primary key,
    ctime timestamptz NOT NULL,
    mtime timestamptz NOT NULL,
    tag varchar,
);

--- Many-to-many join-table
create or replace table bookmarks_tags(
    id uuid primary key,
    bookmarks_id uuid NOT NULL,
    tags_id uuid NOT NULL,
    foreign key (bookmarks_id) references bookmarks (id),
    foreign key (tags_id) references tags (id),
);


---
--- Views
---


--- Master View
CREATE OR REPLACE VIEW main AS 
SELECT
    bookmarks.title,
    string_agg(tags.tag, ', ') as tag_list,
    bookmarks.ctime,
    bookmarks.url,
FROM bookmarks
LEFT JOIN bookmarks_tags ON bookmarks.id = bookmarks_tags.bookmarks_id
LEFT JOIN tags ON bookmarks_tags.tags_id = tags.id
GROUP BY url, title, bookmarks.ctime
ORDER BY url, title, bookmarks.ctime;

--- Tag Count View
CREATE OR REPLACE VIEW tag_count AS
SELECT
  tag,
  count(bookmarks_tags.bookmarks_id) AS count,
FROM
  tags
LEFT JOIN
  bookmarks_tags ON tags.id = bookmarks_tags.tags_id
GROUP BY
  tag
ORDER BY
  count DESC, tag;


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
 commit;
 
 ---
 --- Query the data
 ---
 
 --- Basic query
 SELECT * from bookmarks;
 SELECT * from tags;
 SELECT * from bookmarks_tags;
 select * from main;
