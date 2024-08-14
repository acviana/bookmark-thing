--
-- Table creation prototype
--
create or replace table bookmark (
    id uuid primary key,
    ctime timestamptz,
    mtime timestamptz,
    url varchar,
    title varchar,
    is_read boolean,
    tags varchar[]
)
;

--
-- Table insertion prototype
--
insert into bookmark 
by position
values (
    uuid(), 
    get_current_timestamp(), 
    get_current_timestamp(),
    'https://www.wired.com/story/how-30-lines-of-code-blew-up-27-ton-generator/',
    'How 30 Lines of Code Blew Up a 27-Ton Generator', 
    false,
    ['physical-infrastructure'], 
 ),
 (
    uuid(),
    get_current_timestamp(),
    get_current_timestamp(),
    'https://open.spotify.com/episode/2EGyoSBSsuEnah0CYFTQiF?si=e7ca90633b0e49ad',
    'My Climate Journey: Advancing Nuclear Innovation with INL''s Dr. John Wagner',
    true,
    ['physical-infrastructure']
 )
 ;

--
-- Table update protoptye
--
update bookmark
set 
    mtime = get_current_timestamp(),
    is_read = true
where id = (
    SELECT id 
    FROM bookmark
    where title='How 30 Lines of Code Blew Up a 27-Ton Generator'
);

select *
from bookmark
;

describe bookmark;
