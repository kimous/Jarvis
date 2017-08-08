#! /bin/ksh
# Script : Ca_Va.sh
# Description : Dit si ça va bien
# ID DECLENCHE : va

#############################################################
# VARIABLES
#############################################################


#############################################################
# DIFFUSION DE LA REPONSE
#############################################################
# Voix
say -v "${VOX}" "ça va, et toi ?"
echo "RETURN:ça va, et toi ?:$(date +%H:%M)" >> ${HISTORIQUE_FILE}

# Fermeture du terminal
#osascript -e 'tell application "Terminal" to quit' &