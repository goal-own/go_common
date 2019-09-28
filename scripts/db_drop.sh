#! /bin/sh

cfg_text=$(cat db_scripts/db.cfg)

db_name=$(printf "$cfg_text" | grep 'db_name' | cut -d ':' -f2)
db_user=$(printf "$cfg_text" | grep 'db_user' | cut -d ':' -f2)
db_password=$(printf "$cfg_text" | grep 'db_password' | cut -d ':' -f2)

psql  -c "drop database $db_name;"\
      -c "drop user $db_user;";
