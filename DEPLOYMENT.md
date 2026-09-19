# 📱 How to Run and Play Steve's Diamond Catch (Mac, Windows, iPhone & Android)

This guide outlines how to run and deploy **Steve's Diamond Catch** across **Windows**, **macOS**, and **smartphones**.

---

## 💻 How to Run on a Windows Machine

### 1. Play Directly on Your Windows PC:
- **Zero Installation Required**: Simply double-click **`Play_Game_Windows.bat`** (or right-click `index.html` -> Open with Google Chrome / Microsoft Edge).
- The game runs immediately in full resolution with keyboard controls (`A`/`D` or Arrow keys, `P` for pause, `M` for mute).
- You can also install it as a native desktop app on Windows: in Edge or Chrome, click the **App available / Install** button in the URL address bar to install Steve's Diamond Catch directly to your Windows Start Menu and Taskbar!

### 2. Host from Your Windows PC to Play on a Phone:
- Double-click **`start_server.bat`**.
- It will automatically detect your Windows PC's Wi-Fi IP address and start a local web server on port `8080`.
- Even if Python or Node is **not** installed on your Windows PC, it will automatically fall back to the included **`start_server.ps1`** which runs a native zero-dependency Windows server!
- Open the address shown (e.g. `http://192.168.x.x:8080`) on your phone.

---

## 🍏 How to Run on macOS

1. In your terminal, run:
   ```bash
   ./start_server.sh
   ```
2. Open the printed local URL on your smartphone or browser.

---

## 💡 Frequently Asked Question: "If I turn off the server, will the game still work?"

### 1. While the game is currently open in your browser tab:
**YES!** The game runs 100% on the client side (in browser memory). All graphics, sound synthesizers, collision checks, and touch controls run locally on your device. It never sends ongoing requests back to the server while you are playing.

### 2. If you close and reopen the game, or refresh the page:
**YES, IF SAVED AS A PWA / CACHED!**
Because we included a **Service Worker (`sw.js`)** and **Web App Manifest (`manifest.json`)**:
- The browser caches the entire game locally in your phone's storage after the first visit.
- If you tap **Share -> "Add to Home Screen"** on iOS or **"Install App"** on Android, the game can launch and play **completely offline** — even if your PC is turned off or you have no Wi-Fi/cellular connection!

### 3. When do you need an active server?
- Only when loading the game for the **very first time** on a new device that hasn't cached it yet.
- If you deploy to **GitHub Pages** (Option 2) or **Netlify** (Option 3), it will be hosted in the cloud 24/7 for free, so you never need to keep your PC running!

---

## 🌐 Option 2: Free Worldwide Hosting via GitHub Pages (Recommended)

GitHub Pages hosts static HTML5 games for free with global HTTPS 24/7.

1. **Initialize a Git repository and commit your files**:
   ```bash
   git init
   git add .
   git commit -m "feat: speed config, timer, mobile touch controls, audio, parental lock and PWA"
   ```

2. **Create a new repository on [GitHub](https://github.com/new)** (e.g. `steve-diamond-catch`).

3. **Push your code**:
   ```bash
   git branch -M main
   git remote add origin https://github.com/<your-username>/steve-diamond-catch.git
   git push -u origin main
   ```

4. **Turn on GitHub Pages**:
   - Go to your GitHub repository -> **Settings** -> **Pages**.
   - Under **Build and deployment** -> **Branch**, select `main` and root `/`, then click **Save**.
   - In 1–2 minutes, your game is live 24/7 at:
     ```
     https://<your-username>.github.io/steve-diamond-catch/
     ```
5. Share the link with friends or open it on any mobile device worldwide!

---

## ☁️ Option 3: Deploy via Vercel or Netlify (1-Minute Drag & Drop)

If you prefer a 1-click cloud deployment without command line:

### Using Netlify Drop:
1. Go to [app.netlify.com/drop](https://app.netlify.com/drop).
2. Drag and drop the `Benji` project folder into the browser window.
3. Netlify will generate a live HTTPS URL (e.g., `https://diamond-catch.netlify.app`) instantly.

---

## 📲 Option 4: Install as a Full-Screen App (PWA)

The project includes `manifest.json` and `sw.js`, allowing it to behave like a native smartphone app with no browser address bar:

### On iPhone (Safari):
1. Open the game link in **Safari**.
2. Tap the **Share button** (square with arrow pointing up).
3. Scroll down and tap **Add to Home Screen**.
4. Tap **Add**. A diamond icon will appear on your home screen. Tap it to launch full-screen!

### On Android (Chrome):
1. Open the game link in **Chrome**.
2. Tap the three dots (⋮) in the top-right corner.
3. Tap **Install app** or **Add to Home screen**.
4. Launch the game from your app drawer or home screen in full-screen immersion.
