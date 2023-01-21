#!/bin/bash

pip install -r requirements.txt

gzip docs/ais.1
sudo cp docs/ais.1.gz /usr/share/man/man1

sudo cp -r ./ opt/

printf "\nPlease enter your OpenAI API key:\n"
# shellcheck disable=SC2162
read api_key
sudo touch /opt/openai-search/src/.env
sudo chmod 666 /opt/openai-search/src/.env
echo API_KEY=\'"$api_key"\' > /opt/openai-search/src/.env

chmod +x opt/openai-search/src/main.py

echo 'alias ais="/opt/openai-search/src/main.py"' >> ~/.bashrc
if [ -f "/usr/bin/zsh" ]; then
 	echo 'alias ais="/opt/openai-search/src/main.py"' >> ~/.zshrc
fi

printf "\nInstallation finished successfully!\nThe program is installed to /opt/openai-search and we've added an alias to your bashrc (or zshrc)."
printf "\nBefore using the program please end the current session or type:\n'source ~/.bashrc' - for bash; 'source ~/.zshrc' - for zsh\n"
printf "To view the manual, type: 'man ais'\n"
printf "\nSometimes it might take a while for OpenAI's servers to process your query, so don't panic if you don't get a response immediately :)\nEnjoy!\n"
