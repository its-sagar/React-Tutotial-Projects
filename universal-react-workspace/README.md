# Universal React Workspace (JavaScript)

A shared React + Vite workspace for creating multiple **JavaScript** React projects. It uses JSX and `.js`/`.jsx` files—no TypeScript configuration or `.tsx` files.

## Requirements

- Node.js 20+ recommended
- npm 10+ recommended
- Bash: Linux/macOS, WSL, or Git Bash on Windows

## Install dependencies

Run once from the workspace root:

```bash
npm install
```

Shared dependencies are managed in the root `package.json` using npm workspaces.

## Create a project

Interactive:

```bash
npm run create:react
```

Or supply a name:

```bash
npm run create:react -- my-dashboard
```

## Run the project

After generating it, return to the workspace root and install workspace changes:

```bash
npm install
cd projects/my-dashboard
npm run dev
```

Open the local URL printed by Vite, normally `http://localhost:5173`.

## Build

From inside a project:

```bash
npm run build
npm run preview
```

## Shared package

The shared package is located at `packages/universal-package`. Its CSS is imported by generated projects:

```js
import "@universal/react-kit/styles";
```

To add shared components or utilities, place them in the universal package and expose them through its `exports` field. Add commonly used dependencies to the root `package.json` so workspace projects can share the installation.

## Dependency-sharing note

This setup shares compatible dependencies among projects inside this workspace. It does not automatically share dependencies with unrelated folders outside it. Projects should be created under `projects/` to use the workspace installation.
