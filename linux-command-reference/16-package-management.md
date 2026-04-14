# Software Management (Package Management)

Managing software packages is a **root-level task**, typically performed using `sudo`.

---

# Switch to Root User

```bash
sudo -i
```

---

# Identify Operating System

```bash
cat /etc/os-release
```

- Look at `ID_LIKE` to understand the OS distribution family (RPM-based or Debian-based).

---

# Package Listing

## RPM-Based Systems

```bash
rpm -qa
```

Lists all installed RPM packages.

---

## Debian-Based Systems

```bash
dpkg -l
```

Lists all installed Debian packages.

---

# System Architecture

```bash
arch
uname -m
```

Displays system architecture.

---

# Manual Package Installation (RPM)

Download a package:

```bash
curl {package_url} -o {package_name}
```

> `wget` can also be used instead of `curl`.

Install the package:

```bash
rpm -ivh {package_name}
```

- `i` → install  
- `v` → verbose  
- `h` → human-readable progress  

Verify installation:

```bash
rpm -qa | grep {package_name}
```

Remove a package:

```bash
rpm -e {package_name}
```

---

# Lab

Install **telnet**.

---

# Yum Package Manager

Navigate to repository configuration:

```bash
cd /etc/yum.repos.d/
ls
```

---

# Labs

## Install httpd using yum and dnf

## Install a package not available in default repositories (example: jenkins)