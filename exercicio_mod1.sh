#!/bin/bash

echo "-------------------------------------------------------------------------"
echo  ------------------------- "EXERCICIO - MODULO 01" ------------------------
echo "-------------------------------------------------------------------------"

echo "Parâmetro 01: $1"
echo "Parâmetro 02: $2"
echo
if [ "$1" -gt "$2" ]; then
  echo "$1 é maior que $2."
  echo "PID é: $$"
  echo "Nome do script é: $0"
  echo "Exercício concluído com sucesso!"
fi
if [ "$1" -lt "$2" ]; then
  echo "$1 é menor que $2."
  echo "O número do primeiro parâmetro: $1 precisa ser maior que $2 para trazer as informações corretas do exercício."
fi
echo
if [ "$1" -eq "$2" ]; then
  echo "$1 é igual a $2"
  echo "O número $1 é igual a $2. Exercício concluído com sucesso!"
fi
