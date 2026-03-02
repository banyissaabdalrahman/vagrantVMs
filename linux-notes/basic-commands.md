# Linux Command Reference

A structured overview of essential Linux commands, including command syntax, system information utilities, and basic file and directory management operations.

---

## 1. Command Syntax

Most Linux commands follow this general structure:

```bash
command [options] [arguments]
```

- **command** → The program or utility to execute  
- **options** → Modify the behavior of the command (usually start with `-` or `--`)  
- **arguments** → Target files, directories, or values  

### Example

```bash
ls -l /tmp/
```

- `ls` → Command  
- `-l` → Option (long listing format)  
- `/tmp/` → Argument (target directory)  

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

## 5. Getting Help

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

The `man` command opens the full manual page, including detailed descriptions, options, and usage examples.

---

## Summary

This document covers:

- Command structure fundamentals  
- Basic navigation commands  
- System information utilities  
- File and directory operations  
- Accessing built-in Linux documentation  

These commands form the foundation of daily Linux usage and are essential for system administration and DevOps workflows.