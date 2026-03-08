# File Permissions

## Viewing File Permissions

```bash
ls -l /bin/login
```

Example output:

```
-rwxr-xr-x. 1 root root 44664 Aug 22  2024 /bin/login
```

Explanation:

- `-` → file type  
- `rwx` → owner user permission  
- `r-x` → group permission  
- `r-x` → other users permission  

---

## Permission Modes

- `r` → read, means you can `ls`  
- `w` → write, means you can make changes and even delete  
- `x` → execute, means that you can `cd`  

---

# Create Directory for Lab

```bash
mkdir /opt/devopsdir
ls -l /opt/
```

---

# Create Users and Group

```bash
groupadd devops
ueradd ansible
useradd jenkins
useradd aws
useradd miles
```

Add users to group:

```bash
usermode -aG ansible
usermode -aG jenkins
usermode -aG aws
```

---

# Check Directory Permissions

```bash
ls -ld /opt/devopsdir
```

Example output:

```
drwxr-xr-x. 2 root root 6 Mar  8 19:03 /opt/devopsdir/
```

---

# Change Ownership

Change the ownership for `/opt/devopsdir` directory for **ansible user** and **devops group**.

```bash
chown -R ansible:devops /opt/devopsdir
```

---

# Lab Exercise

Remove permission for **others**, and add **write permission for the group**.

```bash
chmod o-x /opt/devopsdir
chmod o-r /opt/devopsdir
chmod g+w /opt/devopsdir
```

---

# Testing Permissions

Switch to another user:

```bash
su - miles
```

Try the following commands:

```bash
ls /opt/devopsdir
cd /opt/devopsdir
touch /opt/devopsdir/test1.txt
```

Expected result:

```
permission denied
```

This happens because **miles is an "other" user**.

---

# Second Lab Example

Create another directory:

```bash
mkdir /opt/webdata
```

Check permissions:

```bash
ls -ld /opt/webdata
```

Change ownership:

```bash
chown aws:devops /opt/webdata
```

Check again:

```bash
ls -ld /opt/webdata
```

Apply permissions recursively:

```bash
chmod -R 770 /opt/webdata
```

- `-R` → means recursively