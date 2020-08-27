# Create directories needed
mkdir certs
mkdir config
mkdir logs

# Install libraries
sudo apt install jq
sudo apt install openjdk-8-jdk

# Run scripts
chmod +x ./install-docker.sh
./install-docker.sh
