# System Information Commands

| Command | Description |
|----------|------------|
| `cat /etc/hostname` | Display system hostname |
| `cat /etc/os-release` | Display operating system information |
| `uptime` | Show system running time |
| `free -h` | Display memory usage (human readable) |
| `df -h` | Display disk partition usage (human readable) |
| `nproc` | Display the number of available CPU cores |

---

## cat /etc/hostname

Displays the system's hostname — the name that identifies this machine on a network:

```bash
cat /etc/hostname
```

Change the hostname permanently:

```bash
hostnamectl set-hostname newname
```

> The hostname is used to identify the machine in logs, terminal prompts, and network communications. In a DevOps environment, meaningful hostnames like `web01`, `db-primary`, or `jenkins-server` make it easier to manage multiple machines.

---

## cat /etc/os-release

Displays detailed information about the operating system:

```bash
cat /etc/os-release
```

Key fields to look for:

| Field | Meaning |
|-------|---------|
| `NAME` | OS name (e.g. CentOS Stream) |
| `VERSION` | OS version |
| `ID` | Short identifier (e.g. `centos`) |
| `ID_LIKE` | Parent distribution family (e.g. `rhel fedora`) |
| `PRETTY_NAME` | Human-readable full name |

> `ID_LIKE` tells you the distribution family — critical for knowing which package manager to use (`yum`/`dnf` for RPM-based, `apt` for Debian-based).

---

## uptime

Shows how long the system has been running and the CPU load average:

```bash
uptime
```

Example output:

```
17:47:22 up 1:06, 1 user, load average: 0.04, 0.15, 0.08
```

| Field | Meaning |
|-------|---------|
| `17:47:22` | Current time |
| `up 1:06` | System has been running for 1 hour 6 minutes |
| `1 user` | Number of logged-in users |
| `0.04, 0.15, 0.08` | Load average over last 1, 5, and 15 minutes |

**Interpreting load average:**

- Values represent the average number of processes waiting for CPU time
- Compare against your core count (`nproc`) to assess health:

| Load vs Core Count | Status |
|--------------------|--------|
| Below core count | ✅ Healthy |
| Equal to core count | ⚠️ Fully busy |
| Above core count | 🔴 Overloaded |

---

## free -h

Displays RAM and swap usage in human-readable format:

```bash
free -h
```

Example output:

```
               total    used    free    shared  buff/cache  available
Mem:           1.7Gi   321Mi   1.3Gi    5.0Mi      287Mi      1.4Gi
Swap:          1.0Gi     0B    1.0Gi
```

| Column | Meaning |
|--------|---------|
| `total` | Total installed RAM |
| `used` | Currently in use by processes |
| `free` | Completely unused |
| `buff/cache` | Used by kernel for caching — can be reclaimed |
| `available` | Actually available for new processes |

> Focus on **available**, not `free` — Linux uses spare RAM for caching to improve performance. That memory is immediately reclaimed when a process needs it.

**Common options:**

```bash
free -h      # human-readable (GB, MB)
free -m      # show in megabytes
free -g      # show in gigabytes
```

---

## df -h

Displays disk space usage across all mounted filesystems:

```bash
df -h
```

Example output:

```
Filesystem      Size  Used Avail Use% Mounted on
devtmpfs        4.0M     0  4.0M   0% /dev
tmpfs           888M     0  888M   0% /dev/shm
/dev/sda2        78G  2.1G   76G   3% /
/dev/sda1      1014M  241M  774M  24% /boot
```

| Column | Meaning |
|--------|---------|
| `Filesystem` | Device or virtual filesystem |
| `Size` | Total size |
| `Used` | Space in use |
| `Avail` | Space available |
| `Use%` | Percentage used |
| `Mounted on` | Where it is attached in the filesystem tree |

Filesystem types:

| Filesystem | Type | Description |
|------------|------|-------------|
| `/dev/sda1`, `/dev/sda2` | Physical | Real disk partitions |
| `tmpfs` | Virtual | Lives in RAM — cleared on reboot |
| `devtmpfs` | Virtual | Kernel-managed device files |

> Monitor `Use%` on physical partitions. At 80%+ it is time to investigate. At 100% the system can become unstable.

---

## nproc

Displays the number of CPU cores available to the current process:

```bash
nproc
```

For more detailed CPU information:

```bash
lscpu
```

> Use `nproc` to interpret load average values from `uptime`. A load of `2.0` on a 2-core system means 100% utilization — the same value on an 8-core system is only 25%.

---

## 🧪 Lab: System Information

1. Check your system's hostname:
```bash
   cat /etc/hostname
```

2. View operating system details and identify the distribution family:
```bash
   cat /etc/os-release
```

3. See how long the system has been running and note the load average:
```bash
   uptime
```

4. Check RAM — note the difference between `free` and `available`:
```bash
   free -h
```

5. View disk usage across all mounted partitions:
```bash
   df -h
```

6. Check how many CPU cores are available:
```bash
   nproc
```

7. **Exercise:** Interpret your load average — is your system healthy?
   - Run `uptime` and note the three load average numbers
   - Run `nproc` to get your core count
   - If load average is **below** your core count → ✅ Healthy
   - If load average is **equal to** your core count → ⚠️ Fully busy
   - If load average is **above** your core count → 🔴 Overloaded

   Example calculation:
```
   Load average: 0.04, 0.15, 0.08
   CPU cores: 2
   Result: 0.15 < 2 → ✅ System is healthy
```

8. Show only physical disk partitions from `df` output:
```bash
   df -h | grep "^/dev"
```

9. Show only the root partition:
```bash
   df -h | grep " /$"
```

10. **Challenge:** Build a one-liner that prints hostname, OS name, core count, and available memory together:
```bash
    echo "Host: $(cat /etc/hostname) | OS: $(grep ^NAME /etc/os-release | cut -d= -f2) | Cores: $(nproc) | RAM available: $(free -h | awk '/Mem/ {print $7}')"
```