# Antigravity AutoUpdate

![Antigravity AutoUpdate](assets/antigravity-autoupdate.svg)

Automatic updater for Google Antigravity Hub on Linux x64.

## Features

- Detects the current Linux x64 release from the official Antigravity download page.
- Does not hard-code a build number.
- Downloads the official Google Cloud Storage archive.
- Validates gzip and tar before installation.
- Stages the new version before replacing the installation.
- Maintains `~/.local/bin/antigravity`.
- Provides a CLI for checking, updating and inspecting the installation.
- Provides user-level systemd service/timer files.
- No root privileges are required.

## Installation

```bash
git clone https://github.com/AnARCHIS12/antigravity-autoupdate.git
cd antigravity-autoupdate
./install.sh
```

## CLI

```bash
antigravity-autoupdate check
antigravity-autoupdate update
antigravity-autoupdate status
antigravity-autoupdate install-systemd
antigravity-autoupdate uninstall-systemd
```

## Architecture

The updater reads the official download page and accepts only the expected Linux x64 archive path:

```text
https://storage.googleapis.com/antigravity-public/antigravity-hub/<release>/linux-x64/Antigravity.tar.gz
```

This project targets the Antigravity Hub desktop application, not the separate `agy` CLI.

## Systemd

The default timer checks every six hours.

```bash
systemctl --user status antigravity-update.timer --no-pager
systemctl --user list-timers antigravity-update.timer --no-pager
journalctl --user -u antigravity-update.service --no-pager
```

## KDE

The updater does not modify Plasma's launcher. A desktop entry can execute:

```text
/home/USER/.local/bin/antigravity %U
```

## Official resources

- https://antigravity.google/
- https://antigravity.google/download
- https://antigravity.google/changelog

## License

MIT
