-- =============================================================
-- CSI2532 - Projet e-Hôtels
-- Groupe 34 : Marie Youla & Adriane Sempore
-- views.sql : Vues SQL
-- =============================================================

-- =============================================================
-- VUE 1 : Nombre de chambres disponibles par zone
--
-- Justification :
-- Le projet exige de pouvoir consulter la disponibilité des
-- chambres en temps réel par zone géographique. Cette vue
-- regroupe les chambres non occupées aujourd'hui par adresse
-- d'hôtel. Elle est utilisée par l'interface de recherche pour
-- afficher rapidement les zones ayant des chambres libres sans
-- réécrire la sous-requête à chaque appel.
-- =============================================================
DROP VIEW IF EXISTS vue_chambres_disponibles_par_zone;
CREATE VIEW vue_chambres_disponibles_par_zone AS
SELECT
    h.adresse                   AS zone,
    ch.nom                      AS chaine,
    h.categorie,
    COUNT(c.chambre_id)         AS nb_chambres_disponibles,
    MIN(c.prix)                 AS prix_min,
    MAX(c.prix)                 AS prix_max,
    ROUND(AVG(c.prix), 2)       AS prix_moyen
FROM CHAMBRE c
JOIN HOTEL  h  ON c.hotel_id  = h.hotel_id
JOIN CHAINE ch ON h.chaine_id = ch.chaine_id
WHERE c.chambre_id NOT IN (
    -- Chambres actuellement louées
    SELECT chambre_id FROM LOCATION
    WHERE CURRENT_DATE BETWEEN date_debut AND date_fin
)
AND c.chambre_id NOT IN (
    -- Chambres avec réservation active aujourd'hui
    SELECT chambre_id FROM RESERVATION
    WHERE statut != 'annulée'
      AND CURRENT_DATE BETWEEN date_debut AND date_fin
)
GROUP BY h.adresse, ch.nom, h.categorie
ORDER BY h.adresse, ch.nom;

-- Exemple d'utilisation :
-- SELECT * FROM vue_chambres_disponibles_par_zone;
-- SELECT * FROM vue_chambres_disponibles_par_zone WHERE chaine = 'HorizonHotels';
-- SELECT * FROM vue_chambres_disponibles_par_zone ORDER BY nb_chambres_disponibles DESC;


-- =============================================================
-- VUE 2 : Capacité totale des chambres par hôtel
--
-- Justification :
-- Cette vue permet aux gestionnaires de consulter en un coup
-- d'œil la capacité d'accueil de chaque hôtel : nombre de
-- chambres, superficie totale, prix moyen, et répartition
-- par type de capacité (simple, double, triple, suite).
-- Elle sert aussi à vérifier que nb_chambres dans HOTEL
-- correspond bien au nombre réel de chambres enregistrées.
-- =============================================================
DROP VIEW IF EXISTS vue_capacite_hotel;
CREATE VIEW vue_capacite_hotel AS
SELECT
    h.hotel_id,
    h.adresse                                       AS hotel,
    ch.nom                                          AS chaine,
    h.categorie,
    COUNT(c.chambre_id)                             AS nb_chambres_total,
    SUM(c.superficie)                               AS superficie_totale_m2,
    ROUND(AVG(c.prix), 2)                           AS prix_moyen,
    COUNT(c.chambre_id) FILTER (WHERE c.capacite = 'simple')    AS nb_simples,
    COUNT(c.chambre_id) FILTER (WHERE c.capacite = 'double')    AS nb_doubles,
    COUNT(c.chambre_id) FILTER (WHERE c.capacite = 'triple')    AS nb_triples,
    COUNT(c.chambre_id) FILTER (WHERE c.capacite = 'suite')     AS nb_suites,
    COUNT(c.chambre_id) FILTER (WHERE c.lit_supplementaire)     AS nb_avec_lit_sup,
    COUNT(c.chambre_id) FILTER (WHERE c.etat_dommages IS NOT NULL) AS nb_avec_dommages
FROM HOTEL  h
JOIN CHAINE ch ON h.chaine_id = ch.chaine_id
LEFT JOIN CHAMBRE c ON c.hotel_id = h.hotel_id
GROUP BY h.hotel_id, h.adresse, ch.nom, h.categorie
ORDER BY ch.nom, h.hotel_id;

-- Exemple d'utilisation :
-- SELECT * FROM vue_capacite_hotel;
-- SELECT * FROM vue_capacite_hotel WHERE chaine = 'LakeviewSuites';
-- SELECT * FROM vue_capacite_hotel WHERE nb_avec_dommages > 0;
-- SELECT * FROM vue_capacite_hotel ORDER BY prix_moyen DESC;