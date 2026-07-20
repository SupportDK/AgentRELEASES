#!/usr/bin/env bash
#
# install-build-toolchain.sh
# Instala el toolchain necesario para empaquetar plugins WordPress en este workspace
# (php, composer, wp-cli + dist-archive, zip). Pensado para Ubuntu/Debian.
#
# Uso: revisa y ejecuta por bloques, o entero:  bash install-build-toolchain.sh
# Requiere sudo.

set -e

# ─────────────────────────────────────────────────────────────
# Paso 1 — PHP CLI + extensiones típicas de plugins WP, y zip/unzip/git
#          (NECESARIO)  [YA EJECUTADO]
# ─────────────────────────────────────────────────────────────
sudo apt update
sudo apt install -y php-cli php-zip php-mbstring php-xml php-curl unzip zip git

# ─────────────────────────────────────────────────────────────
# Paso 2 — Composer (NECESARIO)
#   Genera vendor/ a partir de composer.json/composer.lock.
#   Sin vendor/ (Action Scheduler) el plugin da fatal error al activar.
# ─────────────────────────────────────────────────────────────
php -r "copy('https://getcomposer.org/installer','/tmp/composer-setup.php');"
sudo php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
rm /tmp/composer-setup.php

# ─────────────────────────────────────────────────────────────
# Paso 3 — WP-CLI (RECOMENDADO)
#   Lo usan /release y /package (wp dist-archive) y make-pot (wp i18n make-pot).
# ─────────────────────────────────────────────────────────────
curl -sSLo /tmp/wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x /tmp/wp-cli.phar
sudo mv /tmp/wp-cli.phar /usr/local/bin/wp

# ─────────────────────────────────────────────────────────────
# Paso 4 — Comando dist-archive para WP-CLI (RECOMENDADO)
#   OJO: las versiones nuevas (v3.x / dev-main) exigen WP-CLI ^2.13.
#   Con WP-CLI 2.12 hay que fijar la v2.0.1 (compatible). Si actualizas
#   WP-CLI a 2.13+ podrás usar la última: wp package install wp-cli/dist-archive-command
# ─────────────────────────────────────────────────────────────
wp package install wp-cli/dist-archive-command:v2.0.1

# ─────────────────────────────────────────────────────────────
# Verificación
# ─────────────────────────────────────────────────────────────
php -v && composer --version && wp --version && wp help dist-archive >/dev/null && echo "dist-archive OK"

echo
echo "Toolchain listo. Empaquetado nativo de un plugin (ejemplo Orders Sync 1.1.0):"
echo "  cd repos/orders-sync-to-airtable-for-woocommerce"
echo "  composer install --no-dev --optimize-autoloader   # crea vendor/ (Action Scheduler)"
echo "  wp dist-archive ./ --plugin-dirname=orders-sync-to-airtable-for-woocommerce"
echo "  mv orders-sync-to-airtable-for-woocommerce.1.1.0.zip ../../dist/"
