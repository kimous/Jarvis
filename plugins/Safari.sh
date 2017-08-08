#! /bin/ksh
# Script : Safari.sh
# Description : Ouvre Safari avec une recherche
# ID DECLENCHE : safari


RECHERCHE=$(sed -n '/Safari/,$p' ${FINAL_TRADUCTION} | awk -F"Safari" '{print $2}' | sed 's/^[ \t]*//' )


say -v "${VOX}" "Début de la recherche sur Google pour : ${RECHERCHE}!"
echo "RETURN:Début de la recherche sur Google pour : ${RECHERCHE}!:$(date +%H:%M)" >> ${HISTORIQUE_FILE}

TO_SEARCH=$(sed -n '/Safari/,$p' ${FINAL_TRADUCTION} | awk -F"Safari" '{print $2}' | sed 's/^[ \t]*//' | sed 's/ /+/g' | sed "s/\'/+/g")
sed -n '/Safari/,$p' ${FINAL_TRADUCTION} | awk -F"Safari" '{print $2}' | sed 's/^[ \t]*//' | sed 's/ /+/g' | sed "s/\'/+/g"

open http://www.google.fr/search?hl=fr\&q=${TO_SEARCH}
echo "open http://www.google.fr/search?hl=fr\&q=${TO_SEARCH}"

# Fermeture du terminal
#osascript -e 'tell application "Terminal" to quit' &




