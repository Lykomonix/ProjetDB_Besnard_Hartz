# Système d'information pour entreprise de transport urbain

**Projet de base de données - Second rendu**

*Clément Besnard & Henri Hartz*

## Rappel du MCD :

![alt text](mcd.png)

## III. Troisième étape : MLD et MPD

### A. MLD

typeLigne = (**id INT**, nom VARCHAR(50)); <br>
station = (**codeInterne VARCHAR(10)**, nom VARCHAR(60), zonetarrifaire DECIMAL(1,0)); <br>
équipement = (**nom VARCHAR(30)**); <br>
titredetransport = (**id INT**, nom VARCHAR(30)); <br>
conducteur = (**matricule VARCHAR(8)**, nom VARCHAR(30), prénom VARCHAR(30)); <br>
typeincident = (**id INT**, nom VARCHAR(30)); <br>
typemessage = (**id VARCHAR(10)**, label VARCHAR(255)); <br>
centredemaintenance = (**code VARCHAR(10)**, nom VARCHAR(60), adresse VARCHAR(120)); <br>
trafic = (**id INT**, date_ DATE, heure TIME, nbentrée INT, nbsortie INT, #id_1, #codeInterne); <br>
LigneMétro = (**Numéro DECIMAL(2,0)*, nom VARCHAR(50), horairededébut TIME, horairedefin TIME, #id); <br>
ramemétro = (**id DECIMAL(6,0)**, capacité DECIMAL(4,0), modeconduite VARCHAR(15), #matricule*, #Numéro); <br>
incident = (**id INT**, date_ DATE, heure TIME, description VARCHAR(255), #Numéro*, #codeInterne*, #id_1); <br>
message = (**id INT**, contenu VARCHAR(255), date_ DATE, heure TIME, canal VARCHAR(50), #id_1, #id_2); <br>
dessert = (**#Numéro, #codeInterne**); <br>
équipé = (**#codeInterne, #nom**); <br>
passe = (**#codeInterne, #id**, horaireprévu DATETIME, horaireréel DATETIME, écart DECIMAL(3,0)); <br>
correspondance = (**#codeInterne, #codeInterne_1**); <br>
entretien = (**#Numéro, #nom, #id, #code**); <br>

### B. MPD

[Voir annexe 1_creation.sql](1_creation.sql)

[Voir annexe 2_contraintes.sql](2_contraintes.sql)

## IV. Insertion des données

[Voir le prompt utilisé](prompt.txt)

[Voir annexe 3_insertion.sql](3_insertion.sql)

## V. Cinquième étape : interrogation de la BD

### Scénario d'utilisation de la base de données :

Nous allons construire le scénario d'un personne chargée d'analyser les performances et les qualités de service, puis de faire un rapport de performance pour la direction générale. Son but est donc d'analyser les performances du réseau et d'identifier les axes d'amélioration.
Pour mener à bien sa mission, il a besoin d'extraire des données clés qui représenteront les indicateurs clés de performance (KPI).

Voici les principales données à extraire :

1. Liste des lignes de métro avec leurs horaires, triées par heure de début
2. Stations de zone tarifaire 1 et 2 avec équipements spécifiques
3. Conducteurs dont le matricule commence par 'AB' ou 'CD'
4. Incidents survenus entre 07h00 et 09h00 (heures de pointe du matin)
5. Rames avec une capacité élevée (plus de 800 voyageurs) et mode automatique
6. Messages d'information diffusés sur plusieurs canaux spécifiques
7. Taux de ponctualité moyen par ligne
8. Nombre d'incidents par type avec durée moyenne
9. Trafic total par station avec moyenne journalière
10. Répartition des types de titres de transport
11. Performance des centres de maintenance (nombre d'interventions par centre)
12. Incidents avec localisation complète et messages associés
13. Toutes les stations avec leur trafic (y compris celles sans données)
14. Rames, conducteurs, lignes et leurs passages récents
15. Équipements par station avec disponibilité
16. Messages par type d'incident
17. Stations avec le trafic le plus élevé
18. Lignes qui ont eu tous les types d'incidents
19. Rames qui n'ont eu aucun incident
20. Stations desservies par plus de lignes que la moyenne

[Voir annexe 4_interrogation.sql](4_interrogation.sql)
