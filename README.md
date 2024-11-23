# Script: Unificar Diretórios GIT com Progresso Visual

Este script automatiza a sincronização entre dois repositórios GIT, implementando uma lógica robusta de clonagem, mesclagem e envio de alterações. Além disso, ele inclui funcionalidades para interação com o usuário, exibição de progresso e tratamento de possíveis conflitos.

---

## Funcionalidades

- Clonagem de dois repositórios GIT.
- Adição de um repositório como remoto de outro.
- Mesclagem de branches específicas entre os repositórios.
- Tratamento de conflitos de mesclagem.
- Envio opcional das alterações para o repositório remoto.
- Limpeza de diretórios temporários após o processo.

---

## Guia de Uso

1. **Clone este repositório ou baixe o script:**

   ```bash
   git clone https://github.com/seu-repositorio/unificar-diretorios-git.git
    ```
Ou faça o download direto do arquivo unificar_diretorios_git_progress.sh.

2. **Conceda permissão de execução ao script:**
    ```bash
    chmod +x unificar_diretorios_git_progress.sh
    ```
3. **Execute o script:**
    ```bash
    ./unificar_diretorios_git_progress.sh
    ```
4. **Siga as instruções interativas no terminal:**
    
    O script solicitará as URLs dos repositórios e outros detalhes necessários.

## Dependências
Certifique-se de que as seguintes ferramentas estão instaladas no seu sistema:

- **GIT**: Para gerenciar os repositórios.
- **Bash**: Para executar o script.

Para instalar o GIT (se necessário):
```bash
sudo apt-get install git  # Debian/Ubuntu
sudo yum install git      # CentOS/Fedora
brew install git          # macOS
```

## Licença
Este script é **GLP** de código aberto e está disponível para forks e modificações. Caso sejam realizadas alterações, _**solicitamos que mantenham a autoria**_: 

- Autor: Rhuan Carlos
- Email: rhuancarloscodev@gmail.com
