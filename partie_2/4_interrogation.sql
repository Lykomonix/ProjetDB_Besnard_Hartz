-- Requête 1 : Liste des lignes de métro avec leurs horaires, triées par heure de début
SELECT Numéro, nom, horairededébut, horairedefin
FROM LigneMétro
WHERE horairededébut BETWEEN '05:00:00' AND '06:30:00'
ORDER BY horairededébut ASC;

-- Requête 2 : Stations de zone tarifaire 1 et 2 avec équipements spécifiques
SELECT DISTINCT station.nom, station.zonetarrifaire, équipement.nom
FROM station
INNER JOIN équipé ON station.codeInterne = équipé.codeInterne
INNER JOIN équipement ON équipé.nom = équipement.nom
WHERE station.zonetarrifaire IN (1, 2) 
AND (équipement.nom LIKE '%ascenseur%' OR équipement.nom LIKE '%escalator%')
ORDER BY station.zonetarrifaire, station.nom;

-- Requête 3 : Conducteurs dont le matricule commence par 'AB' ou 'CD'
SELECT matricule, nom, prénom
FROM conducteur
WHERE matricule LIKE 'AB%' OR matricule LIKE 'CD%'
ORDER BY matricule;

-- Requête 4 : Incidents survenus entre 07h00 et 09h00 (heures de pointe du matin)
SELECT id, date_, heure, description
FROM incident
WHERE heure BETWEEN '07:00:00' AND '09:00:00'
AND date_ >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
ORDER BY date_ DESC, heure ASC;

-- Requête 5 : Rames avec une capacité élevée (plus de 700 voyageurs) et mode automatique
SELECT DISTINCT id, capacité, modeconduite, Numéro
FROM ramemétro
WHERE capacité > 700 
AND modeconduite IN ('automatique', 'semi-automatique')
ORDER BY capacité DESC;

-- Requête 6 : Messages d'information diffusés sur plusieurs canaux spécifiques
SELECT id, contenu, canal, date_, heure
FROM message
WHERE canal IN ('affichage_station', 'application_mobile', 'annonce_sonore')
AND date_ BETWEEN DATE_SUB(CURDATE(), INTERVAL 7 DAY) AND CURDATE()
ORDER BY date_ DESC, heure DESC;

-- Requête 7 : Taux de ponctualité moyen par ligne
SELECT LigneMétro.Numéro,
       LigneMétro.nom,
       COUNT(*) AS total_passages,
       SUM(CASE WHEN ABS(passe.`écart`) <= 2 THEN 1 ELSE 0 END) AS passages_ponctuels,
       ROUND(SUM(CASE WHEN ABS(passe.`écart`) <= 2 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS taux_ponctualite
FROM LigneMétro
JOIN ramemétro ON LigneMétro.Numéro = ramemétro.Numéro
JOIN passe ON ramemétro.id = passe.id
WHERE passe.horaireprévu >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
GROUP BY LigneMétro.Numéro, LigneMétro.nom
HAVING COUNT(*) > 0
ORDER BY taux_ponctualite DESC;

-- Requête 8 : Nombre d'incidents par type avec durée moyenne (calculée approximativement)
SELECT typeincident.nom AS type_incident,
       COUNT(incident.id) AS nombre_incidents,
       COUNT(incident.heure) AS incidents_avec_heure,
       ROUND(AVG(CASE WHEN incident.heure IS NOT NULL THEN TIME_TO_SEC(incident.heure) END)) AS avg_seconds,
       SEC_TO_TIME(ROUND(AVG(CASE WHEN incident.heure IS NOT NULL THEN TIME_TO_SEC(incident.heure) END))) AS heure_moyenne_occurrence
FROM typeincident
JOIN incident ON typeincident.id = incident.id_1
WHERE incident.date_ >= DATE_SUB(CURDATE(), INTERVAL 90 DAY)
GROUP BY typeincident.id, typeincident.nom
ORDER BY nombre_incidents DESC;

-- Requête 9 : Trafic total par station
SELECT station.nom, station.zonetarrifaire,
       SUM(trafic.nbentrée) as total_entrees,
       SUM(trafic.nbsortie) as total_sorties,
       SUM(trafic.nbentrée + trafic.nbsortie) as trafic_total
FROM station
INNER JOIN trafic ON station.codeInterne = trafic.codeInterne
WHERE trafic.date_ >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
GROUP BY station.codeInterne, station.nom, station.zonetarrifaire
HAVING SUM(trafic.nbentrée + trafic.nbsortie) > 0
ORDER BY trafic_total DESC;

-- Requête 10 : Répartition des types de titres de transport
SELECT titredetransport.nom as titre_transport,
       COUNT(trafic.id) as nombre_utilisations,
       SUM(trafic.nbentrée + trafic.nbsortie) as voyageurs_totaux,
       ROUND(AVG(trafic.nbentrée + trafic.nbsortie), 2) as moyenne_par_utilisation
FROM titredetransport
INNER JOIN trafic ON titredetransport.id = trafic.id_1
WHERE trafic.date_ >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
GROUP BY titredetransport.id, titredetransport.nom
HAVING COUNT(trafic.id) > 0
ORDER BY voyageurs_totaux DESC;

-- Requête 11 : Performance des centres de maintenance (nombre d'interventions par centre)
SELECT centredemaintenance.nom as centre_maintenance, centredemaintenance.code,
       COUNT(DISTINCT entretien.Numéro) as lignes_entretenues,
       COUNT(DISTINCT entretien.id) as rames_entretenues,
       COUNT(*) as total_interventions
FROM centredemaintenance
INNER JOIN entretien ON centredemaintenance.code = entretien.code
GROUP BY centredemaintenance.code, centredemaintenance.nom
HAVING COUNT(*) >= 0
ORDER BY total_interventions DESC;

-- Requête 12 : Jointure multiple - Incidents avec localisation complète et messages associés
SELECT incident.id, incident.date_, incident.heure, incident.description,
       LigneMétro.nom as ligne, station.nom as station,
       typeincident.nom as type_incident,
       message.contenu as message_diffuse, message.canal
FROM incident
INNER JOIN typeincident ON incident.id_1 = typeincident.id
LEFT JOIN LigneMétro ON incident.Numéro = LigneMétro.Numéro
LEFT JOIN station ON incident.codeInterne = station.codeInterne
LEFT JOIN message ON incident.id = message.id_1
WHERE incident.date_ >= DATE_SUB(CURDATE(), INTERVAL 15 DAY)
ORDER BY incident.date_ DESC, incident.heure DESC;

-- Requête 13 : Jointure externe - Toutes les stations avec leur trafic (y compris celles sans données)
SELECT station.nom, station.zonetarrifaire, station.codeInterne,
       COALESCE(SUM(trafic.nbentrée), 0) as total_entrees,
       COALESCE(SUM(trafic.nbsortie), 0) as total_sorties,
       COALESCE(COUNT(trafic.id), 0) as nb_mesures
FROM station
LEFT JOIN trafic ON station.codeInterne = trafic.codeInterne
    AND trafic.date_ >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
GROUP BY station.codeInterne, station.nom, station.zonetarrifaire
ORDER BY total_entrees DESC;

-- Requête 14 : Jointure complexe - Rames, conducteurs, lignes et leurs passages récents
SELECT ramemétro.id as rame_id, ramemétro.capacité, ramemétro.modeconduite,
       conducteur.nom as conducteur_nom, conducteur.prénom as conducteur_prenom,
       LigneMétro.nom as ligne_nom,
       COUNT(passe.codeInterne) as nb_passages_recents,
       AVG(passe.écart) as ecart_moyen
FROM ramemétro
LEFT JOIN conducteur ON ramemétro.matricule = conducteur.matricule
INNER JOIN LigneMétro ON ramemétro.Numéro = LigneMétro.Numéro
LEFT JOIN passe ON ramemétro.id = passe.id
    AND passe.horaireprévu >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
GROUP BY ramemétro.id, ramemétro.capacité, ramemétro.modeconduite, conducteur.nom, conducteur.prénom, LigneMétro.nom
ORDER BY nb_passages_recents DESC;

-- Requête 15 : Jointure externe - Équipements par station avec disponibilité
SELECT station.nom as station, station.zonetarrifaire,
       GROUP_CONCAT(équipement.nom SEPARATOR ', ') as equipements_disponibles,
       COUNT(équipé.nom) as nb_equipements
FROM station
LEFT JOIN équipé ON station.codeInterne = équipé.codeInterne
LEFT JOIN équipement ON équipé.nom = équipement.nom
GROUP BY station.codeInterne, station.nom, station.zonetarrifaire
ORDER BY nb_equipements DESC, station.nom;

-- Requête 16 : Jointure multiple avec agrégation - Messages par type d'incident
SELECT typeincident.nom as type_incident,
       typemessage.label as type_message,
       COUNT(message.id) as nb_messages,
       COUNT(DISTINCT incident.id) as nb_incidents_distincts,
       GROUP_CONCAT(DISTINCT message.canal SEPARATOR ', ') as canaux_utilises
FROM typeincident
INNER JOIN incident ON typeincident.id = incident.id_1
INNER JOIN message ON incident.id = message.id_1
INNER JOIN typemessage ON message.id_2 = typemessage.id
WHERE incident.date_ >= DATE_SUB(CURDATE(), INTERVAL 60 DAY)
GROUP BY typeincident.nom, typemessage.label
ORDER BY nb_messages DESC;

-- Requête 17 : Stations avec le trafic le plus élevé (IN avec sous-requête)
SELECT station.nom, station.zonetarrifaire, 
       (SELECT SUM(trafic.nbentrée + trafic.nbsortie) 
        FROM trafic
        WHERE trafic.codeInterne = station.codeInterne 
        AND trafic.date_ >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)) as trafic_total
FROM station
WHERE station.codeInterne IN (
    SELECT trafic.codeInterne
    FROM trafic
    WHERE trafic.date_ >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
    GROUP BY trafic.codeInterne
    HAVING SUM(trafic.nbentrée + trafic.nbsortie) > (
        SELECT AVG(total_trafic) * 1.3
        FROM (
            SELECT SUM(nbentrée + nbsortie) as total_trafic
            FROM trafic
            WHERE date_ >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
            GROUP BY codeInterne
        ) as avg_calc
    )
)
ORDER BY trafic_total DESC;

-- Requête 18 : Lignes qui ont eu TOUS les types d'incidents (ALL)
SELECT LigneMétro.Numéro, LigneMétro.nom
FROM LigneMétro
WHERE NOT EXISTS (
    SELECT typeincident.id
    FROM typeincident
    WHERE NOT EXISTS (
        SELECT 1
        FROM incident
        WHERE incident.Numéro = LigneMétro.Numéro
        AND incident.id_1 = typeincident.id
        AND incident.date_ >= DATE_SUB(CURDATE(), INTERVAL 365 DAY)
    )
);

-- Requête 19 : Rames qui n'ont eu AUCUN incident (NOT EXISTS)
SELECT ramemétro.id, ramemétro.capacité, LigneMétro.nom as ligne
FROM ramemétro
INNER JOIN LigneMétro ON ramemétro.Numéro = LigneMétro.Numéro
WHERE NOT EXISTS (
    SELECT 1
    FROM incident
    WHERE incident.Numéro = ramemétro.Numéro
    AND i.date_ >= DATE_SUB(CURDATE(), INTERVAL 90 DAY)
);

-- Requête 20 : Stations desservies par plus de lignes que la moyenne (ANY)
SELECT station.nom, station.zonetarrifaire,
       (SELECT COUNT(*) FROM dessert WHERE dessert.codeInterne = station.codeInterne) as nb_lignes
FROM station
WHERE (SELECT COUNT(*) FROM dessert WHERE dessert.codeInterne = station.codeInterne) > ANY (
    SELECT AVG(ligne_count)
    FROM (
        SELECT COUNT(*) as ligne_count
        FROM dessert
        GROUP BY codeInterne
    ) as avg_lines
);