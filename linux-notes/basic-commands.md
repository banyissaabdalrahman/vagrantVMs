# Linux Command Reference

A structured overview of essential Linux commands, including command syntax, system information utilities, file types, linking, and basic file management operations.

---

## 1. Command Syntax

Most Linux commands follow this general structure:

```bash
command [options] [arguments]
```

- **command** → The program or utility to execute  
- **options** → Modify command behavior (usually start with `-` or `--`)  
- **arguments** → Target files, directories, or values  

### Example

```bash
ls -l /tmp/
```

- `ls` → Command  
- `-l` → Option (long listing format)  
- `/tmp/` → Target directory  

---

## 2. User and Navigation Commands

| Command   | Description |
|------------|------------|
| `whoami`   | Display the current logged-in user |
| `pwd`      | Print the current working directory |
| `cd`       | Change directory |
| `cd ~`     | Navigate to the home directory |
| `ls`       | List directory contents |
| `sudo -i`  | Switch to the root user |

---

## 3. System Information Commands

| Command | Description |
|----------|------------|
| `cat /etc/hostname` | Display system hostname |
| `cat /etc/os-release` | Display operating system information |
| `uptime` | Show how long the system has been running |
| `free -m` | Display memory usage in megabytes |

---

## 4. File and Directory Management

### 4.1 Create Files and Directories

```bash
mkdir foldername
touch filename.txt
touch devopsfile{1..10}.txt
```

- `mkdir` → Create a new directory  
- `touch` → Create an empty file  
- `{1..10}` → Brace expansion to create multiple files  

---

### 4.2 Copy Files and Directories

```bash
cp file1 destination
cp -r dir1 destination
```

- `cp` → Copy files  
- `-r` → Recursive copy (required for directories)  

---

### 4.3 Move or Rename

```bash
mv source destination
```

- `mv` → Move or rename files and directories  

---

### 4.4 Remove Files and Directories

```bash
rm file
rm -r dir
```

- `rm` → Remove files  
- `-r` → Remove directories recursively  

> ⚠ Use `rm -r` carefully. It permanently deletes directories and their contents.

---

## 5. File Types in Linux

Linux supports different file types such as:

- Regular files
- Directories
- Symbolic links
- Block devices
- Character devices
- Sockets
- Named pipes

### View Detailed File Information

```bash
ls -l
```

Displays long listing format with permissions, ownership, size, and timestamp.

### Identify File Type

```bash
file filename
```

Determines whether a file is text, binary, executable, etc.

---

## 6. Symbolic Links (Soft Links)

### Example Workflow

```bash
mkdir /opt/dev/ops/devops/test
mkdir -p /opt/dev/ops/devops/test
vim /opt/dev/ops/devops/test/commands.txt
```

### Create a Symbolic Link

```bash
ln -s /opt/dev/ops/devops/test/commands.txt cmds
```

- `ln -s` → Create a soft (symbolic) link  
- `cmds` → Link name in the current directory  

### Verify the Link

```bash
cat cmds
ls -l
```

### Move Original File

```bash
mv /opt/dev/ops/devops/test/commands.txt /tmp/
ls -l
```

Move it back:

```bash
mv /tmp/commands.txt /opt/dev/ops/devops/test/
ls -l
```

### Remove a Symbolic Link

```bash
rm cmds
unlink cmds
```

---

## 7. Sorting with `ls`

```bash
ls -l     # Sort alphabetically (default)
ls -lt    # Sort by timestamp (newest first)
ls -ltr   # Reverse sort by timestamp (oldest first)
```

---

## 8. Changing the Hostname

### Edit Hostname File

```bash
vim /etc/hostname
```

### Apply New Hostname Temporarily

```bash
hostname new_hostname
```

### Final Step

```bash
logout
login
```

Log out and log back in to see the updated hostname reflected in your session.

---

## 9. Getting Help

Linux provides built-in documentation for most commands.

### Quick Help

```bash
command --help
```

### Manual Pages

```bash
man command
```

### Examples

```bash
cp --help
man cp
```

---

## Summary

This document covers:

- Command structure fundamentals  
- Navigation and system information  
- File and directory management  
- File types and identification  
- Symbolic links  
- Sorting and hostname management  
- Accessing built-in documentation  

These commands form the foundation of daily Linux usage and are essential for system administration and DevOps workflows.