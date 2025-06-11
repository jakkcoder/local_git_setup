# local_git_setup

```markdown
# 🐙 Self-Hosted Git Server with Gitea (Local Setup with Docker)

This project sets up a lightweight, GitHub-like self-hosted Git server using [Gitea](https://gitea.io) in Docker.

It automatically mounts the **drive with the most available space** for storing all your repositories and metadata.

---

## 📁 Project Structure

```

.
├── docker-compose.yml           # Static Compose file with a volume placeholder
├── setup.sh                     # Linux/macOS setup script
├── setup.ps1                    # Windows PowerShell setup script
└── README.md                    # This file

````

---

## 🛠 Prerequisites

Make sure you have the following installed:

- [Docker](https://www.docker.com/products/docker-desktop)
- [Docker Compose](https://docs.docker.com/compose/)
- Bash (for Linux/macOS) or PowerShell (for Windows)

---

## 🚀 Getting Started

### 🐧 Linux / macOS

1. Open a terminal in this project folder.
2. Run:

   ```bash
   chmod +x setup.sh
   ./setup.sh
````

3. Gitea will be accessible at [http://localhost:3000](http://localhost:3000)

---

### 🪟 Windows

1. Open **PowerShell** as Administrator in this project folder.

2. Run:

   ```powershell
   powershell -ExecutionPolicy Bypass -File .\setup.ps1       
   ```

3. Gitea will be accessible at [http://localhost:3000](http://localhost:3000)

---

## 🔧 What the Setup Does

* Detects the local drive with the most free space.
* Creates a `gitea-data` folder on that drive.
* Replaces the `__GITEA_DATA_PATH__` placeholder in `docker-compose.yml` with the proper path:

  * Linux: `/mnt/yourdrive/gitea-data`
  * Windows: `/d/gitea-data`, etc.
* Starts the Gitea server using a generated `docker-compose.generated.yml`.

---

## 🔐 Default Ports

* Web UI: **3000**
* Git over SSH: **2222**

---

## 📦 Persistent Storage

Your Git repositories and app configuration will be stored in:

* Linux: `/<largest-partition>/gitea-data`
* Windows: `<DriveLetter>:\gitea-data`

---

## 🧼 Cleanup (Optional)

To stop and remove everything:

```bash
docker-compose -f docker-compose.generated.yml down
```

To delete data:

```bash
rm -rf /yourpath/gitea-data
```

---

## 📘 Resources

* [Gitea Documentation](https://docs.gitea.io/en-us/)
* [Docker Hub Image](https://hub.docker.com/r/gitea/gitea)


1. Instructions for **removing file upload restrictions** via `app.ini`.
2. A note about **PowerShell execution policy** and how to bypass it if blocked on Windows.

---

### ✅ Updated Section to Add in Your `README.md`

Append this to your existing `README.md`:

---

## 📦 Increase File Upload Limit in Gitea

By default, Gitea restricts file attachment size to 4 MB. To **remove or increase this limit**, modify the `app.ini` configuration file:

### 🔧 Steps

1. Run Gitea once via Docker to generate the config file.

2. Stop the container:

   ```bash
   docker-compose -f docker-compose.generated.yml down
   ```

3. Locate and edit `app.ini`:

   * Linux: `/<mount-point>/gitea-data/gitea/conf/app.ini`
   * Windows: `D:\gitea-data\gitea\conf\app.ini` (or wherever it was mounted)

4. Add or modify:

   ```ini
   [attachment]
   MAX_SIZE = 1048576000   ; ~1 GB
   ALLOWED_TYPES = */*     ; allow all file types

   [repository]
   MAX_CREATION_LIMIT = -1  ; unlimited repos (optional)
   ```

5. Restart Gitea:

   ```bash
   docker-compose -f docker-compose.generated.yml up -d
   ```

---

Happy coding! 🚀
