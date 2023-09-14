#!/bin/bash

# Directorio del repositorio
repo_dir=/home/i4n1/Obsidian/ObsidianMasuVaultBackUp

# Función para realizar el git pull
do_git_pull() {
    cd "$repo_dir"
    git stash;
    git pull;
    git stash clear;
}

# Bucle infinito para realizar git pull cada 20 minutos
while true
do
    do_git_pull
    sleep 1200 # 1200 segundos = 20 minutos
done
