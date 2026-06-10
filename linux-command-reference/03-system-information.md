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

## 🧪 Lab: System Information

Practice the commands above in order:

1. Check your system's hostname:
```bash
   cat /etc/hostname
```

2. View operating system details (distro, version, ID):
```bash
   cat /etc/os-release
```

3. See how long the system has been running and current load:
```bash
   uptime
```

4. Check RAM usage in megabytes — note used vs available:
```bash
   free -m
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

   Load average: 0.04, 0.15, 0.08

   CPU cores: 2

   Result: 0.15 < 2 → ✅ System is healthy

8. **Challenge:** Find only the line showing the root partition `/` from `df` output:
```bash
   df -h | grep " /$"
```