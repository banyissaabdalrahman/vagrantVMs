# Pipes

A pipe (`|`) sends the output of one command as input to another command.

Example:

```bash
cd /etc/ && ls | wc -l
```

Examples:

```bash
cd /etc/ && ls | grep host
tail -20 /var/log/messages | grep -i vagrant
free -m | grep -i mem
cd /etc/ && ls -l | tail
```