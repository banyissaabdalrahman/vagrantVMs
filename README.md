# 🖥️ Vagrant VMs

Notes and quick reference for working with Vagrant virtual machines.

---

## 🚨 Common Causes of Issues

If `vagrant up` or other commands fail, check the following:

- **Antivirus software** – May block network or VM-related operations.
- **VPN connection** – Can interfere with networking and box downloads.
- **Proxy server** – May block or misroute Vagrant traffic.

---

## ✅ Quick Fixes

1. Temporarily disable your antivirus.
2. Disconnect from your VPN.
3. Switch to a different internet connection (e.g., mobile hotspot).

---

## 📦 Useful Vagrant Commands

### Box Management

```bash
vagrant box list
```

List all installed boxes.

---

### Initialize a Project

```bash
vagrant init
```

Create a new `Vagrantfile`.

---

### Start the VM

```bash
vagrant up
```

Create and start the virtual machine.

---

### Connect to the VM

```bash
vagrant ssh
```

SSH into the running VM.

---

### Reload the VM

```bash
vagrant reload
```

Restart the VM and apply configuration changes.

---

### Stop the VM

```bash
vagrant halt
```

Gracefully shut down the VM.

---

### Destroy the VM

```bash
vagrant destroy
```

Delete the VM completely.

---

### Check Status

```bash
vagrant status
```

Show status of the current VM.

```bash
vagrant global-status
```

Show status of all Vagrant environments.

```bash
vagrant global-status --prune
```

Clean up invalid or stale entries.