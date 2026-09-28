# ubuntu_change_ip_script

Bash script to switch an Ubuntu server from DHCP to a **static IP** via netplan.

What it does:

1. Auto-detects the default network interface
2. Backs up the current netplan config to `/etc/netplan/backup-<date>/`
3. Writes a new `/etc/netplan/01-netcfg.yaml` with your static IP, gateway, and DNS
4. Applies the config and prints the resulting interface state

## Usage

Edit the three values at the top of `ipstatic.sh`:

```bash
ip_address="192.168.0.235/24"   # your desired static IP
gateway="192.168.0.1"           # your gateway
dns_servers="192.168.0.1,8.8.8.8"
```

Then run:

```bash
sudo bash ipstatic.sh
```

## Notes

- Requires **netplan** (default on Ubuntu 18.04+ server)
- The backup of the old config goes to `/etc/netplan/backup-<date>-<time>/` — restore it from there if something goes wrong
- Double-check the IP/gateway before running: a wrong gateway will cut off remote access

## License

[MIT](LICENSE)
