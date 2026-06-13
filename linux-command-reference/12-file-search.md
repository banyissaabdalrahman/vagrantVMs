# File Search

## find (Real-Time Search)

`find` searches the filesystem **in real time** — it scans directories as you run it, so results are always current.

```bash
find /etc/ -name host*        # find files starting with "host" in /etc
```

### Common Options

```bash
find /etc/ -name host*                  # search by name (case-sensitive)
find /etc/ -iname host*                 # search by name (case-insensitive)
find / -name "*.log"                    # find all .log files from root
find /etc/ -type f -name host*          # find files only (not directories)
find /etc/ -type d                      # find directories only
find / -size +10M                       # find files larger than 10MB
find / -mmin -60                        # find files modified in the last 60 minutes
find / -user vagrant                    # find files owned by a specific user
```

| Option | Meaning |
|--------|---------|
| `-name` | Match by filename (case-sensitive) |
| `-iname` | Match by filename (case-insensitive) |
| `-type f` | Match files only |
| `-type d` | Match directories only |
| `-size +10M` | Match files larger than 10MB |
| `-mmin -60` | Modified within the last 60 minutes |
| `-user` | Match files owned by a user |

> `find` is powerful but can be slow on large filesystems since it scans in real time. Use it when you need **current, accurate results**.

---

## locate (Database-Based Search)

`locate` searches a **pre-built database** of filenames — much faster than `find` but not real-time.

```bash
yum install mlocate -y      # install locate
updatedb                    # build/update the database
locate host                 # search for files containing "host"
```

| Feature | `find` | `locate` |
|---------|--------|---------|
| Speed | Slower | Much faster |
| Results | Real-time | Based on last `updatedb` run |
| Newly created files | ✅ Found immediately | ❌ Not found until `updatedb` runs |
| Deleted files | ✅ Not shown | ❌ May still appear |
| Installed by default | ✅ Yes | ❌ Requires `mlocate` package |

> `updatedb` is typically run automatically once a day via a cron job. Run it manually after creating files if you need `locate` to find them immediately.

---

## 🧪 Lab: File Search

### find

1. Find all files in `/etc` starting with "host":
```bash
   find /etc/ -name host*
```

2. Same search but case-insensitive:
```bash
   find /etc/ -iname host*
```

3. Find all `.conf` files in `/etc`:
```bash
   find /etc/ -name "*.conf"
```

4. Find only directories in `/etc`:
```bash
   find /etc/ -type d
```

5. Find files larger than 1MB under `/var`:
```bash
   find /var -size +1M
```

6. Find files modified in the last 60 minutes:
```bash
   find / -mmin -60
```

---

### locate

7. Install `mlocate` if not already installed:
```bash
   yum install mlocate -y
```

8. Build the database:
```bash
   updatedb
```

9. Search for files containing "host":
```bash
   locate host
```

10. Create a new file and try to locate it before and after `updatedb`:
```bash
    touch /tmp/testfile_locate.txt
    locate testfile_locate        # likely not found yet
    updatedb
    locate testfile_locate        # found now
```

11. **Challenge:** Find all `.log` files under `/var` larger than 1MB and count them:
```bash
    find /var -name "*.log" -size +1M | wc -l
```