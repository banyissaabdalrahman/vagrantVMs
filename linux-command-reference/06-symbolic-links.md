# Symbolic Links

```bash
ln -s /opt/dev/ops/devops/test/commands.txt cmds
rm cmds
unlink cmds
```

---

## 🧪 Lab: Symbolic Links

1. Create a directory and a file to link to:
```bash
   mkdir -p /opt/dev/ops/devops/test
   echo "my commands file" > /opt/dev/ops/devops/test/commands.txt
```

2. Navigate to your home directory:
```bash
   cd ~
```

3. Create a symbolic link to the file:
```bash
   ln -s /opt/dev/ops/devops/test/commands.txt cmds
```

4. Verify the link was created — notice the `l` at the start and the `->` pointing to the target:
```bash
   ls -l cmds
```

5. Access the file through the link:
```bash
   cat cmds
```

6. Check the file type of the link:
```bash
   file cmds
```

7. Remove the link using `rm` — note the original file is **not** deleted:
```bash
   rm cmds
```

8. Recreate the link and remove it using `unlink` instead:
```bash
   ln -s /opt/dev/ops/devops/test/commands.txt cmds
   unlink cmds
```

9. Confirm the original file still exists:
```bash
   cat /opt/dev/ops/devops/test/commands.txt
```

10. **Challenge:** Create a symbolic link to a directory instead of a file and navigate into it:
```bash
    ln -s /opt/dev/ops/devops/test mydir
    cd mydir
    ls
```