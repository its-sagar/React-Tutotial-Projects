import React from "react";
import { createRoot } from "react-dom/client";
import Greeting from "./greeting";

function App() {
  return (
    <main>
      <div>
        <Greeting />
      </div>
    </main>
  );
}

createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
