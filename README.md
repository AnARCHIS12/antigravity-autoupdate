# Antigravity AutoUpdate

<p align="center">
  <img src="assets/antigravity-autoupdate.svg" alt="Antigravity AutoUpdate" width="120">
</p>

**Automatic updater for Google Antigravity Hub on Linux x64.**

Antigravity AutoUpdate keeps the **Antigravity Hub desktop application** up to date without requiring root privileges. It checks Google's official download page, detects the latest Linux x64 release, downloads the corresponding archive and installs it in the user's home directory.

> **Important:** this project updates **Antigravity Hub**, the graphical desktop application. It does **not** update the separate `agy` command-line tool.

## Features

- Detects the latest Linux x64 release directly from the official Antigravity download page.
- Does not hard-code a specific build number.
- Downloads the official Google Cloud Storage archive.
- Checks that the downloaded `.tar.gz` archive is valid before installation.
- Replaces the installed version automatically when an update is available.
- Keeps a stable executable at `~/.local/bin/antigravity`.
- Provides a simple CLI for checking, updating and inspecting the installation.
- Can install a user-level systemd timer that checks every six hours.
- Does not require `sudo` or system-wide installation.

## Installation

Clone the repository and run the installer:

```bash
git clone https://github.com/AnARCHIS12/antigravity-autoupdate.git
cd antigravity-autoupdate
./install.sh
```

The installer places the updater here:

```text
~/.local/bin/antigravity-autoupdate
```

It then performs an initial version check.

### If the shell says "Permission denied"

The installer is a shell script and must be executable. If your local clone does not preserve the executable permission, you can launch it explicitly with Bash:

```bash
bash install.sh
```

For a repository clone, the expected Git file mode is **100755** for both:

```text
install.sh
bin/antigravity-autoupdate
```

## CLI

After installation, use:

```bash
antigravity-autoupdate check
```

Checks the installed version and the latest version published by Google.

```bash
antigravity-autoupdate update
```

Checks for a newer release and installs it when available.

```bash
antigravity-autoupdate status
```

Displays the local installation and updater status.

```bash
antigravity-autoupdate install-systemd
```

Installs and enables the user-level systemd timer for automatic checks every six hours.

```bash
antigravity-autoupdate uninstall-systemd
```

Removes the user-level automatic update timer.

## What the updater does

When an update is requested, the updater:

1. Reads the official Antigravity download page.
2. Finds the official Linux x64 archive.
3. Determines the published release version.
4. Compares it with the installed version.
5. Downloads the archive only when an update is needed.
6. Verifies the `gzip` and `tar` archive structure.
7. Extracts the new installation.
8. Replaces the previous Antigravity installation.
9. Updates the stable `~/.local/bin/antigravity` symlink.

The installed application is kept under:

```text
~/.local/opt/Antigravity-x64/
```

The updater itself is kept under:

```text
~/.local/bin/antigravity-autoupdate
```

## Architecture

The updater reads:

```text
https://antigravity.google/download
```

and accepts only the expected official Linux x64 archive pattern:

```text
https://storage.googleapis.com/antigravity-public/antigravity-hub/<release>/linux-x64/Antigravity.tar.gz
```

This avoids relying on a hard-coded build number and allows the updater to follow new releases published by Google.

## Automatic updates with systemd

The optional user-level timer checks for updates every six hours.

Check the timer:

```bash
systemctl --user status antigravity-update.timer --no-pager
```

Show the next scheduled check:

```bash
systemctl --user list-timers antigravity-update.timer --no-pager
```

View the updater logs:

```bash
journalctl --user -u antigravity-update.service --no-pager
```

The updater runs as the current user, so `sudo` is not required.

## KDE Plasma

The updater does not modify the Plasma panel or taskbar.

A KDE desktop entry can launch Antigravity through:

```text
/home/USER/.local/bin/antigravity %U
```

The application itself is installed separately from the updater.

## Troubleshooting

### Check the installed version

```bash
antigravity-autoupdate status
```

### Run an update manually

```bash
antigravity-autoupdate update
```

### Check the systemd timer

```bash
systemctl --user status antigravity-update.timer --no-pager
```

### Read the logs

```bash
journalctl --user -u antigravity-update.service --no-pager
```

## Official resources

- https://antigravity.google/
- https://antigravity.google/download
- https://antigravity.google/changelog

## License

MIT
