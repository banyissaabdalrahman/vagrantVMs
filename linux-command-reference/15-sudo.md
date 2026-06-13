# Sudo

`sudo` allows permitted users to execute commands with **superuser (root) privileges** without logging in directly as root.

> `sudo` stands for **"superuser do"**. It is the standard and safest way to run privileged commands on Linux — it logs every command run with it, unlike logging in directly as root.

---

## Running Commands with sudo

From the **vagrant user**:

```bash
sudo yum install git -y     # succeeds — vagrant has sudo access by default
yum install git -y          # fails — normal users cannot install packages
useradd test                # fails — requires root privileges
```

| Command | Without sudo | With sudo |
|---------|-------------|-----------|
| `yum install` | ❌ Permission denied | ✅ Succeeds |
| `useradd` | ❌ Permission denied | ✅ Succeeds |
| `passwd` | ⚠️ Own password only | ✅ Any user |

> Vagrant has sudo access by default because the Vagrant box is pre-configured for it. Most regular users do not.

---

## Switch to Root User

```bash
sudo -i
```

Opens a full **root login shell** — you are now operating as root with root's environment, home directory, and PATH.

Set a password for the `ansible` user:

```bash
passwd ansible
```

> Always set passwords for users before testing login-based access.

---

## Switch to Another User

```bash
su - ansible
```

Try running a privileged command:

```bash
sudo useradd test12
```

Expected result:

```
ansible is not in the sudoers file. This incident will be reported.
```

> Linux logs every failed sudo attempt. The "incident will be reported" message means it is written to `/var/log/secure` (or `/var/log/auth.log` on Debian-based systems).

Exit back to root:

```bash
exit
```

---

## The sudoers File

The `/etc/sudoers` file controls **who can run sudo, what commands they can run, and whether a password is required**.

```bash
ls -l /etc/sudoers
```

> The file is owned by root and readable only by root — this is intentional for security.

### Editing Safely with visudo

Never edit `/etc/sudoers` directly with a regular text editor:

```bash
vim /etc/sudoers      # risky — no syntax validation
```

Always use `visudo` instead:

```bash
visudo
```

| Feature | `vim /etc/sudoers` | `visudo` |
|---------|-------------------|---------|
| Syntax checking | ❌ None | ✅ Validates before saving |
| File locking | ❌ No | ✅ Prevents simultaneous edits |
| Safe to use | ⚠️ Risky | ✅ Recommended |

> A syntax error in `/etc/sudoers` can completely lock you out of sudo access on the system.

---

## Granting sudo Access to a User

Open the sudoers file:

```bash
visudo
```

Find the root configuration line:

```
root ALL=(ALL) ALL
```

Add a new line below it:

```
ansible ALL=(ALL) ALL
```

Breaking down the syntax:

```
ansible  ALL=(ALL)  ALL
│        │    │      │
│        │    │      └── Commands allowed (ALL = everything)
│        │    └───────── Can run as any user
│        └────────────── On any host
└─────────────────────── Username
```

Save and quit:

```
:wq
```

---

## Disable Password Prompt for sudo

By default, sudo requires the user's password. To allow passwordless sudo:

```
ansible ALL=(ALL) NOPASSWD: ALL
```

> `NOPASSWD` is useful for **automation and scripts** where no human is present to type a password — for example, Ansible playbooks running as the `ansible` user.

---

## Testing sudo Access

Switch to the `ansible` user:

```bash
su - ansible
```

Run a privileged command:

```bash
sudo useradd test12
```

Verify the user was created:

```bash
id test12
```

---

## sudoers Syntax Safety

If a syntax error is introduced, `visudo` will warn you before saving:

```
>>> sudoers file: syntax error, line 15 <
What now?
e) Edit sudoers file again
x) Exit without saving changes
```

Always choose `e` to fix the error — never exit with a broken sudoers file.

> If you somehow end up with a broken sudoers file, you can recover by booting into single-user mode or using `pkexec visudo` if available.

---

## Best Practice — sudoers.d Directory

Instead of modifying `/etc/sudoers` directly, create a **separate file** in `/etc/sudoers.d/`:

```bash
ls /etc/sudoers.d/
```

Create a new sudo rule file for `ansible`:

```bash
visudo -f /etc/sudoers.d/ansible
```

Add the rule:

```
ansible ALL=(ALL) NOPASSWD: ALL
```

| Approach | Risk | Recommended |
|----------|------|-------------|
| Edit `/etc/sudoers` directly | Higher — one file for everything | ⚠️ Acceptable with visudo |
| Use `/etc/sudoers.d/` | Lower — isolated, easy to remove | ✅ Best practice |

> The main `/etc/sudoers` file includes all files in `/etc/sudoers.d/` automatically. Removing a file from that directory instantly revokes those privileges — no need to edit the main file.

---

## 🧪 Lab: Sudo

### Setup

1. Switch to root:
```bash
   sudo -i
```

2. Set a password for `ansible` (create the user first if needed):
```bash
   useradd ansible
   passwd ansible
```

---

### Test Without sudo Access

3. Switch to `ansible`:
```bash
   su - ansible
```

4. Try a privileged command — observe the denial:
```bash
   sudo useradd test12
```

5. Check the sudo log to see the failed attempt:
```bash
   exit
   sudo cat /var/log/secure | grep ansible
```

---

### Grant sudo Access via sudoers

6. Open the sudoers file safely:
```bash
   visudo
```

7. Add the following line below the root entry:
```
   ansible ALL=(ALL) ALL
```

8. Save and quit:
```
   :wq
```

---

### Test sudo Access

9. Switch to `ansible` and run a privileged command:
```bash
   su - ansible
   sudo useradd test12
   id test12
   exit
```

---

### Enable Passwordless sudo

10. Open the sudoers file again:
```bash
    visudo
```

11. Update the ansible line to:
```
    ansible ALL=(ALL) NOPASSWD: ALL
```

12. Switch to `ansible` and verify no password is prompted:
```bash
    su - ansible
    sudo useradd test13
    id test13
    exit
```

---

### Test Syntax Validation

13. Open visudo and intentionally introduce a syntax error:
```bash
    visudo
```
    Add a broken line such as:
```
    ansible ALL=(ALL NOPASSWD: ALL
```

14. Try to save — observe the warning:
```
    >>> sudoers file: syntax error <
```

15. Choose `e` to go back and fix the error before saving.

---

### Best Practice — sudoers.d

16. Create a dedicated sudo rule file for `ansible`:
```bash
    visudo -f /etc/sudoers.d/ansible
```

17. Add the rule:
```
    ansible ALL=(ALL) NOPASSWD: ALL
```

18. Verify it works:
```bash
    su - ansible
    sudo whoami
    exit
```

19. **Challenge:** Grant `jenkins` sudo access **only** for the `yum` command (not all commands):
```bash
    visudo -f /etc/sudoers.d/jenkins
```
    Add:
```
    jenkins ALL=(ALL) NOPASSWD: /usr/bin/yum
```
    Test:
```bash
    su - jenkins
    sudo yum install git -y      # should succeed
    sudo useradd test99          # should be denied
    exit
```