# Vim Editor Notes

## Opening a File

```bash
vim firstfile.txt
```

---

# Vim Modes

Vim has **three main modes**:

## 1. Normal Mode (Command Mode)
- Default mode when Vim starts.
- Used for navigation and commands.

Press `Esc` anytime to return to Normal Mode.

---

## 2. Insert Mode
- Used to write and edit text.

Enter Insert Mode:

- `i` → Insert at cursor position  
- `o` → Open a new line below and enter Insert Mode  

Press `Esc` to return to Normal Mode.

---

## 3. Extended Mode (Command-Line Mode)
- Used for saving, quitting, and settings.
- Entered by typing `:` in Normal Mode.

---

# File Commands

| Command | Description |
|----------|------------|
| `:w` | Save file |
| `:q` | Quit |
| `:wq` | Save and quit |
| `:q!` | Quit without saving (force quit) |

---

# Line Numbers

| Command | Description |
|----------|------------|
| `:set number` or `:se nu` | Show line numbers |
| `:set nonumber` or `:se nonu` | Hide line numbers |

---

# Navigation

| Command | Description |
|----------|------------|
| `G` | Go to last line |
| `gg` | Go to first line |

---

# Copy, Cut, and Paste

| Command | Description |
|----------|------------|
| `yy` | Copy current line |
| `4yy` | Copy 4 lines starting from current line |
| `dd` | Cut (delete) current line |
| `5dd` | Cut 5 lines starting from current line |
| `p` | Paste below |
| `P` | Paste above |
| `u` | Undo |

---

# Search

Start searching:

```
/keyword
```

After a search:

| Command | Description |
|----------|------------|
| `n` | Go to next match |
| `N` | Go to previous match |
| `:noh` | Clear search highlighting |

---

# Quick Summary

- `Esc` → Back to Normal Mode  
- `:` → Enter Extended Mode  
- `/` → Search  

---

These notes cover the essential Vim commands for daily usage.