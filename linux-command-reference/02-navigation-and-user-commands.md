# User and Navigation Commands

| Command   | Description |
|------------|------------|
| `whoami`   | Display the current logged-in user |
| `pwd`      | Print the current working directory |
| `cd`       | Change directory |
| `cd ~`     | Navigate to the home directory |
| `ls`       | List directory contents |
| `sudo -i`  | Switch to the root user |

---

## 🧪 Lab: User and Navigation

Practice the commands above in order:

1. Find out who you are logged in as:
```bash
   whoami
```

2. Check your current location in the filesystem:
```bash
   pwd
```

3. Navigate to your home directory:
```bash
   cd ~
```

4. List the contents, including hidden files:
```bash
   ls -la
```

5. Move into a subdirectory (e.g. `Documents`):
```bash
   cd Documents
```

6. Confirm you moved successfully:
```bash
   pwd
```

7. Switch to the root user and check who you are now:
```bash
   sudo -i
   whoami
```

8. Exit the root session:
```bash
   exit
```