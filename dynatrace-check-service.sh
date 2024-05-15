#!/bin/bash

# Função para verificar a existência do LVM
check_lvm() {
    lv_path="/dev/mapper/$(lsblk -no NAME,MOUNTPOINT | grep '/opt/dynatrace' | awk '{print $1}')"
    if [ -e "$lv_path" ]; then
        echo "LVM /opt/dynatrace encontrado: $lv_path"
        return 0
    else
        echo "LVM /opt/dynatrace não encontrado"
        return 1
    fi
}

# Função para verificar se o LVM está montado corretamente e no fstab
check_mount_fstab() {
    if mountpoint -q /opt/dynatrace; then
        echo "/opt/dynatrace está montado"
    else
        echo "/opt/dynatrace não está montado"
        return 1
    fi
    
    if grep -qs '/opt/dynatrace' /etc/fstab; then
        echo "Entrada de /opt/dynatrace encontrada no fstab"
    else
        echo "Entrada de /opt/dynatrace não encontrada no fstab"
        return 1
    fi
}

# Função para apresentar o tamanho total ocupado no LVM /opt/dynatrace
show_lvm_size() {
    used_size=$(df -h | grep '/opt/dynatrace' | awk '{print $3}')
    echo "Tamanho total ocupado no LVM /opt/dynatrace: $used_size"
}

# Função para verificar se o serviço oneagent.service existe via systemctl
check_systemctl_service() {
    if systemctl list-units --type=service | grep -q 'oneagent.service'; then
        echo "Serviço oneagent.service encontrado via systemctl"
        return 0
    else
        echo "Serviço oneagent.service não encontrado via systemctl"
        return 1
    fi
}

# Função para verificar o status do serviço oneagent usando initd
check_initd_service() {
    if [ -e /etc/init.d/oneagent ]; then
        echo "Serviço oneagent encontrado via init.d"
        service oneagent status
        return 0
    else
        echo "Serviço oneagent não encontrado via init.d"
        return 1
    fi
}

# Função para reiniciar o serviço oneagent se estiver em falha
restart_service_if_needed() {
    if systemctl is-failed oneagent.service &>/dev/null; then
        echo "Serviço oneagent está com falha. Reiniciando serviço..."
        systemctl restart oneagent.service
    else
        echo "Serviço oneagent não está com falha."
    fi
}

# Função para mostrar o status atual do serviço
show_service_status() {
    systemctl status oneagent.service
}

# Executando as funções
check_lvm
lvm_status=$?
check_mount_fstab
mount_status=$?
show_lvm_size
check_systemctl_service
systemctl_status=$?
check_initd_service
initd_status=$?

if [ $lvm_status -eq 0 ] && [ $mount_status -eq 0 ] && [ $systemctl_status -eq 0 ] && [ $initd_status -eq 0 ]; then
    restart_service_if_needed
fi

show_service_status