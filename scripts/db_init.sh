#! /bin/bash
die(){
  printf "ERROR:$*\n" 1>&2 ;
  exit 1;
}

cfg_text=$(cat db_scripts/db.cfg)

if [[ -f 'db_scripts/db.cfg' ]];then
  db_name=$(printf "$cfg_text" | grep 'db_name' | cut -d ':' -f2)
  db_user=$(printf "$cfg_text" | grep 'db_user' | cut -d ':' -f2)
  db_password=$(printf "$cfg_text" | grep 'db_password' | cut -d ':' -f2)
else
  die "no db.cfg file"
fi

printf "db_name = $db_name\n db_user = $db_user \n db_password = $db_password\n"

psql  -c "create database $db_name;"\
      -c "create user $db_user with password '$db_password';"\
      -c "grant all privileges on database $db_name to $db_user;"

psql -d $db_name -f db_scripts/hack_db_init.sql;

psql -d $db_name -c "grant all on session to $db_user;"
