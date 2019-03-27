--demo
cd C:\Program ...\9.2\bin\
psql postgres postgres
\q

--create db
createdb -U postgres test2
-- restore from sql file
psql -d test2 -U postgres -f "...\test2.sql"
--( tao duoc database nhung loi khi revoke and grant do role Salemans chua dc tao)
dropdb -U postgres test2

--restore from an archive file
createdb -U postgres test2
pg_restore -d test2 -U postgres "...test2.backup"

createdb -U postgres test
pg_restore -d test2 -U postgres "...test.backup"

pg_dump -U postgres test2 >testnow.sql
pg_dump -U postgres -Fc test2 >testnow.dump

dropdb -U postgres test2
createdb -U postgres test2
psql -d test2 -U postgres -f testnow.sql --ok
pg_restore -d test2 -U postgres testnow.dump -- ok