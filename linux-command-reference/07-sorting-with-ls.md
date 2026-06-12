# Sorting with ls

```bash
ls -l
ls -lt
ls -ltr
```

---

## 🧪 Lab: Sorting with ls

1. Navigate to your home directory:
```bash
   cd ~
```

2. Create a few files with a small delay between each so they have different timestamps:
```bash
   touch file_a.txt
   sleep 1
   touch file_b.txt
   sleep 1
   touch file_c.txt
```

3. List files in long format:
```bash
   ls -l
```

4. List files sorted by **newest first**:
```bash
   ls -lt
```

5. List files sorted by **oldest first** (reverse):
```bash
   ls -ltr
```

6. Observe the difference — `file_c.txt` should appear first with `-lt` and last with `-ltr`

7. **Challenge:** Combine with `-a` to include hidden files, sorted by oldest first:
```bash
   ls -ltra
```

   | Option | Meaning |
   |--------|---------|
   | `-l` | Long format |
   | `-t` | Sort by modification time, newest first |
   | `-r` | Reverse the sort order |
   | `-a` | Include hidden files |