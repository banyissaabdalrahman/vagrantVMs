# Sudo

`sudo` allows permitted users to execute commands with **superuser (root) privileges** without logging in directly as root.

---

# Running Commands with sudo

From **vagrant user**:

```bash
sudo yum install git -y
yum install git -y
useradd test
```

- `sudo yum install git -y` → installs git with elevated privileges  
- `yum install git -y` → fails for a normal user without root privileges  
- `useradd test` → requires root privileges

---

# Switch to Root User

```bash
sudo -i
```

This opens a **root login shell**.

Change password for a user:

```bash
passwd ansible
```

Example password:

```
admin123
```

---

# Switch to Another User

```bash
su - ansible
```

Try running a sudo command:

```bash
sudo useradd test12
```

Expected result:

```
ansible is not in the sudoers file.
```

This happens because **ansible does not yet have sudo permissions**.

Exit the user session:

```bash
exit
```

---

# Checking the sudoers File

From **root user**:

```bash
ls -l /etc/sudoers
```

This file controls **which users are allowed to run sudo commands**.

Trying to edit it directly with vim may fail:

```bash
vim /etc/sudoers
```

Instead, use the safe editor:

```bash
visudo
```

`visudo` checks the file for **syntax errors before saving**, which prevents locking yourself out of sudo access.

---

# Granting sudo Access to a User

Search for the `root` configuration line.

Example:

```
root ALL=(ALL) ALL
```

Add another line below it:

```
ansible ALL=(ALL) ALL
```

Meaning:

- `ansible` → user  
- `ALL` → any host  
- `(ALL)` → may run commands as any user  
- `ALL` → allowed to run all commands  

Save and quit:

```
:wq
```

---

# Disable Password Prompt for sudo

To allow the user to run sudo commands **without entering a password**, change the rule to:

```
ansible ALL=(ALL) NOPASSWD: ALL
```

---

# Testing sudo Access

Switch back to the **ansible user**:

```bash
su - ansible
```

Run a command requiring elevated privileges:

```bash
sudo useradd test12
```

This command should now succeed.

---

# Important Note

If a **syntax error** is introduced into the sudoers file, sudo may stop working.

`visudo` helps prevent this by validating the configuration before saving.

### Lab

1. Introduce a syntax error in the sudoers file.
2. Attempt to save using `visudo`.
3. Fix the error.

---

# Best Practice

Instead of modifying `/etc/sudoers` directly, create a separate configuration file in:

```bash
/etc/sudoers.d/
```

Example:

```bash
cd /etc/sudoers.d/
ls
```

This approach keeps the main sudoers file clean and reduces the risk of configuration errors.