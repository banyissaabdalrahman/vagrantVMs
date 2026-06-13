# Symbolic Links

A symbolic link (also called a **symlink** or **soft link**) is a file that points to another file or directory. It works like a shortcut — accessing the link transparently accesses the target.

```bash
ln -s /opt/dev/ops/devops/test/commands.txt cmds    # create a symbolic link
rm cmds                                              # remove the link (not the target)
unlink cmds                                          # alternative way to remove a link
```

---

## How Symbolic Links Work

```
cmds  ──→  /opt/dev/ops/devops/test/commands.txt
(link)              (target)
```

- The link is a **separate file** that stores the path to the target
- Reading or writing through the link affects the **actual target file**
- Deleting the link **does not delete the target**
- Deleting the target **breaks the link** — it becomes a dangling symlink

---

## Creating Symbolic Links

```bash
ln -s target linkname
```

| Part | Meaning |
|------|---------|
| `ln` | Link command |
| `-s` | Symbolic (soft) link — without `-s` it creates a hard link |
| `target` | The file or directory the link points to |
| `linkname` | The name of the link being created |

Always use **absolute paths** for the target when possible:

```bash
ln -s /etc/hostname myhostname          # absolute path — works from anywhere
ln -s ../etc/hostname myhostname        # relative path — breaks if link is moved
```

> Relative paths in symlinks are resolved from the **location of the link**, not where you ran the command. Absolute paths are safer and more predictable.

---

## Identifying Symbolic Links

```bash
ls -l cmds
```

Example output:

```
lrwxrwxrwx. 1 vagrant vagrant 42 Mar 8 10:00 cmds -> /opt/dev/ops/devops/test/commands.txt
```

| Part | Meaning |
|------|---------|
| `l` | First character — identifies it as a symbolic link |
| `cmds` | The link name |
| `->` | Points to |
| `/opt/dev/.../commands.txt` | The target file |

```bash
file cmds           # shows: symbolic link to /opt/dev/ops/devops/test/commands.txt
```

---

## Symbolic vs Hard Links

| Feature | Symbolic Link | Hard Link |
|---------|--------------|-----------|
| Created with | `ln -s` | `ln` (no `-s`) |
| Points to | File path | File's inode (data directly) |
| Works across filesystems | ✅ Yes | ❌ No |
| Works on directories | ✅ Yes | ❌ No |
| Breaks if target deleted | ✅ Yes (dangling link) | ❌ No — data still accessible |
| Identified by `ls -l` | `l` prefix, shows `->` | Same type as original file |

> Symbolic links are far more commonly used than hard links in day-to-day Linux work.

---

## Removing Symbolic Links

Two ways to remove a symlink — both remove **only the link**, never the target:

```bash
rm cmds             # remove the link
unlink cmds         # alternative — specifically designed for unlinking
```

> Never use `rm -r` on a symlink to a directory — it will delete the **contents of the target directory**, not just the link.

---

## Dangling Symlinks

A dangling symlink points to a target that no longer exists:

```bash
ln -s /tmp/missing.txt deadlink
ls -l deadlink          # shows the link but target is gone
cat deadlink            # No such file or directory
```

```bash
ls -l deadlink
```

Output — the target appears in red on most terminals:

```
lrwxrwxrwx. 1 vagrant vagrant 16 Mar 8 10:00 deadlink -> /tmp/missing.txt
```

> Dangling symlinks are harmless but can cause confusion. Check for them with:
> ```bash
> find /path -xtype l
> ```

---

## Common Use Cases

Symbolic links are widely used in real Linux and DevOps environments:

| Use Case | Example |
|----------|---------|
| Shorter path to a deep directory | `ln -s /opt/app/releases/v2.1.0 /opt/app/current` |
| Point to the active version of a tool | `ln -s /usr/bin/python3.11 /usr/bin/python` |
| Share a config file across locations | `ln -s /etc/nginx/sites-available/app /etc/nginx/sites-enabled/app` |
| Quick access to a frequently used file | `ln -s /var/log/nginx/access.log ~/logs` |

---

## 🧪 Lab: Symbolic Links

### Setup

1. Create the target directory and file:
```bash
   mkdir -p /opt/dev/ops/devops/test
   echo "my commands file" > /opt/dev/ops/devops/test/commands.txt
   cat /opt/dev/ops/devops/test/commands.txt
```

2. Navigate to your home directory:
```bash
   cd ~
```

---

### Create and Inspect a Symlink

3. Create a symbolic link to the file:
```bash
   ln -s /opt/dev/ops/devops/test/commands.txt cmds
```

4. Verify the link — notice the `l` prefix and `->` arrow:
```bash
   ls -l cmds
```

5. Confirm the file type:
```bash
   file cmds
```

6. Access the file through the link:
```bash
   cat cmds
```

7. Write to the target through the link and verify:
```bash
   echo "new line added via symlink" >> cmds
   cat /opt/dev/ops/devops/test/commands.txt
```

---

### Remove the Link

8. Remove the link using `rm` and confirm the target still exists:
```bash
   rm cmds
   cat /opt/dev/ops/devops/test/commands.txt
```

9. Recreate the link and remove it using `unlink`:
```bash
   ln -s /opt/dev/ops/devops/test/commands.txt cmds
   unlink cmds
   cat /opt/dev/ops/devops/test/commands.txt
```

---

### Dangling Symlink

10. Create a symlink to a file that does not exist:
```bash
    ln -s /tmp/missing.txt deadlink
    ls -l deadlink
    cat deadlink
```

11. Find dangling symlinks in your home directory:
```bash
    find ~ -xtype l
```

12. Clean up the dangling link:
```bash
    rm deadlink
```

---

### Symlink to a Directory

13. Create a symbolic link to a directory and navigate into it:
```bash
    ln -s /opt/dev/ops/devops/test mydir
    cd mydir
    ls
    pwd
```

14. Confirm the real location with `ls -l`:
```bash
    cd ~
    ls -l mydir
```

---

### Challenge

15. Simulate a version switchover using symlinks — a common deployment pattern:
```bash
    mkdir -p /opt/app/v1 /opt/app/v2
    echo "version 1" > /opt/app/v1/index.html
    echo "version 2" > /opt/app/v2/index.html
    ln -s /opt/app/v1 /opt/app/current
    cat /opt/app/current/index.html
    unlink /opt/app/current
    ln -s /opt/app/v2 /opt/app/current
    cat /opt/app/current/index.html
```

> This is exactly how tools like **Capistrano** and **Ansible** handle zero-downtime deployments — switching a `current` symlink from one release directory to another.