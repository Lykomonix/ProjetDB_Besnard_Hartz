-- Script d'insertion de données pour la base de données de transport urbain
-- Génération de 20 lignes par table avec cohérence des données

-- ============================================
-- 1. Table typeLigne (table de référence)
-- ============================================
INSERT INTO typeLigne (id, nom) VALUES 
(1, 'Ligne de métro classique'),
(2, 'Ligne de métro automatique'),
(3, 'Ligne express régionale'),
(4, 'Ligne de tramway'),
(5, 'Ligne de bus'),
(6, 'Ligne de métro circulaire'),
(7, 'Ligne de métro radiale'),
(8, 'Ligne de transport rapide'),
(9, 'Ligne de desserte locale'),
(10, 'Ligne de métro souterraine'),
(11, 'Ligne de métro aérienne'),
(12, 'Ligne de transport nocturne'),
(13, 'Ligne de transport touristique'),
(14, 'Ligne de métro historique'),
(15, 'Ligne de transport moderne'),
(16, 'Ligne de métro intercommunale'),
(17, 'Ligne de transport écologique'),
(18, 'Ligne de métro haute fréquence'),
(19, 'Ligne de transport accessible'),
(20, 'Ligne de métro polyvalente');

-- ============================================
-- 2. Table station (table de référence)
-- ============================================
INSERT INTO station (codeInterne, nom, zonetarrifaire) VALUES 
('CHATEL001', 'Châtelet-Les Halles', 1),
('REPUB002', 'République', 1),
('BASTIL003', 'Bastille', 1),
('NATION004', 'Nation', 1),
('VINCEN005', 'Château de Vincennes', 1),
('DEFENS006', 'La Défense', 1),
('LOUVRE007', 'Louvre-Rivoli', 1),
('OPERA008', "Opéra", 1),
('PIGALL009', 'Pigalle', 1),
('MNTPAR010', 'Montparnasse-Bienvenüe', 1),
('GAREDL011', 'Gare de Lyon', 1),
('GARDN012', 'Gare du Nord', 1),
('INVALIDE013', 'Invalides', 1),
('CONCOR014', 'Concorde', 1),
('TROCAD015', 'Trocadéro', 1),
('ARCHTR016', "Arc de Triomphe", 1),
('BELLEV017', 'Belleville', 1),
('MENILM018', 'Ménilmontant', 1),
('PERELC019', 'Père Lachaise', 1),
('GAMBEL020', 'Gambetta', 1);

-- ============================================
-- 3. Table équipement (table de référence)
-- ============================================
INSERT INTO équipement (nom) VALUES 
('Escalator'),
('Ascenseur'),
('Distributeur de tickets'),
('Borne d\'information'),
('Système de vidéosurveillance'),
('Panneau d\'affichage dynamique'),
('Système audio'),
('Éclairage LED'),
('Portiques d\'accès'),
('Bancs'),
('Poubelles de tri'),
('Défibrillateur'),
('Système d\'alarme'),
('WiFi gratuit'),
('Bornes USB'),
('Toilettes publiques'),
('Distributeur de boissons'),
('Plan de ligne interactif'),
('Système de climatisation'),
('Issue de secours');

-- ============================================
-- 4. Table titredetransport (table de référence)
-- ============================================
INSERT INTO titredetransport (id, nom) VALUES 
(1, 'Ticket t+'),
(2, 'Abonnement Navigo Semaine'),
(3, 'Abonnement Navigo Mois'),
(4, 'Abonnement Navigo Annuel'),
(5, 'Ticket Jeunes Week-end'),
(6, 'Forfait Journée'),
(7, 'Abonnement Senior'),
(8, 'Forfait Aéroport'),
(9, 'Ticket Groupe'),
(10, 'Abonnement Étudiant'),
(11, 'Forfait Touristique'),
(12, 'Ticket Réduit'),
(13, 'Abonnement Famille'),
(14, 'Forfait Soirée'),
(15, 'Ticket Solidarité'),
(16, 'Abonnement Pro'),
(17, 'Forfait Événement'),
(18, 'Ticket Découverte'),
(19, 'Abonnement Liberté'),
(20, 'Forfait Premium');

-- ============================================
-- 5. Table conducteur (table de référence)
-- ============================================
INSERT INTO conducteur (matricule, nom, prénom) VALUES 
('COND0001', 'Dupont', 'Jean'),
('COND0002', 'Martin', 'Marie'),
('COND0003', 'Bernard', 'Pierre'),
('COND0004', 'Dubois', 'Sophie'),
('COND0005', 'Thomas', 'Michel'),
('COND0006', 'Robert', 'Catherine'),
('COND0007', 'Petit', 'Philippe'),
('COND0008', 'Richard', 'Nathalie'),
('COND0009', 'Durand', 'François'),
('COND0010', 'Moreau', 'Isabelle'),
('COND0011', 'Laurent', 'Alain'),
('COND0012', 'Simon', 'Brigitte'),
('COND0013', 'Michel', 'Daniel'),
('COND0014', 'Leroy', 'Monique'),
('COND0015', 'Roux', 'Pascal'),
('COND0016', 'David', 'Sylvie'),
('COND0017', 'Bertrand', 'Thierry'),
('COND0018', 'Morel', 'Véronique'),
('COND0019', 'Fournier', 'Laurent'),
('COND0020', 'Girard', 'Christine');

-- ============================================
-- 6. Table typeincident (table de référence)
-- ============================================
INSERT INTO typeincident (id, nom) VALUES 
(1, 'Panne électrique'),
(2, 'Incident voyageur'),
(3, 'Retard matériel'),
(4, 'Problème technique'),
(5, 'Malaise voyageur'),
(6, 'Colis suspect'),
(7, 'Vandalisme'),
(8, 'Panne de signalisation'),
(9, 'Incident sur la voie'),
(10, 'Problème de climatisation'),
(11, 'Panne d\'éclairage'),
(12, 'Incident de sécurité'),
(13, 'Problème de portes'),
(14, 'Panne de communication'),
(15, 'Incident météorologique'),
(16, 'Problème de freinage'),
(17, 'Panne informatique'),
(18, 'Incident technique majeur'),
(19, 'Problème d\'alimentation'),
(20, 'Dysfonctionnement équipement');

-- ============================================
-- 7. Table typemessage (table de référence)
-- ============================================
INSERT INTO typemessage (id, label) VALUES 
('ALERT001', 'Alerte trafic en temps réel'),
('MAINT002', 'Maintenance programmée'),
('PERTU003', 'Perturbation de service'),
('INFO004', 'Information voyageurs'),
('URGENC005', 'Message d\'urgence'),
('COMME006', 'Communication commerciale'),
('SECU007', 'Consigne de sécurité'),
('TRAVA008', 'Travaux en cours'),
('HORAI009', 'Modification horaires'),
('ACCES010', 'Problème d\'accessibilité'),
('METEO011', 'Alerte météorologique'),
('EVENT012', 'Événement spécial'),
('GREVE013', 'Préavis de grève'),
('FERIE014', 'Service jour férié'),
('NUIT015', 'Service de nuit'),
('WEEK016', 'Service week-end'),
('FLUX017', 'Gestion des flux'),
('CORR018', 'Information correspondance'),
('RETARD019', 'Retard signalé'),
('NORMA020', 'Retour à la normale');

-- ============================================
-- 8. Table centredemaintenance (table de référence)
-- ============================================
INSERT INTO centredemaintenance (code, nom, adresse) VALUES 
('MAINT001', 'Centre de Maintenance Châtelet', '15 Rue de la Ferronnerie, 75001 Paris'),
('MAINT002', 'Atelier République', '45 Boulevard du Temple, 75003 Paris'),
('MAINT003', 'Dépôt Nation', '123 Avenue de la République, 75011 Paris'),
('MAINT004', 'Centre Vincennes', '67 Route de la Pyramide, 94300 Vincennes'),
('MAINT005', 'Maintenance La Défense', '89 Esplanade Charles de Gaulle, 92400 Courbevoie'),
('MAINT006', 'Atelier Louvre', '34 Rue de Rivoli, 75001 Paris'),
('MAINT007', 'Dépôt Opéra', '56 Boulevard des Capucines, 75009 Paris'),
('MAINT008', 'Centre Pigalle', '78 Boulevard de Clichy, 75018 Paris'),
('MAINT009', 'Maintenance Montparnasse', '90 Boulevard du Montparnasse, 75014 Paris'),
('MAINT010', 'Atelier Gare de Lyon', '112 Rue de Bercy, 75012 Paris'),
('MAINT011', 'Dépôt Gare du Nord', '134 Rue de Dunkerque, 75010 Paris'),
('MAINT012', 'Centre Invalides', '156 Rue de Grenelle, 75007 Paris'),
('MAINT013', 'Maintenance Concorde', '178 Rue Saint-Honoré, 75001 Paris'),
('MAINT014', 'Atelier Trocadéro', '190 Avenue Kléber, 75016 Paris'),
('MAINT015', 'Dépôt Arc de Triomphe', '212 Avenue des Champs-Élysées, 75008 Paris'),
('MAINT016', 'Centre Belleville', '234 Rue de Belleville, 75020 Paris'),
('MAINT017', 'Maintenance Ménilmontant', '256 Rue de Ménilmontant, 75020 Paris'),
('MAINT018', 'Atelier Père Lachaise', '278 Boulevard de Ménilmontant, 75020 Paris'),
('MAINT019', 'Dépôt Gambetta', '290 Avenue Gambetta, 75020 Paris'),
('MAINT020', 'Centre Principal Paris', '300 Boulevard Périphérique, 75019 Paris');

-- ============================================
-- 9. Table LigneMétro (dépend de typeLigne)
-- ============================================
INSERT INTO LigneMétro (Numéro, nom, horairededébut, horairedefin, id) VALUES 
(1, 'Ligne 1 – La Défense / Château de Vincennes', '05:30:00', '01:15:00', 2),
(2, 'Ligne 2 – Pont de Levallois / Nation', '05:30:00', '01:15:00', 1),
(3, 'Ligne 3 – Pont de Levallois / Gallieni', '05:30:00', '01:15:00', 1),
(4, 'Ligne 4 – Porte de Clignancourt / Porte d\'Orléans', '05:30:00', '01:15:00', 2),
(5, 'Ligne 5 – Bobigny / Place d\'Italie', '05:30:00', '01:15:00', 1),
(6, 'Ligne 6 – Charles de Gaulle / Nation', '05:30:00', '01:15:00', 6),
(7, 'Ligne 7 – La Courneuve / Villejuif', '05:30:00', '01:15:00', 1),
(8, 'Ligne 8 – Balard / Créteil', '05:30:00', '01:15:00', 1),
(9, 'Ligne 9 – Pont de Sèvres / Montreuil', '05:30:00', '01:15:00', 1),
(10, 'Ligne 10 – Boulogne / Gare d\'Austerlitz', '05:30:00', '01:15:00', 1),
(11, 'Ligne 11 – Châtelet / Mairie des Lilas', '05:30:00', '01:15:00', 1),
(12, 'Ligne 12 – Front Populaire / Mairie d\'Issy', '05:30:00', '01:15:00', 1),
(13, 'Ligne 13 – Saint-Lazare / Châtillon', '05:30:00', '01:15:00', 1),
(14, 'Ligne 14 – Saint-Lazare / Olympiades', '05:30:00', '01:15:00', 2),
(15, 'RER A – Cergy / Marne-la-Vallée', '04:55:00', '01:20:00', 3),
(16, 'RER B – Robinson / Roissy', '04:55:00', '01:20:00', 3),
(17, 'RER C – Pontoise / Massy', '05:00:00', '01:20:00', 3),
(18, 'RER D – Orry / Melun', '05:00:00', '01:20:00', 3),
(19, 'RER E – Haussmann / Tournan', '05:15:00', '00:15:00', 3),
(20, 'Tramway T1 – Asnières / Noisy-le-Sec', '05:00:00', '00:30:00', 4);

-- ============================================
-- 10. Table ramemétro (dépend de conducteur et LigneMétro)
-- ============================================
INSERT INTO ramemétro (id, capacité, modeconduite, matricule, Numéro) VALUES 
(100001, 708, 'Automatique', NULL, 1),
(100002, 708, 'Automatique', NULL, 1),
(100003, 655, 'Conducteur', 'COND0001', 2),
(100004, 655, 'Conducteur', 'COND0002', 2),
(100005, 720, 'Conducteur', 'COND0003', 3),
(100006, 720, 'Conducteur', 'COND0004', 3),
(100007, 708, 'Automatique', NULL, 4),
(100008, 708, 'Automatique', NULL, 4),
(100009, 680, 'Conducteur', 'COND0005', 5),
(100010, 680, 'Conducteur', 'COND0006', 5),
(100011, 745, 'Conducteur', 'COND0007', 6),
(100012, 745, 'Conducteur', 'COND0008', 6),
(100013, 700, 'Conducteur', 'COND0009', 7),
(100014, 700, 'Conducteur', 'COND0010', 7),
(100015, 665, 'Conducteur', 'COND0011', 8),
(100016, 665, 'Conducteur', 'COND0012', 8),
(100017, 690, 'Conducteur', 'COND0013', 9),
(100018, 690, 'Conducteur', 'COND0014', 9),
(100019, 625, 'Conducteur', 'COND0015', 10),
(100020, 625, 'Conducteur', 'COND0016', 10);

-- ============================================
-- 11. Table trafic (dépend de titredetransport et station)
-- ============================================
INSERT INTO trafic (id, date_, heure, nbentrée, nbsortie, id_1, codeInterne) VALUES 
(1, '2024-01-15', '08:00:00', 1250, 850, 1, 'CHATEL001'),
(2, '2024-01-15', '08:00:00', 980, 720, 2, 'REPUB002'),
(3, '2024-01-15', '08:00:00', 1150, 890, 3, 'BASTIL003'),
(4, '2024-01-15', '08:00:00', 1350, 950, 4, 'NATION004'),
(5, '2024-01-15', '08:00:00', 780, 1200, 5, 'VINCEN005'),
(6, '2024-01-15', '08:00:00', 2100, 650, 6, 'DEFENS006'),
(7, '2024-01-15', '08:00:00', 890, 670, 7, 'LOUVRE007'),
(8, '2024-01-15', '08:00:00', 1050, 780, 8, 'OPERA008'),
(9, '2024-01-15', '08:00:00', 650, 580, 9, 'PIGALL009'),
(10, '2024-01-15', '08:00:00', 1450, 1100, 10, 'MNTPAR010'),
(11, '2024-01-15', '18:00:00', 850, 1250, 11, 'GAREDL011'),
(12, '2024-01-15', '18:00:00', 720, 980, 12, 'GARDN012'),
(13, '2024-01-15', '18:00:00', 890, 1150, 13, 'INVALIDE013'),
(14, '2024-01-15', '18:00:00', 950, 1350, 14, 'CONCOR014'),
(15, '2024-01-15', '18:00:00', 1200, 780, 15, 'TROCAD015'),
(16, '2024-01-15', '18:00:00', 650, 2100, 16, 'ARCHTR016'),
(17, '2024-01-15', '18:00:00', 670, 890, 17, 'BELLEV017'),
(18, '2024-01-15', '18:00:00', 780, 1050, 18, 'MENILM018'),
(19, '2024-01-15', '18:00:00', 580, 650, 19, 'PERELC019'),
(20, '2024-01-15', '18:00:00', 1100, 1450, 20, 'GAMBEL020');

-- ============================================
-- 12. Table incident (dépend de LigneMétro, station et typeincident)
-- ============================================
INSERT INTO incident (id, date_, heure, description, Numéro, codeInterne, id_1) VALUES 
(1, '2024-01-15', '08:15:00', 'Panne électrique sur rame en station', 1, 'CHATEL001', 1),
(2, '2024-01-15', '09:30:00', 'Malaise voyageur nécessitant intervention', 2, 'REPUB002', 5),
(3, '2024-01-15', '10:45:00', 'Problème technique de portes palières', 4, 'BASTIL003', 4),
(4, '2024-01-15', '12:20:00', 'Retard dû à un incident sur la ligne précédente', 3, 'NATION004', 3),
(5, '2024-01-15', '14:10:00', 'Colis suspect signalé par un voyageur', 1, 'VINCEN005', 6),
(6, '2024-01-15', '15:25:00', 'Vandalisme sur équipements de station', 5, 'DEFENS006', 7),
(7, '2024-01-15', '16:40:00', 'Panne de signalisation affectant la circulation', 6, 'LOUVRE007', 8),
(8, '2024-01-15', '17:55:00', 'Incident sur la voie nécessitant évacuation', 7, 'OPERA008', 9),
(9, '2024-01-15', '19:10:00', 'Problème de climatisation en période de forte chaleur', 8, 'PIGALL009', 10),
(10, '2024-01-15', '20:25:00', 'Panne d\'éclairage dans le tunnel', 9, 'MNTPAR010', 11),
(11, '2024-01-16', '07:30:00', 'Incident de sécurité nécessitant intervention police', 10, 'GAREDL011', 12),
(12, '2024-01-16', '08:45:00', 'Problème de portes sur rame en circulation', 11, 'GARDN012', 13),
(13, '2024-01-16', '10:00:00', 'Panne de communication entre poste de commande', 12, 'INVALIDE013', 14),
(14, '2024-01-16', '11:15:00', 'Incident météorologique affectant le trafic', 13, 'CONCOR014', 15),
(15, '2024-01-16', '13:30:00', 'Problème de freinage sur matériel roulant', 14, 'TROCAD015', 16),
(16, '2024-01-16', '14:45:00', 'Panne informatique du système de gestion', 15, 'ARCHTR016', 17),
(17, '2024-01-16', '16:00:00', 'Incident technique majeur nécessitant évacuation', 16, 'BELLEV017', 18),
(18, '2024-01-16', '17:15:00', 'Problème d\'alimentation électrique générale', 17, 'MENILM018', 19),
(19, '2024-01-16', '18:30:00', 'Dysfonctionnement équipement de sécurité', 18, 'PERELC019', 20),
(20, '2024-01-16', '19:45:00', 'Incident voyageur avec intervention SAMU', 19, 'GAMBEL020', 5);

-- ============================================
-- 13. Table message (dépend de typeincident et typemessage)
-- ============================================
INSERT INTO message (id, contenu, date_, heure, canal, id_1, id_2) VALUES 
(1, 'Panne électrique ligne 1 - Service interrompu temporairement', '2024-01-15', '08:16:00', 'Annonces sonores', 1, 'ALERT001'),
(2, 'Malaise voyageur République - Intervention en cours', '2024-01-15', '09:31:00', 'Affichage dynamique', 5, 'URGENC005'),
(3, 'Problème technique Bastille - Ralentissements prévus', '2024-01-15', '10:46:00', 'Application mobile', 4, 'PERTU003'),
(4, 'Retard ligne 3 suite incident - Reprise progressive', '2024-01-15', '12:21:00', 'Site web', 3, 'INFO004'),
(5, 'Alerte sécurité Vincennes - Évacuation en cours', '2024-01-15', '14:11:00', 'Annonces sonores', 6, 'URGENC005'),
(6, 'Vandalisme La Défense - Station temporairement fermée', '2024-01-15', '15:26:00', 'Réseaux sociaux', 7, 'SECU007'),
(7, 'Panne signalisation ligne 6 - Service perturbé', '2024-01-15', '16:41:00', 'Affichage dynamique', 8, 'ALERT001'),
(8, 'Incident voie Opéra - Évacuation terminée, reprise en cours', '2024-01-15', '17:56:00', 'Application mobile', 9, 'INFO004'),
(9, 'Problème climatisation - Inconfort temporaire', '2024-01-15', '19:11:00', 'Panneau information', 10, 'INFO004'),
(10, 'Panne éclairage tunnel - Circulation ralentie', '2024-01-15', '20:26:00', 'Radio interne', 11, 'PERTU003'),
(11, 'Incident sécurité Gare de Lyon - Intervention police terminée', '2024-01-16', '07:31:00', 'Annonces sonores', 12, 'SECU007'),
(12, 'Problème portes Gare du Nord - Réparation en cours', '2024-01-16', '08:46:00', 'Affichage dynamique', 13, 'MAINT002'),
(13, 'Panne communication - Retour à la normale progressif', '2024-01-16', '10:01:00', 'Site web', 14, 'NORMA020'),
(14, 'Conditions météo - Adaptation du service', '2024-01-16', '11:16:00', 'Application mobile', 15, 'METEO011'),
(15, 'Problème freinage matériel - Contrôle sécurité renforcé', '2024-01-16', '13:31:00', 'Radio interne', 16, 'SECU007'),
(16, 'Panne informatique - Retour fonctionnement normal', '2024-01-16', '14:46:00', 'Réseaux sociaux', 17, 'NORMA020'),
(17, 'Incident technique majeur - Service de substitution mis en place', '2024-01-16', '16:01:00', 'Tous canaux', 18, 'URGENC005'),
(18, 'Coupure alimentation - Générateurs de secours activés', '2024-01-16', '17:16:00', 'Annonces sonores', 19, 'ALERT001'),
(19, 'Dysfonctionnement sécurité - Vérifications en cours', '2024-01-16', '18:31:00', 'Affichage dynamique', 20, 'SECU007'),
(20, 'Intervention SAMU terminée - Service normal repris', '2024-01-16', '19:46:00', 'Application mobile', 5, 'NORMA020');

-- ============================================
-- 14. Table dessert (relation LigneMétro-station)
-- ============================================
INSERT INTO dessert (Numéro, codeInterne) VALUES 
(1, 'CHATEL001'),
(1, 'LOUVRE007'),
(1, 'CONCOR014'),
(1, 'DEFENS006'),
(1, 'VINCEN005'),
(2, 'NATION004'),
(2, 'REPUB002'),
(2, 'PIGALL009'),
(3, 'REPUB002'),
(3, 'BASTIL003'),
(4, 'CHATEL001'),
(4, 'MNTPAR010'),
(5, 'REPUB002'),
(5, 'BASTIL003'),
(6, 'NATION004'),
(6, 'MNTPAR010'),
(6, 'TROCAD015'),
(7, 'CHATEL001'),
(7, 'OPERA008'),
(8, 'INVALIDE013'),
(8, 'OPERA008');

-- ============================================
-- 15. Table équipé (relation station-équipement)
-- ============================================
INSERT INTO équipé (codeInterne, nom) VALUES 
('CHATEL001', 'Escalator'),
('CHATEL001', 'Ascenseur'),
('CHATEL001', 'Distributeur de tickets'),
('REPUB002', 'Escalator'),
('REPUB002', 'Borne d\'information'),
('BASTIL003', 'Ascenseur'),
('BASTIL003', 'Système de vidéosurveillance'),
('NATION004', 'Escalator'),
('NATION004', 'Panneau d\'affichage dynamique'),
('VINCEN005', 'Distributeur de tickets'),
('VINCEN005', 'Système audio'),
('DEFENS006', 'Escalator'),
('DEFENS006', 'Ascenseur'),
('DEFENS006', 'Éclairage LED'),
('LOUVRE007', 'Portiques d\'accès'),
('LOUVRE007', 'Bancs'),
('OPERA008', 'Poubelles de tri'),
('OPERA008', 'Défibrillateur'),
('PIGALL009', 'Système d\'alarme'),
('MNTPAR010', 'WiFi gratuit');

-- ============================================
-- 16. Table passe (relation station-ramemétro avec horaires)
-- ============================================
INSERT INTO passe (codeInterne, id, horaireprévu, horaireréel, écart) VALUES 
('CHATEL001', 100001, '2024-01-15 08:00:00', '2024-01-15 08:02:00', 2),
('REPUB002', 100003, '2024-01-15 08:05:00', '2024-01-15 08:05:00', 0),
('BASTIL003', 100005, '2024-01-15 08:10:00', '2024-01-15 08:12:00', 2),
('NATION004', 100003, '2024-01-15 08:15:00', '2024-01-15 08:14:00', -1),
('VINCEN005', 100001, '2024-01-15 08:20:00', '2024-01-15 08:23:00', 3),
('DEFENS006', 100001, '2024-01-15 08:25:00', '2024-01-15 08:25:00', 0),
('LOUVRE007', 100001, '2024-01-15 08:30:00', '2024-01-15 08:31:00', 1),
('OPERA008', 100013, '2024-01-15 08:35:00', '2024-01-15 08:37:00', 2),
('PIGALL009', 100003, '2024-01-15 08:40:00', '2024-01-15 08:40:00', 0),
('MNTPAR010', 100007, '2024-01-15 08:45:00', '2024-01-15 08:46:00', 1),
('GAREDL011', 100015, '2024-01-15 08:50:00', '2024-01-15 08:52:00', 2),
('GARDN012', 100011, '2024-01-15 08:55:00', '2024-01-15 08:54:00', -1),
('INVALIDE013', 100015, '2024-01-15 09:00:00', '2024-01-15 09:03:00', 3),
('CONCOR014', 100001, '2024-01-15 09:05:00', '2024-01-15 09:05:00', 0),
('TROCAD015', 100011, '2024-01-15 09:10:00', '2024-01-15 09:11:00', 1),
('ARCHTR016', 100017, '2024-01-15 09:15:00', '2024-01-15 09:17:00', 2),
('BELLEV017', 100019, '2024-01-15 09:20:00', '2024-01-15 09:20:00', 0),
('MENILM018', 100019, '2024-01-15 09:25:00', '2024-01-15 09:26:00', 1),
('PERELC019', 100017, '2024-01-15 09:30:00', '2024-01-15 09:32:00', 2),
('GAMBEL020', 100019, '2024-01-15 09:35:00', '2024-01-15 09:34:00', -1);

-- ============================================
-- 17. Table correspondance (relation station-station)
-- ============================================
INSERT INTO correspondance (codeInterne, codeInterne_1) VALUES 
('CHATEL001', 'LOUVRE007'),
('CHATEL001', 'GAREDL011'),
('REPUB002', 'BASTIL003'),
('REPUB002', 'BELLEV017'),
('NATION004', 'VINCEN005'),
('NATION004', 'GAREDL011'),
('MNTPAR010', 'INVALIDE013'),
('MNTPAR010', 'GARDN012'),
('OPERA008', 'PIGALL009'),
('OPERA008', 'CONCOR014'),
('TROCAD015', 'ARCHTR016'),
('DEFENS006', 'ARCHTR016'),
('LOUVRE007', 'CONCOR014'),
('BASTIL003', 'GAREDL011'),
('GARDN012', 'CHATEL001'),
('INVALIDE013', 'CONCOR014'),
('BELLEV017', 'MENILM018'),
('MENILM018', 'PERELC019'),
('PERELC019', 'GAMBEL020'),
('GAMBEL020', 'BELLEV017');

-- ============================================
-- 18. Table entretien (relation multiple : LigneMétro-équipement-ramemétro-centredemaintenance)
-- ============================================
INSERT INTO entretien (Numéro, nom, id, code) VALUES 
(1, 'Escalator', 100001, 'MAINT001'),
(1, 'Ascenseur', 100002, 'MAINT001'),
(2, 'Distributeur de tickets', 100003, 'MAINT002'),
(2, 'Borne d\'information', 100004, 'MAINT002'),
(3, 'Système de vidéosurveillance', 100005, 'MAINT003'),
(3, 'Panneau d\'affichage dynamique', 100006, 'MAINT003'),
(4, 'Système audio', 100007, 'MAINT004'),
(4, 'Éclairage LED', 100008, 'MAINT004'),
(5, 'Portiques d\'accès', 100009, 'MAINT005'),
(5, 'Bancs', 100010, 'MAINT005'),
(6, 'Poubelles de tri', 100011, 'MAINT006'),
(6, 'Défibrillateur', 100012, 'MAINT006'),
(7, 'Système d\'alarme', 100013, 'MAINT007'),
(7, 'WiFi gratuit', 100014, 'MAINT007'),
(8, 'Bornes USB', 100015, 'MAINT008'),
(8, 'Toilettes publiques', 100016, 'MAINT008'),
(9, 'Distributeur de boissons', 100017, 'MAINT009'),
(9, 'Plan de ligne interactif', 100018, 'MAINT009'),
(10, 'Système de climatisation', 100019, 'MAINT010'),
(10, 'Issue de secours', 100020, 'MAINT010');

-- ============================================
-- Fin du script d'insertion
-- ============================================
COMMIT;