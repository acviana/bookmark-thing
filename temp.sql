--create table bookmark (
--    id uuid,
--    ctime timestamp_s,
--    mtime timestamp_s,
--    url varchar,
--    title varchar,
--    tags varchar[]
--)

alter table bookmark
add column is_read boolean
;

insert 

SELECT * FROM bookmark;
describe bookmark;