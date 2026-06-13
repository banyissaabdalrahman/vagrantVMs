# Pipes

A pipe (`|`) sends the **stdout** of one command as the **stdin** of the next command. This lets you chain commands together to filter, transform, and process output in a single line.

```
command1 | command2 | command3 ...
```

> Think of it as an assembly line — each command does one job and passes the result to the next.

---

## How Pipes Work

Without a pipe, output goes to the terminal:
```bash
ls /etc
```

With a pipe, output is passed to the next command instead:
```bash
ls /etc | wc -l        # count how many files are in /etc
```

---

## Examples

```bash
cd /etc/ && ls | wc -l                        # count files in /etc
cd /etc/ && ls | grep host                    # filter files containing "host"
tail -20 /var/log/messages | grep -i vagrant  # search last 20 log lines for "vagrant"
free -m | grep -i mem                         # show only the memory line from free
cd /etc/ && ls -l | tail                      # show last 10 files in long format
```

| Example | What it does |
|---------|-------------|
| `ls \| wc -l` | Count files in a directory |
| `ls \| grep host` | Filter filenames by keyword |
| `tail -20 \| grep keyword` | Search within the last N lines of a log |
| `free -m \| grep Mem` | Extract a specific line from command output |
| `ls -l \| tail` | Show only the last entries of a listing |

---

## Chaining Multiple Pipes

You can chain as many pipes as needed:

```bash
cat /etc/passwd | grep -v root | cut -d: -f1 | sort
```

This pipeline:
1. `cat /etc/passwd` → reads the file
2. `grep -v root` → removes lines containing "root"
3. `cut -d: -f1` → extracts usernames (field 1)
4. `sort` → sorts the result alphabetically

---

## 🧪 Lab: Pipes

1. Count the number of files in `/etc`:
```bash
   ls /etc | wc -l
```

2. Filter files in `/etc` containing the word "host":
```bash
   ls /etc | grep host
```

3. Show only the memory line from `free`:
```bash
   free -m | grep -i mem
```

4. Search the last 20 lines of the system log for "vagrant":
```bash
   tail -20 /var/log/messages | grep -i vagrant
```

5. Show the last 10 files in `/etc` in long format:
```bash
   ls -l /etc | tail
```

6. Count how many users have `/bin/bash` as their shell:
```bash
   grep '/bin/bash' /etc/passwd | wc -l
```

7. List all running processes and filter by a specific service:
```bash
   ps aux | grep sshd
```

8. **Challenge:** Build a pipeline that:
   - Reads `/etc/passwd`
   - Excludes lines containing `nologin`
   - Extracts only the username (field 1)
   - Sorts the result
   - Counts the total

```bash
   cat /etc/passwd | grep -v nologin | cut -d: -f1 | sort | wc -l
```