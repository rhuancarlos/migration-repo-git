#!/bin/bash

# Função para ler entrada do usuário
read_input() {
  local prompt="$1"
  local input
  read -p "$prompt" input
  echo "$input"
}

# Função para exibir barra de progresso (usada em operações longas)
show_progress() {
  local duration=$1
  echo -n "["
  for ((i=0; i<duration; i++)); do
    echo -n "#"
    sleep 1
  done
  echo "]"
}

# Função para exibir mensagens em amarelo
yellow_text() {
  local text="$1"
  echo -e "\e[33m$text\e[0m"
}

# Função para exibir mensagens em verde
green_text() {
  local text="$1"
  echo -e "\e[32m$text\e[0m"
}

# Função para exibir mensagens em azul
blue_text() {
  local text="$1"
  echo -e "\e[34m$text\e[0m"
}

# Função para exibir mensagens em vermelho
red_text() {
  local text="$1"
  echo -e "\e[31m$text\e[0m"
}

echo "======================================================================================================="
echo "∥                               Atualização de código entre repositórios GIT                          ∥"
echo "∥                                                                                                     ∥"
echo "∥ > AVISO IMPORTANTE:                                                                                 ∥"
echo "∥ Caso ocorrá alguma falha nos processos de clonagem e mesclagem, o todo o processo será abortado.    ∥"
echo "∥                                                                                                     ∥"
echo "∥ > PROCESSO REALIZADO POR ESTE SCRIPT                                                                ∥"
echo "∥  1. Clonamos os repositórios 1 e 2.                                                                 ∥"
echo "∥  2. Listamos as branches existentes nos repositórios.                                               ∥"
echo "∥  3. Verificamos se as branches informadas pelo usuário existem nos repositórios.                    ∥"
echo "∥  4. Navegamos até o diretório do repositório 2.                                                     ∥"
echo "∥  5. Adicionamos o repositório 1 como remoto.                                                        ∥"
echo "∥  6. Buscamos as mudanças do repositório 1.                                                          ∥"
echo "∥  7. Criamos uma nova branch temporária no repositório 2 baseada na branch especificada.             ∥"
echo "∥  8. Mesclamos as mudanças da branch 'main' do repositório 1 na branch temporária do repositório 2.  ∥"
echo "∥  9. Perguntamos ao usuário se deseja enviar as mudanças para o repositório remoto.                  ∥"
echo "∥  10. Enviamos a branch temporária para o repositório remoto.                                        ∥"
echo "∥  11. Limpamos o diretório temporário do repositório 1.                                              ∥"
echo "∥  12. Perguntamos ao usuário se deseja deletar o diretório do repositório 2.                         ∥"
echo "∥  13. Deletamos o diretório do repositório 2, caso solicitado.                                       ∥"
echo "∥  14. Mensagem final de sucesso.                                                                     ∥"
echo "∥                                                                                                     ∥"
echo "∥ Author: Rhuan Carlos                                                                                ∥"
echo "∥ E-mail: rhuancarloscodev@gmail.com                                                                  ∥"
echo "∥ Created: 22/Nov 2024 18h48                                                                          ∥"
echo "======================================================================================================="
echo "****"
echo "***"
echo "**"
echo "*"
START=$(read_input "Deseja [i]niciar ou [c]ancelar? (i/c): ")
if [ "$START" = "i" ]; then
  # Solicita as entradas do usuário
  REPO_1_URL=$(read_input "Digite a URL do repositório 1: ")
  REPO_2_URL=$(read_input "Digite a URL do repositório 2: ")

  # Diretórios dos repositórios
  PATH_PROJECT="${PWD}/migration-repo-git"
  REPO_1_DIR="repo_1"
  REPO_2_DIR="repo_2"
else
  yellow_text "Processo finalizado pelo usuário"
  exit 1
fi

# Verifica se o diretório do repositório 1 existe
if [ -d "$REPO_1_DIR" ]; then
  ACTION=$(read_input "O diretório do repositório 1 já existe. Deseja [a]tualizar, [r]emover e clonar novamente, ou [p]rosseguir conforme está? (a/r/p): ")
  if [ "$ACTION" = "r" ]; then
    rm -rf $REPO_1_DIR
    yellow_text "1/14: Clonando o repositório 1 (o mais atualizado)..."
    git clone $REPO_1_URL $REPO_1_DIR
    if [ $? -ne 0 ]; then
      echo "Falha ao clonar o repositório 1. Abortando o processo."
      exit 1
    else
      green_text "Repositório 1 clonado com sucesso!"
    fi
  elif [ "$ACTION" = "a" ]; then
    yellow_text "Atualizando o repositório 1..."
    cd $REPO_1_DIR
    git pull
    cd ..
  fi
else
  yellow_text "1/14: Clonando o repositório 1 (o mais atualizado)..."
  git clone $REPO_1_URL $REPO_1_DIR
  if [ $? -ne 0 ]; then
    echo "Falha ao clonar o repositório 1. Abortando o processo."
    exit 1
  else
    green_text "Repositório 1 clonado com sucesso!"
  fi
fi

# Verifica se o diretório do repositório 2 existe
if [ -d "$REPO_2_DIR" ]; then
  ACTION=$(read_input "O diretório do repositório 2 já existe. Deseja [a]tualizar, [r]emover e clonar novamente, ou [p]rosseguir conforme está? (a/r/p): ")
  if [ "$ACTION" = "r" ]; then
    rm -rf $REPO_2_DIR
    yellow_text "2/14: Clonando o repositório 2..."
    git clone $REPO_2_URL $REPO_2_DIR
    if [ $? -ne 0 ]; then
      echo "Falha ao clonar o repositório 2. Abortando o processo."
      rm -rf $REPO_1_DIR
      exit 1
    else
      green_text "Repositório 2 clonado com sucesso!"
    fi
  elif [ "$ACTION" = "a" ]; then
    yellow_text "Atualizando o repositório 2..."
    cd $REPO_2_DIR
    git pull
    cd ..
  fi
else
  yellow_text "2/14: Clonando o repositório 2..."
  git clone $REPO_2_URL $REPO_2_DIR
  if [ $? -ne 0 ]; then
    echo "Falha ao clonar o repositório 2. Abortando o processo."
    rm -rf $REPO_1_DIR
    exit 1
  else
    green_text "Repositório 2 clonado com sucesso!"
  fi
fi

# Listagem das branches existentes nos repositórios
cd $REPO_1_DIR
yellow_text "3/14: Listando branches existentes no repositório 1..."
LIST_BRANCHES_REP_1=$(git branch -r)
if [ $? -ne 0 ]; then
  echo "Falha ao listar branches do repositório 1."
elif [ -z "$LIST_BRANCHES_REP_1" ]; then
  echo "Não existe nenhum branch no repositório 1"
else
  echo "$LIST_BRANCHES_REP_1"
fi
cd ..
cd $REPO_2_DIR
yellow_text "4/14: Listando branches existentes no repositório 2..."
LIST_BRANCHES_REP_2=$(git branch -r)
if [ $? -ne 0 ]; then
  echo "Falha ao listar branches do repositório 2."
elif [ -z "$LIST_BRANCHES_REP_2" ]; then
  echo "Não existe nenhum branch no repositório 2"
else
  echo "$LIST_BRANCHES_REP_2"
fi
cd ..

# Entrada de branch pelo usuário
yellow_text "5/14: Definindo as branches de unificação entre os projetos..."
REPO_1_BRANCH=$(read_input "Digite o nome da branch do repositório 1: ")
REPO_2_BRANCH=$(read_input "Digite o nome da branch do repositório 2: ")

# Verificação das branches informadas pelo usuário
yellow_text "6/14: Verificando se as branches informadas existem nos repositórios..."
cd $REPO_1_DIR
BRANCH_EXISTS_1=$(git branch -r | grep "origin/$REPO_1_BRANCH")
cd ..
cd $REPO_2_DIR
BRANCH_EXISTS_2=$(git branch -r | grep "origin/$REPO_2_BRANCH")

if [ -z "$BRANCH_EXISTS_1" ]; then
  echo "A branch $REPO_1_BRANCH não existe no repositório 1. Abortando o processo."
  cd ..
  rm -rf $REPO_1_DIR
  rm -rf $REPO_2_DIR
  exit 1
else
  green_text "A branch $REPO_1_BRANCH existe no repositório 1."
fi

if [ -z "$BRANCH_EXISTS_2" ]; then
  echo "A branch $REPO_2_BRANCH não existe no repositório 2. Será sugerido criar a branch 'main'."
  REPO_2_BRANCH="main"
  git checkout -b $REPO_2_BRANCH
  green_text "Branch 'main' criada no repositório 2."
else
  green_text "A branch $REPO_2_BRANCH existe no repositório 2."
fi
cd ..

# Navegação para o diretório do repositório 2
yellow_text "7/14: Navegando até o diretório do repositório 2..."
cd $REPO_2_DIR
if [ $? -ne 0 ]; then
  echo "Falha ao navegar para o diretório do repositório 2. Abortando o processo."
  rm -rf ../$REPO_1_DIR
  rm -rf ../$REPO_2_DIR
  exit 1
fi

# Adiciona o repositório 1 como remoto
yellow_text "8/14: Adicionando o repositório 1 como remoto..."
git remote add repo1 ../$REPO_1_DIR
if [ $? -ne 0 ]; then
  echo "Falha ao adicionar o repositório 1 como remoto. Abortando o processo."
  cd ..
  rm -rf $REPO_1_DIR
  rm -rf $REPO_2_DIR
  exit 1
fi

# Busca as mudanças do repositório 1
yellow_text "9/14: Buscando mudanças do repositório 1..."
git fetch repo1
if [ $? -ne 0 ]; then
  echo "Falha ao buscar mudanças do repositório 1. Abortando o processo."
  cd ..
  rm -rf $REPO_1_DIR
  rm -rf $REPO_2_DIR
  exit 1
fi

# Cria uma nova branch temporária no repositório 2
yellow_text "10/14: Criando uma nova branch temporária no repositório 2..."
git checkout -b temp_$REPO_2_BRANCH repo1/$REPO_1_BRANCH
if [ $? -ne 0 ]; then
  echo "Falha ao criar a branch temporária no repositório 2. Abortando o processo."
  cd ..
  rm -rf $REPO_1_DIR
  rm -rf $REPO_2_DIR
  exit 1
fi

# Mescla as mudanças da branch main do repositório 1 na branch temporária do repositório 2
yellow_text "11/14: Mesclando mudanças da branch main do repositório 1 na branch temporária do repositório 2..."
git merge repo1/$REPO_1_BRANCH
MERGE_EXIT_CODE=$?

# Verifica se a mesclagem foi bem-sucedida ou se há conflito
if [ $MERGE_EXIT_CODE -ne 0 ]; then
  if git ls-files -u | grep -q '^'; then
    echo "Conflitos de mesclagem detectados. Abortando o processo."
  else
    echo "Falha na mesclagem. Não é possível mesclar. Abortando o processo."
  fi
  cd ..
  rm -rf $REPO_1_DIR
  rm -rf $REPO_2_DIR
  exit 1
else
  show_progress 5
  green_text "Mesclagem concluída com sucesso!"
fi

# Pergunta se o usuário deseja enviar as mudanças para o repositório remoto
yellow_text "12/14: Envio das alterações para o repositório remoto..."
SEND_PUSH=$(read_input "Deseja enviar as mudanças para o repositório remoto? (s/n): ")
if [ "$SEND_PUSH" = "s" ]; then
  yellow_text "13/14: Enviando mudanças para o repositório remoto..."
  git push origin temp_$REPO_2_BRANCH:$REPO_2_BRANCH
  if [ $? -ne 0 ]; then
    echo "Falha ao enviar para o repositório remoto."
  else
    show_progress 5
    green_text "Envio para o repositório remoto concluído com sucesso!"
  fi
else
  yellow_text "13/14: Enviando mudanças para o repositório remoto..."
  echo "Envio para o repositório remoto cancelado pelo usuário."
fi

# Limpa o diretório temporário do repositório 1
rm -rf ../$REPO_1_DIR

# Pergunta se o usuário deseja deletar o diretório do repositório 2
yellow_text "14/14: Deletar diretório do repositório 2..."
DELETE_REPO_2=$(read_input "Deseja deletar o diretório do repositório 2? (s/n): ")
if [ "$DELETE_REPO_2" = "s" ]; then
  rm -rf ../$REPO_2_DIR
  green_text "Diretório do repositório 2 deletado."
else
  echo "Diretório do repositório 2 mantido."
fi

# Mensagem final de sucesso
green_text "Processo concluído com sucesso!"