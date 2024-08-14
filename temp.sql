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

insert into bookmark 
by position
values (
    uuid(), 
    get_current_timestamp(), 
    get_current_timestamp(),
    'https://www.wired.com/story/how-30-lines-of-code-blew-up-27-ton-generator/',
    'How 30 Lines of Code Blew Up a 27-Ton Generator', 
    false,
    ['physical-infra'], 
 )
 ;

select *
from bookmark
;

describe bookmark;
