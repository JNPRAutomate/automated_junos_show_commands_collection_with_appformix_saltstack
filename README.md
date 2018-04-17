## SaltStack Git execution module demo 
```
salt-key -L
```
```
# salt core-rtr-p-01 git.clone /tmp/local_copy git@github.com:JNPRAutomate/appformix_saltstack_automated_show_commands_collection.git identity="/root/.ssh/id_rsa"
core-rtr-p-01:
    True

# salt core-rtr-p-01 cmd.run "ls /tmp/local_copy"
core-rtr-p-01:
    README.md
    collect_junos_show_commands.sls
    ...

# salt core-rtr-p-01 git.config_set user.email me@example.com cwd=/tmp/local_copy
core-rtr-p-01:
    - me@example.com

# salt core-rtr-p-01 git.config_set user.name ksator cwd=/tmp/local_copy
core-rtr-p-01:
    - ksator
    
# salt core-rtr-p-01 git.config_get user.name cwd=/tmp/local_copy
core-rtr-p-01:
    ksator

# salt core-rtr-p-01 git.pull /tmp/local_copy
core-rtr-p-01:
    Already up-to-date.

# salt core-rtr-p-01 file.touch "/tmp/local_copy/test.txt"
core-rtr-p-01:
    True

# salt core-rtr-p-01 file.write "/tmp/local_copy/test.txt" "hello from SaltStack using git executiom module"
core-rtr-p-01:
    Wrote 1 lines to "/tmp/local_copy/test.txt"

# salt core-rtr-p-01 cmd.run "more /tmp/local_copy/test.txt"
core-rtr-p-01:
    ::::::::::::::
    /tmp/local_copy/test.txt
    ::::::::::::::
    hello from SaltStack using git executiom module

# salt core-rtr-p-01 git.status /tmp/local_copy
core-rtr-p-01:
    ----------
    untracked:
        - test.txt

# salt core-rtr-p-01 git.add /tmp/local_copy /tmp/local_copy/test.txt
core-rtr-p-01:
    add 'test.txt'

# salt core-rtr-p-01 git.status /tmp/local_copy
core-rtr-p-01:
    ----------
    new:
        - test.txt

# salt core-rtr-p-01 git.commit /tmp/local_copy 'The commit message'
core-rtr-p-01:
    [master 60f5943] The commit message
     1 file changed, 1 insertion(+)
     create mode 100644 test.txt

# salt core-rtr-p-01 git.status /tmp/local_copy
core-rtr-p-01:
    ----------

# salt core-rtr-p-01 git.push /tmp/local_copy origin master identity="/root/.ssh/id_rsa"
core-rtr-p-01:

```
## Test your Junos proxy daemons

ssh to the Salt master.

On the Salt master, list all the keys. 
```
# salt-key -L
```
Run this command to check if the minions are up and responding to the master. This is not an ICMP ping.
```
# salt -G 'roles:minion' test.ping
```
```
# salt core-rtr-p-01 test.ping
core-rtr-p-01:
    True
```
List the grains: 
```
# salt core-rtr-p-01 grains.ls
...
```
Get the value of the key nodename. 
```
# salt core-rtr-p-01 grains.item nodename
core-rtr-p-01:
    ----------
    nodename:
        svl-util-01
```
So, the junos proxy daemon ```core-rtr-p-01``` is running on the minion ```svl-util-01```  

The Salt Junos proxy has some requirements (junos-eznc python library and other dependencies).
```
# salt svl-util-01 cmd.run "pip list | grep junos"
svl-util-01:
    junos-eznc (2.1.7)
```
```
# salt core-rtr-p-01 junos.cli "show chassis hardware"
core-rtr-p-01:
    ----------
    message:

        Hardware inventory:
        Item             Version  Part number  Serial number     Description
        Chassis                                VM5AA80D5BB2      VMX
        Midplane
        Routing Engine 0                                         RE-VMX
        CB 0                                                     VMX SCB
        FPC 0                                                    Virtual FPC
          CPU            Rev. 1.0 RIOT-LITE    BUILTIN
          MIC 0                                                  Virtual
            PIC 0                 BUILTIN      BUILTIN           Virtual
    out:
        True
```
## 
```
# salt core-rtr-p-01 state.apply collect_junos_show_commands
```


