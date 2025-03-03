#!/usr/bin/env bash

# Verzeichnis vorbereiten
cd /home/user
rm -rf myplaywright
mkdir myplaywright
cd myplaywright

# Node.js-Projekt initialisieren und Playwright installieren
npm init -y
npm install playwright@latest
npx playwright install chromium

# Playwright-Testskript erstellen
echo '
const { chromium } = require("playwright");

async function main() {
    const browser = await chromium.launch({ headless: true });
    const context = await browser.newContext();
    const page = await context.newPage();

    page.on("console", (msg) => console.log(msg.text()));
    page.on("load", () => console.log("Seite geladen"));

    await page.goto("http://haproxy:80", { waitUntil: "networkidle" });  // Warten, bis alle Netzwerkanfragen abgeschlossen sind
    await page.waitForTimeout(5000);  // 5 Sekunden warten

    await page.screenshot({ path: "/home/user/myplaywright/screenshot.png", fullPage: true });
    console.log("Screenshot gespeichert!");

    await browser.close();
}

main();
' > playwright-test.js

# Playwright-Test ausführen
time node playwright-test.js

