#!/usr/bin/env bash
set -euo pipefail

: "${FILEBROWSER_URL:?Set FILEBROWSER_URL}"
: "${IDE_DEFAULT_DIR:=/workspace}"

mkdir -p "$IDE_DEFAULT_DIR"

NAV_DIR="${HOME}/nav"
mkdir -p "$NAV_DIR"
cat > "${NAV_DIR}/index.html" <<EOF
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>UNITN DevPack</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <style>
    body{font-family:system-ui,-apple-system,Segoe UI,Roboto,Ubuntu,Arial,sans-serif;max-width:820px;margin:40px auto;padding:0 16px}
    h1{font-size:28px;margin:0 0 16px}
    .grid{display:grid;grid-template-columns:1fr 1fr;gap:16px;margin-top:24px}
    a.card{display:block;padding:20px;border:1px solid #ddd;border-radius:12px;text-decoration:none;color:#111}
    a.card:hover{box-shadow:0 4px 24px rgba(0,0,0,.08)}
    .muted{color:#666;font-size:14px;margin-top:6px}
    code{background:#f6f8fa;padding:2px 6px;border-radius:6px}
  </style>
</head>
<body>
  <h1>UNITN DevPack</h1>
  <div class="grid">
    <a class="card" href="/ide/" target="_self">
      <strong>Open IDE (code-server)</strong>
      <div class="muted">Workspace<code>${IDE_DEFAULT_DIR}</code></div>
    </a>
    <a class="card" href="/files/" target="_self">
      <strong>Open Files</strong>
      <div class="muted">FileBrowser/div>
    </a>
  </div>
</body>
</html>
EOF

nohup code-server "${IDE_DEFAULT_DIR}" >/tmp/code-server.log 2>&1 &

export NAV_DIR
export FILEBROWSER_URL
caddy run --config /etc/caddy/Caddyfile --adapter caddyfile