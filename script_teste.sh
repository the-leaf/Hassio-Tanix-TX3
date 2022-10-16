#######################################################################
#######################################################################
##                                                                   ##
## THIS SCRIPT SHOULD ONLY BE RUN ON A TANIX TX3 BOX RUNNING ARMBIAN ##
##                                                                   ##
#######################################################################
#######################################################################
# ==============================================================================
# GLOBALS
# ==============================================================================
readonly HOSTNAME="homeassistant"
readonly OS_AGENT="os-agent_1.2.2_linux_aarch64.deb"
readonly OS_AGENT_PATH="https://github.com/home-assistant/os-agent/releases/download/1.2.2/"
readonly HA_INSTALLER="homeassistant-supervised.deb"
readonly HA_INSTALLER_PATH="https://github.com/home-assistant/supervised-installer/releases/latest/download/"
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
    echo ""
    echo "O nome do host será alterado na próxima reinicialização: ${HOSTNAME}"
    echo ""
  fi
}

# ------------------------------------------------------------------------------
# Installs all required software packages and tools
# ------------------------------------------------------------------------------
install_requirements() {
  echo ""
  echo "Atualizando APT packages list..."
  echo ""
  armbian-software
  sudo apt-get install \
  apparmor \
  jq \
  wget \
  curl \
  udisks2 \
  libglib2.0-bin \
  network-manager \
  dbus \
  systemd-journal-remote -y
}

# ------------------------------------------------------------------------------
# Installs the Docker engine
# ------------------------------------------------------------------------------
install_docker() {
  echo ""
  echo "A instalar Docker..."
  echo ""
  curl -fsSL get.docker.com | sh
}

# ------------------------------------------------------------------------------
# Installs os agents
# ------------------------------------------------------------------------------
install_os_agents() {
  echo ""
  echo "A instalar o Home Assistant..."
  echo ""
  wget https://github.com/home-assistant/os-agent/releases/download/1.4.1/os-agent_1.4.1_linux_aarch64.deb
  sudo dpkg -i os-agent_1.4.1_linux_aarch64.deb
  systemctl status haos-agent
}

# ------------------------------------------------------------------------------
# Install Home Assistant Supervisor
# ------------------------------------------------------------------------------
install_os_agents() {
  echo ""
  echo "A instalar o Home Assistant..."
  echo ""
  wget https://github.com/home-assistant/supervised-installer/releases/latest/download/homeassistant-supervised.deb
  sudo dpkg -i os-agent_1.4.1_linux_aarch64.deb
  sudo dpkg -i homeassistant-supervised.deb
}

  # Friendly closing message
  ip_addr=$(hostname -I | cut -d ' ' -f1)
  echo "======================================================================="
  echo "Hass.io está agora a instalar o Home Assistant."
  echo "Este processo demora a volta de  20 minutes. Abre o seguinte link:"
  echo "http://${HOSTNAME}.local:8123/ no teu browser"
  echo "para carregar o home assistant."
  echo "Se o link acima não funcionar, tenta o seguinte link http://${ip_addr}:8123/"
  echo "Aproveita o teu home assistant :)"

  exit 0
}
main
