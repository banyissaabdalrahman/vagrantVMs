# Users and Groups

This document covers basic Linux user and group management commands commonly used in system administration and DevOps environments.

---

# Switch to Root User

```bash
sudo -i
```

---

# User and Group Information Files

Linux stores user and group information in the following files:

```bash
cat /etc/passwd
cat /etc/group
```

- `/etc/passwd` → contains user account information  
- `/etc/group` → contains group information  

---

# Inspect a Specific User

Search for a user in the system:

```bash
grep vagrant /etc/passwd
```

Example output:

```
vagrant:x:1000:1000::/home/vagrant:/bin/bash
```

Explanation:

- `vagrant` → username  
- `x` → link to the shadow file where the encrypted password is stored  
- `1000` → user ID (UID)  
- `1000` → group ID (GID)  
- comment field  
- `/home/vagrant` → user home directory  
- `/bin/bash` → login shell  

---

# Inspect a Group

Search for a group:

```bash
grep vagrant /etc/group
```

Example output:

```
vagrant:x:1000:
```

Explanation:

- `vagrant` → group name  
- `x` → link to the shadow file  
- `1000` → group ID  
- last field → users associated with this group  

---

# Check User Identity

```bash
id vagrant
```

Example output:

```
uid=1000(vagrant) gid=1000(vagrant) groups=1000(vagrant)
```

---

# Add Users

Create new users:

```bash
useradd ansible
useradd jenkins
useradd aws
```

Verify the users:

```bash
tail -4 /etc/passwd
tail -4 /etc/group
```

Check user information:

```bash
id ansible
```

---

# Create a Group

```bash
groupadd devops
```

---

# Add Users to a Group

## Method 1 — Using usermod

```bash
usermod -aG devops ansible
```

- `-G` → secondary group  
- `-g` → primary group  

---

## Method 2 — Editing the Group File

```bash
vim /etc/group
```

Example entry:

```
devops:x:1004:ansible,jenkins,aws
```

Save and exit.

---

# Verify Group Membership

```bash
id ansible
id aws
id jenkins
```

---

# Set User Passwords

After creating a user, a password must be set from the root account.

```bash
passwd ansible
passwd aws
passwd jenkins
```

Example password:

```
admin123
```

---

# Switch Users

```bash
su - username
```

---

# User Activity

Show login history:

```bash
last
```

List all open files by a specific user:

```bash
lsof -u username
```

Install `lsof` if not available:

```bash
yum install lsof -y
```

---

# Delete Users and Groups

Delete a user:

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

---