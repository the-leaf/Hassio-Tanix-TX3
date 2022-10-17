#######################################################################
#######################################################################
##                                                                   ##
## THIS SCRIPT SHOULD ONLY BE RUN ON A TANIX TX3 BOX RUNNING ARMBIAN ##
##                                                                   ##
#######################################################################
#######################################################################
set -o errexit  # Exit script when a command exits with non-zero status
set -o errtrace # Exit on error inside any functions or sub-shells
set -o nounset  # Exit script on use of an undefined variable
set -o pipefail # Return exit status of the last command in the pipe that failed

# ==============================================================================
# GLOBALS
# ==============================================================================
readonly HOSTNAME="homeassistant"

# ------------------------------------------------------------------------------
# Installs all required software packages and tools
# ------------------------------------------------------------------------------
install_armbian-software() {
  echo ""
  echo "A instalar Armbian Software..."
  echo ""
  armbian-software
}

install_home_assistant() {
  echo "This script is about to run another script."
  curl -sL https://raw.githubusercontent.com/maxcalavera81/Hassio-Tanix-TX3/main/script_teste.sh | bash -s
  echo "This script has just run another script."
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
#  update_hostname
  install_armbian-software
  install_home_assistant
#  install_dependences
#  install_docker
#  install_osagents
#  install_hassio
