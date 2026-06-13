# User and Navigation Commands

| Command   | Description |
|------------|------------|
| `whoami`   | Display the current logged-in user |
| `pwd`      | Print the current working directory |
| `cd`       | Change directory |
| `cd ~`     | Navigate to the home directory |
| `ls`       | List directory contents |
| `sudo -i`  | Switch to the root user |

---

## whoami

Prints the username of the currently logged-in user:

```bash
whoami
```

> Useful in scripts and after switching users with `su` to confirm your current identity.

---

## pwd — Print Working Directory

Shows your exact location in the filesystem:

```bash
pwd
```

> Linux has no concept of "you are here" by default — `pwd` is how you confirm where you are before running commands that depend on location.

---

## cd — Change Directory

Navigate the filesystem:

```bash
cd /etc              # go to an absolute path
cd Documents         # go to a relative path (from current location)
cd ~                 # go to your home directory
cd ..                # go up one level
cd -                 # go back to the previous directory
```

| Shortcut | Meaning |
|----------|---------|
| `~` | Home directory of the current user |
| `.` | Current directory |
| `..` | Parent directory |
| `-` | Previous directory |

> **Absolute paths** start with `/` and work from anywhere. **Relative paths** depend on where you currently are.

---

## ls — List Directory Contents

```bash
ls                   # basic listing
ls -l                # long format — shows permissions, owner, size, date
ls -a                # include hidden files (files starting with `.`)
ls -la               # long format + hidden files
ls -lah              # long format + hidden files + human-readable sizes
ls -lt               # sort by modification time, newest first
ls /etc              # list a specific directory
```

| Option | Meaning |
|--------|---------|
| `-l` | Long format |
| `-a` | Show hidden files |
| `-h` | Human-readable file sizes |
| `-t` | Sort by modification time |
| `-r` | Reverse sort order |

> Hidden files in Linux start with a `.` — they are not secret, just not shown by default. Configuration files like `.bashrc` and `.bash_history` are hidden files in your home directory.

---

## sudo -i — Switch to Root

Opens a full root login shell:

```bash
sudo -i
```

| Command | Difference |
|---------|-----------|
| `sudo command` | Run a single command as root |
| `sudo -i` | Open a full root shell session |
| `su -` | Switch to root using root's password |

> When you are done with root tasks, always `exit` back to your normal user. Operating as root unnecessarily increases the risk of accidental damage.

---

## 🧪 Lab: User and Navigation

1. Find out who you are logged in as:
```bash
   whoami
```

2. Check your current location in the filesystem:
```bash
   pwd
```

3. Navigate to your home directory:
```bash
   cd ~
   pwd
```

4. List the contents, including hidden files:
```bash
   ls -la
```

5. Move into a subdirectory (e.g. `Documents`) — create it first if it does not exist:
```bash
   mkdir -p Documents
   cd Documents
```

6. Confirm you moved successfully:
```bash
   pwd
```

7. Go back up one level and confirm:
```bash
   cd ..
   pwd
```

8. Jump back to the previous directory using the shortcut:
```bash
   cd -
   pwd
```

9. List `/etc` without navigating into it:
```bash
   ls -lah /etc
```

10. Switch to the root user and check who you are now:
```bash
    sudo -i
    whoami
    pwd
```

11. Exit the root session and confirm you are back to your normal user:
```bash
    exit
    whoami
```

12. **Challenge:** Without using `cd`, find out what is inside `/var/log` and how many items it contains:
```bash
    ls /var/log | wc -l
```