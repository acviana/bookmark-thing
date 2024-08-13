-- create table bookmark (
-- id uuid,
-- ctime timestamp_s,
-- mtime timestamp_s,
-- url varchar,
-- title varchar,
-- tags varchar[]
-- )
alter table bookmark
add column is_read boolean
;

insert into bookmark 
by position
values (
    uuid(), 
    get_current_timestamp(), 
    get_current_timestamp(),
    'https://www.wired.com/story/how-30-lines-of-code-blew-up-27-ton-generator/',
    'How 30 Lines of Code Blew Up a 27-Ton Generator', 
    ['physical-infra'], 
    false)
 ;

select *
from bookmark
;

describe bookmark;
