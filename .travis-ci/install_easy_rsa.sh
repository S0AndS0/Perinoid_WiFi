#!/usr/bin/env bash
export Var_script_dir="${0%/*}"
export Var_script_name="${0##*/}"
source "${Var_script_dir}/lib/functions.sh"
Func_source_file "${Var_script_dir}/lib/variables"
echo "# ${Var_script_name} started at: $(date -u +%s)"
Var_source_string='deb http://ftp.us.debian.org/debian unstable main contrib non-free'
echo "# ${Var_script_name} running: echo \"${Var_source_string}\" | sudo tee -a /etc/apt/sources.list.d/custom_testing.list"
echo "${Var_source_string}" | sudo tee -a /etc/apt/sources.list.d/custom_testing.list
_exit_status=$?
Func_check_exit_status "${_exit_status}" "echo \"${Var_source_string}\" | sudo tee -a /etc/apt/sources.list.d/custom_testing.list"
echo "# ${Var_script_name} running: sudo apt-get update 2> /tmp/keymissing; for key in \$(grep \"NO_PUBKEY\" /tmp/keymissing |sed \"s/.*NO_PUBKEY //\"); do echo -e \"nProcessing key: \$key\"; gpg --keyserver keys.gnupg.net --recv $key && gpg --export --armor \$key | sudo apt-key add -; done"
sudo apt-get update 2> /tmp/keymissing; for key in $(grep "NO_PUBKEY" /tmp/keymissing |sed "s/.*NO_PUBKEY //"); do echo -e "nProcessing key: $key"; gpg --keyserver keys.gnupg.net --recv $key && gpg --export --armor $key | sudo apt-key add -; done
_exit_status=$?
Func_check_exit_status "${_exit_status}" "sudo apt-get update 2> /tmp/keymissing; for key in \$(grep \"NO_PUBKEY\" /tmp/keymissing |sed \"s/.*NO_PUBKEY //\"); do echo -e \"nProcessing key: \$key\"; gpg --keyserver keys.gnupg.net --recv $key && gpg --export --armor \$key | sudo apt-key add -; done"
echo "# ${Var_script_name} running: sudo apt-get update && sudo apt-get install easy-rsa"
sudo apt-get update && sudo apt-get install easy-rsa
_exit_status=$?
Func_check_exit_status "${_exit_status}" "sudo apt-get update && sudo apt-get install easy-rsa"
echo "# ${Var_script_name} reports: all checks passed"
echo "# ${Var_script_name} finished at: $(date -u +%s)"
