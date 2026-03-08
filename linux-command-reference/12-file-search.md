# File Search

## find (Real-Time Search)

```bash
find /etc/ -name host*
```

Searches for files by name in real time.

---

## locate (Database-Based Search)

```bash
yum install mlocate -y
updatedb
locate host
```

- `locate` searches using a database  
- Not real-time  
- May not be installed by default