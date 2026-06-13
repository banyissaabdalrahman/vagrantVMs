# Sorting with ls

`ls` lists directory contents, and its sorting options help you quickly find the newest, oldest, or largest files — especially useful when working with logs, backups, and deployments.

```bash
ls -l       # long format — permissions, owner, size, timestamp
ls -lt      # sort by modification time, newest first
ls -ltr     # sort by modification time, oldest first (reversed)
```

---

## Default Behavior

By default, `ls` sorts alphabetically:

```bash
ls          # alphabetical order, no details
ls -l       # alphabetical order, with full details
```

Example output:

```
-rw-r--r--. 1 vagrant vagrant 0 Mar 8 10:00 file_a.txt
-rw-r--r--. 1 vagrant vagrant 0 Mar 8 10:01 file_b.txt
-rw-r--r--. 1 vagrant vagrant 0 Mar 8 10:02 file_c.txt
```

---

## Sorting Options

```bash
ls -lt      # newest files first — most recently modified at the top
ls -ltr     # oldest files first — most recently modified at the bottom
ls -lS      # sort by file size, largest first
ls -lSr     # sort by file size, smallest first
ls -lX      # sort by file extension
```

| Option | Meaning |
|--------|---------|
| `-l` | Long format — shows permissions, owner, size, and timestamp |
| `-t` | Sort by modification time, newest first |
| `-r` | Reverse the current sort order |
| `-S` | Sort by file size, largest first |
| `-a` | Include hidden files (files starting with `.`) |
| `-h` | Human-readable file sizes (KB, MB, GB) |

> Options can be combined freely. `-ltr` is one of the most commonly used combinations in real environments — it puts the most recently changed file at the **bottom**, making it easy to spot in a long listing.

---

## Timestamps in ls -l

The timestamp column in `ls -l` shows the **last modification time** — when the file content was last changed:

```bash
ls -l
```

```
-rw-r--r--. 1 vagrant vagrant 0 Mar  8 10:02 file_c.txt
```

Three timestamps exist for every file — view all with:

```bash
stat filename
```

| Timestamp | Name | Meaning |
|-----------|------|---------|
| `Access` | atime | Last time the file was read |
| `Modify` | mtime | Last time the file content was changed |
| `Change` | ctime | Last time the file metadata changed (permissions, owner) |

> `ls -lt` sorts by **mtime** — the last time file content was modified.

---

## Practical Use Cases

Sorting by time is especially useful in these scenarios:

```bash
ls -lt /var/log/          # find the most recently updated log file
ls -ltr /var/log/         # find the oldest log file
ls -lt /etc/              # see what config files were recently changed
ls -lSh /var/log/         # find the largest log files
```

> In production troubleshooting, `ls -ltr /var/log/` is often one of the first commands run — it shows which logs were written to most recently, pointing you toward active services and recent events.

---

## 🧪 Lab: Sorting with ls

### Setup

1. Navigate to your home directory:
```bash
   cd ~
```

2. Create files with deliberate time gaps so timestamps differ:
```bash
   touch file_a.txt
   sleep 1
   touch file_b.txt
   sleep 1
   touch file_c.txt
```

---

### Basic Sorting

3. List files in long format — default alphabetical order:
```bash
   ls -l
```

4. List files sorted by newest first:
```bash
   ls -lt
```

5. List files sorted by oldest first:
```bash
   ls -ltr
```

6. Observe the difference — `file_c.txt` should appear:
   - **First** with `ls -lt` (newest)
   - **Last** with `ls -ltr` (oldest first, newest at bottom)

---

### Size Sorting

7. Create files of different sizes:
```bash
   dd if=/dev/zero of=small.txt bs=1K count=1
   dd if=/dev/zero of=medium.txt bs=100K count=1
   dd if=/dev/zero of=large.txt bs=1M count=1
```

8. Sort by size, largest first:
```bash
   ls -lSh
```

9. Sort by size, smallest first:
```bash
   ls -lShr
```

---

### Include Hidden Files

10. List all files including hidden ones, sorted oldest first:
```bash
    ls -ltra
```

11. Observe hidden files like `.bash_history` and `.bashrc` — these are configuration and session files:
```bash
    ls -ltra ~ | grep "^\."
```

---

### Inspect Timestamps with stat

12. View all three timestamps for a file:
```bash
    stat file_a.txt
```

13. Touch a file to update its timestamp and re-sort:
```bash
    touch file_a.txt
    ls -lt
```

    > `file_a.txt` should now appear at the top — its mtime was just updated.

---

### Practical Exercise

14. Find the most recently modified file in `/var/log`:
```bash
    ls -lt /var/log/ | head -5
```

15. Find the largest files in `/var/log`:
```bash
    ls -lSh /var/log/ | head -5
```

16. **Challenge:** Find the five most recently modified files anywhere under `/etc` using `find` and sort by time:
```bash
    find /etc -type f -printf "%T@ %p\n" 2>/dev/null | sort -rn | head -5 | awk '{print $2}'
```

    Break it down:
    - `find /etc -type f` → find all files in `/etc`
    - `-printf "%T@ %p\n"` → print modification timestamp and filename
    - `sort -rn` → sort numerically in reverse (newest first)
    - `head -5` → take the top 5
    - `awk '{print $2}'` → print only the filename column