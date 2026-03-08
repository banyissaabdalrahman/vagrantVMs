# Input / Output Redirection

## Basic Redirection

```bash
uptime > /tmp/sysinfo.txt
cat /tmp/sysinfo.txt
ls > /tmp/sysinfo.txt
uptime >> /tmp/sysinfo.txt
```

- `>` → Overwrite file  
- `>>` → Append to file  

---

## Building a System Report

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

## Redirect to /dev/null

```bash
yum install vim -y > /dev/null
```

Redirect output to a null device (discard output).

Clear file using:

```bash
cat /dev/null > /tmp/sysinfo.txt
```

---

## Redirecting Errors

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

## Word Count

```bash
wc -l /etc/passwd
```

Counts number of lines.