#!/usr/bin/env bash
export Var_script_dir="${0%/*}"
export Var_script_name="${0##*/}"
source "${Var_script_dir}/lib/functions.sh"
Func_source_file "${Var_script_dir}/lib/variables"
Var_server_country="$(curl ipinfo.io | awk '/country/{gsub("\"",""); print $2}' | sed 's/,//g')"
Var_server_city="$(curl ipinfo.io | awk '/city/{gsub("\"",""); print $2}' | sed 's/,//g')"
echo "# ${Var_script_name} started at: $(date -u +%s)"
if [ -e "${Var_main_script_name}" ]; then
	echo "# ${Var_script_name} running: sudo ./${Var_main_script_name} --debug-level='9' --ovpns-config-yn='yes' --ovpns-listen-ip=\"${Var_local_ip}\" --ovpns-listen-port=\"${Var_listen_port}\" --easyrsa-key-country=\"${Var_server_country}\" --easyrsa-key-city=\"${Var_server_city}\" --easyrsa-key-email=\"${Var_server_email}\""
	sudo ./${Var_main_script_name} --debug-level='9' --ovpns-config-yn='yes' --ovpns-auto-start-yn='yes' --ovpns-listen-ip="${Var_local_ip}" --ovpns-listen-port="${Var_listen_port}" --easyrsa-key-country="${Var_server_country}" --easyrsa-key-city="${Var_server_city}" --easyrsa-key-email="${Var_server_email}"
	_exit_status=$?
	Func_check_exit_status "${_exit_status}" "./${Var_main_script_name} --debug-level='9' --ovpns-config-yn='yes' --ovpns-listen-ip=\"${Var_local_ip}\" --ovpns-listen-port=\"${Var_listen_port}\""
else
	echo "# ${Var_script_name} could not execute: ${Var_main_script_name}"
	exit 1
fi
#echo "# ${Var_script_name} running: <command>"
#<command>
#_exit_status=$?
#Func_check_exit_status "${_exit_status}" "<command>"

echo "# ${Var_script_name} reports: all checks passed"
echo "# ${Var_script_name} finished at: $(date -u +%s)"
