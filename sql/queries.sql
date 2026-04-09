-
-- =============================================================
-- REQUÊTE 1 : Recherche de chambres disponibles selon critères
-- Retourne toutes les chambres libres pour des dates données,
-- filtrées par capacité, prix max, et chaîne hôtelière.
-- Utilisation : moteur de recherche de l'interface utilisateur
-- =============================================================
SELECT
    c.chambre_id,
    ch.nom           AS chaine,
    h.adresse        AS hotel,
    h.categorie,
    c.capacite,
    c.vue,
    c.prix,
    c.superficie,
    c.commodites,
    c.lit_supplementaire
FROM CHAMBRE c
JOIN HOTEL h   ON c.hotel_id   = h.hotel_id
JOIN CHAINE ch ON h.chaine_id  = ch.chaine_id
WHERE
    -- Chambre non occupée pendant la période demandée
    c.chambre_id NOT IN (
        SELECT chambre_id FROM RESERVATION
        WHERE statut != 'annulée'
          AND date_debut < '2026-04-20'
          AND date_fin   > '2026-04-15'
    )
    AND c.chambre_id NOT IN (
        SELECT chambre_id FROM LOCATION
        WHERE date_debut < '2026-04-20'
          AND date_fin   > '2026-04-15'
    )
    -- Filtres optionnels (adapter selon les critères de l'utilisateur)
    AND c.capacite  = 'double'        -- capacité souhaitée
    AND c.prix     <= 500.00          -- prix maximum
    AND ch.nom      = 'HorizonHotels' -- chaîne souhaitée
ORDER BY c.prix ASC;


-- =============================================================
-- REQUÊTE 2 : Historique des réservations d'un client
-- Retourne toutes les réservations et locations passées
-- et futures d'un client donné, avec les détails de la chambre.
-- Utilisation : espace client dans l'interface
-- =============================================================
SELECT
    'Réservation'           AS type,
    r.reservation_id        AS id,
    r.date_debut,
    r.date_fin,
    r.statut,
    h.adresse               AS hotel,
    ch.nom                  AS chaine,
    c.capacite,
    c.prix,
    c.vue
FROM RESERVATION r
JOIN CHAMBRE c ON r.chambre_id = c.chambre_id
JOIN HOTEL h   ON c.hotel_id   = h.hotel_id
JOIN CHAINE ch ON h.chaine_id  = ch.chaine_id
WHERE r.client_id = 1  -- remplacer par le client_id voulu

UNION ALL

SELECT
    'Location'              AS type,
    l.location_id           AS id,
    l.date_debut,
    l.date_fin,
    'complétée'             AS statut,
    h.adresse               AS hotel,
    ch.nom                  AS chaine,
    c.capacite,
    c.prix,
    c.vue
FROM LOCATION l
JOIN CHAMBRE c ON l.chambre_id = c.chambre_id
JOIN HOTEL h   ON c.hotel_id   = h.hotel_id
JOIN CHAINE ch ON h.chaine_id  = ch.chaine_id
WHERE l.client_id = 1  -- remplacer par le client_id voulu

ORDER BY date_debut DESC;


-- =============================================================
-- REQUÊTE 3 : Taux d'occupation des hôtels sur une période
-- Retourne le nombre de chambres occupées vs total par hôtel,
-- ainsi que le pourcentage d'occupation.
-- Utilisation : tableau de bord gestionnaire
-- =============================================================
SELECT
    h.hotel_id,
    h.adresse,
    ch.nom                              AS chaine,
    h.categorie,
    h.nb_chambres                       AS total_chambres,
    COUNT(DISTINCT l.chambre_id)        AS chambres_occupees,
    ROUND(
        COUNT(DISTINCT l.chambre_id)::DECIMAL
        / NULLIF(h.nb_chambres, 0) * 100, 1
    )                                   AS taux_occupation_pct
FROM HOTEL h
JOIN CHAINE ch ON h.chaine_id = ch.chaine_id
LEFT JOIN CHAMBRE c ON c.hotel_id = h.hotel_id
LEFT JOIN LOCATION l ON l.chambre_id = c.chambre_id
    AND l.date_debut <= CURRENT_DATE
    AND l.date_fin   >= CURRENT_DATE
GROUP BY h.hotel_id, h.adresse, ch.nom, h.categorie, h.nb_chambres
ORDER BY taux_occupation_pct DESC NULLS LAST;


-- =============================================================
-- REQUÊTE 4 : Employés par hôtel avec leur rôle
-- Retourne la liste de tous les employés, leur hôtel,
-- leur chaîne et leur rôle. Met en évidence les gestionnaires.
-- Utilisation : gestion des employés dans l'interface admin
-- =============================================================
SELECT
    e.employe_id,
    e.nom_complet,
    e.role,
    h.adresse   AS hotel,
    ch.nom      AS chaine,
    h.categorie,
    CASE
        WHEN e.role = 'gestionnaire' THEN 'Oui'
        ELSE 'Non'
    END         AS est_gestionnaire
FROM EMPLOYE e
JOIN HOTEL h   ON e.hotel_id  = h.hotel_id
JOIN CHAINE ch ON h.chaine_id = ch.chaine_id
ORDER BY ch.nom, h.adresse, e.role, e.nom_complet;