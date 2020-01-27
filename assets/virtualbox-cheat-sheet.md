

## Common VirualBox Commands

- `VBoxManage list vms` -- list vms
- `VBoxManage list runningvms` 
- `VBoxManage guestproperty get <usid|vname> "/VirtualBox/GuestInfo/Net/0/V4/IP"`  -- Getting the VM’s IP address
- `VBoxManage showvminfo <usid|vname> --details`

### Start/Stop

#### Start
- `VBoxManage startvm <usid|vname>` 
- `VBoxManage startvm <usid|vname> --type headless` 

#### Stop
- `VBoxManage controlvm <usid|vname> stop` 
- `VBoxManage unregistervm <usid|vname> --delete` -- Unregister/delete a VM
- `VBoxManage unregistervm <usid|vname> poweroff` -- Forcibly Shutdown a VM


###  Add Hardware storage components
- `VBoxManage storagectl <usid|vname> --add sata --name "SCSI Controller"`
