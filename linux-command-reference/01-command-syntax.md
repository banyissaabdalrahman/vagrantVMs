# Command Syntax

Most Linux commands follow this general structure:

```bash
command [options] [arguments]
```

- **command** → The program or utility to execute
- **options** → Modify command behavior
- **arguments** → Target files, directories, or values

> Items in `[brackets]` are optional — many commands work with just the command name alone (e.g. `ls`, `pwd`, `whoami`).

---

## Options

Options (also called **flags**) modify how a command behaves. They come in two forms:

| Style | Example | Notes |
|-------|---------|-------|
| Short | `-l`, `-a`, `-h` | Single dash, one letter |
| Long | `--all`, `--human-readable` | Double dash, full word |

Short options can be **combined** after a single dash:

```bash
ls -l -a -h
ls -lah          # same result — combined
```

---

## Arguments

Arguments tell the command **what to act on** — a file, directory, user, or value:

```bash
cat /etc/hostname          # /etc/hostname is the argument
mkdir myfolder             # myfolder is the argument
useradd ansible            # ansible is the argument
head -n 5 /etc/passwd      # 5 is the option value, /etc/passwd is the argument
```

Some commands accept **multiple arguments**:

```bash
cp file1.txt file2.txt /tmp/    # two files copied to one destination
rm file1.txt file2.txt          # remove multiple files at once
```

---

## Getting Help

Every command has built-in documentation:

```bash
man ls             # full manual page
ls --help          # quick usage summary
whatis ls          # one-line description
```

| Command | Purpose |
|---------|---------|
| `man` | Full manual — navigate with arrows, quit with `q` |
| `--help` | Quick flag and usage reference |
| `whatis` | One-line description of the command |

---

## Example

```bash
ls -la /home/user
```

- **`ls`** → command — lists directory contents
- **`-la`** → options — `-l` for long format, `-a` to include hidden files
- **`/home/user`** → argument — the directory to list

---

## More Examples

```bash
grep -i root /etc/passwd
```
- **`grep`** → command — search for patterns in text
- **`-i`** → option — case-insensitive search
- **`root`** → argument — the keyword to search for
- **`/etc/passwd`** → argument — the file to search in

```bash
find /etc -name "*.conf" -type f
```
- **`find`** → command — search for files
- **`/etc`** → argument — where to search
- **`-name "*.conf"`** → option + value — match by filename pattern
- **`-type f`** → option — match files only

---

## 🧪 Lab: Command Syntax

1. Run a command with no options or arguments — observe the default behavior:
```bash
   ls
```

2. Add a short option:
```bash
   ls -l
```

3. Combine multiple short options:
```bash
   ls -lah
```

4. Add an argument to specify a target:
```bash
   ls -lah /etc
```

5. Use the long form of an option:
```bash
   ls --all /etc
```

6. Read the manual for a command:
```bash
   man ls
```
   Navigate with arrow keys, quit with `q`.

7. Use `--help` for a quick reference:
```bash
   grep --help
```

8. Use `whatis` to get a one-line description:
```bash
   whatis find
   whatis grep
   whatis chmod
```

9. **Challenge:** Construct a command using what you know — list all files in `/var/log`, including hidden files, sorted by modification time, newest first:
```bash
   ls -laht /var/log
```
   Break it down:
   - `l` → long format
   - `a` → include hidden files
   - `h` → human-readable sizes
   - `t` → sort by modification time