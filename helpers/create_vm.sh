#!/bin/bash

BASE_DIR=$(readlink -f $(dirname $0))
cd $BASE_DIR
NAME=$(basename $BASE_DIR)
TARGET=/tmp/$NAME
VBOX=VBoxManage
REPO="http://pet.inf.ufsc.br/mirrors/archlinux/iso/2016.01.01"
LINUX_ISO="archlinux-2016.01.01-dual.iso"
HOST_IP=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')
HOST_PORT="8080"
export DATA_REPO="http://$HOST_IP:$HOST_PORT"

function prepare() {
    if [ ! -f $LINUX_ISO ]; then
        wget $REPO/$LINUX_ISO -O $LINUX_ISO
    fi
    rm -rf $TARGET && mkdir -p $TARGET &> /dev/null
    cp $LINUX_ISO $TARGET
    sed 's#${HOST}#'$DATA_REPO'#g' guest_setup.sh > $TARGET/guest_setup.sh
    tar --exclude=helpers --exclude=.git -zcf $TARGET/archlinux-my-setup.tar.gz ../  &> /dev/null
    docker rm -fv $NAME &> /dev/null
}

function waitShutdown() {
    while VBoxManage list runningvms | grep -q $NAME
    do
        sleep 30
    done
}

if $VBOX list vms | grep -q $NAME; then
    read -p "Já existe uma VM $NAME, deseja recriar [sN]?" -n 1 -r
    echo    # (optional) move to a new line
    if [[ ! $REPLY =~ ^[Ss]$ ]]; then
        echo "Criação da VM $NAME cancelada."
        exit 0
    fi
    $VBOX controlvm $NAME poweroff &> /dev/null
    waitShutdown
    $VBOX unregistervm $NAME --delete &> /dev/null

fi

prepare
set -e
echo "1. Criando maquina virtual $NAME"
$VBOX createvm --name $NAME --register --basefolder .  &> /dev/null
$VBOX modifyvm $NAME --ostype ArchLinux_64 --clipboard hosttoguest --nic1 nat --vram 16 --memory 1024 --acpi on --boot1 dvd --natpf1 "ssh,tcp,,30022,,22"  &> /dev/null
echo "2. Criando HD com com 10gb de capacidade"
$VBOX createmedium disk --filename "$NAME.vdi" --size 20480  &> /dev/null
$VBOX storagectl $NAME --name "IDE Controller" --add ide  &> /dev/null
$VBOX storageattach $NAME --storagectl "IDE Controller" --port 0 --device 0 --type hdd --medium "$NAME.vdi"  &> /dev/null
$VBOX storageattach $NAME --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium $LINUX_ISO  &> /dev/null
echo "3. Inicializando maquina virtual e repositorio de dados"
docker run -d --name $NAME -v $TARGET:/data -v $BASE_DIR/nginx.conf:/etc/nginx/conf.d/default.conf -p "$HOST_PORT:80" nginx  &> /dev/null
printf "4. Criação completa. Selecionar a primeira opção de boot. Após inicializar executar:\nwget -O - $DATA_REPO/guest_setup.sh | sh\n"
VBoxSDL --startvm $NAME  &> /dev/null
printf "5. VM desligada, preparando box Vagrant"
$VBOX storageattach $NAME --storagectl "IDE Controller" --port 1 --device 0 --medium none  &> /dev/null
vagrant box add archlinux-$(basename $REPO).box --name "andreptb/archlinux"
