# File Types

```bash
ls -l
file filename
```

- `ls -l` → Long listing format  
- `file` → Identify file type

---

## 🧪 Lab: File Types

1. Navigate to your home directory:
```bash
   cd ~
```

2. Run a long listing to see file types and permissions:
```bash
   ls -l
```

3. Look at the **first character** of each line — it tells you the file type:

   | Character | Type |
   |-----------|------|
   | `-` | Regular file |
   | `d` | Directory |
   | `l` | Symbolic link |
   | `c` | Character device |
   | `b` | Block device |

4. Identify the type of a specific file:
```bash
   file /etc/hostname
```

5. Identify the type of a directory:
```bash
   file /etc
```

6. Identify the type of a binary:
```bash
   file /bin/bash
```

7. **Challenge:** Run `file` against multiple files at once and observe the different types:
```bash
   file /etc/hostname /etc /bin/bash /dev/sda
```