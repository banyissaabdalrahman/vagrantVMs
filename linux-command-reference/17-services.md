# Services

Linux uses **systemd** to manage services (also called daemons) — background processes that run continuously, such as web servers, databases, and schedulers. `systemctl` is the command used to control these services.

```bash
yum install httpd -y      # install the Apache web server package
```

> `httpd` is a web service that can be managed by the `systemctl` command — like most modern Linux services.

---

## systemctl — Managing Services

```bash
systemctl status httpd      # check current status — running, stopped, errors
systemctl start httpd       # start the service immediately
systemctl enable httpd      # enable the service to start automatically on boot
```

| Command | Effect | Persists After Reboot |
|---------|--------|----------------------|
| `start` | Starts the service now | ❌ No — stops on reboot unless enabled |
| `enable` | Configures auto-start on boot | ✅ Yes — but doesn't start it now |
| `start` + `enable` | Running now AND on every boot | ✅ Yes |

> A common mistake is running only `enable` and expecting the service to start immediately — it does not. `enable` only configures boot behavior; `start` is needed to run it now.

---

## Applying Configuration Changes

After editing a service's configuration file, the running service must be told to pick up the changes:

```bash
systemctl restart httpd     # stop and start the service — brief downtime
systemctl reload httpd      # reload config without stopping the service — no downtime
```

| Command | Downtime | Use When |
|---------|----------|----------|
| `restart` | ✅ Brief downtime | Major changes, or service doesn't support reload |
| `reload` | ❌ No downtime | Minor config changes, service supports graceful reload |

> Always prefer `reload` over `restart` in production when possible — it avoids dropping active connections. Not all services support `reload`; check the service's documentation if unsure.

---

## Checking Service State

```bash
systemctl is-active httpd     # returns "active" or "inactive"
systemctl is-enabled httpd    # returns "enabled" or "disabled"
```

These are useful in **scripts** because they return simple, predictable output — perfect for conditional checks:

```bash
if systemctl is-active --quiet httpd; then
  echo "httpd is running"
else
  echo "httpd is not running"
fi
```

| Command | Returns | Meaning |
|---------|---------|---------|
| `is-active` | `active` / `inactive` / `failed` | Is it running right now? |
| `is-enabled` | `enabled` / `disabled` | Will it start on boot? |

---

## Service Unit Files

Every systemd-managed service has a **unit file** that defines how it behaves — what to run, dependencies, restart policy, and more.

```bash
cat /etc/systemd/system/multi-user.target.wants/httpd.service
```

> This path is actually a **symbolic link** pointing to the real unit file, typically located at `/usr/lib/systemd/system/httpd.service`. The `multi-user.target.wants` directory is how systemd knows which services to start at the standard multi-user boot target — this link is created automatically when you run `systemctl enable`.

Example unit file structure:

```ini
[Unit]
Description=The Apache HTTP Server
After=network.target

[Service]
Type=notify
ExecStart=/usr/sbin/httpd $OPTIONS -DFOREGROUND
ExecReload=/usr/sbin/httpd $OPTIONS -k graceful
KillSignal=SIGWINCH

[Install]
WantedBy=multi-user.target
```

| Section | Purpose |
|---------|---------|
| `[Unit]` | Description and dependencies (what must start first) |
| `[Service]` | How to start, reload, and stop the service |
| `[Install]` | Which boot target enables this service |

> Editing a unit file directly requires running `systemctl daemon-reload` afterward so systemd picks up the change.

---

## Other Useful systemctl Commands

```bash
systemctl stop httpd            # stop the service
systemctl disable httpd         # remove from boot startup
systemctl list-units --type=service        # list all active services
systemctl list-unit-files --type=service   # list all installed service unit files
journalctl -u httpd             # view logs specific to the httpd service
```

> `journalctl -u <service>` is one of the most useful troubleshooting commands — it shows the service's logs directly from systemd, including startup errors.

---

## 🧪 Lab: Services

### Install and Start

1. Switch to root:
```bash
   sudo -i
```

2. Install the Apache web server:
```bash
   yum install httpd -y
```

3. Check its current status — it should be inactive:
```bash
   systemctl status httpd
```

4. Start the service:
```bash
   systemctl start httpd
   systemctl status httpd
```

5. Confirm it's serving content:
```bash
   curl http://localhost
```

---

### Enable on Boot

6. Check if it's enabled to start on boot:
```bash
   systemctl is-enabled httpd
```

7. Enable it:
```bash
   systemctl enable httpd
   systemctl is-enabled httpd
```

8. Confirm the symlink was created:
```bash
   ls -l /etc/systemd/system/multi-user.target.wants/httpd.service
```

---

### Quick State Checks

9. Use the quiet status checks:
```bash
   systemctl is-active httpd
   systemctl is-enabled httpd
```

10. Write a simple conditional check:
```bash
    if systemctl is-active --quiet httpd; then echo "Running"; else echo "Stopped"; fi
```

---

### Apply a Config Change

11. View the default web page location and make a small change:
```bash
    echo "<h1>Lab Test Page</h1>" > /var/www/html/index.html
    curl http://localhost
```

12. Reload the service to apply changes without downtime:
```bash
    systemctl reload httpd
```

13. Now restart it instead and compare:
```bash
    systemctl restart httpd
    systemctl status httpd
```

---

### Inspect the Unit File

14. View the symlinked unit file:
```bash
    cat /etc/systemd/system/multi-user.target.wants/httpd.service
```

15. Find the actual unit file it links to:
```bash
    readlink -f /etc/systemd/system/multi-user.target.wants/httpd.service
```

16. View service logs:
```bash
    journalctl -u httpd | tail -20
```

---

### Cleanup

17. Stop and disable the service:
```bash
    systemctl stop httpd
    systemctl disable httpd
    systemctl is-active httpd
    systemctl is-enabled httpd
```

---

### Challenge

18. Write a one-liner that checks if `httpd` is active, and if not, starts it and confirms success:
```bash
    systemctl is-active --quiet httpd || (systemctl start httpd && echo "httpd started successfully")
```

    Break it down:
    - `systemctl is-active --quiet httpd` → silently checks status, returns exit code only
    - `||` → only runs the next command if the previous one **failed**
    - `&&` → only runs `echo` if `start` succeeded

19. **Bonus:** Find all currently running services on the system and count them:
```bash
    systemctl list-units --type=service --state=running | grep ".service" | wc -l
```