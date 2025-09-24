// UserScript
// @name         userChrome.css Hot Reload
// @namespace    userChrome.js
// @description  Automatically reloads userChrome.css when changes are detected.
// @version      7.0 (Final)
// @include      chrome://browser/content/browser.xhtml
// @grant        none
// /UserScript

(function () {
  "use strict";
  console.log("userChrome hot reload script starting...");

  const RELOAD_DELAY = 200; // ms delay to prevent multiple reloads
  const CHECK_INTERVAL = 2000; // Check every 1 second for changes

  const userChromeReloader = {
    // Track if we're watching for changes
    watching: true,
    watcherId: null,
    reloadTimer: null,
    lastModified: 0,

    // StyleSheetService reference
    sss: null,

    // URI for userChrome.css
    userChromeURI: null,
    userChromeFile: null,

    // Initialize the reloader
    init() {
      try {
        console.log("Initializing userChrome hot reloader...");

        // Get services and components we need
        this.sss = Components.classes[
          "@mozilla.org/content/style-sheet-service;1"
        ].getService(Components.interfaces.nsIStyleSheetService);

        // Get the userChrome.css file path
        const profileDir = Services.dirsvc.get(
          "ProfD",
          Components.interfaces.nsIFile,
        );
        const chromeDir = profileDir.clone();
        chromeDir.append("chrome");

        this.userChromeFile = chromeDir.clone();
        this.userChromeFile.append("userChrome.css");

        console.log("Looking for userChrome.css at:", this.userChromeFile.path);

        if (!this.userChromeFile.exists() || !this.userChromeFile.isFile()) {
          console.log("userChrome.css not found, hot-reload disabled.");
          return false;
        }

        // Create a URI for the userChrome.css file
        this.userChromeURI = Services.io.newFileURI(this.userChromeFile);
        console.log("userChrome.css URI:", this.userChromeURI.spec);

        // Store the initial last modified time
        this.lastModified = this.userChromeFile.lastModifiedTime;

        // Set up the file watcher
        this.startWatching();

        // Set up cleanup on window unload
        window.addEventListener("unload", () => this.cleanup(), { once: true });

        console.log("userChrome hot reload initialized successfully");
        return true;
      } catch (e) {
        console.error("Error initializing userChrome hot reload:", e);
        return false;
      }
    },

    // Start watching for changes to userChrome.css
    startWatching() {
      console.log("Starting to watch userChrome.css for changes...");
      this.watching = true;
      this.checkForChanges();
    },

    // Check for changes to userChrome.css
    checkForChanges() {
      if (!this.watching) return;

      try {
        // Create a new file object to get fresh information
        const tempFile = this.userChromeFile.parent.clone();
        tempFile.append(this.userChromeFile.leafName);

        if (tempFile.exists() && tempFile.isFile()) {
          const currentModified = tempFile.lastModifiedTime;

          if (currentModified > this.lastModified) {
            console.log(
              "userChrome.css change detected",
              "Previous:",
              this.lastModified,
              "Current:",
              currentModified,
            );
            this.lastModified = currentModified;
            this.reloadUserChrome();
          }
        } else {
          console.log("userChrome.css no longer exists");
        }

        // Continue checking
        this.watcherId = setTimeout(
          () => this.checkForChanges(),
          CHECK_INTERVAL,
        );
      } catch (e) {
        console.error("Error checking for userChrome.css changes:", e);
        this.watching = false;

        // Try to recover by restarting the watcher
        setTimeout(() => {
          if (!this.watching) {
            this.watching = true;
            this.watcherId = setTimeout(
              () => this.checkForChanges(),
              CHECK_INTERVAL,
            );
            console.log("Recovered file watcher");
          }
        }, 5000);
      }
    },

    // Reload userChrome.css using multiple methods
    reloadUserChrome() {
      if (this.reloadTimer) {
        clearTimeout(this.reloadTimer);
      }

      this.reloadTimer = setTimeout(() => {
        try {
          console.log("Reloading userChrome.css...");

          // Read the file content to force a fresh load
          const fileContent = this.readUserChromeFile();
          console.log(
            "Read userChrome.css file, length:",
            fileContent ? fileContent.length : 0,
          );

          // Method 1: Use StyleSheetService with both sheet types
          this.reloadWithStyleSheetService();

          // Method 2: Apply CSS directly to document
          this.applyCSSDirect(fileContent);

          // Method 3: Force UI refresh
          this.forceUIRefresh();

          console.log("userChrome.css reload complete");
        } catch (e) {
          console.error("Error reloading userChrome.css:", e);
        }
        this.reloadTimer = null;
      }, RELOAD_DELAY);
    },

    // Reload with StyleSheetService
    reloadWithStyleSheetService() {
      try {
        // Try both USER_SHEET and AGENT_SHEET types
        const sheetTypes = [this.sss.USER_SHEET, this.sss.AGENT_SHEET];

        sheetTypes.forEach((sheetType) => {
          const typeStr =
            sheetType === this.sss.USER_SHEET ? "USER_SHEET" : "AGENT_SHEET";

          // Check if registered and unregister if needed
          if (this.sss.sheetRegistered(this.userChromeURI, sheetType)) {
            console.log(`Unregistering stylesheet (${typeStr})`);
            this.sss.unregisterSheet(this.userChromeURI, sheetType);
          }

          // Register the stylesheet
          console.log(`Registering stylesheet (${typeStr})`);
          this.sss.loadAndRegisterSheet(this.userChromeURI, sheetType);

          // Verify registration
          const isRegistered = this.sss.sheetRegistered(
            this.userChromeURI,
            sheetType,
          );
          console.log(`Stylesheet registered (${typeStr}):`, isRegistered);
        });
      } catch (e) {
        console.error("Error in reloadWithStyleSheetService:", e);
      }
    },

    // Apply CSS directly to document
    applyCSSDirect(cssContent) {
      if (!cssContent) return;

      try {
        // Create a new style element
        const styleId = "userChrome-hot-reload-direct";
        let styleElement = document.getElementById(styleId);

        if (!styleElement) {
          styleElement = document.createElement("style");
          styleElement.id = styleId;
          styleElement.setAttribute("type", "text/css");
          document.documentElement.appendChild(styleElement);
        }

        // Update the stylesheet content
        styleElement.textContent = `/* userChrome.css hot-reload - ${new Date().toISOString()} */\n${cssContent}`;
        console.log("Applied CSS directly to document");
      } catch (e) {
        console.error("Error in applyCSSDirect:", e);
      }
    },

    // Force UI refresh
    forceUIRefresh() {
      try {
        // Method 1: Notification observers
        Services.obs.notifyObservers(null, "chrome-flush-caches", null);
        Services.obs.notifyObservers(null, "chrome-flush-skin-caches", null);
        Services.obs.notifyObservers(null, "startupcache-invalidate", null);

        // Method 2: Animation trick
        document.documentElement.style.animation = "none";
        setTimeout(() => {
          document.documentElement.style.animation = "";
        }, 50);

        // Method 3: Force layout recalculation
        void document.documentElement.offsetHeight;

        console.log("Forced UI refresh");
      } catch (e) {
        console.error("Error in forceUIRefresh:", e);
      }
    },

    // Read userChrome.css file content
    readUserChromeFile() {
      try {
        const fileInputStream = Components.classes[
          "@mozilla.org/network/file-input-stream;1"
        ].createInstance(Components.interfaces.nsIFileInputStream);
        fileInputStream.init(this.userChromeFile, 0x01, 0o444, 0);

        const converterInputStream = Components.classes[
          "@mozilla.org/intl/converter-input-stream;1"
        ].createInstance(Components.interfaces.nsIConverterInputStream);
        converterInputStream.init(fileInputStream, "UTF-8", 1024, 0);

        let content = "";
        let str = {};

        while (converterInputStream.readString(4096, str) != 0) {
          content += str.value;
        }

        converterInputStream.close();
        fileInputStream.close();

        return content;
      } catch (e) {
        console.error("Error reading userChrome.css file:", e);
        return null;
      }
    },

    // Clean up when window closes
    cleanup() {
      console.log("Cleaning up userChrome hot reload...");
      this.watching = false;

      if (this.watcherId !== null) {
        clearTimeout(this.watcherId);
        this.watcherId = null;
      }

      if (this.reloadTimer !== null) {
        clearTimeout(this.reloadTimer);
        this.reloadTimer = null;
      }

      console.log("Stopped watching userChrome.css");
    },
  };

  // Initialize the reloader once the browser is fully loaded
  if (gBrowserInit.delayedStartupFinished) {
    userChromeReloader.init();
  } else {
    let delayedListener = (subject, topic) => {
      if (topic === "browser-delayed-startup-finished" && subject === window) {
        Services.obs.removeObserver(delayedListener, topic);
        userChromeReloader.init();
      }
    };
    Services.obs.addObserver(
      delayedListener,
      "browser-delayed-startup-finished",
    );
  }
})();
