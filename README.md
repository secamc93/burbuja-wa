# burbuja-wa

Burbuja flotante de WhatsApp para Linux (GNOME / X11), estilo "chat head".
Un solo proceso en Python + GTK3 + WebKitGTK que carga WhatsApp Web; no depende
de ZapZap ni de otro cliente.

## Qué hace

- **Burbuja** con el logo de WhatsApp, siempre encima y en todos los escritorios.
  Muestra el número de mensajes sin leer.
  - Clic: abre el chat / lo trae al frente / lo oculta.
  - Arrastrar: mueve la burbuja (el chat abierto la sigue).
  - Clic derecho: menú (abrir, chat siempre encima, recargar, salir).
- **Ventana del chat** sin bordes del sistema, con esquinas redondeadas y barra propia:
  - Arrastrar la barra: mover. Doble clic: maximizar / restaurar.
  - Bordes y esquinas: redimensionar.
  - Botones: alejar, acercar, recargar, siempre encima, minimizar, maximizar, ocultar.
  - Recuerda posición, tamaño, zoom y "siempre encima".
- **Modo compacto** (`assets/compacto.css` + `compacto.js`): en ventanas angostas
  WhatsApp Web se muestra en una sola columna con botón para volver a la lista.
- Notificaciones de escritorio, micrófono para notas de voz, descargas a
  `~/Descargas`, enlaces externos en el navegador.

## Atajos

| Tecla | Acción |
|---|---|
| `Super+W` | abrir / ocultar el chat |
| `Ctrl +` / `Ctrl -` / `Ctrl 0` | zoom (0 = 115 %) |
| `Ctrl R` / `F5` | recargar |

## Instalar

```bash
./instalar.sh
burbuja-wa
```

Requiere `python3-gi`, `python3-gi-cairo` y `gir1.2-webkit2-4.0` (Ubuntu 22.04).
La primera vez hay que escanear el QR con el celular.

## Archivos en tu equipo

- `~/.config/burbuja-wa/estado.json`: posición, tamaño y zoom.
- `~/.local/share/burbuja-wa/`: sesión de WhatsApp Web (cookies, IndexedDB, caché).

## Ajustes rápidos

Constantes al inicio de `burbuja-wa`: `TAM` (diámetro de la burbuja), `RADIO`
(redondeo del chat), `ZOOM` (zoom por defecto), `CHAT_ANCHO` / `CHAT_ALTO`.

El logo viene de [Simple Icons](https://simpleicons.org/) (CC0). WhatsApp es una
marca de Meta; este proyecto no está afiliado.
