#!/bin/bash

# Diretório onde as credenciais da AWS são armazenadas
AWS_DIR="$HOME/.aws"

# Criando o diretório, se não existir
mkdir -p "$AWS_DIR"

# Configurando credenciais
echo "[default]
aws_access_key_id = test
aws_secret_access_key = test" > "$AWS_DIR/credentials"

# Configurando a região e o formato de saída
echo "[default]
region = us-east-1
output = json" > "$AWS_DIR/config"

echo "✅ Configuração da AWS CLI para LocalStack concluída!"
