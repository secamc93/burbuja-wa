#!/usr/bin/env bash
# Instala la burbuja: enlace en ~/.local/bin, inicio automático y atajo Super+W.
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"

sudo_falta=()
if ! python3 -c 'import gi; gi.require_version("WebKit2", "4.1")' 2>/dev/null &&
   ! python3 -c 'import gi; gi.require_version("WebKit2", "4.0")' 2>/dev/null; then
  if apt-cache show gir1.2-webkit2-4.1 >/dev/null 2>&1; then sudo_falta+=(gir1.2-webkit2-4.1); else sudo_falta+=(gir1.2-webkit2-4.0); fi
fi
python3 -c 'import cairo' 2>/dev/null || sudo_falta+=(python3-gi-cairo)
if ((${#sudo_falta[@]})); then
  echo "Instalando dependencias: ${sudo_falta[*]}"
  sudo apt install -y "${sudo_falta[@]}"
fi

mkdir -p ~/.local/bin ~/.config/autostart
ln -sf "$DIR/burbuja-wa" ~/.local/bin/burbuja-wa

cat > ~/.config/autostart/burbuja-wa.desktop <<DESK
[Desktop Entry]
Type=Application
Name=Burbuja WhatsApp
Comment=Burbuja flotante con WhatsApp Web propio
Exec=$HOME/.local/bin/burbuja-wa
Icon=$DIR/assets/wa-icono.svg
X-GNOME-Autostart-enabled=true
X-GNOME-Autostart-Delay=3
DESK

# atajo Super+W -> burbuja-wa --toggle
BASE=org.gnome.settings-daemon.plugins.media-keys
RUTA=/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/burbuja-wa/
LISTA=$(gsettings get $BASE custom-keybindings)
# si ya hay un atajo con Super+W, se reutiliza en vez de crear otro que choque
for r in $(grep -o "'[^']*'" <<<"$LISTA" | tr -d "'"); do
  [[ $(gsettings get $BASE.custom-keybinding:$r binding) == "'<Super>w'" ]] && RUTA=$r
done
if [[ $LISTA != *"$RUTA"* ]]; then
  if [[ $LISTA == "@as []" || $LISTA == "[]" ]]; then LISTA="['$RUTA']"; else LISTA="${LISTA%]}, '$RUTA']"; fi
  gsettings set $BASE custom-keybindings "$LISTA"
fi
gsettings set $BASE.custom-keybinding:$RUTA name "Burbuja WhatsApp"
gsettings set $BASE.custom-keybinding:$RUTA command "$HOME/.local/bin/burbuja-wa --toggle"
gsettings set $BASE.custom-keybinding:$RUTA binding "<Super>w"

echo "Listo. Ejecuta: burbuja-wa"
