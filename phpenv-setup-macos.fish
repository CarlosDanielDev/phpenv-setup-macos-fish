#!/usr/bin/env fish

echo "🛠 Installing dependencies via Homebrew..."
brew install \
  bzip2 \
  libiconv \
  tidy-html5 \
  openssl@3 \
  readline \
  libxml2 \
  libzip \
  autoconf \
  automake \
  bison \
  re2c \
  pkg-config \
  icu4c \
  oniguruma \
  grep

echo "📦 Installing phpenv and php-build..."
git clone https://github.com/phpenv/phpenv.git ~/.phpenv
mkdir -p ~/.phpenv/plugins
git clone https://github.com/php-build/php-build.git ~/.phpenv/plugins/php-build

echo "🧼 Adjusting build flags to avoid phar error..."
set config_file ~/.phpenv/plugins/php-build/share/php-build/default_configure_options
if test -f $config_file
  sed -i '' 's/--enable-phar/--disable-phar/g' $config_file
end

echo "📁 Adding config to your Fish Shell..."

set config_fish ~/.config/fish/config.fish

if not grep -q "phpenv" $config_fish
  echo "\n# PHPENV CONFIG" >> $config_fish
  echo "set -x PHPEENV_ROOT \$HOME/.phpenv" >> $config_fish
  echo "set -x PATH \$PHPEENV_ROOT/bin /opt/homebrew/opt/bison/bin /opt/homebrew/opt/grep/libexec/gnubin \$PATH" >> $config_fish
  echo "status --is-interactive; and source (phpenv init -|psub)" >> $config_fish
end

if not grep -q "CPPFLAGS" $config_fish
  echo "\n# PHP BUILD FLAGS" >> $config_fish
  echo "set -x CPPFLAGS \"-I/opt/homebrew/opt/bzip2/include -I/opt/homebrew/opt/libiconv/include -I/opt/homebrew/opt/tidy-html5/include\"" >> $config_fish
  echo "set -x LDFLAGS \"-L/opt/homebrew/opt/bzip2/lib -L/opt/homebrew/opt/libiconv/lib -L/opt/homebrew/opt/tidy-html5/lib\"" >> $config_fish
  echo "set -x PKG_CONFIG_PATH \"/opt/homebrew/opt/bzip2/lib/pkgconfig:/opt/homebrew/opt/libiconv/lib/pkgconfig:/opt/homebrew/opt/tidy-html5/lib/pkgconfig\"" >> $config_fish
end

echo "🔄 Reloading shell config..."
source ~/.config/fish/config.fish

echo "✅ PHP build environment ready!"
echo ""
echo "👉 You can now install PHP using:"
echo ""
echo "CONFIGURE_OPTS=\"--disable-intl --with-bz2=/opt/homebrew/opt/bzip2 --with-iconv=/opt/homebrew/opt/libiconv --with-tidy=/opt/homebrew/opt/tidy-html5\" \\"
echo "phpenv install 8.1.1"
