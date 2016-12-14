#!/usr/bin/env bash
export Var_script_dir="${0%/*}"
export Var_script_name="${0##*/}"
source "${Var_script_dir}/lib/functions.sh"
Func_source_file "${Var_script_dir}/lib/variables"
echo "# ${Var_script_name} started at: $(date -u +%s)"
if [ -f "${Var_main_script_name}" ]; then
	chmod u+x "${Var_main_script_name}"
else
	echo "# ${Var_script_name} could not find: ${Var_main_script_name}"
	exit 1
fi
if [ -e "${Var_main_script_name}" ]; then
	echo "# ${Var_script_name} running: ./${Var_main_script_name} --version"
	./${Var_main_script_name} --version
	_exit_status=$?
	Func_check_exit_status "${_exit_status}" "${Var_main_script_name} --version"
#	echo "# ${Var_script_name} running: sudo ./${Var_main_script_name} --debug-level='9' --apt-check-depends-yn=\"yes\" --apt-depends-list=\"${Var_main_script_apt_get_depends_list}\""
#	sudo ./${Var_main_script_name} --debug-level='9' --apt-check-depends-yn="yes" --apt-depends-list="${Var_main_script_apt_get_depends_list}"
	echo "# ${Var_script_name} running: sudo apt-get update -qqq && sudo apt-get install ${Var_main_script_apt_get_depends_list}"
	sudo apt-get update -qqq && sudo apt-get install ${Var_main_script_apt_get_depends_list}
	_exit_status=$?
	Func_check_exit_status "${_exit_status}" "./${Var_main_script_name} --debug-level='9' --apt-check-depends-yn=\"yes\" --apt-depends-list=\"${Var_main_script_apt_get_depends_list}\""
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
