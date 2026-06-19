# Processes

Every running program on Linux is represented as a **process** — identified by a unique Process ID (PID) and tracked in a process table maintained by the kernel.

---

## top — Dynamic Process Viewer

```bash
top
```

> `top` shows all running processes **dynamically** — the display refreshes in real time (every few seconds), updated based on RAM and CPU usage.

Key columns in `top`:

| Column | Meaning |
|--------|---------|
| `PID` | Process ID |
| `USER` | Owner of the process |
| `%CPU` | Current CPU usage |
| `%MEM` | Current memory usage |
| `STAT` | Process state (see below) |
| `COMMAND` | The command/program running |

Useful keys while `top` is running:

| Key | Action |
|-----|--------|
| `q` | Quit |
| `M` | Sort by memory usage |
| `P` | Sort by CPU usage |
| `k` | Kill a process (prompts for PID) |
| `1` | Show per-core CPU breakdown |

> `top` is your first stop when a system feels slow — sort by `%CPU` or `%MEM` to immediately spot what's consuming resources.

---

## Process States

Processes move through different states during their lifecycle:

| State | Symbol | Meaning |
|-------|--------|---------|
| Running | `R` | Currently executing or ready to run |
| Sleeping | `S` | Waiting for an event (e.g. I/O) |
| Stopped | `T` | Paused, usually by a signal |
| Zombie | `Z` | Finished execution, but still has an entry in the process table |

### Zombie Process

> A **zombie process** is a process whose operations are complete, but its entry is still in the process table — it has finished but hasn't been "cleaned up" yet. This happens because the parent process hasn't read the child's exit status. Zombies consume a process table slot but no CPU or memory resources. They typically disappear once the parent process acknowledges them or exits.

---

## ps -aux — Static Process Snapshot

```bash
ps -aux
```

> `ps -aux` works similarly to `top`, but it's a **static snapshot** — it does not refresh automatically. You see the system's process state at the exact moment you ran the command.

| Option | Meaning |
|--------|---------|
| `a` | Show processes for all users |
| `u` | Display user-oriented format (shows %CPU, %MEM) |
| `x` | Include processes not attached to a terminal |

| Column | Meaning |
|--------|---------|
| `PID` | Process ID |
| `%CPU` | CPU usage at the time of the snapshot |
| `%MEM` | Memory usage at the time of the snapshot |
| `COMMAND` | Command that started the process |

---

## ps -ef — Process Hierarchy

```bash
ps -ef
```

> `ps -ef` shows all processes **along with their parent process** — useful for understanding which process spawned which.

| Option | Meaning |
|--------|---------|
| `-e` | Show every process |
| `-f` | Full format listing |

| Column | Meaning |
|--------|---------|
| `UID` | User running the process |
| `PID` | Process ID |
| `PPID` | Parent Process ID — the process that started this one |
| `C` | CPU utilization |
| `STIME` | Start time |
| `CMD` | Command with full arguments |

> Every process (except the very first one, `PID 1`) has a parent. This relationship is called the **process tree**.

---

## Filtering Processes with grep

```bash
ps -ef | grep httpd | grep -v "grep"
```

> This returns all processes related to `httpd`.

Breaking it down:

- `ps -ef` → list all processes
- `grep httpd` → filter only lines containing "httpd"
- `grep -v "grep"` → exclude the `grep` command itself from the results (since the search command shows up in the process list too)

> Without `grep -v "grep"`, the output would include a line for the `grep httpd` command itself — since it briefly appears as a running process.

---

## Killing Processes

```bash
kill PID
```

Use the `kill` command to terminate the **parent process** and observe what happens.

| Behavior | Result |
|----------|--------|
| Kill the parent process | Child processes may become **orphaned** — no longer attached to their original parent |
| Orphaned processes | Get re-parented to `PID 1` (init/systemd), or may need to be killed manually |

> Killing a parent doesn't always kill its children automatically — this depends on how the application is designed. This is why httpd, for example, can leave behind orphaned worker processes after the parent is killed.

---

## Killing All Related Processes at Once

If killing the parent process leaves orphaned children behind, find and kill them all in one command:

```bash
ps -ef | grep httpd | grep -v "grep" | awk '{print $2}' | xargs kill -9
```

Breaking it down:

| Part | Purpose |
|------|---------|
| `ps -ef` | List all processes |
| `grep httpd` | Filter for httpd-related processes |
| `grep -v "grep"` | Remove the grep command itself from results |
| `awk '{print $2}'` | Extract column 2 — the PID |
| `xargs kill -9` | Pass each PID to `kill -9` |

> `-9` means **force kill** (`SIGKILL`) — it terminates the process immediately without giving it a chance to clean up or save state. Use it as a last resort when a normal `kill` (`SIGTERM`, signal 15) doesn't work.

| Signal | Number | Behavior |
|--------|--------|----------|
| `SIGTERM` | 15 (default) | Polite request to terminate — process can clean up first |
| `SIGKILL` | 9 | Forceful, immediate termination — no cleanup |
| `SIGHUP` | 1 | Often used to reload configuration |

---

## 🧪 Lab: Processes

### Explore with top

1. Open `top` and observe live CPU/memory usage:
```bash
   top
```

2. While `top` is running, press `M` to sort by memory, then `P` to sort by CPU.

3. Quit `top`:
```
   q
```

---

### Static Snapshots with ps

4. Take a static snapshot of all processes:
```bash
   ps -aux
```

5. Take a snapshot showing parent-child relationships:
```bash
   ps -ef
```

6. Compare — find a process in both outputs and note the difference in columns shown.

---

### Filter Specific Processes

7. Install and start httpd if not already running:
```bash
   sudo yum install httpd -y
   sudo systemctl start httpd
```

8. Filter for httpd processes, excluding the grep command itself:
```bash
   ps -ef | grep httpd | grep -v "grep"
```

9. Identify the **parent** process (lowest PID, often owned by root) versus the **worker** processes (owned by `apache`).

---

### Kill the Parent and Observe

10. Note the parent PID, then kill it:
```bash
    ps -ef | grep httpd | grep -v "grep"
    kill <parent_PID>
```

11. Check if any orphaned processes remain:
```bash
    ps -ef | grep httpd | grep -v "grep"
```

12. If orphaned processes are still running, identify their new parent:
```bash
    ps -ef | grep httpd | grep -v "grep"
```
    > Look at the `PPID` column — it may now show `1` (orphaned, re-parented to systemd).

---

### Force Kill All Related Processes

13. Kill all remaining httpd-related processes in one command:
```bash
    ps -ef | grep httpd | grep -v "grep" | awk '{print $2}' | xargs kill -9
```

14. Confirm nothing remains:
```bash
    ps -ef | grep httpd | grep -v "grep"
```

15. Check the service status — note it shows as failed/inactive since processes were killed outside of systemctl:
```bash
    systemctl status httpd
```

16. Restart httpd properly using systemctl:
```bash
    systemctl start httpd
    ps -ef | grep httpd | grep -v "grep"
```

---

### Challenge

17. Write a one-liner to count how many httpd processes are currently running:
```bash
    ps -ef | grep httpd | grep -v "grep" | wc -l
```

18. **Bonus:** Find the top 5 processes consuming the most memory on the system, without using `top`:
```bash
    ps -aux --sort=-%mem | head -6
```

    Break it down:
    - `ps -aux` → list all processes
    - `--sort=-%mem` → sort by memory usage, descending
    - `head -6` → show the header row plus top 5 processes