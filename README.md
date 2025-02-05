# 🚀 Configuração do LocalStack com AWS CLI

Este documento fornece um guia passo a passo para configurar o LocalStack, instalar as ferramentas necessárias e testar serviços como S3, SQS e SNS.

---

## 📌 **1. Instalar dependências**

### 🔹 **1.1 Instalar Docker**

O LocalStack roda dentro de um contêiner Docker, então certifique-se de que o Docker esteja instalado:

- [Instalar Docker no Linux](https://docs.docker.com/engine/install/ubuntu/)
- [Instalar Docker no macOS](https://docs.docker.com/desktop/install/mac-install/)
- [Instalar Docker no Windows](https://docs.docker.com/desktop/install/windows-install/)

Para verificar a instalação, execute:

```sh
docker --version
```

### 🔹 **1.2 Instalar AWS CLI**

Se a AWS CLI não estiver instalada, siga as instruções para seu sistema operacional:

- **MacOS:**
  ```sh
  brew install awscli
  ```
- **Linux (Ubuntu/Debian):**
  ```sh
  sudo apt update && sudo apt install awscli -y
  ```
- **Windows:** Baixe e instale via [link oficial](https://awscli.amazonaws.com/AWSCLIV2.msi)

Verifique a instalação com:

```sh
aws --version
```

Saída esperada:

```
aws-cli/2.x.x Python/3.x.x ...
```

---

## 🔑 **2. Configurar AWS CLI para LocalStack**

Para facilitar a configuração da AWS CLI para LocalStack, utilize o seguinte script automatizado:

Crie um arquivo chamado `setup_localstack_aws.sh` com o seguinte conteúdo:

```sh
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

# Desativar o paginador da AWS CLI
export AWS_PAGER=""

echo "✅ Configuração da AWS CLI para LocalStack concluída!"
```

Para executar o script, siga os passos abaixo:

1. Dê permissão de execução ao script:
   ```sh
   chmod +x setup_localstack_aws.sh
   ```
2. Execute o script:
   ```sh
   ./setup_localstack_aws.sh
   ```

Isso configurará automaticamente as credenciais, a região e desativará o paginador da AWS CLI para evitar comandos interativos.

---

## ⚙️ **3. Configurar LocalStack**

### 🔹 **3.1 Criar o ****`docker-compose.yml`**

Crie um arquivo chamado `docker-compose.yml` e adicione o seguinte conteúdo:

```yaml
services:
  localstack:
    container_name: "localstack-main"
    image: localstack/localstack
    ports:
      - "127.0.0.1:4566:4566"            # LocalStack Gateway
      - "127.0.0.1:4510-4559:4510-4559"  # Faixa de portas para serviços
    environment:
      - DEBUG=0
      - SERVICES=s3,sqs,sns
    volumes:
      - "./volume:/var/lib/localstack"
      - "/var/run/docker.sock:/var/run/docker.sock"
```

### 🔹 **3.2 Iniciar o LocalStack**

Para rodar o LocalStack:

```sh
docker-compose up -d
```

Para verificar se está rodando:

```sh
docker ps
```

---

## 🛠 **4. Testando os serviços**

### 📂 **4.1 Criar um bucket no S3**

```sh
aws --no-cli-pager --endpoint-url=http://localhost:4566 s3 mb s3://meu-bucket-teste
```

### 📤 **4.2 Fazer upload de um arquivo para o bucket**

```sh
echo "Este é um arquivo de teste para o LocalStack S3" > arquivo_teste.txt
aws --no-cli-pager --endpoint-url=http://localhost:4566 s3 cp arquivo_teste.txt s3://meu-bucket-teste/
```

---

## 🎯 **5. Testando SQS e SNS**

### 📥 **5.1 Criar uma fila no SQS**

```sh
aws --no-cli-pager --endpoint-url=http://localhost:4566 sqs create-queue --queue-name minha-fila
```

### 📤 **5.2 Enviar uma mensagem para a fila**

```sh
aws --no-cli-pager --endpoint-url=http://localhost:4566 sqs send-message --queue-url http://localhost:4566/000000000000/minha-fila --message-body "Teste de mensagem"
```

---

## 🎉 **Conclusão**

Agora você tem um ambiente LocalStack configurado e pode testar os serviços da AWS localmente sem custo! 🚀

Se precisar de mais alguma coisa, entre em contato! 😉

# localstack
