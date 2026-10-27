import React from "react";
import { createRoot } from "react-dom/client";
import Greeting from "./Greeting";

function App() {
  return (
    <main>
      <div>
        <Greeting name='Priya'/>
        <Greeting name='Rahul'/>
      </div>
    </main>
  );
}

createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
