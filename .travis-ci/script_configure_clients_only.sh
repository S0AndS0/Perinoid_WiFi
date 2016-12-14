#!/usr/bin/env bash
export Var_script_dir="${0%/*}"
export Var_script_name="${0##*/}"
source "${Var_script_dir}/lib/functions.sh"
Func_source_file "${Var_script_dir}/lib/variables"
echo "# ${Var_script_name} started at: $(date -u +%s)"
if [ -e "${Var_main_script_name}" ]; then
	echo "# ${Var_script_name} running: sudo ./${Var_main_script_name} --debug-level='9' --ovpnc-config-yn='yes' --ovpnc-pass-yn='yes' --ovpnc-host-ports=\"${Var_external_ip}:${Var_listen_port}\" --ovpnc-names=\"${Var_client_users_list}\""
	sudo ./${Var_main_script_name} --debug-level='9' --ovpnc-config-yn='yes' --ovpnc-pass-yn='yes' --ovpnc-host-ports="${Var_external_ip}:${Var_listen_port}" --ovpnc-names="${Var_client_users_list}"
	_exit_status=$?
	Func_check_exit_status "${_exit_status}" "./${Var_main_script_name} --debug-level='9' --ovpnc-config-yn='yes' --ovpnc-pass-yn='yes' --ovpnc-host-ports=\"${Var_external_ip}:${Var_listen_port}\" --ovpnc-names=\"${Var_client_users_list}\""
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
