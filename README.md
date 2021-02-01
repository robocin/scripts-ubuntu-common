# scripts-ubuntu-common 📜

*Esse repositório tem como objetivo apenas armazenar scripts shell para a instalação de dependências no ubuntu, funcionando como submódulo de outros projetos maiores;*

## Regras:

- ***Parte desses scripts poderão rodar em servidores ou containers Docker 🐳, portanto precisam ser automatizáveis;***
    - Procure manter os scripts funcionando apenas ao chamá-los, ou seja, evitando a iteração com o usuário;

    ---

    - Para scripts `apt install`, `apt-get install`  por exemplo, comumente adiciona-se a flag `-y` ao final para que seja respondido `yes` de forma automática sempre que for requisitado, ex:

    ```bash
    apt-get install reino-das-coxinhas -y # ok
    apt-get install script-bom            # errado, adicionar '-y'
    ```

    ---

    - Para scripts que aceitam argumentos, procure a adição de argumentos default, ex:

    ```bash
    ARG1=${1}

    if [ -z ${ARG1} ] # verifica se o argumento 1 é vazio
    then
      ARG1="default-value"   # adiciona um valor default
    fi
    ```

    ---

    - [Pode ser necessário adicionar ao script a variável de ambiente](https://askubuntu.com/questions/876240/how-to-automate-setting-up-of-keyboard-configuration-package) `DEBIAN_FRONTEND=noninteractive` ao inicio, ex:
    ```bash
    DEBIAN_FRONTEND=noninteractive apt-get install keyboard-configuration -y # ok
    ```

- ***Não adicione a keyword `sudo` no começo do script, é responsabilidade do comando que o chamar ser com essa keyword, ex:***

```bash
sudo apt-get install reino-das-coxinhas -y # errado, remover 'sudo'
sudo apt-get install script-bom            # errado, remover 'sudo', adicionar '-y'
apt-get install g++ -y                     # ok
```
