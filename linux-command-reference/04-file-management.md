# File and Directory Management

---

## Create

### mkdir — Make Directory

```bash
mkdir foldername                  # create a single directory
mkdir -p dir1/dir2/dir3           # create nested directories in one command
mkdir dir{1..5}                   # create dir1, dir2, dir3, dir4, dir5
```

| Option | Meaning |
|--------|---------|
| `-p` | Create parent directories as needed — no error if they already exist |

> Without `-p`, trying to create a nested path like `mkdir a/b/c` will fail if `a` or `b` do not exist yet.

### touch — Create Files

```bash
touch filename.txt                # create a single empty file
touch file1.txt file2.txt         # create multiple files at once
touch devopsfile{1..10}.txt       # create 10 files using brace expansion
```

> `touch` also updates the **modification timestamp** of an existing file without changing its content — useful for triggering time-based scripts.

**Brace expansion** is a powerful shell feature:

```bash
touch devopsfile{1..10}.txt    # creates devopsfile1.txt through devopsfile10.txt
mkdir {dev,test,prod}-config   # creates dev-config, test-config, prod-config
```

---

## Copy

```bash
cp file1 destination           # copy a file to a destination
cp file1 file2                 # copy file1 and name the copy file2
cp -r dir1 destination         # copy an entire directory recursively
cp -p file1 destination        # preserve permissions, timestamps, and ownership
```

| Option | Meaning |
|--------|---------|
| `-r` | Recursive — required for copying directories |
| `-p` | Preserve file metadata (permissions, timestamps) |
| `-v` | Verbose — show what is being copied |

> Without `-r`, trying to copy a directory will fail with an error: `omitting directory`.

---

## Move / Rename

`mv` serves two purposes — **moving** and **renaming** — depending on the destination:

```bash
mv source destination              # move a file or directory
mv oldname.txt newname.txt         # rename a file
mv file1.txt /tmp/                 # move a file to a different directory
mv dir1 /opt/dir1                  # move an entire directory
```

> `mv` works on both files and directories without needing a `-r` flag — unlike `cp`.

| Scenario | Command |
|----------|---------|
| Rename a file | `mv old.txt new.txt` |
| Move to another directory | `mv file.txt /tmp/` |
| Move and rename at once | `mv file.txt /tmp/newname.txt` |

---

## Remove

```bash
rm file.txt                    # remove a single file
rm file1.txt file2.txt         # remove multiple files
rm *.txt                       # remove all .txt files using wildcard
rm -r dir                      # remove a directory and all its contents
rm -rf dir                     # force remove — no prompts, no errors if missing
```

| Option | Meaning |
|--------|---------|
| `-r` | Recursive — required for removing directories |
| `-f` | Force — suppress errors and prompts |
| `-v` | Verbose — show what is being deleted |

> **There is no recycle bin in Linux.** Once deleted with `rm`, files are gone. Be especially careful with `-rf` and wildcards — double-check your command before pressing Enter.

**Wildcards** work with all file management commands:

| Wildcard | Matches |
|----------|---------|
| `*` | Any number of any characters |
| `?` | Any single character |
| `[abc]` | Any one of the listed characters |

---

## 🧪 Lab: File and Directory Management

### Setup

1. Navigate to your home directory:
```bash
   cd ~
```

2. Create a new directory to work in and enter it:
```bash
   mkdir devops_lab
   cd devops_lab
```

---

### Create Files and Directories

3. Create a single file:
```bash
   touch notes.txt
```

4. Create 10 files at once using brace expansion:
```bash
   touch devopsfile{1..10}.txt
```

5. Create multiple directories at once:
```bash
   mkdir backup backup2 archive
```

6. Verify everything was created:
```bash
   ls
```

---

### Copy

7. Copy a single file into a directory:
```bash
   cp notes.txt backup/
   ls backup/
```

8. Copy an entire directory:
```bash
   cp -r backup backup_copy
   ls backup_copy/
```

9. Copy a file and preserve its metadata:
```bash
   cp -p notes.txt archive/notes_preserved.txt
   ls -l archive/
```

---

### Move and Rename

10. Rename a file:
```bash
    mv notes.txt notes_renamed.txt
    ls
```

11. Move a file into a directory:
```bash
    mv notes_renamed.txt backup/
    ls backup/
```

12. Move and rename in a single command:
```bash
    mv devopsfile1.txt archive/firstfile.txt
    ls archive/
```

---

### Remove

13. Remove a single file:
```bash
    rm devopsfile2.txt
    ls
```

14. Remove an entire directory:
```bash
    rm -r backup_copy
    ls
```

15. Remove all remaining `devopsfile` files using a wildcard:
```bash
    rm devopsfile*.txt
    ls
```

16. Confirm the cleanup:
```bash
    ls
```

---

### Challenge

17. Create a nested directory structure in one command, create files inside, then remove everything recursively:
```bash
    mkdir -p project/{src,test,docs}
    touch project/src/main.sh
    touch project/test/test1.sh
    touch project/docs/readme.txt
    ls -R project/
    rm -rf project/
    ls
```

> `ls -R` lists contents recursively — useful for verifying nested directory structures before removing them.