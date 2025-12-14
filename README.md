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

## 🚀 Usage

```bash
chmod +x bitleaker.sh
./bitleaker.sh
```
