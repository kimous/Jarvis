#! /bin/ksh
# Script : Meteo.sh
# Description : Donne la météo du jour
# ID DECLENCHE : météo
# Infos : 
#	- http://www.prevision-meteo.ch/services
#	- http://www.prevision-meteo.ch/uploads/pdf/recuperation-donnees-meteo.pdf

#############################################################
# VARIABLES
#############################################################
# Utilitaire de parse json
PARSE_JSON="/Users/Kimous/Documents/Projets_Personnels/Vocal/bin/jq"
# Ville 
VILLE="baigneaux-28"
# URL
URL="http://www.prevision-meteo.ch/services/json"



#############################################################
# TRAITEMENT METEO
#############################################################
# Download du fichier json
curl "${URL}/${VILLE}" -o "meteo.txt"

# Nom de la ville 
VOX_VILLE=$(cat "meteo.txt" | ${PARSE_JSON} '.city_info.name' | sed s/\"//g | cut -d" " -f1)
# Temperature actuelle
VOX_TEMP=$(cat "meteo.txt" | ${PARSE_JSON} '.current_condition.tmp')
# Type de temps/conditions
VOX_CONDI=$(cat "meteo.txt" | ${PARSE_JSON} '.fcst_day_0.condition' | sed s/\"//g)


#############################################################
# VARIABLES
#############################################################
# Voix
#say -v "${VOX}" "Nous somme dans la ville de ${VOX_VILLE} !"
say -v "${VOX}" "Pour la journée se sera ${VOX_CONDI}, la température est de ${VOX_TEMP} degrés !"
echo "RETURN:Pour la journée se sera ${VOX_CONDI}, la température est de ${VOX_TEMP} degrés !:$(date +%H:%M)" >> ${HISTORIQUE_FILE}


#############################################################
# NETOYAGE
#############################################################
# Suppression du fichier meteo
rm -f meteo.txt



# Fermeture du terminal
#osascript -e 'tell application "Terminal" to quit' &





