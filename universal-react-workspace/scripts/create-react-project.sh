#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROJECT_NAME="${1:-}"

if [[ -z "$PROJECT_NAME" ]]; then
  read -rp "Project name (e.g. dashboard): " PROJECT_NAME
fi

if [[ ! "$PROJECT_NAME" =~ ^[a-zA-Z0-9][a-zA-Z0-9._-]*$ ]]; then
  echo "Invalid project name. Use letters, numbers, dots, underscores, or hyphens."
  exit 1
fi

PROJECT_DIR="$ROOT_DIR/projects/$PROJECT_NAME"
if [[ -e "$PROJECT_DIR" ]]; then
  echo "Error: $PROJECT_DIR already exists."
  exit 1
fi

mkdir -p "$PROJECT_DIR/src"

cat > "$PROJECT_DIR/package.json" <<EOF
{
  "name": "$PROJECT_NAME",
  "private": true,
  "version": "1.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview"
  },
  "dependencies": {
    "@universal/react-kit": "file:../../packages/universal-package"
  }
}
EOF

cat > "$PROJECT_DIR/index.html" <<'EOF'
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>React Project</title>
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.jsx"></script>
  </body>
</html>
EOF

cat > "$PROJECT_DIR/src/main.jsx" <<'EOF'
import React from "react";
import { createRoot } from "react-dom/client";
import "@universal/react-kit/styles";
import "./style.css";

function App() {
  return (
    <main className="container">
      <span className="eyebrow">Universal React Workspace</span>
      <h1>Your React project is ready.</h1>
      <p>This JavaScript project uses shared React dependencies and styles from the universal package.</p>
      <button onClick={() => alert("It works!")}>Test interaction</button>
    </main>
  );
}

createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
EOF

cat > "$PROJECT_DIR/src/style.css" <<'EOF'
.container { max-width: 760px; margin: 12vh auto; padding: 32px; }
.eyebrow { color: #5b5bd6; font-size: .8rem; font-weight: 700; text-transform: uppercase; letter-spacing: .12em; }
h1 { font-size: clamp(2rem, 5vw, 3.5rem); margin: 16px 0; letter-spacing: -.04em; }
p { color: #596174; line-height: 1.7; }
button { border: 0; border-radius: 10px; padding: 12px 18px; background: #4f46e5; color: white; cursor: pointer; }
button:hover { background: #4338ca; }
EOF

cat > "$PROJECT_DIR/vite.config.js" <<'EOF'
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

export default defineConfig({
  plugins: [react()],
  server: {
    host: "localhost",
    port: 5173,
    strictPort: false
  }
});
EOF

echo "Created: $PROJECT_DIR"
echo
echo "Next steps:"
echo "  1. Return to workspace root: cd \"$ROOT_DIR\""
echo "  2. Install/update workspace dependencies: npm install"
echo "  3. Start project: cd \"projects/$PROJECT_NAME\" && npm run dev"
