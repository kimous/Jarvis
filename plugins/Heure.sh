#! /bin/ksh
# Script : Heure.sh
# Description : Donne l'heure
# ID DECLENCHE : heure

#############################################################
# VARIABLES
#############################################################
# Heure
HEURE=$(date +%H)
# Minutes
MINUTES=$(date +%M)


#############################################################
# DIFFUSION DE LA REPONSE
#############################################################
# Voix
say -v "${VOX}" "Il est ${HEURE} heures ${MINUTES} !"
echo "RETURN:Il est ${HEURE} heures ${MINUTES} !:$(date +%H:%M)" >> ${HISTORIQUE_FILE}


# Fermeture du terminal
#osascript -e 'tell application "Terminal" to quit' &

