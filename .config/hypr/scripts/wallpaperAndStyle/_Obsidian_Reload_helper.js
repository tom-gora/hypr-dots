#!/usr/bin/env node

const { spawn } = require("child_process");

const openUri = (uri) => {
  return new Promise((resolve, reject) => {
    const child = spawn("xdg-open", [uri]);
    child.on("close", (code) => {
      if (code === 0) {
        resolve();
      } else {
        reject(new Error(`Failed to open URI: ${uri}`));
      }
    });
  });
};

const uri =
  "obsidian://adv-uri?eval=app%2Ecommands%2EexecuteCommandById%28%22editor%3Asave-file%22%29%3Blet%20file%3Dthis%2Eapp%2Eworkspace%2EgetActiveFile%28%29%3Bif%28%21file%29%7Bnew%20Notice%28%22No%20active%20file%20found%2E%22%29%3Bapp%2Ecommands%2EexecuteCommandById%28%27app%3Areload%27%29%3B%7Delse%7Bconst%20filePath%3Dfile%2Epath%3Bapp%2Ecommands%2EexecuteCommandById%28%27app%3Areload%27%29%3B%7D";

async function main() {
  try {
    await openUri(uri);
  } catch (error) {}
}

main();
