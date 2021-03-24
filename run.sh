#!/bin/sh
srcDir="$(cd `dirname "$0"` && pwd)"
confFile="$(basename "${0%.*}")"
. "${srcDir}/config/${confFile}.conf"

# Log status
logStatus(){
    echo -e "$(date -u "+%FT%TZ") [$1] $2" >> ${srcDir}/$(date +"%Y-%m-%d-%H-%M")_mysql.log
}

# Create mysql databases and execute table creation scripts
run_sql(){
    if [ ! "$(ls ${srcDir}/scripts/ | grep sql | head -1)" ]; then
        echo "Place sql scripts into '${srcDir}/scripts/' directory!"
    else
        for db in "${dbs[@]}"; do
            status=$(mysql --user="$user" --password="$pass" -e "create database $db" 2>&1 1>/dev/null)
            if [ $? -eq 0 ]; then
                logStatus "INFO" "Creating database: '$db'"
            else
                logStatus "ERROR" "${status}"
            fi

            cd ${srcDir}/scripts

            for script in $(ls -1 | grep "$db"); do
                status=$(mysql --user="$user" --database="$db" --password="$pass" < "$script" 2>&1 1>/dev/null)
                if [ $? -eq 0 ]; then
                    logStatus "INFO" "Executing '${script##*/}' to '$db'"
                else
                    logStatus "ERROR" "${status}"
                fi
            done
        done
    fi
}

# Run SQL
run_sql