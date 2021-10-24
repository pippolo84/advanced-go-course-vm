#!/bin/bash

set -Eeuo pipefail

# set to true to debug script output
DEBUG=false

function install_go {
    echo Installing Go

    go_version=1.17.1
    go_sum=dab7d9c34361dc21ec237d584590d72500652e7c909bf082758fb63064fca0ef
    echo -e "\tinstalling version $go_version"
    mkdir /godl
    pushd /godl > /dev/null
        wget -q -O go.tar.gz https://golang.org/dl/go$go_version.linux-amd64.tar.gz
        sha256sum --quiet -c <(echo "$go_sum go.tar.gz")
        tar -C /usr/local -xzf go.tar.gz
    popd > /dev/null
    rm -r /godl

    echo -e "\tsetting up path env vars"
    export PATH=$PATH:/usr/local/go/bin
    echo 'export PATH=$PATH:/usr/local/go/bin' >> /home/vagrant/.profile
    echo 'export PATH=$PATH:/home/vagrant/go/bin' >> /home/vagrant/.profile
    echo 'export PATH=$PATH:/usr/local/go/bin' >> /root/.profile
    echo 'export PATH=$PATH:/root/go/bin' >> /root/.profile

    echo Done Installing Go
}

function install_delve {
    echo Installing Delve

    echo -e "\tinstalling for root user"
    go install github.com/go-delve/delve/cmd/dlv@v1.7.2

    echo -e "\tinstalling for vagrant user"
    sudo -iu vagrant go install github.com/go-delve/delve/cmd/dlv@v1.7.2

    echo Done Installing Delve
}

function install_bpfcc_tools {
    echo Installing bpfcc-tools

    add-apt-repository -y universe
    apt-get update -qq
    apt install -qq -y bpfcc-tools

    echo Done Installing bpfcc-tools
}

function install_gdb {
    echo Installing gdb

    apt-get update -qq
    apt-get install -qq -y gdb

    echo Done Installing gdb
}

function configure_ptrace {
    echo Configuring ptrace yama setting

    echo 0 > /proc/sys/kernel/yama/ptrace_scope

    echo Done Configuring ptrace yama setting
}

function install_docker {
    echo Installing Docker

    echo -e "\tinstalling apt repository"
    apt-get update -qq
    apt-get install -qq --yes \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg \
        lsb-release
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
    add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable"

    echo -e "\tinstalling docker ce"
    apt-get update -qq
    apt-get install -qq -y \
        docker-ce \
        docker-ce-cli \
        containerd.io

    echo -e "\tadding vagrant user to docker group"
    usermod -aG docker vagrant

    echo -e "\tpulling go image"
    docker pull -q golang:1.17

    echo Done Installing Docker
}

function install_protoc {
    echo "Installing protobuf-compiler"

    apt-get update -qq
    apt install -qq -y protobuf-compiler
    
    echo "Done installing protobuf-compiler"
}

function install_perf {
    echo "Installing perf"

    apt-get update -qq
    apt install -qq -y linux-tools-common linux-tools-generic linux-tools-5.11.0-37-generic

    echo "Done installing perf"
}

function install_graphviz {
    echo "Installing graphviz"

    apt install -qq -y graphviz

    echo "Done installing graphviz"
}

function install_bpftrace {
    echo "Installing bpftrace"

    apt install -y -qq bpftrace

    echo "Done installing bpftrace"
}

function main {
    install_go
    install_delve
    install_bpfcc_tools
    install_gdb
    configure_ptrace
    install_docker
    install_protoc
    install_perf
    install_graphviz
    install_bpftrace
}

[ "$DEBUG" = "false" ] && exec 2>/dev/null
main
wait
