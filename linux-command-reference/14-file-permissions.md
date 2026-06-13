# File Permissions

## Viewing File Permissions

```bash
ls -l /bin/login
```

Example output:

```
-rwxr-xr-x. 1 root root 44664 Aug 22  2024 /bin/login
```

Every file and directory in Linux has a permission string made of 10 characters:

```
- rwx r-x r-x
│ │   │   │
│ │   │   └── Others permissions
│ │   └──── Group permissions
│ └────── Owner (user) permissions
└──────── File type
```

| Character | Meaning |
|-----------|---------|
| `-` | Regular file |
| `d` | Directory |
| `l` | Symbolic link |

---

## Permission Modes

Each permission set has three characters — `r`, `w`, `x` — or `-` if the permission is not granted:

| Permission | Symbol | On a File | On a Directory |
|------------|--------|-----------|----------------|
| Read | `r` | View file contents (`cat`, `less`) | List contents (`ls`) |
| Write | `w` | Modify or delete the file | Create, delete, rename files inside |
| Execute | `x` | Run the file as a program | Enter the directory (`cd`) |

> A directory needs **execute (`x`)** permission to be entered. Without it, even if you have read permission, you cannot `cd` into it.

---

## Numeric (Octal) Permissions

Permissions can also be set using numbers — each permission has a value:

| Permission | Value |
|------------|-------|
| `r` | 4 |
| `w` | 2 |
| `x` | 1 |
| `-` | 0 |

Add the values together for each group:

| Octal | Binary | Permissions |
|-------|--------|-------------|
| `7` | 111 | `rwx` |
| `6` | 110 | `rw-` |
| `5` | 101 | `r-x` |
| `4` | 100 | `r--` |
| `0` | 000 | `---` |

Example:
```
chmod 770 /opt/devopsdir
```
- `7` → owner: `rwx`
- `7` → group: `rwx`
- `0` → others: `---`

---

## Create Directory for Lab

```bash
mkdir /opt/devopsdir
ls -l /opt/
```

---

## Create Users and Group

```bash
groupadd devops
useradd ansible
useradd jenkins
useradd aws
useradd miles
```

Add users to the `devops` group:

```bash
usermod -aG devops ansible
usermod -aG devops jenkins
usermod -aG devops aws
```

> Note: `miles` is intentionally **not** added to the `devops` group — he will be used to test "others" permissions later.

---

## Check Directory Permissions

```bash
ls -ld /opt/devopsdir
```

Example output:

```
drwxr-xr-x. 2 root root 6 Mar  8 19:03 /opt/devopsdir/
```

- Owner (`root`) → `rwx`
- Group (`root`) → `r-x`
- Others → `r-x`

---

## Change Ownership

Change the owner to `ansible` and the group to `devops`:

```bash
chown -R ansible:devops /opt/devopsdir
```

| Option | Meaning |
|--------|---------|
| `chown user:group` | Change both owner and group |
| `chown user` | Change owner only |
| `chown :group` | Change group only |
| `-R` | Apply recursively to all files inside |

Verify the change:

```bash
ls -ld /opt/devopsdir
```

---

## Symbolic Permission Changes

Permissions can be changed using symbols:

| Operator | Meaning |
|----------|---------|
| `+` | Add permission |
| `-` | Remove permission |
| `=` | Set exact permission |

| Target | Meaning |
|--------|---------|
| `u` | User (owner) |
| `g` | Group |
| `o` | Others |
| `a` | All (user + group + others) |

Remove permissions from others and add write to group:

```bash
chmod o-x /opt/devopsdir      # remove execute from others
chmod o-r /opt/devopsdir      # remove read from others
chmod g+w /opt/devopsdir      # add write to group
```

Or combine into a single command:

```bash
chmod o-rx,g+w /opt/devopsdir
```

---

## Testing Permissions

Switch to `miles` — an "others" user with no group membership:

```bash
su - miles
```

Try the following:

```bash
ls /opt/devopsdir       # list directory contents
cd /opt/devopsdir       # enter the directory
touch /opt/devopsdir/test1.txt    # create a file
```

Expected result:

```
Permission denied
```

This confirms that removing `r` and `x` from others prevents access completely.

Switch back to root:

```bash
exit
```

---

## Second Lab Example — Numeric Permissions

Create another directory:

```bash
mkdir /opt/webdata
ls -ld /opt/webdata
```

Change ownership:

```bash
chown aws:devops /opt/webdata
ls -ld /opt/webdata
```

Apply `770` permissions recursively:

```bash
chmod -R 770 /opt/webdata
ls -ld /opt/webdata
```

Result:
- Owner (`aws`) → `rwx`
- Group (`devops`) → `rwx`
- Others → `---`

> `770` is a common permission for shared team directories — full access for owner and group, no access for anyone else.

---

## 🧪 Lab: File Permissions

### Setup

1. Switch to root:
```bash
   sudo -i
```

2. Create the lab directory:
```bash
   mkdir /opt/devopsdir
   ls -ld /opt/devopsdir
```

3. Create users and group:
```bash
   groupadd devops
   useradd ansible
   useradd jenkins
   useradd aws
   useradd miles
   passwd ansible
   passwd miles
```

4. Add `ansible` and `jenkins` to the `devops` group (not `miles`):
```bash
   usermod -aG devops ansible
   usermod -aG devops jenkins
   usermod -aG devops aws
```

---

### Ownership

5. Change ownership of the directory:
```bash
   chown -R ansible:devops /opt/devopsdir
   ls -ld /opt/devopsdir
```

---

### Symbolic Permissions

6. Remove read and execute from others, add write to group:
```bash
   chmod o-rx /opt/devopsdir
   chmod g+w /opt/devopsdir
   ls -ld /opt/devopsdir
```

   Expected result:
```
   drwxrwx---. ansible devops /opt/devopsdir
```

7. Switch to `ansible` (group member) and confirm access:
```bash
   su - ansible
   cd /opt/devopsdir
   touch /opt/devopsdir/ansible_file.txt
   ls /opt/devopsdir
   exit
```

8. Switch to `miles` (others) and confirm denial:
```bash
   su - miles
   ls /opt/devopsdir
   cd /opt/devopsdir
   exit
```

---

### Numeric Permissions

9. Create a second directory and apply numeric permissions:
```bash
   mkdir /opt/webdata
   chown aws:devops /opt/webdata
   chmod -R 770 /opt/webdata
   ls -ld /opt/webdata
```

10. Verify `aws` has full access:
```bash
    su - aws
    cd /opt/webdata
    touch webfile.txt
    ls
    exit
```

11. Verify `miles` is denied:
```bash
    su - miles
    cd /opt/webdata
    exit
```

---

### Challenge

12. Create a directory `/opt/shared` where:
    - Owner is `ansible`
    - Group is `devops`
    - Owner has full access
    - Group can read and execute but not write
    - Others have no access

```bash
    mkdir /opt/shared
    chown ansible:devops /opt/shared
    chmod 750 /opt/shared
    ls -ld /opt/shared
```

    Verify by switching between users and testing access.