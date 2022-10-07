#!/usr/bin/env bash
###################################################################
###################################################################
##                                                               ##
## -------------INICIANDO INSTALAÇÃO NA TV BOX-------------- ##
##                                                               ##
###################################################################
###################################################################
set -o errexit  # Exit script when a command exits with non-zero status
set -o errtrace # Exit on error inside any functions or sub-shells
set -o nounset  # Exit script on use of an undefined variable
set -o pipefail # Return exit status of the last command in the pipe that failed

# ==============================================================================
# GLOBALS
# ==============================================================================
readonly HOSTNAME="armhassio"
readonly HASSIO_INSTALLER="https://github.com/home-assistant/supervised-installer/releases/latest/download/"
readonly REQUIREMENTS=(
  apparmor-utils
  apt-transport-https
  avahi-daemon
  ca-certificates
  curl
  dbus
  jq
  network-manager
  socat
  software-properties-common
)

# ==============================================================================
# SCRIPT LOGIC
# ==============================================================================

# ------------------------------------------------------------------------------
# Ensures the hostname of the Pi is correct.
# ------------------------------------------------------------------------------
update_hostname() {
  old_hostname=$(< /etc/hostname)
  if [[ "${old_hostname}" != "${HOSTNAME}" ]]; then
    sed -i "s/${old_hostname}/${HOSTNAME}/g" /etc/hostname
    sed -i "s/${old_hostname}/${HOSTNAME}/g" /etc/hosts
    hostname "${HOSTNAME}"
    echo "Hostname will be changed on next reboot: ${HOSTNAME}"
  fi
}

# ------------------------------------------------------------------------------
# Installs all required software packages and tools
# ------------------------------------------------------------------------------
install_requirements() {
  echo "Updating APT packages list..."
  apt-get install software-properties-common
  apt-get update

  echo "Ensure all requirements are installed..."
  apt-get install -y "${REQUIREMENTS[@]}"
}

# ------------------------------------------------------------------------------
# Installs the Docker engine
# ------------------------------------------------------------------------------
install_docker() {
  echo "Installing Docker..."
  curl -fsSL https://get.docker.com | sh
}

# ------------------------------------------------------------------------------
# Installs and starts Hass.io
# ------------------------------------------------------------------------------
install_hassio() {
  echo "Installing Hass.io..."
  curl -sL "${HASSIO_INSTALLER}" | bash -s -- -m qemuarm-64
}

# ------------------------------------------------------------------------------
# Configure network-manager to disable random MAC-address on Wi-Fi
# ------------------------------------------------------------------------------
config_network_manager() {
  {
    echo -e "\n[device]";
    echo "wifi.scan-rand-mac-address=no";
    echo -e "\n[connection]";
    echo "wifi.clone-mac-address=preserve";
  } >> "/etc/NetworkManager/NetworkManager.conf"
}

# ==============================================================================
# RUN LOGIC
# ------------------------------------------------------------------------------
main() {
  # Are we root?
  if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    echo "Please try again after running:"
    echo "  sudo su"
    exit 1
  fi

  # Install ALL THE THINGS!
  update_hostname
  install_requirements
  config_network_manager
  install_docker
  install_hassio

  # Friendly closing message
  ip_addr=$(hostname -I | cut -d ' ' -f1)
  echo "======================================================================="
  echo "Home Assistant está a ser instalado."
  echo "Aguarde cerca de 20 minutos"
  echo "Parabens! O Home Asistant foi instalado"
  echo "Teste por nsf"
  echo "Para aceder vá ao endereço: http://${ip_addr}:8123/"

  exit 0
}
main
