-- Requête 1 : Liste des lignes de métro avec leurs horaires, triées par heure de début
SELECT Numéro, nom, horairededébut, horairedefin
FROM LigneMétro
WHERE horairededébut BETWEEN '05:00:00' AND '06:30:00'
ORDER BY horairededébut ASC;

-- Requête 2 : Stations de zone tarifaire 1 et 2 avec équipements spécifiques
SELECT DISTINCT s.nom, s.zonetarrifaire, e.nom AS equipement
FROM station s
INNER JOIN équipé eq ON s.codeInterne = eq.codeInterne
INNER JOIN équipement e ON eq.nom = e.nom
WHERE s.zonetarrifaire IN (1, 2) 
AND e.nom LIKE '%ascenseur%' OR e.nom LIKE '%escalator%'
ORDER BY s.zonetarrifaire, s.nom;

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

-- Requête 5 : Rames avec une capacité élevée (plus de 800 voyageurs) et mode automatique
SELECT DISTINCT id, capacité, modeconduite, Numéro
FROM ramemétro
WHERE capacité > 800 
AND modeconduite IN ('automatique', 'semi-automatique')
ORDER BY capacité DESC;

-- Requête 6 : Messages d'information diffusés sur plusieurs canaux spécifiques
SELECT id, contenu, canal, date_, heure
FROM message
WHERE canal IN ('affichage_station', 'application_mobile', 'annonce_sonore')
AND date_ BETWEEN DATE_SUB(CURDATE(), INTERVAL 7 DAY) AND CURDATE()
ORDER BY date_ DESC, heure DESC;

-- Requête 7 : Taux de ponctualité moyen par ligne (écart ≤ 2 minutes = ponctuel)
SELECT lm.Numéro, lm.nom,
       COUNT(*) as total_passages,
       COUNT(CASE WHEN ABS(p.écart) <= 2 THEN 1 END) as passages_ponctuels,
       ROUND((COUNT(CASE WHEN ABS(p.écart) <= 2 THEN 1 END) * 100.0 / COUNT(*)), 2) as taux_ponctualite
FROM LigneMétro lm
INNER JOIN ramemétro rm ON lm.Numéro = rm.Numéro
INNER JOIN passe p ON rm.id = p.id
WHERE p.horaireprévu >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
GROUP BY lm.Numéro, lm.nom
HAVING COUNT(*) > 100
ORDER BY taux_ponctualite DESC;

-- Requête 8 : Nombre d'incidents par type avec durée moyenne (calculée approximativement)
SELECT ti.nom as type_incident,
       COUNT(i.id) as nombre_incidents,
       AVG(CASE WHEN i.heure IS NOT NULL THEN 1 ELSE 0 END) as incidents_avec_heure,
       ROUND(AVG(HOUR(i.heure) + MINUTE(i.heure)/60.0), 2) as heure_moyenne_occurrence
FROM typeincident ti
INNER JOIN incident i ON ti.id = i.id_1
WHERE i.date_ >= DATE_SUB(CURDATE(), INTERVAL 90 DAY)
GROUP BY ti.id, ti.nom
HAVING COUNT(i.id) >= 5
ORDER BY nombre_incidents DESC;

-- Requête 9 : Trafic total par station avec moyenne journalière
SELECT s.nom, s.zonetarrifaire,
       SUM(t.nbentrée) as total_entrees,
       SUM(t.nbsortie) as total_sorties,
       SUM(t.nbentrée + t.nbsortie) as trafic_total,
       ROUND(AVG(t.nbentrée + t.nbsortie), 0) as moyenne_journaliere
FROM station s
INNER JOIN trafic t ON s.codeInterne = t.codeInterne
WHERE t.date_ >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
GROUP BY s.codeInterne, s.nom, s.zonetarrifaire
HAVING SUM(t.nbentrée + t.nbsortie) > 10000
ORDER BY trafic_total DESC;

-- Requête 10 : Répartition des types de titres de transport
SELECT tt.nom as titre_transport,
       COUNT(t.id) as nombre_utilisations,
       SUM(t.nbentrée + t.nbsortie) as voyageurs_totaux,
       ROUND(AVG(t.nbentrée + t.nbsortie), 2) as moyenne_par_utilisation
FROM titredetransport tt
INNER JOIN trafic t ON tt.id = t.id_1
WHERE t.date_ >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
GROUP BY tt.id, tt.nom
HAVING COUNT(t.id) > 50
ORDER BY voyageurs_totaux DESC;

-- Requête 11 : Performance des centres de maintenance (nombre d'interventions par centre)
SELECT cm.nom as centre_maintenance, cm.code,
       COUNT(DISTINCT e.Numéro) as lignes_entretenues,
       COUNT(DISTINCT e.id) as rames_entretenues,
       COUNT(*) as total_interventions
FROM centredemaintenance cm
INNER JOIN entretien e ON cm.code = e.code
GROUP BY cm.code, cm.nom
HAVING COUNT(*) >= 10
ORDER BY total_interventions DESC;

-- Requête 12 : Jointure multiple - Incidents avec localisation complète et messages associés
SELECT i.id, i.date_, i.heure, i.description,
       lm.nom as ligne, s.nom as station,
       ti.nom as type_incident,
       m.contenu as message_diffuse, m.canal
FROM incident i
INNER JOIN typeincident ti ON i.id_1 = ti.id
LEFT JOIN LigneMétro lm ON i.Numéro = lm.Numéro
LEFT JOIN station s ON i.codeInterne = s.codeInterne
LEFT JOIN message m ON i.id = m.id_1
WHERE i.date_ >= DATE_SUB(CURDATE(), INTERVAL 15 DAY)
ORDER BY i.date_ DESC, i.heure DESC;

-- Requête 13 : Jointure externe - Toutes les stations avec leur trafic (y compris celles sans données)
SELECT s.nom, s.zonetarrifaire, s.codeInterne,
       COALESCE(SUM(t.nbentrée), 0) as total_entrees,
       COALESCE(SUM(t.nbsortie), 0) as total_sorties,
       COALESCE(COUNT(t.id), 0) as nb_mesures
FROM station s
LEFT JOIN trafic t ON s.codeInterne = t.codeInterne 
    AND t.date_ >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
GROUP BY s.codeInterne, s.nom, s.zonetarrifaire
ORDER BY total_entrees DESC;

-- Requête 14 : Jointure complexe - Rames, conducteurs, lignes et leurs passages récents
SELECT rm.id as rame_id, rm.capacité, rm.modeconduite,
       c.nom as conducteur_nom, c.prénom as conducteur_prenom,
       lm.nom as ligne_nom,
       COUNT(p.codeInterne) as nb_passages_recents,
       AVG(p.écart) as ecart_moyen
FROM ramemétro rm
LEFT JOIN conducteur c ON rm.matricule = c.matricule
INNER JOIN LigneMétro lm ON rm.Numéro = lm.Numéro
LEFT JOIN passe p ON rm.id = p.id 
    AND p.horaireprévu >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
GROUP BY rm.id, rm.capacité, rm.modeconduite, c.nom, c.prénom, lm.nom
ORDER BY nb_passages_recents DESC;

-- Requête 15 : Jointure externe - Équipements par station avec disponibilité
SELECT s.nom as station, s.zonetarrifaire,
       GROUP_CONCAT(e.nom SEPARATOR ', ') as equipements_disponibles,
       COUNT(eq.nom) as nb_equipements
FROM station s
LEFT JOIN équipé eq ON s.codeInterne = eq.codeInterne
LEFT JOIN équipement e ON eq.nom = e.nom
GROUP BY s.codeInterne, s.nom, s.zonetarrifaire
ORDER BY nb_equipements DESC, s.nom;

-- Requête 16 : Jointure multiple avec agrégation - Messages par type d'incident
SELECT ti.nom as type_incident,
       tm.label as type_message,
       COUNT(m.id) as nb_messages,
       COUNT(DISTINCT i.id) as nb_incidents_distincts,
       GROUP_CONCAT(DISTINCT m.canal SEPARATOR ', ') as canaux_utilises
FROM typeincident ti
INNER JOIN incident i ON ti.id = i.id_1
INNER JOIN message m ON i.id = m.id_1
INNER JOIN typemessage tm ON m.id_2 = tm.id
WHERE i.date_ >= DATE_SUB(CURDATE(), INTERVAL 60 DAY)
GROUP BY ti.nom, tm.label
ORDER BY nb_messages DESC;

-- Requête 17 : Stations avec le trafic le plus élevé (IN avec sous-requête)
SELECT s.nom, s.zonetarrifaire, 
       (SELECT SUM(t.nbentrée + t.nbsortie) 
        FROM trafic t 
        WHERE t.codeInterne = s.codeInterne 
        AND t.date_ >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)) as trafic_total
FROM station s
WHERE s.codeInterne IN (
    SELECT t.codeInterne
    FROM trafic t
    WHERE t.date_ >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
    GROUP BY t.codeInterne
    HAVING SUM(t.nbentrée + t.nbsortie) > (
        SELECT AVG(total_trafic) * 1.5
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
SELECT lm.Numéro, lm.nom
FROM LigneMétro lm
WHERE NOT EXISTS (
    SELECT ti.id
    FROM typeincident ti
    WHERE NOT EXISTS (
        SELECT 1
        FROM incident i
        WHERE i.Numéro = lm.Numéro 
        AND i.id_1 = ti.id
        AND i.date_ >= DATE_SUB(CURDATE(), INTERVAL 365 DAY)
    )
);

-- Requête 19 : Rames qui n'ont eu AUCUN incident (NOT EXISTS)
SELECT rm.id, rm.capacité, lm.nom as ligne
FROM ramemétro rm
INNER JOIN LigneMétro lm ON rm.Numéro = lm.Numéro
WHERE NOT EXISTS (
    SELECT 1
    FROM incident i
    WHERE i.Numéro = rm.Numéro
    AND i.date_ >= DATE_SUB(CURDATE(), INTERVAL 90 DAY)
);

-- Requête 20 : Stations desservies par plus de lignes que la moyenne (ANY)
SELECT s.nom, s.zonetarrifaire,
       (SELECT COUNT(*) FROM dessert d WHERE d.codeInterne = s.codeInterne) as nb_lignes
FROM station s
WHERE (SELECT COUNT(*) FROM dessert d WHERE d.codeInterne = s.codeInterne) > ANY (
    SELECT AVG(ligne_count)
    FROM (
        SELECT COUNT(*) as ligne_count
        FROM dessert
        GROUP BY codeInterne
    ) as avg_lines
);