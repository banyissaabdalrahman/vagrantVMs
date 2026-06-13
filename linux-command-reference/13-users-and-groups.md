# Users and Groups

This document covers basic Linux user and group management commands commonly used in system administration and DevOps environments.

---

## Switch to Root User

Most user management commands require root privileges. Switch to root using:

```bash
sudo -i
```

> Always be careful when operating as root — there are no guardrails. Any mistake can affect the entire system.

---

## User and Group Information Files

Linux stores user and group information in plain text files:

```bash
cat /etc/passwd       # user account information
cat /etc/group        # group information
```

| File | Purpose |
|------|---------|
| `/etc/passwd` | One entry per user — username, UID, GID, home dir, shell |
| `/etc/group` | One entry per group — group name, GID, members |
| `/etc/shadow` | Encrypted passwords — readable by root only |

---

## Inspect a Specific User

Search for a user in the system:

```bash
grep vagrant /etc/passwd
```

Example output:

```
vagrant:x:1000:1000::/home/vagrant:/bin/bash
```

| Field | Value | Meaning |
|-------|-------|---------|
| 1 | `vagrant` | Username |
| 2 | `x` | Password stored in `/etc/shadow` |
| 3 | `1000` | User ID (UID) |
| 4 | `1000` | Primary Group ID (GID) |
| 5 | *(empty)* | Comment / description field |
| 6 | `/home/vagrant` | Home directory |
| 7 | `/bin/bash` | Login shell |

> UID `0` is always root. UIDs `1-999` are reserved for system accounts. Regular users start at `1000`.

---

## Inspect a Group

Search for a group:

```bash
grep vagrant /etc/group
```

Example output:

```
vagrant:x:1000:
```

| Field | Value | Meaning |
|-------|-------|---------|
| 1 | `vagrant` | Group name |
| 2 | `x` | Password (rarely used, stored in `/etc/gshadow`) |
| 3 | `1000` | Group ID (GID) |
| 4 | *(empty)* | Members of this group |

---

## Check User Identity

```bash
id vagrant
```

Example output:

```
uid=1000(vagrant) gid=1000(vagrant) groups=1000(vagrant)
```

- `uid` → the user's unique ID
- `gid` → the user's primary group ID
- `groups` → all groups the user belongs to (primary + secondary)

---

## Add Users

Create new users:

```bash
useradd ansible
useradd jenkins
useradd aws
```

> `useradd` creates the user, sets up a home directory under `/home`, and adds an entry to `/etc/passwd` and `/etc/group`.

Verify the users were created:

```bash
tail -4 /etc/passwd
tail -4 /etc/group
```

Check a specific user's information:

```bash
id ansible
```

---

## Create a Group

```bash
groupadd devops
```

> Groups are used to manage shared access to files and resources. Instead of setting permissions for each user individually, you add users to a group and set permissions on the group.

---

## Add Users to a Group

### Method 1 — Using usermod

```bash
usermod -aG devops ansible
```

| Option | Meaning |
|--------|---------|
| `-a` | Append — keep existing groups, add the new one |
| `-G` | Secondary (supplementary) group |
| `-g` | Change primary group |

> Always use `-aG` together. Using `-G` without `-a` will **remove** the user from all other secondary groups.

### Method 2 — Editing the Group File Directly

```bash
vim /etc/group
```

Find the group entry and add usernames to the last field:

```
devops:x:1004:ansible,jenkins,aws
```

Save and exit. Changes take effect immediately.

> Method 1 (`usermod`) is safer and preferred. Direct file editing is useful when adding multiple users at once.

---

## Verify Group Membership

```bash
id ansible
id aws
id jenkins
```

---

## Set User Passwords

A newly created user has no password and cannot log in until one is set. Must be done from the root account:

```bash
passwd ansible
passwd aws
passwd jenkins
```

> In production environments, use strong passwords or SSH key authentication instead of simple passwords like `admin123`.

---

## Switch Users

Switch to another user account:

```bash
su - username
```

- `su` → switch user
- `-` → load the user's full environment (home directory, shell, variables)

> Without `-`, you switch the user but keep the current environment, which can cause unexpected behavior.

---

## User Activity

Show login history of all users:

```bash
last
```

List all open files and processes by a specific user:

```bash
lsof -u username
```

Install `lsof` if not available:

```bash
yum install lsof -y
```

> `lsof` (list open files) is useful for auditing what a user is currently doing on the system — open files, network connections, running processes.

---

## Delete Users and Groups

Delete a user (keeps home directory):

```bash
userdel aws
```

Delete a user and their home directory:

```bash
userdel -r jenkins
```

Delete a group:

```bash
groupdel devops
```

> Always check if a user owns important files before deleting them. Use `find / -user username` first.

---

## 🧪 Lab: Users and Groups

### Setup

1. Switch to root:
```bash
   sudo -i
```

---

### Explore Existing Users and Groups

2. View all users on the system:
```bash
   cat /etc/passwd
```

3. View all groups:
```bash
   cat /etc/group
```

4. Inspect the vagrant user:
```bash
   grep vagrant /etc/passwd
   grep vagrant /etc/group
   id vagrant
```

---

### Create Users and a Group

5. Create three new users:
```bash
   useradd ansible
   useradd jenkins
   useradd aws
```

6. Verify they were created:
```bash
   tail -4 /etc/passwd
   tail -4 /etc/group
   id ansible
```

7. Create a group:
```bash
   groupadd devops
```

---

### Add Users to the Group

8. Add users to the `devops` group using `usermod`:
```bash
   usermod -aG devops ansible
   usermod -aG devops jenkins
   usermod -aG devops aws
```

9. Verify group membership:
```bash
   id ansible
   id jenkins
   id aws
   grep devops /etc/group
```

---

### Set Passwords and Switch Users

10. Set passwords for each user:
```bash
    passwd ansible
    passwd jenkins
    passwd aws
```

11. Switch to the ansible user and confirm identity:
```bash
    su - ansible
    whoami
    id
    exit
```

---

### User Activity

12. View login history:
```bash
    last
```

13. Install and use `lsof` to list open files by vagrant:
```bash
    yum install lsof -y
    lsof -u vagrant
```

---

### Cleanup

14. Check what files the `aws` user owns before deleting:
```bash
    find / -user aws 2>/dev/null
```

15. Delete the `aws` user (keep home directory):
```bash
    userdel aws
```

16. Delete `jenkins` and their home directory:
```bash
    userdel -r jenkins
```

17. Delete the `devops` group:
```bash
    groupdel devops
```

18. **Challenge:** Create a new user `deploy`, add them to a new group `cicd`, set a password, verify membership, then clean up:
```bash
    useradd deploy
    groupadd cicd
    usermod -aG cicd deploy
    passwd deploy
    id deploy
    grep cicd /etc/group
    userdel -r deploy
    groupdel cicd
```