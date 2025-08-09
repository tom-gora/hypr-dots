#!/usr/bin/env node

const { spawn } = require("child_process");

function openUri(uri) {
  return new Promise((resolve, reject) => {
    command = "xdg-open";
    const child = spawn(command, [uri]);
    child.on("close", (code) => {
      if (code === 0) {
        resolve();
      } else {
        reject(new Error(`Failed to open URI: ${uri}`));
      }
    });
  });
}

async function main() {
  const commands = [
    "obsidian://adv-uri?commandname=Save%20current%20file",
    "obsidian://adv-uri?commandname=Reload%20app%20without%20saving",
  ];

  try {
    for (const uri of commands) {
      await openUri(uri);
    }
  } catch (error) {
    console.error("Error executing commands:", error);
    exit(1);
  }
  exit(0);
}

main();
