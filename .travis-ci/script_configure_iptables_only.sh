#!/usr/bin/env bash
export Var_script_dir="${0%/*}"
export Var_script_name="${0##*/}"
source "${Var_script_dir}/lib/functions.sh"
Func_source_file "${Var_script_dir}/lib/variables"
echo "# ${Var_script_name} started at: $(date -u +%s)"
if [ -e "${Var_main_script_name}" ]; then
	echo "# ${Var_script_name} running: sudo ./${Var_main_script_name} --debug-level='9' --iptables-write-config-yn='yes' --iptables-config-path=\"${Var_iptables_script_path}\" --ovpns-listen-ip=\"${Var_local_ip}\" --ovpns-listen-port=\"${Var_listen_port}\""
	sudo ./${Var_main_script_name} --debug-level='9' --iptables-write-config-yn='yes' --iptables-config-path="${Var_iptables_script_path}" --ovpns-listen-ip="${Var_local_ip}" --ovpns-listen-port="${Var_listen_port}"
	_exit_status=$?
	Func_check_exit_status "${_exit_status}" "sudo ./${Var_main_script_name} --debug-level='9' --iptables-write-config-yn='yes' --iptables-config-path=\"${Var_iptables_script_path}\" --ovpns-listen-ip=\"${Var_local_ip}\" --ovpns-listen-port=\"${Var_listen_port}\""
else
	echo "# ${Var_script_name} could not execute: ${Var_main_script_name}"
	exit 1
fi
if [ -f "${Var_iptables_script_path}" ]; then
	echo "# ${Var_script_name} running: cat \"${Var_iptables_script_path}\""
	cat "${Var_iptables_script_path}"
	_exit_status=$?
	Func_check_exit_status "${_exit_status}" "cat \"${Var_iptables_script_path}\""
else
	echo "# ${Var_script_name} cannot find: ${Var_iptables_script_path}"
	exit 1
fi
echo "# ${Var_script_name} reports: all checks passed"
echo "# ${Var_script_name} finished at: $(date -u +%s)"
