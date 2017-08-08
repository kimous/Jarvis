#! /bin/ksh
# Script : Salut.sh
# Description : Dit bonjour
# ID DECLENCHE : salut

#############################################################
# VARIABLES
#############################################################


#############################################################
# DIFFUSION DE LA REPONSE
#############################################################
# Voix
say -v "${VOX}" "Salut !"
echo "RETURN:Salut !:$(date +%H:%M)" >> ${HISTORIQUE_FILE}
# Fermeture du terminal
#osascript -e 'tell application "Terminal" to quit' &