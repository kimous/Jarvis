# Jarvis

Reconnaissance vocale pour Linux et Mac basée sur des binaires facilement trouvables et du code shell


## Prérequis

Pour pouvoir utiliser Jarvis, il faut installer "SOX".
Il permet d'enregistrer la voix.

Installation de sox :
 ```bash
 brew install sox --with-lame --with-flac --with-libvorbis
 ```



## Installation

Il suffit de cloner le repository sur le poste. bwa bwa bwa



## Paramétrage

Il faut éditer le fichier jarvis.sh :
- `VOX=`: défini le timbre de vois utilisé (femme : Amelie ou Audrey ; homme : Thomas)
- `KEY_WORD_ACTIVATION=`: nom de l'asistant, permet de lui faire comprendre qu'on lui parle
- `GOOGLE_API_KEY=`: la clef API SPEECH V2 de google personnelle
- `DIRECTORY_JARVIS=`: chemin/directory où est installé Jarvis (clone du dossier)
- `AUDIO_FILE=`: nom du fichier audio créé avec "rec" et contenant les dernière instructions vocales
- `JSON_FILE_RETURN=`: nom du fichier où sera stocké la dernière instruction traduite par l'API Google, au format JSON
- `FINAL_TRADUCTION=`: nom du fichier où sera stocké la dernière instruction traduite par l'API Google mais épurée (**compréhensible**)
- `HISTORIQUE_FILE=`: nom du fichier où sera stocké tous les echanges avec Jarvis
- `PLUGINS_DIR=`: dossier où il y a les différents fichiers de plugins (réponses/traitements de Jarvis)



## Utilisation 

Depuis une invite de commande, lancer le script "jarvis.sh"



## Création de plugins

Les fichiers de plugins prossédent une en-tête spécifiques.

 ```bash
! /bin/ksh
# Script : NOM DU SCRIPT/PLUGIN
# Description : DESCRIPTION DE CE QUE FAIT LE PLUGIN
# ID DECLENCHE : LE OU LES MOT CLEF QUI PERMETTRONT DE DECLENCHER L'UTILISATION DE CE FICHIER
 ```

Des fichiers plugins d'exemple sont disponibles dans le dossier "plugins" de Jarvis.



## Autheur

**kimous**



## License

Ce projet est sous licence GNU GPL3 - voir le fichier de [LICENSE](LICENSE) pour plus de détails


