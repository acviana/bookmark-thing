--- Cascading delete to reset everything
drop table bookmarks_tags cascade;

---
--- Create tables
---

--- Bookmarks table
CREATE OR REPLACE table bookmarks (
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

