# linux-startup-status

Portable Linux start-up status banner for Raspberry Pi and desktop systems.

`linux-startup-status` displays key host, network, and system health details in a clean terminal layout. It can be installed as a dynamic MOTD script for SSH and console logins, and it also includes an optional desktop-friendly viewer that waits for a keypress or times out after 10 seconds.

## Features

- host, user, and terminal
- uptime, load averages, memory, and root disk usage
- primary IP and all assigned IPs
- CPU temperature
- Raspberry Pi throttling state when `vcgencmd` is available
- pending APT updates with a one-hour cache
- reboot-required flag
- gateway, WAN reachability, and DNS status
- journal error count for the current boot
- failed systemd unit count
- running process count and logged-in user count

## Project layout

```text
linux-startup-status                         core non-interactive banner script
scripts/install.sh                           install to standard system locations
scripts/uninstall.sh                         remove installed files
scripts/linux-startup-status-viewer          terminal/desktop wrapper with optional pause
desktop/linux-startup-status-viewer.desktop  example desktop launcher
```

## Installation

### Install from the repository

```bash
chmod +x linux-startup-status scripts/*.sh
sudo ./scripts/install.sh
```

### Manual install

```bash
sudo install -d /etc/update-motd.d /usr/local/bin /usr/local/share/applications
sudo install -m 0755 linux-startup-status /etc/update-motd.d/99-linux-startup-status
sudo install -m 0755 linux-startup-status /usr/local/bin/linux-startup-status
sudo install -m 0755 scripts/linux-startup-status-viewer /usr/local/bin/linux-startup-status-viewer
sudo install -m 0644 desktop/linux-startup-status-viewer.desktop /usr/local/share/applications/linux-startup-status-viewer.desktop
```

## Uninstall

```bash
sudo ./scripts/uninstall.sh
```

## Usage

Run the installed banner directly:

```bash
linux-startup-status
```

Run the installed desktop/manual viewer:

```bash
linux-startup-status-viewer
```

Run the MOTD script directly:

```bash
/etc/update-motd.d/99-linux-startup-status
```

Run all dynamic MOTD scripts:

```bash
run-parts /etc/update-motd.d
```

## Desktop viewer behavior

The core banner script never pauses.

The `linux-startup-status-viewer` wrapper is intended for manual terminal launches and desktop shortcuts.

Default behavior:

- SSH session: no pause
- redirected or piped output: no pause
- interactive GUI terminal: waits for any key and times out after 10 seconds

Overrides:

```bash
PAUSE_SECONDS=5 linux-startup-status-viewer
ENABLE_PAUSE=off linux-startup-status-viewer
ENABLE_PAUSE=force PAUSE_SECONDS=15 linux-startup-status-viewer
```

## Platform notes

### Raspberry Pi

On Raspberry Pi systems with `vcgencmd`, the banner reports:

- CPU temperature
- throttling state from `vcgencmd get_throttled`

### Desktop Linux

On systems without `vcgencmd`, throttling displays as `n/a`. Temperature falls back to `/sys/class/thermal/thermal_zone0/temp` when available.

### APT update cache

Pending update counting can be slow if recalculated on every login. The banner caches the count for one hour in:

```text
/run/linux-startup-status-updates.count
/run/linux-startup-status-updates.stamp
```

## Suggested screenshots

```text
screenshots/raspberry-pi-login.png
screenshots/linux-mint-terminal.png
```

## GitHub setup

```bash
git init
git branch -M main
git add .
git commit -m "Initial release"
git remote add origin git@github.com:<your-user>/linux-startup-status.git
git push -u origin main
```

## License

MIT
