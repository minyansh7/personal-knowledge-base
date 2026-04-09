// ingest.js — Minyan's Wiki QuickAdd macro
// Place this file in scripts/ and point QuickAdd's Script step to scripts/ingest.js
// Calls scripts/ingest.sh with the currently open file's absolute path.

const INGEST_SCRIPT = "/Users/minyan/Minyan's Wiki/scripts/ingest.sh";

module.exports = async (params) => {
  const file = params.app.workspace.getActiveFile();

  if (!file) {
    new Notice("No file is currently open.");
    return;
  }

  const filePath = params.app.vault.adapter.getFullPath(file.path);

  // Only allow files inside raw/ subfolders
  if (!filePath.includes("/raw/")) {
    new Notice(`Not a raw/ file — skipping ingest.\n${file.name}`);
    return;
  }

  const { exec } = require("child_process");

  new Notice(`Ingesting: ${file.name}`);

  exec(`bash "${INGEST_SCRIPT}" "${filePath}"`, (error, stdout, stderr) => {
    if (error) {
      new Notice(`Ingest failed. Check scripts/watcher.log for details.`);
      console.error("[ingest.js] error:", error.message);
      console.error("[ingest.js] stderr:", stderr);
    } else {
      new Notice(`Ingest complete: ${file.name}`);
      console.log("[ingest.js] stdout:", stdout);
    }
  });
};
