kill_port() {
if [ -n "$1" ]
then
lsof -ti :"$1" | xargs kill -9
else
echo "Pass in port number."
fi
}


load-nvmrc() {
if [[ -f .nvmrc && -r .nvmrc ]]; then
nvm use
elif [[ $(nvm version) != $(nvm version default)  ]]; then
echo "Reverting to nvm default version"
nvm use default
fi
}

