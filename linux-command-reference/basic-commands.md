# Linux Command Reference

A structured overview of essential Linux commands, including command syntax, system information utilities, file types, linking, filtering, redirection, pipes, and file search operations.

---

## 1. Command Syntax

Most Linux commands follow this general structure:

```bash
command [options] [arguments]
```

- **command** → The program or utility to execute  
- **options** → Modify command behavior  
- **arguments** → Target files, directories, or values  

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
| `free -m` | Display memory usage (MB) |
| `df -h` | Display disk partition usage (human readable) |

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

---

## 5. File Types

```bash
ls -l
file filename
```

- `ls -l` → Long listing format  
- `file` → Identify file type  

---

## 6. Symbolic Links

```bash
ln -s /opt/dev/ops/devops/test/commands.txt cmds
rm cmds
unlink cmds
```

---

## 7. Sorting with ls

```bash
ls -l
ls -lt
ls -ltr
```

---

## 8. Changing Hostname

```bash
vim /etc/hostname
hostname new_hostname
logout
login
```

---

## 9. Filters and Text Processing

### grep

```bash
grep firewall anaconda-ks.cfg
grep -i keyword fileName
grep -R keyword *
grep -v keyword fileName
```

Example:

```bash
grep -R SELINUX /etc/*
```

---

### head and tail

```bash
head fileName
head -n 2 fileName
tail fileName
tail -n 7 fileName
tail -f fileName
```

Example:

```bash
cd /var/log/
tail -f yum.log
tail -f messages
```

---

### cut and awk

```bash
cat /etc/passwd
cut -d: -f1 /etc/passwd
awk -F':' '{print $1}' /etc/passwd
```

---

### Search and Replace

```bash
:%s/searchFor/replaceWith/g
sed 's/searchFor/replaceWith/g' fileName
```

---

## 10. Input / Output Redirection

### Basic Redirection

```bash
uptime > /tmp/sysinfo.txt
cat /tmp/sysinfo.txt
ls > /tmp/sysinfo.txt
uptime >> /tmp/sysinfo.txt
```

- `>` → Overwrite file  
- `>>` → Append to file  

---

### Building a System Report

```bash
echo > /tmp/sysinfo.txt
date >> /tmp/sysinfo.txt
echo "##############################################" >> /tmp/sysinfo.txt
uptime >> /tmp/sysinfo.txt
echo "##############################################" >> /tmp/sysinfo.txt
free -m >> /tmp/sysinfo.txt
echo "##############################################" >> /tmp/sysinfo.txt
df -h >> /tmp/sysinfo.txt
echo "##############################################" >> /tmp/sysinfo.txt
echo >> /tmp/sysinfo.txt
cat /tmp/sysinfo.txt
```

---

### Redirect to /dev/null

```bash
yum install vim -y > /dev/null
```

Redirect output to a null device (discard output).

Clear file using:

```bash
cat /dev/null > /tmp/sysinfo.txt
```

---

### Redirecting Errors

```bash
freeee -m > /dev/null
freeee -m 2>> /tmp/errors.log
```

- `2>>` → Append error output  

Redirect both output and errors:

```bash
free -m &>> /tmp/errors.log
freeeeee -m &>> /tmp/errors.log
```

---

### Word Count

```bash
wc -l /etc/passwd
```

Counts number of lines.

---

## 11. Pipes

A pipe (`|`) sends the output of one command as input to another command.

Example:

```bash
cd /etc/ && ls | wc -l
```

Examples:

```bash
cd /etc/ && ls | grep host
tail -20 /var/log/messages | grep -i vagrant
free -m | grep -i mem
cd /etc/ && ls -l | tail
```

---

## 12. File Search

### find (Real-Time Search)

```bash
find /etc/ -name host*
```

Searches for files by name in real time.

---

### locate (Database-Based Search)

```bash
yum install mlocate -y
updatedb
locate host
```

- `locate` searches using a database  
- Not real-time  
- May not be installed by default  

---

## 13. Getting Help

```bash
command --help
man command
```

---

## Summary

This document covers:

- Command structure  
- File management  
- Filters and text processing  
- Input/output redirection  
- Pipes  
- File search utilities  
- System monitoring commands  
- Built-in documentation  

These commands form the foundation of practical Linux and DevOps workflows.