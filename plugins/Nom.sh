#! /bin/ksh
# Script : Bonjour.sh
# Description : Dit bonjour
# ID DECLENCHE : Nom

#############################################################
# VARIABLES
#############################################################


#############################################################
# DIFFUSION DE LA REPONSE
#############################################################
# Voix
say -v "${VOX}" "Je m'appel ${KEY_WORD_ACTIVATION} !"
echo "RETURN:Je m'appel ${KEY_WORD_ACTIVATION} !:$(date +%H:%M)" >> ${HISTORIQUE_FILE}

# Fermeture du terminal
#osascript -e 'tell application "Terminal" to quit' &