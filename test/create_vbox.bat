@echo off

set VB_EXEC=VBoxManage
set VM=ArchLinux_64
set ARCH_LINUX_ISO=archlinux.iso

%VB_EXEC% createhd --filename %VM%.vdi --size 53248
%VB_EXEC% createvm --name %VM% --ostype %VM% --register
%VB_EXEC% storagectl %VM% --name sata_controller --add sata --controller IntelAHCI
%VB_EXEC% storageattach %VM% --storagectl sata_controller --port 0 --device 0 --type hdd --medium %VM%.vdi
%VB_EXEC% storagectl %VM% --name ide_controller --add ide
%VB_EXEC% storageattach %VM% --storagectl ide_controller --port 0 --device 0 --type dvddrive --medium %ARCH_LINUX_ISO%
%VB_EXEC% modifyvm %VM% --memory 512 --vram 16 --natpf1 "guestssh,tcp,,2200,,22"
%VB_EXEC% modifyvm %VM% --hostonlyadapter2 "VirtualBox Host-Only Network"
%VB_EXEC% startvm %VM%
