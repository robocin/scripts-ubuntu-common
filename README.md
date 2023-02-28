# scripts-ubuntu-common 📜

*Store shell scripts for installing dependencies on Ubuntu.*

## Rules:
- ***These scripts will be able to run on Docker 🐳 servers or containers, so they need to be automatable;***
    - Try to keep the scripts working only when calling them, that is, avoiding interaction with the user;

    ---

    - For `apt install` scripts for example, the `-y` flag is usually added to the end so that `yes` is answered automatically whenever it is requested, e.g.:

    ```bash
    apt install reino-das-coxinhas -y # ok
    apt install good-script           # wrong, add '-y'
    ```

    ---

    - For scripts that accept arguments, assign values by default, e.g.:

    ```bash
    ARG1=${1}

    if [ -z ${ARG1} ] # checks if 'ARG1' is empty
    then
      ARG1="some-default-value"   # add a default value
    fi
    ```

    ---

    - [It may be necessary to add the `DEBIAN_FRONTEND=noninteractive` environment variable to the script](https://askubuntu.com/questions/876240/how-to-automate-setting-up-of-keyboard-configuration-package), e.g.:
    ```bash
    DEBIAN_FRONTEND=noninteractive apt install keyboard-configuration -y # ok
    ```

- ***Do not add the `sudo` keyword at the beginning of the script, it is the responsibility of the command that calls it with that keyword, e.g.:***

```bash
sudo apt install reino-das-coxinhas -y # wrong, remove 'sudo'
sudo apt install good-script           # wrong, remove 'sudo, add '-y'
apt install g++ -y                     # ok
```

- ***Pay attention to the permissions of the added files. Put `chown` if necessary, e.g.:***

```bash
CURRENT_USER=$(who | awk 'NR==1{print $1}')

chown "${CURRENT_USER}":"${CURRENT_USER}" "${DIR}" -R
```

- ***Remove temporary files downloaded with `wget` and similar during script execution, e.g.:***

```bash
wget https://github.com/microsoft/vscode-cpptools/releases/download/1.2.1/cpptools-linux.vsix
code --install-extension cpptools-linux.vsix
rm cpptools-linux.vsix # << don't forget
```
