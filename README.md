<h1 align="center"> SUDARSHAN </h1>  
<h3 align="center">A Next-Generation Digital Forensics Framework </h3>  

<p align="center">
  <img src="https://img.shields.io/badge/Author-CYBER--4RMY-blue?style=for-the-badge&logo=github" />
  <img src="https://img.shields.io/badge/Built%20With-Bash-orange?style=for-the-badge&logo=gnubash" />
  <img src="https://img.shields.io/badge/License-MIT-green?style=for-the-badge" />
  <img src="https://img.shields.io/badge/Platform-Linux%20%7C%20Unix-lightgrey?style=for-the-badge&logo=linux" />
</p>

---

## 🔮 Why SUDARSHAN?  
Digital forensics should be **powerful, portable, and panic-free**.  
SUDARSHAN is designed as a **command-line, interactive, case-driven forensic framework** — an **Autopsy GUI alternative** without the bloat.  

- **One command. One interface. Infinite possibilities.**  
- Modular design for every phase of an investigation.  
- Built entirely in **Bash** for maximum transparency and portability.  

> ⚡ *Think of it as a forensic Swiss Army knife — compact, sharp, and reliable.*  

---

## 🚀 Key Highlights  

✅ **Single Entry Point** → Everything runs from `main.sh`  
✅ **Fully Interactive** → No commands to memorize; guided menus like a GUI  
✅ **Case Management** → Organized, professional workflow  
✅ **12 Core Modules** → Imaging, Malware, Memory, Network, Reporting & more  
✅ **Reports in Markdown** → Easy to convert to HTML/PDF  
✅ **Lightweight & Transparent** → No dependencies beyond standard tools  
✅ **Autopsy Replacement** → Same logic, CLI speed  

---

## 🏗️ Architecture  

```bash
SUDARSHAN/
│── cases/                   # Case data storage
│
├── core/                    # Core engine
│   ├── case_manager.sh       # Manage forensic cases
│   ├── logging.sh            # Unified logging
│   └── ui.sh                 # Interactive UI engine
│
├── modules/                 # Independent forensic modules
│   ├── 01_imaging.sh         # Disk imaging
│   ├── 02_fs_analysis.sh     # File system analysis
│   ├── 03_carving.sh         # Data carving
│   ├── 04_hashing.sh         # Hash verification
│   ├── 05_keyword.sh         # Keyword search
│   ├── 06_timeline.sh        # Timeline generation
│   ├── 07_artifacts.sh       # Artifact extraction
│   ├── 08_malware.sh         # Malware analysis
│   ├── 09_memory.sh          # Memory forensics
│   ├── 10_network.sh         # Network forensics
│   ├── 11_cloud_mobile.sh    # Cloud & mobile forensics
│   └── 12_reporting.sh       # Automated report generation
│
├── reports/                 # Case reports
│
├── LICENSE
├── main.sh                  # 🚀 Master launcher
└── README.md
````

---

## 🎮 How to Use

1️⃣ **Clone the repository**

```bash
git clone https://github.com/CYBER-4RMY/SUDARSHAN.git
cd SUDARSHAN
```

2️⃣ **Set permissions**

```bash
chmod +x main.sh
```

3️⃣ **Launch the framework**

```bash
./main.sh
```

💡 From here, you’ll enter a **menu-driven interactive mode** that guides you through:

* Case setup & management
* Disk imaging & file system analysis
* Malware, memory, and network forensics
* Artifact discovery
* Automated reporting

---

## 🖥️ Example Interface

```text
╔════════════════════════════════════════════════════════════════════╗
║     🚀 SUDARSHAN FORENSIC FRAMEWORK   v6.0                         ║
╠════════════════════════════════════════════════════════════════════╣
   <<-  CASE: 001       | MODULES: 12   | USER: groot          ->>
╠════════════════════════════════════════════════════════════════════╣
║ [1 ] 01_imaging         – Acquire forensic disk images             ║
║ [2 ] 02_fs_analysis     – No description available                 ║
║ [3 ] 03_carving         – Recover deleted or hidden files          ║
║ [4 ] 04_hashing         – Generate & verify cryptographic hashes   ║
║ [5 ] 05_keyword         – Search keywords, regex, and IOC patterns ║
║ [6 ] 06_timeline        – Build forensic activity timelines        ║
║ [7 ] 07_artifacts       – Extract OS, user, and browser artifacts  ║
║ [8 ] 08_malware         – Static & dynamic malware triage          ║
║ [9 ] 09_memory          – RAM dump analysis (Volatility, YARA)     ║
║ [10] 10_network         – PCAP/network traffic analysis            ║
║ [11] 11_cloud_mobile    – No description available                 ║
║ [12] 12_reporting       – Export structured forensic reports       ║
╠════════════════════════════════════════════════════════════════════╣
║   [H] Help   [L] Logs   [C] Switch Case   [99] Exit                ║
╚════════════════════════════════════════════════════════════════════╝

 (SUDARSHAN)> 

```

--- 

![ezgif com-speed](https://github.com/user-attachments/assets/4d56f22d-493d-40f2-83ca-3c6150deef76)

---

## ⚖️ License

This project is licensed under the [MIT License](LICENSE).

---

## 👨‍💻 Author

Built with precision by **[CODE](https://github.com/CYBER-4RMY)**

---
