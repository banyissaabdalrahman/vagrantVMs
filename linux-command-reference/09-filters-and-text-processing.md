# Filters and Text Processing

## grep

Search for patterns inside files or command output.

```bash
grep firewall anaconda-ks.cfg      # search for "firewall" in a file
grep -i keyword fileName           # case-insensitive search
grep -R keyword *                  # search recursively in all files
grep -v keyword fileName           # invert match — show lines that do NOT contain keyword
```

| Option | Meaning |
|--------|---------|
| `-i` | Ignore case (matches `Firewall`, `FIREWALL`, `firewall`) |
| `-R` | Recurse into subdirectories |
| `-v` | Invert — show lines that do **not** match |
| `-n` | Show line numbers |
| `-c` | Count matching lines |

Example:

```bash
grep -R SELINUX /etc/*
```

---

## head and tail

Read the beginning or end of a file — useful for logs and large files.

```bash
head fileName          # show first 10 lines (default)
head -n 2 fileName     # show first 2 lines
tail fileName          # show last 10 lines (default)
tail -n 7 fileName     # show last 7 lines
tail -f fileName       # follow the file in real time — updates as new lines are added
```

| Option | Meaning |
|--------|---------|
| `-n` | Specify number of lines to show |
| `-f` | Follow mode — live stream new lines as they are written |

> `tail -f` is especially useful for **monitoring logs in real time** while a service is running.

Example:

```bash
cd /var/log/
tail -f messages
```

---

## cut and awk

Extract specific columns or fields from structured text.

```bash
cat /etc/passwd                        # view the full file
cut -d: -f1 /etc/passwd               # extract field 1, using : as delimiter
awk -F':' '{print $1}' /etc/passwd    # same result using awk
```

**`cut`** — simple column extractor:
- `-d:` → use `:` as the field delimiter
- `-f1` → print field number 1

**`awk`** — more powerful field processor:
- `-F':'` → set field separator to `:`
- `{print $1}` → print the first field
- `$1, $2, $3...` refer to each field in order

> `awk` can do much more than `cut` — it can filter, calculate, and format output using conditions and logic.

Example — print username and home directory (fields 1 and 6):

```bash
awk -F':' '{print $1, $6}' /etc/passwd
```

---

## Search and Replace

Find and replace text inside files.

**In `vim`** — replace across the entire file:
```bash
:%s/searchFor/replaceWith/g
```
- `:` → enter command mode
- `%` → apply to all lines
- `s` → substitute
- `/g` → replace all occurrences on each line (not just the first)

**In the terminal with `sed`** — non-interactive replacement:
```bash
sed 's/searchFor/replaceWith/g' fileName          # print result to terminal
sed -i 's/searchFor/replaceWith/g' fileName       # edit the file in place
```

| Option | Meaning |
|--------|---------|
| `s` | Substitute |
| `/g` | Global — replace all occurrences per line |
| `-i` | In-place — modify the actual file |

> Without `-i`, `sed` only prints the result to the terminal and does **not** modify the file.

---

## 🧪 Lab: Filters and Text Processing

### grep

1. Search for a keyword in a file:
```bash
   grep root /etc/passwd
```

2. Case-insensitive search:
```bash
   grep -i ROOT /etc/passwd
```

3. Show lines that do **not** contain a keyword:
```bash
   grep -v root /etc/passwd
```

4. Search recursively and show line numbers:
```bash
   grep -Rn SELINUX /etc/*
```

---

### head and tail

5. View the first 5 lines of a file:
```bash
   head -n 5 /etc/passwd
```

6. View the last 5 lines:
```bash
   tail -n 5 /etc/passwd
```

7. Monitor a log file in real time (open a second terminal and trigger some activity):
```bash
   tail -f /var/log/messages
```

---

### cut and awk

8. Extract just the usernames from `/etc/passwd`:
```bash
   cut -d: -f1 /etc/passwd
```

9. Do the same with `awk`:
```bash
   awk -F':' '{print $1}' /etc/passwd
```

10. Print username and home directory together:
```bash
    awk -F':' '{print $1, $6}' /etc/passwd
```

---

### Search and Replace

11. Create a test file:
```bash
    echo "the firewall is disabled" > test.txt
```

12. Preview the replacement without modifying the file:
```bash
    sed 's/disabled/enabled/g' test.txt
```

13. Apply the replacement to the file:
```bash
    sed -i 's/disabled/enabled/g' test.txt
    cat test.txt
```

14. **Challenge:** Extract only the usernames that have `/bin/bash` as their shell:
```bash
    grep '/bin/bash' /etc/passwd | cut -d: -f1
```