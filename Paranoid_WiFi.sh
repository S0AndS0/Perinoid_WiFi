#!/usr/bin/env bash
Var_script_dir="${0%/*}"
Var_script_name="${0##*/}"
## Internal script variables that can also be set by users
Var_debug_level="0"
Var_log_level="0"
Var_script_log_path="${PWD}/${Var_script_name%.sh*}.log"
Var_columns="${COLUMNS:-$(tput cols)}"
Var_columns="${Var_columns:-80}"
Var_authors_contact='strangerthanbland@gmail.com'
Var_authors_username='S0AndS0'
Var_source_var_file=""
Var_script_version_main="0"
Var_script_version_sub="1"
Var_script_version_full="${Var_script_version_main}.${Var_script_version_sub}"
## Variables for apt-get
Var_apt_check_depends_yn=""
Var_apt_depends_list="openvpn,easy-rsa"
## Variables for OpenVPN server configs
Var_ovpns_config_yn=""
Var_ovpns_config_path="/etc/openvpn/server.conf"
Var_ovpns_internal_ip="10.8.0.0"
Var_ovpns_internal_netmask="255.255.255.0"
Var_ovpns_listen_ip="192.168.0.5"
Var_ovpns_listen_protocal="udp"
Var_ovpns_listen_port="9988"
Var_ovpns_chroot_yn="yes"
Var_ovpns_chroot_path="/etc/openvpn/jailed_server"
Var_ovpns_dns_ip_list="208.67.222.222,208.67.220.220"
Var_ovpns_route_ip="192.168.0.0"
Var_ovpns_route_netmask="255.255.255.0"
Var_ovpns_user="vpnjail"
Var_ovpns_group="nogroup"
Var_ovpns_ca_path="/etc/openvpn/certs/ca.crt"
Var_ovpns_cert_path="/etc/openvpn/certs/server.crt"
Var_ovpns_key_path="/etc/openvpn/certs/server.key"
Var_ovpns_dh_path="/etc/openvpn/certs/dh2048.pem"
Var_ovpns_ipp_path="/etc/openvpn/ipp.txt"
Var_ovpns_ta_path="/etc/openvpn/certs/ta.key"
Var_ovpns_status_path="/etc/openvpn/openvpn-status.log"
Var_ovpns_log_path="/etc/openvpn/openvpn.log"
Var_ovpns_verbosity="3"
Var_ovpn_cipher="AES-256-CBC"
Var_ovpn_auth="SHA512"
Var_ovpns_sndbuf="393216"
Var_ovpns_rcvbuf="393216"
Var_ovpns_tun_mtu="1400"
Var_ovpns_mssfix="1360"
Var_ovpns_tls_cipher="TLS-DHE-RSA-WITH-AES-256-GCM-SHA384:TLS-DHE-RSA-WITH-AES-128-GCM-SHA256:TLS-DHE-RSA-WITH-AES-256-CBC-SHA:TLS-DHE-RSA-WITH-CAMELLIA-256-CBC-SHA:TLS-DHE-RSA-WITH-AES-128-CBC-SHA:TLS-DHE-RSA-WITH-CAMELLIA-128-CBC-SHA"
## Easy-RSA config settings
Var_easyrsa_examples_path="/usr/share/doc/openvpn/examles/easy-rsa/2.0"
Var_easyrsa_working_path="/etc/openvpn/easy-rsa"
Var_easyrsa_key_size="2048"
Var_easyrsa_ca_expire="3650"
Var_easyrsa_key_expire="3650"
Var_easyrsa_key_country="NonesuchCountry"
Var_easyrsa_key_province="NonesuchProvince"
Var_easyrsa_key_city="NonesuchCity"
Var_easyrsa_key_org="Organization"
Var_easyrsa_key_email="$(id -un)@${HOSTNAME}.local"
Var_easyrsa_key_ou="OrganizationUnit"
Var_easyrsa_key_name="EasyRSA"
## Assigne default functions for handling messages,
Func_check_args(){
	_arr_input=( "${@}" )
	Func_message "# ${Var_script_name} parsing: ${_arr_input[*]}" '2' '3'
	let _arr_count=0
	until [ "${#_arr_input[@]}" = "${_arr_count}" ]; do
		_arg="${_arr_input[${_arr_count}]}"
		case "${_arg%=*}" in
			#--|)
			#	Func_assign_arg "" "${_arg#*=}"
			#;;
			--apt-check-depends-yn|Var_apt_check_depends_yn)
				Func_assign_arg "Var_apt_check_depends_yn" "${_arg#*=}"
			;;
			--apt-depends-list|Var_apt_depends_list)
				Func_assign_arg "Var_apt_depends_list" "${_arg#*=}"
			;;
			--debug-level|Var_debug_level)
				Func_assign_arg "Var_debug_level" "${_arg#*=}"
			;;
			--log-level|Var_log_level)
				Func_assign_arg "Var_log_level" "${_arg#*=}"
			;;
			--ovpns-config-yn|Var_ovpns_config_yn)
				Func_assign_arg "Var_ovpns_config_yn" "${_arg#*=}"
			;;
			--ovpns-config-path|Var_ovpns_config_path)
				Func_assign_arg "Var_ovpns_config_path" "${_arg#*=}"
			;;
			--ovpns-chroot-yn|Var_ovpns_chroot_yn)
				Func_assign_arg "Var_ovpns_chroot_yn" "${_arg#*=}"
			;;
			--ovpns-chroot-path|Var_ovpns_chroot_path)
				Func_assign_arg "Var_ovpns_chroot_path" "${_arg#*=}"
			;;
			--ovpns-dns-ip-list|Var_ovpns_dns_ip_list)
				Func_assign_arg "Var_ovpns_dns_ip_list" "${_arg#*=}"
			;;
			--ovpns-internal-ip|Var_ovpns_internal_ip)
				Func_assign_arg "Var_ovpns_internal_ip" "${_arg#*=}"
			;;
			--ovpns-internal-netmask|Var_ovpns_internal_netmask)
				Func_assign_arg "Var_ovpns_internal_netmask" "${_arg#*=}"
			;;
			--ovpns-listen-ip|Var_ovpns_listen_ip)
				Func_assign_arg "Var_ovpns_listen_ip" "${_arg#*=}"
			;;
			--ovpns-listen-protocal|Var_ovpns_listen_protocal)
				Func_assign_arg "Var_ovpns_listen_protocal" "${_arg#*=}"
			;;
			--ovpns-listen-port|Var_ovpns_listen_port)
				Func_assign_arg "Var_ovpns_listen_port" "${_arg#*=}"
			;;
			--ovpns-route-ip|Var_ovpns_route_ip)
				Func_assign_arg "Var_ovpns_route_ip" "${_arg#*=}"
			;;
			--ovpns-route-netmask|Var_ovpns_route_netmask)
				Func_assign_arg "Var_ovpns_route_netmask" "${_arg#*=}"
			;;
			--ovpns-user|Var_ovpns_user)
				Func_assign_arg "Var_ovpns_user" "${_arg#*=}"
			;;
			--ovpns-group|Var_ovpns_group)
				Func_assign_arg "Var_ovpns_group" "${_arg#*=}"
			;;
			--ovpns-ca-path|Var_ovpns_ca_path)
				Func_assign_arg "Var_ovpns_ca_path" "${_arg#*=}"
			;;
			--ovnps-cert-path|Var_ovpns_cert_path)
				Func_assign_arg "Var_ovpns_cert_path" "${_arg#*=}"
			;;
			--ovpns-key-path|Var_ovpns_key_path)
				Func_assign_arg "Var_ovpns_key_path" "${_arg#*=}"
			;;
			--ovpns-dh-path|Var_ovpns_dh_path)
				Func_assign_arg "Var_ovpns_dh_path" "${_arg#*=}"
			;;
			--ovpns-ipp-path|Var_ovpns_ipp_path)
				Func_assign_arg "Var_ovpns_ipp_path" "${_arg#*=}"
			;;
			--ovpns-status-path|Var_ovpns_status_path)
				Func_assign_arg "Var_ovpns_status_path" "${_arg#*=}"
			;;
			--ovpns-log-path|Var_ovpns_log_path)
				Func_assign_arg "Var_ovpns_log_path" "${_arg#*=}"
			;;
			--ovpns-ta-path|Var_ovpns_ta_path)
				Func_assign_arg "Var_ovpns_ta_path" "${_arg#*=}"
			;;
			--ovpns-tls-cipher|Var_ovpns_tls_cipher)
				Func_assign_arg "Var_ovpns_tls_cipher" "${_arg#*=}"
			;;
			--ovpns-verbosity|Var_ovpns_verbosity)
				Func_assign_arg "Var_ovpns_verbosity" "${_arg#*=}"
			;;
			--ovpns-cipher|Var_ovpn_cipher)
				Func_assign_arg "Var_ovpn_cipher" "${_arg#*=}"
			;;
			--ovpns-auth|Var_ovpn_auth)
				Func_assign_arg "Var_ovpn_auth" "${_arg#*=}"
			;;
			--ovpns-sndbuf|Var_ovpns_sndbuf)
				Func_assign_arg "Var_ovpns_sndbuf" "${_arg#*=}"
			;;
			--ovpns-rcvbuf|Var_ovpns_rcvbuf)
				Func_assign_arg "Var_ovpns_rcvbuf" "${_arg#*=}"
			;;
			--ovpns-tun-mtu|Var_ovpns_tun_mtu)
				Func_assign_arg "Var_ovpns_tun_mtu" "${_arg#*=}"
			;;
			--ovpns-mssfix|Var_ovpns_mssfix)
				Func_assign_arg "Var_ovpns_mssfix" "${_arg#*=}"
			;;
			--easyrsa-examples-path|Var_easyrsa_examples_path)
				Func_assign_arg "Var_easyrsa_examples_path" "${_arg#*=}"
			;;
			--easyrsa-working-path|Var_easyrsa_working_path)
				Func_assign_arg "Var_easyrsa_working_path" "${_arg#*=}"
			;;
			--easyrsa-key-size|Var_easyrsa_key_size)
				Func_assign_arg "Var_easyrsa_key_size" "${_arg#*=}"
			;;
			--easyrsa-ca-expire|Var_easyrsa_ca_expire)
				Func_assign_arg "Var_easyrsa_ca_expire" "${_arg#*=}"
			;;
			--easyrsa-key-expire|Var_easyrsa_key_expire)
				Func_assign_arg "Var_easyrsa_key_expire" "${_arg#*=}"
			;;
			--easyrsa-key-country|Var_easyrsa_key_country)
				Func_assign_arg "Var_easyrsa_key_country" "${_arg#*=}"
			;;
			--easyrsa-key-province|Var_easyrsa_key_province)
				Func_assign_arg "Var_easyrsa_key_province" "${_arg#*=}"
			;;
			--easyrsa-key-city|Var_easyrsa_key_city)
				Func_assign_arg "Var_easyrsa_key_city" "${_arg#*=}"
			;;
			--easyrsa-key-org|Var_easyrsa_key_org)
				Func_assign_arg "Var_easyrsa_key_org" "${_arg#*=}"
			;;
			--easyrsa-key-email|Var_easyrsa_key_email)
				Func_assign_arg "Var_easyrsa_key_email" "${_arg#*=}"
			;;
			--easyrsa-key-ou|Var_easyrsa_key_ou)
				Func_assign_arg "Var_easyrsa_key_ou" "${_arg#*=}"
			;;
			--easyrsa-key-name|Var_easyrsa_key_name)
				Func_assign_arg "Var_easyrsa_key_name" "${_arg#*=}"
			;;
			--script-log-path|Var_script_log_path)
				Func_assign_arg "Var_script_log_path" "${_arg#*=}"
			;;
			--columns|Var_columns)
				Func_assign_arg "Var_columns" "${_arg#*=}"
			;;
			--save-variables-yn|Var_save_variables_yn)
				Func_assign_arg "Var_save_variables_yn" "${_arg#*=}"
			;;
			--source-var-file|Var_source_var_file)
				Func_assign_arg "Var_source_var_file" "${_arg#*=}"
				if [ -f "${Var_source_var_file}" ]; then
					Func_message "# ${Var_script_name} running: source \"${Var_source_var_file}\"" '2' '3'
					source "${Var_source_var_file}"
				fi
			;;
			---*)
				_extra_var="${_arg%=*}"
				_extra_arg="${_arg#*=}"
				Func_assign_arg "${_extra_var/---/}" "${_arg#*=}"
			;;
			--help|help)
				Func_message "# Func_check_args read variable [${_arg%=*}] with value [${_arg#*=}]" '2' '3'
				Func_help
				exit 0
			;;
			--license)
				Func_script_license_customizer
				exit 0
			;;
			--version)
				echo "# ${Var_script_name} version: ${Var_script_version_full}"
				exit 0
			;;
			*)
				Func_message "# " '2' '3'
				declare -ag "Arr_extra_input+=( ${_arg} )"
			;;
		esac
		let _arr_count++
	done
	unset _arr_count
}
## Display what current values are held by command line options
Func_help(){
	echo "# ${Var_script_dir}/${Var_script_name} knows the following command line options"
	echo "# --columns		Var_columns=\"${Var_columns}\""
	echo "# --debug-level		Var_debug_level=\"${Var_debug_level}\""
	echo "# --log-level		Var_log_level=\"${Var_log_level}\""
	echo "# --script-log-level	Var_script_log_path=\"${Var_script_log_path}\""
	echo "# --save-variables-yn	Var_save_variables_yn=\"${Var_save_variables_yn}\""
	echo "# --source-var-file	Var_source_var_file=\"${Var_source_var_file}\""
	echo "# --license		Display the license for this script."
	echo "# --help			Display this message."
	echo "# --version		Display version for this script."
	echo "## Command line options for apt-get automation"
	echo "# --apt-check-depends-yn		Var_apt_check_depends_yn=\"${Var_apt_check_depends_yn}\""
	echo "# --apt-depends-list		Var_apt_depends_list=\"${Var_apt_depends_list}\""
	echo "## Command line options for OpenVPN server installation/configuration"
	echo "# --ovnps-config-yn		Var_ovpns_config_yn=\"${Var_ovpns_config_yn}\""
	echo "# --ovpns-config-path		Var_ovpns_config_path=\"${Var_ovpns_config_path}\""
	echo "# --ovpns-chroot-yn		Var_ovpns_chroot_yn=\"${Var_ovpns_chroot_yn}\""
	echo "# --ovpns-chroot-path		Var_ovpns_chroot_path=\"${Var_ovpns_chroot_path}\""
	echo "# --ovpns-dns-ip-list		Var_ovpns_dns_ip_list=\"${Var_ovpns_dns_ip_list}\""
	echo "# --ovpns-internal-ip		Var_ovpns_internal_ip=\"${Var_ovpns_internal_ip}\""
	echo "# --ovpns-internal-netmask	Var_ovpns_internal_netmask=\"${Var_ovpns_internal_netmask}\""
	echo "# --ovpns-listen-ip		Var_ovpns_listen_ip=\"${Var_ovpns_listen_ip}\""
	echo "# --ovpns-listen-protocal		Var_ovpns_listen_protocal=\"${Var_ovpns_listen_protocal}\""
	echo "# --ovpns-listen-port		Var_ovpns_listen_port=\"${Var_ovpns_listen_port}\""
	echo "# --ovpns-route-ip		Var_ovpns_route_ip=\"${Var_ovpns_route_ip}\""
	echo "# --ovpns-route-netmask		Var_ovpns_route_netmask=\"${Var_ovpns_route_netmask}\""
	echo "# --ovpns-user			Var_ovpns_user=\"${Var_ovpns_user\""
	echo "# --ovpns-group			Var_ovpns_group=\"${Var_ovpns_group}\""
	echo "# --ovpns-ca-path			Var_ovpns_ca_path=\"${Var_ovpns_ca_path}\""
	echo "# --ovpns-cert-path		Var_ovpns_cert_path=\"${Var_ovpns_cert_path}\""
	echo "# --ovpns-key-path		Var_ovpns_key_path=\"${Var_ovpns_key_path}\""
	echo "# --ovpns-dh-path			Var_ovpns_dh_path=\"${Var_ovpns_dh_path}\""
	echo "# --ovpns-ipp-path		Var_ovpns_ipp_path=\"${Var_ovpns_ipp_path}\""
	echo "# --ovpns-status-path		Var_ovpns_status_path=\"${Var_ovpns_status_path}\""
	echo "# --ovpns-log-path		Var_ovpns_log_path=\"${Var_ovpns_log_path}\""
	echo "# --ovpns-verbosity		Var_ovpns_verbosity=\"${Var_ovpns_verbosity}\""
	echo "# --ovpns-cipher			Var_ovpn_cipher=\"${Var_ovpn_cipher}\""
	echo "# --ovpns-auth			Var_ovpn_auth=\"${Var_ovpn_auth}\""
	echo "# --ovpns-tun-mtu			Var_ovpns_tun_mtu=\"${Var_ovpns_tun_mtu}\""
	echo "# --ovpns-mssfix			Var_ovpns_mssfix=\"${Var_ovpns_mssfix}\""
	echo "# --ovpns-ta-path			Var_ovpns_ta_path=\"${Var_ovpns_ta_path}\""
	echo "# --ovpns-tls-cipher		Var_ovpns_tls_cipher=\"${Var_ovpns_tls_cipher}\""
	echo "# --easyrsa-examples-path		Var_easyrsa_examples_path=\"${Var_easyrsa_examples_path}\""
	echo "# --easyrsa-working-path		Var_easyrsa_working_path=\"${Var_easyrsa_working_path}\""
	echo "# --easyrsa-key-size		Var_easyrsa_key_size=\"${Var_easyrsa_key_size}\""
	echo "# --easyrsa-ca-expire		Var_easyrsa_ca_expire=\"${Var_easyrsa_ca_expire}\""
	echo "# --easyrsa-key-expire		Var_easyrsa_key_expire=\"${Var_easyrsa_key_expire}\""
	echo "# --easyrsa-key-country		Var_easyrsa_key_country=\"${Var_easyrsa_key_country}\""
	echo "# --easyrsa-key-province		Var_easyrsa_key_province=\"${Var_easyrsa_key_province}\""
	echo "# --easyrsa-key-city		Var_easyrsa_key_city=\"${Var_easyrsa_key_city}\""
	echo "# --easyrsa-key-org		Var_easyrsa_key_org=\"${Var_easyrsa_key_org}\""
	echo "# --easyrsa-key-email		Var_easyrsa_key_email=\"${Var_easyrsa_key_email}\""
	echo "# --easyrsa-key-ou		Var_easyrsa_key_ou=\"${Var_easyrsa_key_ou}\""
	echo "# --easyrsa-key-name		Var_easyrsa_key_name=\"${Var_easyrsa_key_name}\""
}
## Note the following three functions should not need much editing
Func_script_license_customizer(){
	Func_message "## Salutations ${Var_script_current_user}, the following license" '0' '42'
	Func_message "#  only applies to this script [${Var_script_title}]. Software external to but" '0' '42'
	Func_message '#  used by [${Var_script_name}] are protected under their own licensing' '0' '42'
	Func_message "#  usage agreements. The authors of this project assume **no** rights" '0' '42'
	Func_message '#  to modify software licensing agreements external to [${Var_script_name}]' '0' '42'
	Func_message '## GNU AGPL v3 Notice start' '0' '42'
	Func_message "# ${Var_script_name}, configurer/manager for chroot jailed OpenVPN servers." '0' '42'
	Func_message "#  Copyright (C) 2016 ${Var_authors_username}" '0' '42'
	Func_message '# This program is free software: you can redistribute it and/or modify' '0' '42'
	Func_message '#  it under the terms of the GNU Affero General Public License as' '0' '42'
	Func_message '#  published by the Free Software Foundation, version 3 of the' '0' '42'
	Func_message '#  License.' '0' '42'
	Func_message '# You should have received a copy of the GNU Afferno General Public License' '0' '42'
	Func_message '# along with this program. If not, see <http://www.gnu.org/licenses/>.' '0' '42'
	Func_message "#  Contact authors of [${Var_script_name}] at: ${Var_authors_contact}" '0' '42'
	Func_message '# GNU AGPL v3 Notice end' '0' '42'
	if [ -r "${Var_script_dir}/Licenses/GNU_AGPLv3_Code.md" ]; then
		Func_message '## Found local license file, prompting to display...' '0' '42'
		Func_prompt_continue "Func_script_license_customizer"
		less -R5 "${Var_script_dir}/Licenses/GNU_AGPLv3_Code.md"
	else
		${Var_echo_exec_path} -en "Please input the downloaded source directory for ${Var_script_name}: "
		read -r _responce
		if [ -d "${_responce}" ] && [ -r "${_responce}/Licenses/GNU_AGPLv3_Code.md" ]; then
			Func_message '## Found local license file, prompting to display...' '0' '42'
			Func_prompt_continue "Func_script_license_customizer"
			fold -sw $((${Var_columns_width}-8)) "${_responce}/Licenses/GNU_AGPLv3_Code.md" | less -R5
		else
			Func_message '## Unable to find full license, see linke in above short version or find full license under downloaded source directory for this script.' '0' '42'
		fi
	fi
}
Func_message(){
	_message="${1}"
	_debug_level="${2:-${Var_debug_level}}"
	_log_level="${3:-${Var_log_level}}"
	if [ "${#_message}" != "0" ]; then
		if [ "${_debug_level}" = "${Var_debug_level}" ] || [ "${Var_debug_level}" -gt "${_debug_level}" ]; then
			_folded_message="$(fold -sw $((${Var_columns}-6)) <<<"${_message}" | sed -e "s/^.*$/$(echo -n "#DBL-${_debug_level}") &/g")"
			cat <<<"${_folded_message}"
		fi
	fi
	if [ "${#_message}" != "0" ]; then
		if [ "${Var_log_level}" -gt "${_log_level}" ]; then
			cat <<<"${_message}" >> "${Var_script_log_path}"
		fi
	fi
}
Func_assign_arg(){
	_variable="${1}"
	_value="${2}"
	Func_message "# ${Var_script_name} running: declare -g \"${_variable}=${_value}\"" '3' '4'
	Func_message "# Func_assign_arg running: declare -g \"${_variable}=${_value}\"" '3' '4'
	declare -g "${_variable}=${_value}"
	Func_save_variables "${_variable}" "${_value}"
}
Func_save_variables(){
	_variable="${1}"
	_value="${2}"
	case "${Var_save_variables_yn}" in
		Y|y|Yes|yes|YES)
			${Var_cat} >> "${Var_source_var_file}" <<EOF
declare -g ${_variable}="${_value}"
EOF
		;;
	esac
}
## Write functions to do stuff with assigned variables
Func_apt_check_install_depends(){
	for _app in ${Var_apt_depends_list//,/ }; do
		_installed_state="$(apt-cache policy ${_app} | awk '/Installed/{print $2}')"
		case "${_installed_state}" in
			*none*)
				Func_message "# Func_apt_check_install_depends found [${_app}] to install" '2' '3'
				declare -a "Arr_apt_depends_list+=( ${_app} )"
			;;
		esac
	done
	if [ "${#Arr_apt_depends_list[@]}" != "0" ]; then
		Func_message "# Func_apt_check_install_depends installing [${Arr_apt_depends_list[*]}] via apt-get" '2' '3'
		sudo apt-get update -qqq && sudo apt-get install -qqqy ${Arr_apt_depends_list[*]}
	fi
}
Func_write_openvpn_server_config(){
	if [ -f "${Var_ovpns_config_path}" ]; then
		#Func_message "#  running: " '2' '3'
		mv -v "${Var_ovpns_config_path}" "${Var_ovpns_config_path%.conf*}.bak"
	fi
	#Func_message "#  running: " '2' '3'
	cat > "${Var_ovpns_config_path}" <<EOF
dev tun
local ${Var_ovpns_listen_ip}
port ${Var_ovpns_listen_port}
proto ${Var_ovpns_listen_protocal}
server ${Var_ovpns_internal_ip} ${Var_ovpns_internal_netmask}
keepalive 10 60
comp-lzo
persist-key
persist-tun
EOF
	case "${Var_ovpns_chroot_yn}" in
		y|Y|yes|Yes|YES)
			#Func_message "#  running: " '2' '3'
			cat >> "${Var_ovpns_config_path}" <<EOF
chroot ${Var_ovpns_chroot_path}
EOF
		;;
	esac
	#Func_message "#  running: " '2' '3'
	cat >> "${Var_ovpns_config_path}" <<EOF
user ${Var_ovpns_user}
group ${Var_ovpns_group}
ca ${Var_ovpns_ca_path}
cert ${Var_ovpns_cert_path}
key ${Var_ovpns_key_path}
dh ${Var_ovpns_dh_path}
ifconfig-pool-persist ${Var_ovpns_ipp_path} 0
status ${Var_ovpns_status_path}
log ${Var_ovpns_log_path}
verb ${Var_ovpns_verbosity}
push "redirect-gateway def1"
EOF
	for _dns_ip in ${Var_ovpns_dns_ip_list//,/ }; do
		#Func_message "#  running: " '2' '3'
		cat >> "${Var_ovpns_config_path}" <<EOF
push "dhcp-option DNS ${_dns_ip}"
EOF
	#Func_message "#  running: " '2' '3'
	cat >> "${Var_ovpns_config_path}" <<EOF
route ${Var_ovpns_route_ip} ${Var_ovpns_route_netmask}
push "route ${Var_ovpns_route_ip} ${Var_ovpns_route_netmask}"
cipher ${Var_ovpn_cipher}
auth ${Var_ovpn_auth}
tls-cipher ${Var_ovpns_tls_cipher}
tls-auth ${Var_ovpns_ta_path} 0
sndbuf ${Var_ovpns_sndbuf}
rcvbuf ${Var_ovpns_rcvbuf}
push "sndbuf ${Var_ovpns_sndbuf}"
push "rcvbuf ${Var_ovpns_rcvbuf}"
tun-mtu ${Var_ovpns_tun_mtu}
mssfix ${Var_ovpns_mssfix}
#push "dhcp-option PROXY_HTTP <ip> <port>"
#push "dhcp-option PROXY_HTTPS <ip> <port>"
push "block-outside-dns"
EOF
}
Func_write_easyrsa_vars(){
	#Func_message "#  running: " '2' '3'
	mkdir -p "${Var_easyrsa_working_path}"
	#Func_message "#  running: " '2' '3'
	cp -R "${Var_easyrsa_examples_path}/*" "${Var_easyrsa_working_path}/"
	#Func_message "#  running: " '2' '3'
	cat > "${Var_easyrsa_working_path}/vars" <<EOF
export EASY_RSA="\$(pwd)"
export OPENSSL="openssl"
export PKCS11TOOL="pkcs11-tool"
export GREP="grep"
export KEY_CONFIG=\$(\${EASY_RSA}/whichopensslcnf \${EASY_RSA})
export KEY_DIR="\${EASY_RSA}/keys"
echo "# Note running './clean-all' will preform 'rm -rf' on directory: \${KEY_DIR}"
export PKCS11_MODULE_PATH="dummy"
export PKCS11_PIN="dummy"
export KEY_SIZE="${Var_easyrsa_key_size}"
export CA_EXPIRE="${Var_easyrsa_ca_expire}"
export KEY_EXPIRE="${Var_easyrsa_key_expire}"
export KEY_COUNTRY="${Var_easyrsa_key_country}"
export KEY_PROVINCE="${Var_easyrsa_key_province}"
export KEY_CITY="${Var_easyrsa_key_city}"
export KEY_ORG="${Var_easyrsa_key_org}"
export KEY_EMAIL="${Var_easyrsa_key_email}"
export KEY_OU="${Var_easyrsa_key_ou}"
export KEY_NAME="${Var_easyrsa_key_name}"
EOF
}
Func_mkuser_openvpn_server(){
	#Func_message "#  running: " '2' '3'
	adduser --system --shell /usr/sbin/nologin --no-create-home ${Var_ovpns_user}
}
#Func_write_openvpn_client_config(){
#	cat >> "${Var_ovpns_config_path}" <<EOF
#	
#EOF
#}
## Do stuff with input and above functions inside bellow function
Func_main(){
	_input=( "$@" )
	if [ "${#_input[@]}" = "0" ]; then
		Func_message "# ${Var_script_name} running: Func_check_args \"--help\"" '1' '2'
		Func_check_args "--help"
	else
		Func_message "# ${Var_script_name} running: Func_check_args \"${_input[@]}\"" '1' '2'
		Func_check_args "${_input[@]}"
	fi
	unset -v _input[@]
	## Do stuff with assigned variables
	case "${Var_apt_check_depends_yn}" in
		y|Y|yes|Yes|YES)
			Func_message "# ${Var_script_name} running: " '1' '2'
			Func_apt_check_install_depends
		;;
	esac
	case "${Var_ovpns_config_yn}" in
		y|Y|yes|Yes|YES)
			Func_message "# ${Var_script_name} running: " '1' '2'
			Func_mkuser_openvpn_server
			Func_message "# ${Var_script_name} running: " '1' '2'
			Func_write_openvpn_server_config
			Func_message "# ${Var_script_name} running: " '1' '2'
			Func_write_easyrsa_vars
		;;
	esac
	#Func_message "# ${Var_script_name} running: " '1' '2'
	#Func_write_openvpn_client_config
	
}
Func_message "# ${Var_script_name} running: Func_main \"\$@\"" '0' '1'
Func_main "$@"
Func_message "# ${Var_script_name} finished at: $(date)" '0' '1'
