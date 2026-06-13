# File Types

In Linux, **everything is a file** — regular files, directories, devices, sockets, and pipes are all represented as files in the filesystem. Knowing the file type is essential before operating on it.

```bash
ls -l          # long listing — shows file type as the first character
file filename  # identify the actual type and format of a file
```

---

## ls -l — Long Listing Format

```bash
ls -l
```

Example output:

```
drwxr-xr-x. 2 vagrant vagrant   6 Mar  8 10:00 Documents
-rw-r--r--. 1 vagrant vagrant 123 Mar  8 10:01 notes.txt
lrwxrwxrwx. 1 vagrant vagrant  10 Mar  8 10:02 cmds -> /etc/hostname
```

The **first character** of each line identifies the file type:

| Character | Type | Description |
|-----------|------|-------------|
| `-` | Regular file | Text files, binaries, images, scripts |
| `d` | Directory | A folder containing other files |
| `l` | Symbolic link | A pointer to another file or directory |
| `c` | Character device | Devices that transfer data character by character (e.g. terminal, keyboard) |
| `b` | Block device | Devices that transfer data in blocks (e.g. hard drives, SSDs) |
| `s` | Socket | Used for inter-process communication over a network |
| `p` | Named pipe | Used for inter-process communication on the same system |

> The file **extension** (`.txt`, `.sh`, `.conf`) in Linux is just a naming convention — it does not determine how the OS treats the file. The actual type is determined by the file's content.

---

## file — Identify File Type

The `file` command reads the file's content and reports its actual type — regardless of the name or extension:

```bash
file filename
```

Common outputs:

| Command | Output | Meaning |
|---------|--------|---------|
| `file /etc/hostname` | `ASCII text` | Plain text file |
| `file /etc` | `directory` | A directory |
| `file /bin/bash` | `ELF 64-bit LSB executable` | Compiled binary |
| `file /dev/sda` | `block special` | Block device (hard disk) |
| `file script.sh` | `Bourne-Again shell script` | Bash script |
| `file image.png` | `PNG image data` | Image file |

Run `file` against multiple files at once:

```bash
file /etc/hostname /etc /bin/bash /dev/sda
```

> `file` is especially useful when a file has no extension or a misleading one — it reads the actual content signature (called a **magic number**) to determine the real type.

---

## Regular Files

Regular files (`-`) cover a wide range of formats:

| Format | Example | Identified by `file` as |
|--------|---------|------------------------|
| Plain text | `/etc/hostname` | `ASCII text` |
| Shell script | `script.sh` | `Bourne-Again shell script` |
| Compiled binary | `/bin/ls` | `ELF 64-bit LSB executable` |
| Compressed archive | `file.tar.gz` | `gzip compressed data` |
| Image | `photo.jpg` | `JPEG image data` |

---

## Device Files

Device files live under `/dev/` and represent hardware:

```bash
ls -l /dev/sda      # block device — hard disk
ls -l /dev/tty      # character device — terminal
```

> You never read or write device files directly in normal use — they are interfaces the kernel uses to communicate with hardware.

---

## 🧪 Lab: File Types

### Setup

1. Navigate to your home directory:
```bash
   cd ~
```

2. Create some test files to work with:
```bash
   touch textfile.txt
   mkdir testdir
   ln -s /etc/hostname symlink_test
   echo "#!/bin/bash" > script.sh
```

---

### ls -l — Identify Types by First Character

3. Run a long listing and observe the first character of each entry:
```bash
   ls -l
```

4. Run a long listing in `/dev` to see block and character devices:
```bash
   ls -l /dev/ | head -20
```

5. Filter only symbolic links in `/etc`:
```bash
   ls -l /etc | grep "^l"
```

6. Filter only directories in `/etc`:
```bash
   ls -l /etc | grep "^d"
```

---

### file — Identify File Content Type

7. Identify a plain text file:
```bash
   file /etc/hostname
```

8. Identify a directory:
```bash
   file /etc
```

9. Identify a compiled binary:
```bash
   file /bin/bash
```

10. Identify a block device:
```bash
    file /dev/sda
```

11. Identify your shell script:
```bash
    file script.sh
```

12. Run `file` against multiple targets at once:
```bash
    file /etc/hostname /etc /bin/bash /dev/sda script.sh symlink_test
```

---

### Observe Extension vs Actual Type

13. Create a file with a misleading extension and check its real type:
```bash
    echo "#!/bin/bash" > fakescript.txt
    file fakescript.txt
```

14. Create a text file with no extension and check its type:
```bash
    echo "hello world" > noextension
    file noextension
```

> Both demonstrate that Linux ignores extensions — `file` reads the actual content.

---

### Challenge

15. List all file types present in `/dev` and count how many of each type exist:
```bash
    ls -l /dev | awk '{print $1}' | cut -c1 | sort | uniq -c
```

    Break it down:
    - `ls -l /dev` → long listing of device files
    - `awk '{print $1}'` → extract the permissions column
    - `cut -c1` → extract just the first character (file type)
    - `sort` → group identical characters together
    - `uniq -c` → count occurrences of each type