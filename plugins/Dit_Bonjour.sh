#! /bin/ksh
# Script : Dit_Bonjour.sh
# Description : Ouvre Safari avec une recherche
# ID DECLENCHE : dis bonjour à


RECHERCHE=$(sed -n '/bonjour/,$p' ${FINAL_TRADUCTION} | awk -F"bonjour à" '{print $2}' | sed 's/^[ \t]*//' )


say -v "${VOX}" "Bonjour ${RECHERCHE}!"
echo "RETURN:Bonjour ${RECHERCHE}!:$(date +%H:%M)" >> ${HISTORIQUE_FILE}


# Fermeture du terminal
#osascript -e 'tell application "Terminal" to quit' &




