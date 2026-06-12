# File and Directory Management

## Create

```bash
mkdir foldername
touch filename.txt
touch devopsfile{1..10}.txt
```

## Copy

```bash
cp file1 destination
cp -r dir1 destination
```

## Move / Rename

```bash
mv source destination
```

## Remove

```bash
rm file
rm -r dir
```

---

## 🧪 Lab: File and Directory Management

1. Navigate to your home directory:
```bash
   cd ~
```

2. Create a new directory to work in:
```bash
   mkdir devops_lab
   cd devops_lab
```

3. Create a single file:
```bash
   touch notes.txt
```

4. Create 10 files at once using brace expansion:
```bash
   touch devopsfile{1..10}.txt
```

5. Verify all files were created:
```bash
   ls
```

6. Create a subdirectory and copy a file into it:
```bash
   mkdir backup
   cp notes.txt backup/
```

7. Copy an entire directory:
```bash
   cp -r backup backup2
```

8. Rename a file:
```bash
   mv notes.txt notes_renamed.txt
```

9. Move a file into a directory:
```bash
   mv notes_renamed.txt backup/
```

10. Remove a single file:
```bash
    rm devopsfile1.txt
```

11. Remove an entire directory:
```bash
    rm -r backup2
```

12. **Challenge:** Remove all remaining `devopsfile` files at once using a wildcard:
```bash
    rm devopsfile*.txt
```

13. Confirm the cleanup:
```bash
    ls
```