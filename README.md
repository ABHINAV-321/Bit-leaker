# Bit Leak 🔥

Bit Leak is a lightweight Bash-based bandwidth usage and network stress tool.

It continuously downloads **large public files from the internet** and **deletes them immediately after download**.  
This process repeats indefinitely, causing continuous bandwidth consumption **without storing any files on disk**.

⚠️ **This tool does NOT keep downloaded data. Files are deleted automatically.**

---

## ⚙️ How Bit Leak Works

1. Randomly selects a large public file (ISO / binary / test files)
2. Downloads the file silently in the background
3. Measures the data transferred in real time
4. Deletes the file immediately after download
5. Repeats the process endlessly

👉 **Bandwidth is consumed only by downloading, not by storage.**

---

## ✨ Features

- Continuous bandwidth usage
- Downloads large files from public mirrors
- Automatically deletes files after download
- No progress bar or download spam
- Live total data usage counter
- Live speed (MB/s)
- Elapsed session time
- Counts partial downloads
- CTRL+C safe summary
- Linux & Termux compatible
- No disk space usage buildup

---

## 📦 Requirements

- bash
- curl (preferred)
- wget (fallback)
- awk
- stat (coreutils)

All are preinstalled on most Linux systems and Termux.

---

## 📥 Installation

### 🔹 Termux (Android)

```bash
pkg update && pkg upgrade -y 
git clone https://github.com/ABHINAV-321/bit-leaker.git
cd bit-leaker
chmod +x bitleaker.sh
```


---

🔹 Linux (Ubuntu / Debian / Kali / Mint)

```
sudo apt update -y
git clone https://github.com/ABHINAV-321/bit-leaker.git
cd bit-leaker
chmod +x bitleaker.sh
```


---

🚀 Usage

```
cd bit-leaker
./bitleaker.sh
```

---

🔖 Command Line Options

Option	Description

--version	Show tool version

--update	Self-update from GitHub



---

📊 Live Display

During execution, Bit Leak shows:
```
Used: 842.51 MB (0.82 GB) | Speed: 2.94 MB/s | Time: 00:09:41
```

Used → Total bandwidth consumed since start

Speed → Current download speed

Time → Total running time



---

🛑 Stopping the Tool

Press CTRL + C at any time.

You will see a clean summary showing:

Total data used (bytes / MB / GB)

Session end message



---

⚠️ Disclaimer

This tool is intended for:

Network testing

Bandwidth monitoring

Educational purposes


Do NOT use it on networks where excessive bandwidth usage is restricted or prohibited.

The author is not responsible for misuse.


---

👤 Author

Created by Abhinav
GitHub: https://github.com/ABHINAV-321


---

📜 License

MIT License

---
