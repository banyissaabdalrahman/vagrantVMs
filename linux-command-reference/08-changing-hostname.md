# Changing Hostname

The hostname is the name that identifies your machine on a network and in the terminal prompt. There are two ways to change it — temporarily for the current session, or permanently across reboots.

```bash
vim /etc/hostname          # permanently change the hostname (requires reboot or re-login)
hostname new_hostname      # temporarily change the hostname for the current session only
logout                     # log out to apply the change from /etc/hostname
login                      # log back in — prompt now reflects the new hostname
```

---

## How Hostnames Work

```bash
hostname                   # display the current hostname
cat /etc/hostname           # view the stored hostname
hostnamectl                 # show full hostname details (static, transient, pretty)
```

| Type | Meaning |
|------|---------|
| **Static** | Stored in `/etc/hostname` — persists across reboots |
| **Transient** | Set by `hostname` command — active only until reboot |
| **Pretty** | Human-readable label (e.g. "My Dev Server") — optional |

> The terminal prompt (`[vagrant@hostname ~]$`) reflects the **transient** hostname — it updates immediately when changed with `hostname`. The static hostname in `/etc/hostname` takes effect after logout or reboot.

---

## Method 1 — Edit /etc/hostname Directly

```bash
vim /etc/hostname
```

Replace the existing name with the new one:

```
webserver01
```

Save and quit:

```
:wq
```

Apply without rebooting by logging out and back in:

```bash
logout
```

> This is a **permanent** change — survives reboots. The file should contain only the hostname, nothing else.

---

## Method 2 — hostname Command (Temporary)

```bash
hostname new_hostname
```

Verify immediately:

```bash
hostname
```

> This change is **temporary** — it updates the running system but does not write to `/etc/hostname`. It will revert to the original hostname after a reboot.

---

## Method 3 — hostnamectl (Recommended)

`hostnamectl` is the modern, preferred way to change the hostname permanently — it updates both the running system and `/etc/hostname` in one command:

```bash
hostnamectl set-hostname new_hostname
```

Verify:

```bash
hostnamectl
cat /etc/hostname
```

| Method | Permanent | Instant | Recommended |
|--------|-----------|---------|-------------|
| `vim /etc/hostname` | ✅ | ❌ (needs logout) | ⚠️ Manual |
| `hostname new_name` | ❌ | ✅ | ⚠️ Temporary only |
| `hostnamectl set-hostname` | ✅ | ✅ | ✅ Best practice |

---

## Hostname Naming Conventions

A good hostname should be:

- **Lowercase** — avoid uppercase letters
- **Short and descriptive** — reflects the server's role
- **No spaces** — use hyphens instead
- **No special characters** — only letters, numbers, and hyphens

| Good | Bad |
|------|-----|
| `web01` | `My Server` |
| `db-primary` | `server_1` |
| `jenkins-server` | `SERVER` |
| `app-prod-01` | `app.prod.01` |

> In `/etc/hosts`, the hostname is also mapped to an IP address. After changing the hostname, update `/etc/hosts` to keep them consistent:
> ```bash
> vim /etc/hosts
> ```
> Change the line `127.0.0.1 old_hostname` to `127.0.0.1 new_hostname`.

---

## 🧪 Lab: Changing Hostname

### Check Current Hostname

1. View the current hostname:
```bash
   hostname
   cat /etc/hostname
   hostnamectl
```

---

### Method 1 — Temporary Change

2. Change the hostname temporarily:
```bash
   hostname devbox
```

3. Verify the change took effect immediately:
```bash
   hostname
```

4. Open a new shell and check the prompt — it reflects the new hostname:
```bash
   bash
   hostname
   exit
```

5. Confirm `/etc/hostname` was **not** changed:
```bash
   cat /etc/hostname
```

---

### Method 2 — Permanent Change via hostnamectl

6. Switch to root:
```bash
   sudo -i
```

7. Set the hostname permanently:
```bash
   hostnamectl set-hostname webserver01
```

8. Verify both the running hostname and the file:
```bash
   hostname
   cat /etc/hostname
   hostnamectl
```

9. Update `/etc/hosts` to match:
```bash
   vim /etc/hosts
```
   Find the line with the old hostname and update it:
```
   127.0.0.1   webserver01
```

10. Log out and back in — confirm the prompt shows the new hostname:
```bash
    exit
    exit
    vagrant ssh
```

---

### Method 3 — Direct File Edit

11. Switch to root and edit `/etc/hostname` manually:
```bash
    sudo -i
    vim /etc/hostname
```
    Change the content to:
```
    labserver01
```
    Save and quit:
```
    :wq
```

12. Apply without rebooting using `hostname`:
```bash
    hostname labserver01
    hostname
```

---

### Challenge

13. Write a one-liner that changes the hostname, updates `/etc/hosts`, and verifies both in a single step:
```bash
    hostnamectl set-hostname prod-server01 && \
    sed -i "s/$(hostname)/prod-server01/g" /etc/hosts && \
    echo "Hostname: $(hostname)" && \
    grep prod-server01 /etc/hosts
```

    Break it down:
    - `hostnamectl set-hostname` → sets the new hostname permanently
    - `sed -i` → replaces the old hostname in `/etc/hosts` in place
    - `&&` → only runs the next command if the previous one succeeded
    - Final two lines verify both changes were applied