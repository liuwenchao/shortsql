#!/bin/bash
#
# A shell script to run sql statment in shorter commands
# for MySQL.
#
# @author Louis<louis.wenchao.liu@gmail.com>
# @see https://github.com/liuwenchao/sql_guru
# @license MIT

# @todo 
# up and down keys for HISTORY
# auto discovery on foreign keys
# help manual


# require: user, pass, db
source .my.cnf
: ${user:="root"}
: ${password:="root"}
: ${database:="test"}
: ${host:="localhost"}


case $# in
  1)
    # first arg is database
    database=$1;;
  *)
   ;;
esac

# ARGS: $1 log message
log() {
  echo -e "\033[1;34m $1 \033[0m"
}

log "will login by: mysql $database -u$user -p$password"

while read -p "$user@host:$database> " line
do
  HISTORY[${#HISTORY[*]}]="$line"
  case $line in
    "q")
      echo "dash out."
      break;;
    "h"|"help") 
      echo "see the source code, you are a guru.";;

    # up key
    $'\e[A') 
       : ${CURSOR:=${#HISTORY[*]}}
       ((CURSOR--))
       line=${HISTORY[$CURSOR]}
       ;;

    # down key
    $'\e[B') 
       
       ((CURSOR++))
       line=${HISTORY[$CURSOR]}
       ;;

    *)
      c=($(echo "$line"))
      op=${c[0]}
      table=${c[1]}
      param=${c[@]:2}
      : ${param:="1=1"}
      case $op in
        "d") sql="desc $table;";;
        "c") sql="show create table $table;";;
        "l") sql="select * from $table where $param;";;
        "s") sql="select ${c[2]} from $table where ${c[@]:3};";;
        "c") sql="select count(*) from $table where $param;";;
        "g") sql="select $param, count(*) from $table group by $param;";;
        "del") sql="delete from $table where $param;";;
        "use") database=$table;;

        # fall back
        *)     sql=$line;;
      esac
      log "$sql"
      eval "mysql $database -u$user -p$password -e ' $sql '"
      echo
      ;;
  esac
done
