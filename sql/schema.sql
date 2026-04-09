-- =============================================================
-- CSI2532 - Projet e-Hôtels
-- Groupe 34 : Marie Youla & Adriane Sempore
-- schema.sql : Création de la base de données
-- =============================================================

-- Supprimer les vues d'abord (elles dépendent des tables)
DROP VIEW IF EXISTS vue_chambres_disponibles_par_zone;
DROP VIEW IF EXISTS vue_capacite_hotel;

-- Supprimer les tables (ordre inverse des dépendances)
DROP TABLE IF EXISTS LOCATION   CASCADE;
DROP TABLE IF EXISTS RESERVATION CASCADE;
DROP TABLE IF EXISTS CHAMBRE    CASCADE;
DROP TABLE IF EXISTS EMPLOYE    CASCADE;
DROP TABLE IF EXISTS CLIENT     CASCADE;
DROP TABLE IF EXISTS HOTEL      CASCADE;
DROP TABLE IF EXISTS CHAINE     CASCADE;

-- =============================================================
-- TABLE CHAINE
-- =============================================================
CREATE TABLE CHAINE (
    chaine_id   SERIAL PRIMARY KEY,
    nom         VARCHAR(100) NOT NULL,
    adresse_siege_social VARCHAR(255) NOT NULL,
    nb_hotels   INT NOT NULL DEFAULT 0,
    email       VARCHAR(100),
    telephone   VARCHAR(20)
);

-- =============================================================
-- TABLE HOTEL
-- =============================================================
CREATE TABLE HOTEL (
    hotel_id    SERIAL PRIMARY KEY,
    chaine_id   INT NOT NULL,
    adresse     VARCHAR(255) NOT NULL,
    categorie   INT NOT NULL,
    nb_chambres INT NOT NULL DEFAULT 0,
    email       VARCHAR(100),
    telephone   VARCHAR(20),

    CONSTRAINT fk_hotel_chaine
        FOREIGN KEY (chaine_id) REFERENCES CHAINE(chaine_id)
        ON DELETE CASCADE,

    CONSTRAINT chk_categorie
        CHECK (categorie BETWEEN 1 AND 5)
);

-- =============================================================
-- TABLE CHAMBRE
-- =============================================================
CREATE TABLE CHAMBRE (
    chambre_id          SERIAL PRIMARY KEY,
    hotel_id            INT NOT NULL,
    prix                DECIMAL(10,2) NOT NULL,
    commodites          VARCHAR(255),
    capacite            VARCHAR(50) NOT NULL,
    vue                 VARCHAR(100),
    lit_supplementaire  BOOLEAN NOT NULL DEFAULT FALSE,
    etat_dommages       VARCHAR(255),
    superficie          DECIMAL(8,2),

    CONSTRAINT fk_chambre_hotel
        FOREIGN KEY (hotel_id) REFERENCES HOTEL(hotel_id)
        ON DELETE CASCADE,

    CONSTRAINT chk_prix
        CHECK (prix > 0),

    CONSTRAINT chk_superficie
        CHECK (superficie IS NULL OR superficie > 0)
);

-- =============================================================
-- TABLE CLIENT
-- =============================================================
CREATE TABLE CLIENT (
    client_id       SERIAL PRIMARY KEY,
    nom_complet     VARCHAR(150) NOT NULL,
    adresse         VARCHAR(255),
    nas             VARCHAR(20) NOT NULL UNIQUE,
    date_inscription DATE NOT NULL DEFAULT CURRENT_DATE
);

-- =============================================================
-- TABLE EMPLOYE
-- =============================================================
CREATE TABLE EMPLOYE (
    employe_id  SERIAL PRIMARY KEY,
    hotel_id    INT NOT NULL,
    nom_complet VARCHAR(150) NOT NULL,
    adresse     VARCHAR(255),
    nas         VARCHAR(20) NOT NULL UNIQUE,
    role        VARCHAR(100) NOT NULL,

    CONSTRAINT fk_employe_hotel
        FOREIGN KEY (hotel_id) REFERENCES HOTEL(hotel_id)
        ON DELETE RESTRICT
);

-- =============================================================
-- TABLE RESERVATION
-- =============================================================
CREATE TABLE RESERVATION (
    reservation_id   SERIAL PRIMARY KEY,
    chambre_id       INT NOT NULL,
    client_id        INT NOT NULL,
    date_reservation DATE NOT NULL DEFAULT CURRENT_DATE,
    date_debut       DATE NOT NULL,
    date_fin         DATE NOT NULL,
    statut           VARCHAR(50) NOT NULL DEFAULT 'en attente',

    CONSTRAINT fk_reservation_chambre
        FOREIGN KEY (chambre_id) REFERENCES CHAMBRE(chambre_id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_reservation_client
        FOREIGN KEY (client_id) REFERENCES CLIENT(client_id)
        ON DELETE RESTRICT,

    CONSTRAINT chk_dates_reservation
        CHECK (date_fin > date_debut)
);

-- =============================================================
-- TABLE LOCATION
-- =============================================================
CREATE TABLE LOCATION (
    location_id     SERIAL PRIMARY KEY,
    chambre_id      INT NOT NULL,
    client_id       INT NOT NULL,
    employe_id      INT NOT NULL,
    reservation_id  INT,           -- NULL si location directe sans réservation
    date_checkin    DATE NOT NULL DEFAULT CURRENT_DATE,
    date_debut      DATE NOT NULL,
    date_fin        DATE NOT NULL,

    CONSTRAINT fk_location_chambre
        FOREIGN KEY (chambre_id) REFERENCES CHAMBRE(chambre_id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_location_client
        FOREIGN KEY (client_id) REFERENCES CLIENT(client_id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_location_employe
        FOREIGN KEY (employe_id) REFERENCES EMPLOYE(employe_id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_location_reservation
        FOREIGN KEY (reservation_id) REFERENCES RESERVATION(reservation_id)
        ON DELETE SET NULL,

    CONSTRAINT chk_dates_location
        CHECK (date_fin > date_debut),

    CONSTRAINT chk_checkin
        CHECK (date_checkin >= date_debut)
);

-- =============================================================
-- INDEX (performance des requêtes)
-- =============================================================

-- Index 1 : Recherche de chambres disponibles par hôtel
CREATE INDEX IF NOT EXISTS idx_chambre_hotel ON CHAMBRE(hotel_id);

-- Index 2 : Recherche des réservations par client
CREATE INDEX IF NOT EXISTS idx_reservation_client ON RESERVATION(client_id);

-- Index 3 : Recherche des locations par dates
CREATE INDEX IF NOT EXISTS idx_location_dates ON LOCATION(date_debut, date_fin);

-- Index 4 : Recherche des hôtels par chaîne
CREATE INDEX IF NOT EXISTS idx_hotel_chaine ON HOTEL(chaine_id);

-- Index 5 : Recherche des employés par hôtel
CREATE INDEX IF NOT EXISTS idx_employe_hotel ON EMPLOYE(hotel_id);

-- Les vues sont définies dans views.sql
-- Exécuter views.sql après schema.sql et data.sql

-- =============================================================
-- TRIGGERS
-- =============================================================

-- Trigger 1 : Mettre à jour nb_hotels dans CHAINE à l'ajout/suppression d'un hôtel
CREATE OR REPLACE FUNCTION update_nb_hotels()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE CHAINE SET nb_hotels = nb_hotels + 1
        WHERE chaine_id = NEW.chaine_id;
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE CHAINE SET nb_hotels = nb_hotels - 1
        WHERE chaine_id = OLD.chaine_id;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_update_nb_hotels ON HOTEL;
CREATE TRIGGER trg_update_nb_hotels
AFTER INSERT OR DELETE ON HOTEL
FOR EACH ROW EXECUTE FUNCTION update_nb_hotels();

-- Trigger 2 : Mettre à jour nb_chambres dans HOTEL à l'ajout/suppression d'une chambre
CREATE OR REPLACE FUNCTION update_nb_chambres()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE HOTEL SET nb_chambres = nb_chambres + 1
        WHERE hotel_id = NEW.hotel_id;
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE HOTEL SET nb_chambres = nb_chambres - 1
        WHERE hotel_id = OLD.hotel_id;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_update_nb_chambres ON CHAMBRE;
CREATE TRIGGER trg_update_nb_chambres
AFTER INSERT OR DELETE ON CHAMBRE
FOR EACH ROW EXECUTE FUNCTION update_nb_chambres();

-- Trigger 3 : Changer le statut de la réservation quand elle est convertie en location
CREATE OR REPLACE FUNCTION confirmer_reservation()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.reservation_id IS NOT NULL THEN
        UPDATE RESERVATION SET statut = 'confirmée'
        WHERE reservation_id = NEW.reservation_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_confirmer_reservation ON LOCATION;
CREATE TRIGGER trg_confirmer_reservation
AFTER INSERT ON LOCATION
FOR EACH ROW EXECUTE FUNCTION confirmer_reservation();