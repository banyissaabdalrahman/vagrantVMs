# Filters and Text Processing

## grep

```bash
grep firewall anaconda-ks.cfg
grep -i keyword fileName
grep -R keyword *
grep -v keyword fileName
```

Example:

```bash
grep -R SELINUX /etc/*
```

---

## head and tail

```bash
head fileName
head -n 2 fileName
tail fileName
tail -n 7 fileName
tail -f fileName
```

Example:

```bash
cd /var/log/
tail -f yum.log
tail -f messages
```

---

## cut and awk

```bash
cat /etc/passwd
cut -d: -f1 /etc/passwd
awk -F':' '{print $1}' /etc/passwd
```

---

## Search and Replace

```bash
:%s/searchFor/replaceWith/g
sed 's/searchFor/replaceWith/g' fileName
```