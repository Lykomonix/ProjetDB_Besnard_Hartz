# Système d'information pour entreprise de transport urbain
**Projet de base de données - Premier rendu**

*Clément Besnard & Henri Hartz*

## Prompt utilisé

Tu travailles dans le domaine du transport urbain et de la mobilité.
Ton entreprise a comme activité de gérer, exploiter et maintenir le réseau de transports publics parisiens, en particulier les lignes de métro, leurs stations, rames et services associés.
C'est une entreprise de transport en commun comme la RATP ou la SNCF Transilien.

Les informations utiles à mettre dans la base concernent :
-	Les lignes de métro (numéros, noms, type de ligne, horaires).
-	Les stations (nom, code, zone tarifaire, équipements disponibles).
-	Les rames (numéro, capacité, affectation à une ligne).
-	Les horaires de service (premier et dernier départ, fréquence planifiée).
-	Les passages réels des rames (heures prévues et heures effectives).
-	Le trafic voyageur (entrées/sorties par station, titres de transport utilisés).
-	Les conducteurs (identité, matricule) ou système automatisé.
-	Les incidents (date, heure, type, description, localisation).
-	Les messages d'information voyageurs associés aux perturbations.
-	Les correspondances entre lignes/stations.
-	Les centres de maintenance liés aux lignes.

Inspire-toi du site web suivant : https://www.ratp.fr
Ton entreprise veut appliquer MERISE pour concevoir un système d'information.
Tu es chargé de la partie analyse, c'est-à-dire de collecter les besoins auprès de l'entreprise.
Elle a fait appel à un étudiant en ingénierie informatique pour réaliser ce projet, tu dois lui fournir les informations nécessaires pour qu'il applique ensuite lui-même les étapes suivantes de conception et développement de la base de données.
D'abord, établis les règles de gestion des données de ton entreprise, sous la forme d'une liste à puce. Elle doit correspondre aux informations que fournit quelqu'un qui connaît le fonctionnement de l'entreprise, mais pas comment se construit un système d'informations.
Ensuite, à partir de ces règles, fournis un dictionnaire de données brutes avec les colonnes suivantes, regroupées dans un tableau : signification de la donnée, type, taille en nombre de caractères ou de chiffres. Il doit y avoir entre 25 et 35 données.
Il sert à fournir des informations supplémentaires sur chaque donnée (taille et type) mais sans a priori sur comment les données vont être modélisées ensuite.
Fournis donc les règles de gestion et le dictionnaire de données.

## Règles de gestion (vue métier)

- Une ligne de métro est identifiée par un numéro et un nom (par exemple : « Ligne 1 – La Défense ↔ Château de Vincennes »).
- Chaque ligne a un type (métro classique, métro automatique, RER, tramway urbain géré par l'entreprise).
- Chaque ligne a des horaires de service (premier départ et dernier départ selon les jours).
- Une ligne dessert plusieurs stations, et une station peut appartenir à plusieurs lignes.
- Une station est identifiée par un nom et un code interne unique.
- Chaque station appartient à une zone tarifaire (exemple : zone 1, zone 2).
- Une station peut proposer des équipements (ascenseur, escalator, guichets automatiques, toilettes, bornes d'information, accessibilité PMR).
- Une rame de métro est identifiée par un numéro unique.
- Chaque rame a une capacité maximale en nombre de voyageurs.
- Une rame est affectée à une ligne (même si elle peut changer d'affectation au cours de sa vie).
- Les horaires de service définissent la fréquence planifiée des rames sur une ligne donnée.
- Pour chaque rame, il existe un planning de passages prévus et des enregistrements des passages réels (heures effectives).
- Un écart entre horaire prévu et horaire réel peut être mesuré.
- Le trafic voyageur est comptabilisé par station et par période (entrées, sorties, titres de transport utilisés).
- Les titres de transport peuvent être variés (ticket, passe Navigo, forfait spécifique, carte bancaire sans contact).
- Les rames sont conduites soit par des conducteurs identifiés (avec matricule), soit par un système automatisé.
- Chaque incident est enregistré avec une date, une heure, un type (panne technique, accident voyageur, signal d'alarme, mouvement social, etc.), une description et une localisation (ligne/station).
- Chaque incident peut donner lieu à un ou plusieurs messages d'information voyageurs diffusés sur différents canaux (affichage en station, annonces sonores, application mobile).
- Il existe des correspondances entre lignes, permettant aux voyageurs de passer d'une ligne à une autre dans une station donnée.
- Les centres de maintenance sont liés à une ou plusieurs lignes et prennent en charge l'entretien et la réparation des rames ou équipements.
- Chaque centre de maintenance est identifié par un nom, un code et une adresse.

## Dictionnaire de données brutes

| **Signification de la donnée**                 | **Type**         | **Taille** |
|------------------------------------------------|------------------|------------|
| Numéro de ligne                                | Numérique        | 2          |
| Nom de ligne                                   | Alphanumérique   | 50         |
| Type de ligne (classique, automatique, RER…)   | Alphanumérique   | 20         |
| Premier départ (heure)                         | Heure            | -          |
| Dernier départ (heure)                         | Heure            | -          |
| Fréquence planifiée (minutes)                  | Numérique        | 2          |
| Nom de station                                 | Alphanumérique   | 60         |
| Code station                                   | Alphanumérique   | 10         |
| Zone tarifaire                                 | Numérique        | 1          |
| Liste des équipements disponibles              | Alphanumérique   | 200        |
| Numéro de rame                                 | Numérique        | 6          |
| Capacité maximale voyageurs                    | Numérique        | 4          |
| Ligne affectée (numéro)                        | Numérique        | 2          |
| Horaire prévu de passage                       | Date/Heure       | -          |
| Horaire réel de passage                        | Date/Heure       | -          |
| Écart prévu/réel (minutes)                     | Numérique        | 3          |
| Volume d'entrées voyageurs (par station/période)| Numérique       | 6          |
| Volume de sorties voyageurs (par station/période)| Numérique      | 6          |
| Type de titre de transport utilisé             | Alphanumérique   | 30         |
| Identité conducteur (nom/prénom)               | Alphanumérique   | 60         |
| Matricule conducteur                           | Alphanumérique   | 8          |
| Mode de conduite (humain/automatisé)           | Alphanumérique   | 15         |
| Date incident                                  | Date             | -          |
| Heure incident                                 | Heure            | -          |
| Type d'incident                                | Alphanumérique   | 30         |
| Description incident                           | Alphanumérique   | 255        |
| Localisation incident (ligne/station)          | Alphanumérique   | 60         |
| Code message information voyageurs             | Alphanumérique   | 10         |
| Contenu du message                             | Alphanumérique   | 255        |
| Canal de diffusion du message                  | Alphanumérique   | 30         |
| Correspondance (ligne/station liée)            | Alphanumérique   | 50         |
| Nom centre de maintenance                      | Alphanumérique   | 60         |
| Code centre de maintenance                     | Alphanumérique   | 10         |
| Adresse centre de maintenance                  | Alphanumérique   | 120        |

## MCD

_Note: Le Modèle Conceptuel de Données (MCD) est fourni dans un fichier séparé avec l'extension .svg ou .png dans ce même répertoire._
