# Parinoid_WiFi

> A `Bash` script that writes OpenVPN server or client configuration files and
> aims to make setup of new servers or clients a simple or automated process.

## How to download the latest version

> Make a local directory for downloads and change the current working directory
> for your terminal to it.

```
mkdir ~/github_clones
cd ~/github_clones
echo "${PWD}"
## Example report: /home/<user>/github_clones
```

> Clone the latest version of the project's `master` branch

```
git clone https://github.com/S0AndS0/Perinoid_WiFi
```

> Change the current working directory of your terminal yet again to the new
> downloaded directory.

```
cd Perinoid_WiFi/
```

> In the future you may use the following command from within this directory to
> download updated versions of this project.

```
git fetch https://github.com/S0AndS0/Perinoid_WiFi
## Or to download all branches
#git fetch --all
```

## How to setup a new server

> The following steps maybe used to setup a new OpenVPN server instance on nearly
> any Debian based distrobution.

### Variables for server only configuration

```
Var_local_ip="$(ip addr | awk '/inet/{print $2}' | grep -vE '127' | awk '{gsub("/"," "); print $1}' | head -n1)"
Var_external_ip="$(dig +short myip.opendns.com @resolver1.opendns.com)"
Var_listen_port="9988"
```

> Find examples of above variables and usage with script call bellow within the
> [`script_configure_server_only.sh`](.travis-ci/script_configure_server_only.sh)
> script used by Travis-CI for automaticly build testing this project.

### Command to issue for server only setup

```
sudo ./Paranoid_WiFi.sh\
 --debug-level='9'\
 --ovpns-config-yn='yes'\
 --ovpns-auto-start-yn='yes'\
 --ovpns-listen-ip="${Var_local_ip}"\
 --ovpns-listen-port="${Var_listen_port}"
```

> The above command will output every action taken to your terminal as it happens
> because the command line option `--debug-level='9'` determins script verbosity.
> End results are that dependancies are installed (or updated), a new config file
> will be saved by default to `/etc/openvpn/openvpn.conf`, and the server is
> restarted.

## How to configure clients

> The following steps maybe repeated for every client or by using a comma (`,`)
> seperated list of client names saved to `Var_client_users_list` variable or
> `--ovpnc-names` command line option bellow.

### Variables to be used for setting up client configs on server

```
Var_local_ip="$(ip addr | awk '/inet/{print $2}' | grep -vE '127' | awk '{gsub("/"," "); print $1}' | head -n1)"
Var_external_ip="$(dig +short myip.opendns.com @resolver1.opendns.com)"
Var_external_port="9988"
Var_client_users_list="alice,bob,jack,etc..."
```

> Find examples of above variables and usage with script call bellow within the
> [script_configure_clients_only.sh](.travis-ci/script_configure_clients_only.sh)
> script used by Travis-CI for automaticly build testing this project.

```
sudo ./Paranoid_WiFi.sh\
 --debug-level='9'\
 --ovpnc-config-yn='yes'\
 --ovpnc-pass-yn='yes'\
 --ovpnc-host-ports="${Var_external_ip}:${Var_external_port}"\
 --ovpnc-names="${Var_client_users_list}"
```

> Resulting client configs and related user/pass file will be saved to directory
> `OVPNC_configs` under the current working directory which maybe transfered to
> clients for use and internal VPN used IP addresses will be appended to
> `/etc/openvpn/ipp.txt` file for each client username listed.
