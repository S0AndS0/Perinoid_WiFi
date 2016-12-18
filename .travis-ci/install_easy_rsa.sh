#!/usr/bin/env bash
export Var_script_dir="${0%/*}"
export Var_script_name="${0##*/}"
source "${Var_script_dir}/lib/functions.sh"
Func_source_file "${Var_script_dir}/lib/variables"
echo "# ${Var_script_name} started at: $(date -u +%s)"
Var_deb_url="http://ftp.us.debian.org/debian/pool/main/e/easy-rsa/easy-rsa_2.2.2-1_all.deb"
Var_deb_file="${Var_deb_url##*/}"
echo "# ${Var_script_name} running: wget \"${Var_deb_url}\" -qO \"${Var_deb_file}\" && sudo dpkg -i \"${Var_deb_file}\""
wget "${Var_deb_url}" -qO "${Var_deb_file}" && sudo dpkg -i "${Var_deb_file}"
_exit_status=$?
Func_check_exit_status "${_exit_status}" "wget \"${Var_deb_url}\" -qO \"${Var_deb_file}\" && sudo dpkg -i \"${Var_deb_file}\""
echo "# ${Var_script_name} reports: all checks passed"
echo "# ${Var_script_name} finished at: $(date -u +%s)"
