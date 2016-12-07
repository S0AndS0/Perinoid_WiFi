Func_source_file(){
	_file="${1}"
	if [ -f "${_file}" ]; then
		echo "# Running: source ${_file}"
		source "${_file}"
	else
		echo "# Could **not** Source: ${_file}"
		exit 1
	fi
}
Func_check_exit_status(){
	_status="$1"
	_command="{2:-unidentified_command}"
	if [ "${_status}" != '0' ]; then
		echo "# ${Var_script_name} error: ${_status}"
		echo "# Failed to run: ${_command}"
		exit "${_status}"
	fi
}
