#! /bin/ksh
# Script : jarvis.sh
# Description : Reconnaissance vocale

# Clear de la fenetre pour que ce soit plus lisible
clear

# Ajout des binaire au path de la session
PATH=$PATH:/usr/local/bin


#############################################################
# DEBUT VARIABLES
#############################################################
# Nom de la voix (femme : Amelie ou Audrey ; homme : Thomas)
VOX="Thomas"
# Mot Clef d'activation
KEY_WORD_ACTIVATION="Jarvis"

# Clef Google API SPEECH V2
GOOGLE_API_KEY="-------------------------------"
# Chemin vers le dossier de l'application (où a été cloné Jarvis)
DIRECTORY_JARVIS="-----/USER/DIRECTORY/JARVIS-----"
# Nom du fichier audio
AUDIO_FILE="message.flac"
# Nom du message de retour brut json
JSON_FILE_RETURN="message.ret"
# Message TXT épuré
FINAL_TRADUCTION="message.txt"
# Fichier d'historique
HISTORIQUE_FILE="${DIRECTORY_JARVIS}/historique.txt"

# Dossier de plugin
PLUGINS_DIR="plugins"

#############################################################
# FIN VARIABLES
#############################################################

# Tag par défaut pour déclencher l'écoute 
TAG=0
# Tag de boucle d'écoute infini pour que le script tourne tout le temp
ALWAYS=1

# Déplacement vers le dossier de l'application
cd ${DIRECTORY_JARVIS}

# Boucle pour que Jarvis écoute en boucle 
while [[  $ALWAYS -eq 1 ]]; do

	#############################################################
	# ENREGISTREMENT ET TRADUCTION EN TEXTE VIA GOOGLE API V2
	#############################################################
	# Si le dernier fichier audio est vide alors en enregistre encore sans declencher de plugin
	if [[ $TAG -eq 0 ]]; then
		
		echo "1 : Enregistrement de la voix" 
		# rec enregistre et gére les coupures silence seul 
		rec -r 44100 -q -c 1 ${AUDIO_FILE} silence -l 1 0.1 1% 1 2.0 1%

		echo "2 : Envoi du fichier a Google pour traduction en texte JSON"
		# Le retour se fait au format json 
		wget -O - -o /dev/null --post-file ${AUDIO_FILE} --header="Content-Type: audio/x-flac; rate=44100" "http://www.google.com/speech-api/v2/recognize?lang=fr-FR&key=${GOOGLE_API_KEY}&output=json" > ${JSON_FILE_RETURN}
		
		echo "3 : Parse du fichier JSON pour recuperer la traduction" 
		cat ${JSON_FILE_RETURN} | sed 's/","confidence.*//' | cut -d":" -f4 | sed 's/"//g' | cut -d"}" -f1 | sed '/^$/d'> ${FINAL_TRADUCTION}
		# Test si le retour est pas vide
		if [[ -s ${FINAL_TRADUCTION} ]]; then
			echo "fichier pas vide"
			TAG=1
		fi

	fi

	echo "4 : Suppression du fichier audio et json"
	# Suppression non obligatoire mais c'est juste pour être propre
	rm ${AUDIO_FILE}
	rm ${JSON_FILE_RETURN}

	echo "5 : Affichage de la reponse en clair"
	cat ${FINAL_TRADUCTION}

	echo "6 : Ecriture dans le fichier d'historique"
	# Contenu du fichier de retour
	RETURN_TRAD=$(cat ${FINAL_TRADUCTION})
	if [[ -n $RETURN_TRAD ]]; then
		echo "SEND:${RETURN_TRAD}:$(date +%H:%M)" >> ${HISTORIQUE_FILE}
	fi
	


	#############################################################
	# ANALYSE DU RETOUR
	#############################################################
	# Test si mot clef sans tenir compte de la casse
	TEST_KEY_ACTIVATION=$(cat ${FINAL_TRADUCTION} | grep -i "${KEY_WORD_ACTIVATION}")

	# Si mot clef alors on parse le dossier "plugins" et on traite les différents fichiers
	if [[ -n ${TEST_KEY_ACTIVATION} ]]; then
		# Listing des fichiers de plugins
		for PLUGIN_FILE in $(ls ${PLUGINS_DIR} | grep -v ".DS_Store"); do
			# Récupération du mot déclencheur 
			KEY_DECLENCHE=$(cat ${PLUGINS_DIR}/${PLUGIN_FILE} | grep "ID DECLENCHE" | cut -d":" -f2 | sed 's/^[ \t]*//')
			# Si mot déclencheur trouver alors déclenchement le script
			[[ -n $(cat ${FINAL_TRADUCTION} | grep -i "${KEY_DECLENCHE}") ]] && . ${PLUGINS_DIR}/${PLUGIN_FILE} 
			# Vidage de la variable de déclenchement
			KEY_DECLENCHE=""
		done
	fi

	# Remise en place du TAG pour repasser sur l'écoute
	TAG=0

done

exit 0



