# Archiving

Archiving combines multiple files and directories into a single file — useful for backups, transfers, and storage. Linux offers two common tools: `tar` and `zip`/`unzip`.

---

## Using tar

`tar` (Tape Archive) is the most common archiving tool on Linux — it bundles files together and can optionally compress them.

### Create an Archive

```bash
cd /var/log
tar -czvf jenkins_06122020.tar.gz jenkins/
```

| Flag | Meaning |
|------|---------|
| `c` | Create a new archive |
| `z` | Compress using gzip |
| `v` | Verbose — show files as they are processed |
| `f` | File — specifies the archive filename (must come last, right before the filename) |

> The number `06122020` in the filename is just a **randomly selected timestamp** — a naming convention for tracking when the archive was made, not a required syntax element. You could name the file anything.

> Naming archives with a date is a common practice in backup scripts, since it makes it easy to identify when each backup was taken (e.g. `jenkins_DDMMYYYY.tar.gz`).

Move the archive to a different location:

```bash
mv jenkins_06122020.tar.gz /tmp/
cd /tmp/
```

---

### Extract an Archive

```bash
tar -xzvf jenkins_06122020.tar.gz              # extract into the current directory
tar -xzvf jenkins_06122020.tar.gz -C /opt/     # extract into a different directory
```

| Flag | Meaning |
|------|---------|
| `x` | Extract files from an archive |
| `z` | Decompress using gzip |
| `v` | Verbose |
| `f` | File — specifies the archive to read from |
| `-C` | Change to a specified directory before extracting |

> Without `-C`, `tar` extracts into your **current working directory**. Using `-C` lets you extract directly into a target location without needing to `cd` there first.

---

### tar File Extensions

| Extension | Meaning |
|-----------|---------|
| `.tar` | Uncompressed archive (just bundled, no compression) |
| `.tar.gz` / `.tgz` | Compressed with gzip |
| `.tar.bz2` | Compressed with bzip2 — slower, smaller output |
| `.tar.xz` | Compressed with xz — slower still, smallest output |

> The flag matches the compression type: use `z` for gzip, `j` for bzip2, and `J` for xz.

---

### Getting Help

```bash
tar --help        # see all available options
man tar            # full manual page
```

> **Note:** `tar` is a very legacy command with origins going back to actual tape backup systems. This isn't a reason to avoid it — it's still the standard tool on virtually every Linux system — just useful context for why its syntax feels a bit dated compared to modern tools.

---

## Using zip / unzip

`zip` is more familiar to users coming from Windows or macOS, and produces archives that are easy to open cross-platform.

### Install if Needed

```bash
sudo yum install zip unzip -y
```

### Create an Archive

```bash
zip -r jenkins_06122020.tar.gz jenkins/
```

| Flag | Meaning |
|------|---------|
| `-r` | Recursive — include all files and subdirectories |

> Note: even though the filename here ends in `.tar.gz`, `zip` actually creates a **zip-format** archive — the extension is just a label and doesn't change the actual format. For clarity, it's better practice to name zip archives with a `.zip` extension:
> ```bash
> zip -r jenkins_06122020.zip jenkins/
> ```

Move the archive:

```bash
mv jenkins_06122020.tar.gz /tmp/
cd /tmp/
```

---

### Extract an Archive

```bash
unzip jenkins_06122020.tar.gz
```

Extract into a specific directory:

```bash
unzip jenkins_06122020.tar.gz -d /opt/
```

| Flag | Meaning |
|------|---------|
| `-d` | Destination directory for extraction |

---

## tar vs zip

| Feature | tar (+gzip) | zip |
|---------|-------------|-----|
| Native to Linux | ✅ Yes | ⚠️ Requires install |
| Cross-platform friendly | ⚠️ Less common on Windows | ✅ Very common |
| Compression ratio | Generally better | Slightly less efficient |
| Preserves permissions/ownership | ✅ Yes | ⚠️ Limited |
| Common in DevOps/scripts | ✅ Very common | ⚠️ Less common |

> In Linux server environments and automation scripts, `tar.gz` is by far the more common choice. `zip` is more useful when the archive needs to be shared with or opened on Windows machines.

---

## 🧪 Lab: Archiving

### Setup

1. Switch to root and create test content to archive:
```bash
   sudo -i
   mkdir -p /var/log/jenkins
   echo "sample jenkins log entry" > /var/log/jenkins/jenkins.log
   echo "another log line" > /var/log/jenkins/access.log
```

---

### Archive with tar

2. Navigate to the directory and create a compressed archive:
```bash
   cd /var/log
   tar -czvf jenkins_19062026.tar.gz jenkins/
```

3. Check the size of the archive versus the original directory:
```bash
   ls -lh jenkins_19062026.tar.gz
   du -sh jenkins/
```

4. Move the archive to `/tmp`:
```bash
   mv jenkins_19062026.tar.gz /tmp/
   cd /tmp/
```

5. List the contents of the archive **without extracting** it:
```bash
   tar -tzvf jenkins_19062026.tar.gz
```

6. Extract it into the current directory:
```bash
   tar -xzvf jenkins_19062026.tar.gz
   ls
```

7. Clean up, then extract into a different directory using `-C`:
```bash
   rm -rf jenkins/
   mkdir -p /opt/restore
   tar -xzvf jenkins_19062020.tar.gz -C /opt/restore/
   ls /opt/restore/
```

---

### Archive with zip/unzip

8. Install zip and unzip if not already present:
```bash
   yum install zip unzip -y
```

9. Create a zip archive of the same directory:
```bash
   cd /var/log
   zip -r jenkins_19062026.zip jenkins/
```

10. Move it to `/tmp`:
```bash
    mv jenkins_19062026.zip /tmp/
    cd /tmp/
```

11. Extract it into the current directory:
```bash
    unzip jenkins_19062026.zip
```

12. Clean up, then extract into a specific directory using `-d`:
```bash
    rm -rf jenkins/
    mkdir -p /opt/restore_zip
    unzip jenkins_19062026.zip -d /opt/restore_zip/
    ls /opt/restore_zip/
```

---

### Compare Compression

13. Compare file sizes between the two archive formats:
```bash
    ls -lh /tmp/jenkins_19062026.tar.gz /tmp/jenkins_19062026.zip
```

---

### Challenge

14. Write a one-liner that archives `/etc` with today's date in the filename, then verify the archive was created successfully:
```bash
    tar -czvf /tmp/etc_backup_$(date +%d%m%Y).tar.gz /etc/ 2>/dev/null && ls -lh /tmp/etc_backup_*.tar.gz
```

    Break it down:
    - `$(date +%d%m%Y)` → dynamically inserts today's date in `DDMMYYYY` format
    - `2>/dev/null` → suppresses permission-denied warnings for files tar can't read
    - `&&` → only runs the verification `ls` if the archive command succeeded

> This pattern — embedding a dynamic timestamp using `$(date ...)` — is exactly how real backup scripts generate uniquely named backups automatically.