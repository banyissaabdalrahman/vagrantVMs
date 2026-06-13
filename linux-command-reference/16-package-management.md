# Software Management (Package Management)

Managing software packages is a **root-level task**, typically performed using `sudo`.

> Linux distributions use **package managers** to install, update, and remove software. They handle dependencies automatically — so when you install a package, all required libraries are installed alongside it.

---

## Switch to Root User

```bash
sudo -i
```

---

## Identify Operating System

```bash
cat /etc/os-release
```

Look at the `ID_LIKE` field to identify the distribution family:

| Family | Distributions | Package Manager |
|--------|--------------|-----------------|
| RPM-based | RHEL, CentOS, Fedora, Rocky, AlmaLinux | `rpm`, `yum`, `dnf` |
| Debian-based | Ubuntu, Debian, Mint | `dpkg`, `apt` |

> Knowing your OS family determines which package manager and commands to use.

---

## Package Listing

### RPM-Based Systems

```bash
rpm -qa                        # list all installed packages
rpm -qa | grep package_name    # check if a specific package is installed
rpm -qi package_name           # detailed info about an installed package
```

### Debian-Based Systems

```bash
dpkg -l                        # list all installed packages
dpkg -l | grep package_name    # check if a specific package is installed
```

---

## System Architecture

```bash
arch
uname -m
```

Common values:

| Output | Meaning |
|--------|---------|
| `x86_64` | 64-bit Intel/AMD |
| `aarch64` | 64-bit ARM |
| `i686` | 32-bit Intel |

> Always match the package architecture to your system — installing an `x86_64` package on an `aarch64` system will fail.

---

## Manual Package Installation (RPM)

Used when a package is **not available in any repository** and must be downloaded manually.

Download a package:

```bash
curl {package_url} -o {package_name}.rpm
```

> `wget` can also be used instead of `curl` — both download files from the internet.

Install the package:

```bash
rpm -ivh {package_name}.rpm
```

| Option | Meaning |
|--------|---------|
| `-i` | Install |
| `-v` | Verbose — show details |
| `-h` | Human-readable progress bar |

Verify installation:

```bash
rpm -qa | grep {package_name}
```

Remove a package:

```bash
rpm -e {package_name}
```

> `rpm` does **not** resolve dependencies automatically. If the package requires other libraries, you must install them manually. This is why `yum`/`dnf` is preferred.

---

## Yum / DNF Package Manager

`yum` and `dnf` are **high-level package managers** that sit on top of `rpm`. They automatically resolve and install dependencies.

> `dnf` is the modern replacement for `yum`. On newer systems (RHEL 8+, CentOS Stream 9), `yum` is actually an alias for `dnf`.

### Common Commands

```bash
yum install package_name -y       # install a package
yum remove package_name -y        # remove a package
yum update -y                     # update all packages
yum update package_name -y        # update a specific package
yum list installed                # list all installed packages
yum search package_name           # search for a package
yum info package_name             # show package details
```

| Option | Meaning |
|--------|---------|
| `-y` | Automatically answer yes to prompts |

### Repository Configuration

Yum pulls packages from configured repositories:

```bash
cd /etc/yum.repos.d/
ls
cat /etc/yum.repos.d/*.repo
```

> Each `.repo` file defines a package source — a URL where `yum` looks for packages. Third-party software like Jenkins requires adding a custom `.repo` file first.

---

## Installing Packages from External Repositories

Some packages (like Jenkins) are not available in the default OS repositories. The process is:

1. Add the external repository
2. Import the GPG key (verifies package authenticity)
3. Install the package with `yum`

Example — adding the Jenkins repository:

```bash
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
yum install jenkins -y
```

> GPG keys verify that packages come from a trusted source and have not been tampered with. Always import the key before installing from an external repo.

---

## 🧪 Lab: Software Management

### Setup

1. Switch to root:
```bash
   sudo -i
```

2. Identify your OS and architecture:
```bash
   cat /etc/os-release
   arch
```

---

### List Installed Packages

3. List all installed packages:
```bash
   rpm -qa
```

4. Count how many packages are installed:
```bash
   rpm -qa | wc -l
```

5. Check if `git` is already installed:
```bash
   rpm -qa | grep git
```

---

### Manual RPM Installation — telnet

6. Search for the telnet package URL for your architecture, then download it:
```bash
   curl https://vault.centos.org/8.5.2111/BaseOS/x86_64/os/Packages/telnet-0.17-76.el8.x86_64.rpm -o telnet.rpm
```

7. Install the downloaded RPM:
```bash
   rpm -ivh telnet.rpm
```

8. Verify the installation:
```bash
   rpm -qa | grep telnet
```

9. Remove the package:
```bash
   rpm -e telnet
   rpm -qa | grep telnet
```

---

### Install with Yum — httpd

10. Search for the `httpd` package:
```bash
    yum search httpd
    yum info httpd
```

11. Install `httpd`:
```bash
    yum install httpd -y
```

12. Verify installation:
```bash
    rpm -qa | grep httpd
```

13. Start and enable the service:
```bash
    systemctl start httpd
    systemctl enable httpd
    systemctl status httpd
```

14. Remove `httpd`:
```bash
    yum remove httpd -y
```

---

### Install from External Repository — Jenkins

15. Check existing repositories:
```bash
    ls /etc/yum.repos.d/
```

16. Add the Jenkins repository:
```bash
    wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
```

17. Import the GPG key:
```bash
    rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
```

18. Install Jenkins (requires Java first):
```bash
    yum install java-17-openjdk -y
    yum install jenkins -y
```

19. Verify and start Jenkins:
```bash
    rpm -qa | grep jenkins
    systemctl start jenkins
    systemctl enable jenkins
    systemctl status jenkins
```

20. **Challenge:** Install `nginx` using `yum`, verify it is running, then remove it cleanly:
```bash
    yum install nginx -y
    systemctl start nginx
    systemctl status nginx
    curl http://localhost
    systemctl stop nginx
    yum remove nginx -y
    rpm -qa | grep nginx
```