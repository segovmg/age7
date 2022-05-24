# "chmod +x docker_install.sh" needed to run ./docker_install.sh

if ! [ -x "$(command -v docker)" ]; then
    echo 'Error: docker is not installed.' >&2
    # Docker instalation - https://docs.docker.com/engine/install/ubuntu/
    {
    sudo apt-get update && \
    sudo apt-get install \
        ca-certificates \
        curl \
        gnupg \
        lsb-release && \

    sudo mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \

    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null && \

    sudo apt-get update && \
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin && \

    docker --version
} > logs/docker_install.txt
else
  echo 'Error: docker is installed.' >&2
  exit 1  
fi