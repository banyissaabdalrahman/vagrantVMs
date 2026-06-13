# Input / Output Redirection

## Basic Redirection

Every command in Linux has three standard streams:

| Stream | Number | Description |
|--------|--------|-------------|
| `stdin` | `0` | Standard input — what you type |
| `stdout` | `1` | Standard output — normal result |
| `stderr` | `2` | Standard error — error messages |

By default, output goes to the terminal. Redirection lets you send it elsewhere.

```bash
uptime > /tmp/sysinfo.txt     # write output to file (overwrite)
cat /tmp/sysinfo.txt          # view the file
ls > /tmp/sysinfo.txt         # overwrites previous content
uptime >> /tmp/sysinfo.txt    # append to existing content
```

| Operator | Meaning |
|----------|---------|
| `>` | Redirect stdout — **overwrite** file |
| `>>` | Redirect stdout — **append** to file |

---

## Building a System Report

Chain multiple commands to build a formatted report file:

```bash
echo > /tmp/sysinfo.txt                                      # clear the file
date >> /tmp/sysinfo.txt                                     # add current date/time
echo "##############################################" >> /tmp/sysinfo.txt
uptime >> /tmp/sysinfo.txt                                   # add system uptime
echo "##############################################" >> /tmp/sysinfo.txt
free -m >> /tmp/sysinfo.txt                                  # add memory usage
echo "##############################################" >> /tmp/sysinfo.txt
df -h >> /tmp/sysinfo.txt                                    # add disk usage
echo "##############################################" >> /tmp/sysinfo.txt
echo >> /tmp/sysinfo.txt                                     # add blank line
cat /tmp/sysinfo.txt                                         # display the report
```

> This is the foundation of **shell scripting** — instead of running these manually every time, you can save them in a `.sh` file and run them on a schedule.

---

## Redirect to /dev/null

`/dev/null` is a special device that **discards everything written to it** — think of it as a black hole.

```bash
yum install vim -y > /dev/null      # suppress normal output
```

Use it when you want a command to run silently without cluttering the terminal.

Clear a file instantly using:

```bash
cat /dev/null > /tmp/sysinfo.txt    # empties the file without deleting it
```

---

## Redirecting Errors

Normal `>` only redirects **stdout**. Errors go to **stderr** and still appear on the terminal.

```bash
freeee -m > /dev/null               # error still shows — stdout redirected, not stderr
freeee -m 2>> /tmp/errors.log       # append stderr to a log file
```

| Operator | Meaning |
|----------|---------|
| `2>` | Redirect stderr — overwrite |
| `2>>` | Redirect stderr — append |
| `&>` | Redirect **both** stdout and stderr — overwrite |
| `&>>` | Redirect **both** stdout and stderr — append |

Redirect both output and errors together:

```bash
free -m &>> /tmp/errors.log         # valid command — stdout + stderr appended
freeeeee -m &>> /tmp/errors.log     # invalid command — error also captured
```

> Capturing both streams into one log file is a common practice in **automated scripts and cron jobs** where nobody is watching the terminal.

---

## Word Count

```bash
wc -l /etc/passwd       # count lines in a file
```

| Option | Meaning |
|--------|---------|
| `-l` | Count lines |
| `-w` | Count words |
| `-c` | Count bytes |

Combine with pipes to count command output:

```bash
ls /etc | wc -l         # how many files are in /etc
grep -c root /etc/passwd   # how many lines contain "root"
```

---

## 🧪 Lab: Input / Output Redirection

### Basic Redirection

1. Write uptime output to a file:
```bash
   uptime > /tmp/sysinfo.txt
   cat /tmp/sysinfo.txt
```

2. Overwrite the file with directory listing:
```bash
   ls > /tmp/sysinfo.txt
   cat /tmp/sysinfo.txt
```

3. Append uptime without overwriting:
```bash
   uptime >> /tmp/sysinfo.txt
   cat /tmp/sysinfo.txt
```

---

### Build a System Report

4. Build a full system report:
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

### /dev/null

5. Run a command silently:
```bash
   yum install vim -y > /dev/null
```

6. Clear the report file without deleting it:
```bash
   cat /dev/null > /tmp/sysinfo.txt
   cat /tmp/sysinfo.txt
```

---

### Error Redirection

7. Try redirecting an invalid command's output — notice the error still shows:
```bash
   freeee -m > /dev/null
```

8. Capture the error to a log file:
```bash
   freeee -m 2>> /tmp/errors.log
   cat /tmp/errors.log
```

9. Redirect both stdout and stderr together:
```bash
   free -m &>> /tmp/errors.log
   freeeeee -m &>> /tmp/errors.log
   cat /tmp/errors.log
```

---

### Word Count

10. Count users in `/etc/passwd`:
```bash
    wc -l /etc/passwd
```

11. Count how many files are in `/etc`:
```bash
    ls /etc | wc -l
```

12. **Challenge:** Build the system report, then count how many lines it contains:
```bash
    cat /tmp/sysinfo.txt | wc -l
```