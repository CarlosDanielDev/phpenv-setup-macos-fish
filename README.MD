# 📘 phpenv-setup-macos.fish

A complete Fish Shell setup script to build PHP with phpenv on macOS (M1/M2/M3) — with all the annoying dependencies and compiler issues already taken care of.

## Stop suffering to compile PHP on Apple Silicon. Run this once and get back to coding.

## ⚡️ Why use this?
Compiling PHP with phpenv on macOS (especially Apple Silicon) can be a nightmare — missing libraries, broken flags, ICU errors, and obscure phar.phar build failures.

> This script solves it all:

- Installs all required Homebrew dependencies
- Clones phpenv and php-build
- Sets correct `CPPFLAGS`, `LDFLAGS`, `PKG_CONFIG_PATH`
- Patches known PHP build errors (like phar.phar)
- Adds persistent shell config for Fish

## 🧰 Requirements
- macOS (tested on M1, M2, M3)
- Fish Shell
- Homebrew installed

## 🚀 How to use
1. Download the script

```bash
curl -O https://raw.githubusercontent.com/CarlosDanielDev/phpenv-setup-macos-fish/main/phpenv-setup-macos.fish
````

2. Make it executable
```bash
chmod +x phpenv-setup-macos.fish
````

3. Run the script

```bash
./phpenv-setup-macos.fish
````

## ✅ Installing PHP
After setup, you can install PHP like this:

```bash
CONFIGURE_OPTS="--disable-intl \
  --with-bz2=/opt/homebrew/opt/bzip2 \
  --with-iconv=/opt/homebrew/opt/libiconv \
  --with-tidy=/opt/homebrew/opt/tidy-html5" \
phpenv install 8.1.1
````

Swap 8.1.1 for the version you need (use phpenv install --list to see all options).

## 🧼 Bonus: Clean and reset a failed build

```bash
rm -rf ~/.phpenv/versions/8.1.1
rm -rf /var/tmp/php-build/source/8.1.1

````

## 💬 Troubleshooting
If you get an error like:

phar.phar: Error 255 → already patched by this script with `--disable-phar`

ICU template error → upgrade to PHP 8.2+ or disable intl

bzip2 not found → make sure the flags are applied correctly

Fish config not reloading → try running `source ~/.config/fish/config.fish` manually

## ✨ Credits
Created by @CarlosDanielDev after hours of fighting the PHP build on macOS.
Feel free to fork, star, open issues or PRs 🙌

# phpenv-setup-macos-fish
