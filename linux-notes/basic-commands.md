# Linux Command Reference

A structured overview of essential Linux commands, including command syntax, system information utilities, file types, linking, filtering, and basic file management operations.

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
| `uptime` | Show system running time |
| `free -m` | Display memory usage in MB |

---

## 4. File and Directory Management

### Create

```bash
mkdir foldername
touch filename.txt
touch devopsfile{1..10}.txt
```

### Copy

```bash
cp file1 destination
cp -r dir1 destination
```

### Move / Rename

```bash
mv source destination
```

### Remove

```bash
rm file
rm -r dir
```

> ⚠ `rm -r` permanently deletes directories and their contents.

---

## 5. File Types in Linux

### Long Listing Format

```bash
ls -l
```

Displays detailed file information (permissions, owner, size, timestamp).

### Identify File Type

```bash
file filename
```

Determines whether a file is text, binary, executable, etc.

---

## 6. Symbolic Links (Soft Links)

### Create Directory Structure

```bash
mkdir /opt/dev/ops/devops/test
mkdir -p /opt/dev/ops/devops/test
vim /opt/dev/ops/devops/test/commands.txt
```

### Create Symbolic Link

```bash
ln -s /opt/dev/ops/devops/test/commands.txt cmds
```

### Verify

```bash
cat cmds
ls -l
```

### Move Original File

```bash
mv /opt/dev/ops/devops/test/commands.txt /tmp/
ls -l
```

Move back:

```bash
mv /tmp/commands.txt /opt/dev/ops/devops/test/
ls -l
```

### Remove Link

```bash
rm cmds
unlink cmds
```

---

## 7. Sorting with `ls`

```bash
ls -l     # Alphabetical (default)
ls -lt    # Newest first
ls -ltr   # Oldest first
```

---

## 8. Changing the Hostname

### Edit Hostname File

```bash
vim /etc/hostname
```

### Apply Hostname Temporarily

```bash
hostname new_hostname
```

### Apply Changes

```bash
logout
login
```

---

## 9. Filters and Text Processing

### grep (Search Text)

```bash
grep firewall anaconda-ks.cfg
```

Search for a keyword inside a file.

```bash
grep -i keyword fileName
```

Ignore case sensitivity.

```bash
grep -R keyword *
```

Search recursively in all files and directories in the current path.

```bash
grep -v keyword fileName
```

Exclude lines containing the keyword.

### Example

```bash
grep -R SELINUX /etc/*
```

---

### less and more (Read File Content)

```bash
less fileName
more fileName
```

Display file content page by page.

---

### head (Beginning of File)

```bash
head fileName
```

Show first 10 lines.

```bash
head -n 2 fileName
```

Show first *n* lines.

---

### tail (End of File)

```bash
tail fileName
```

Show last 10 lines.

```bash
tail -n 7 fileName
```

Show last *n* lines.

```bash
tail -f fileName
```

Monitor file changes in real time.

### Example (Log Monitoring)

```bash
cd /var/log/
ls
tail -f yum.log
tail -f messages
```

Open another terminal and log in (e.g., `vagrant ssh`) to observe live updates.

---

## 10. Working with Columns and Fields

### View User Information

```bash
cat /etc/passwd
```

### Extract First Column Using cut

```bash
cut -d: -f1 /etc/passwd
```

- `-d:` → Delimiter  
- `-f1` → First field  

### Extract First Column Using awk

```bash
awk -F':' '{print $1}' /etc/passwd
```

- `-F` → Field separator  

**Difference:**  
`cut` requires a delimiter.  
`awk` allows flexible field processing.

---

## 11. Search and Replace

### Using Vim

```bash
:%s/searchFor/replaceWith/g
```

- `g` → Global replacement (entire file)

### Using sed

```bash
sed 's/searchFor/replaceWith/g' fileName
```

Performs search and replace within the file output.

---

## 12. Getting Help

```bash
command --help
man command
```

---

## Summary

This document covers:

- Command syntax  
- Navigation and system information  
- File management  
- File types and symbolic links  
- Sorting  
- Hostname management  
- Text filtering and processing  
- Search and replace  
- Built-in documentation  

These commands form the foundation of practical Linux usage and DevOps workflows.