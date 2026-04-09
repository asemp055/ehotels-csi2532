
-- data.sql : Insertion des données initiales
-- =============================================================

-- =============================================================
-- CHAÎNES HÔTELIÈRES (5 chaînes)
-- =============================================================
INSERT INTO CHAINE (nom, adresse_siege_social, email, telephone) VALUES
('HorizonHotels',   '100 Bay St, Toronto, ON, Canada',          'contact@horizonhotels.com',  '416-100-0001'),
('PeakResorts',     '200 Robson St, Vancouver, BC, Canada',      'info@peakresorts.com',       '604-200-0002'),
('MapleStay',       '300 Sainte-Catherine, Montréal, QC, Canada','hello@maplestay.com',        '514-300-0003'),
('LakeviewSuites',  '400 Rideau St, Ottawa, ON, Canada',         'stay@lakeviewsuites.com',    '613-400-0004'),
('NorthernLodge',   '500 Jasper Ave, Edmonton, AB, Canada',      'book@northernlodge.com',     '780-500-0005');

-- =============================================================
-- HÔTELS (8 par chaîne = 40 hôtels)
-- Catégories variées (1 à 5 étoiles)
-- Au moins 2 hôtels dans une même zone (Ottawa)
-- =============================================================

-- HorizonHotels (chaine_id = 1)
INSERT INTO HOTEL (chaine_id, adresse, categorie, email, telephone) VALUES
(1, '10 King St, Toronto, ON',          5, 'toronto1@horizonhotels.com',   '416-101-0001'),
(1, '20 Queen St, Toronto, ON',         4, 'toronto2@horizonhotels.com',   '416-101-0002'),
(1, '30 Rideau St, Ottawa, ON',         5, 'ottawa1@horizonhotels.com',    '613-101-0003'),
(1, '40 Sparks St, Ottawa, ON',         3, 'ottawa2@horizonhotels.com',    '613-101-0004'),
(1, '50 Yonge St, Toronto, ON',         2, 'toronto3@horizonhotels.com',   '416-101-0005'),
(1, '60 Front St, Toronto, ON',         4, 'toronto4@horizonhotels.com',   '416-101-0006'),
(1, '70 College St, Toronto, ON',       1, 'toronto5@horizonhotels.com',   '416-101-0007'),
(1, '80 Bloor St, Toronto, ON',         3, 'toronto6@horizonhotels.com',   '416-101-0008');

-- PeakResorts (chaine_id = 2)
INSERT INTO HOTEL (chaine_id, adresse, categorie, email, telephone) VALUES
(2, '100 Granville St, Vancouver, BC',  5, 'van1@peakresorts.com',         '604-201-0001'),
(2, '200 Burrard St, Vancouver, BC',    4, 'van2@peakresorts.com',         '604-201-0002'),
(2, '300 Robson St, Vancouver, BC',     3, 'van3@peakresorts.com',         '604-201-0003'),
(2, '400 Georgia St, Vancouver, BC',    5, 'van4@peakresorts.com',         '604-201-0004'),
(2, '500 Hastings St, Vancouver, BC',   2, 'van5@peakresorts.com',         '604-201-0005'),
(2, '600 Main St, Vancouver, BC',       1, 'van6@peakresorts.com',         '604-201-0006'),
(2, '700 Davie St, Vancouver, BC',      4, 'van7@peakresorts.com',         '604-201-0007'),
(2, '800 Denman St, Vancouver, BC',     3, 'van8@peakresorts.com',         '604-201-0008');

-- MapleStay (chaine_id = 3)
INSERT INTO HOTEL (chaine_id, adresse, categorie, email, telephone) VALUES
(3, '100 Sainte-Catherine O, Montréal, QC', 5, 'mtl1@maplestay.com',      '514-301-0001'),
(3, '200 Peel St, Montréal, QC',            4, 'mtl2@maplestay.com',      '514-301-0002'),
(3, '300 Sherbrooke St, Montréal, QC',      3, 'mtl3@maplestay.com',      '514-301-0003'),
(3, '400 Saint-Denis St, Montréal, QC',     2, 'mtl4@maplestay.com',      '514-301-0004'),
(3, '500 Notre-Dame St, Montréal, QC',      5, 'mtl5@maplestay.com',      '514-301-0005'),
(3, '600 Crescent St, Montréal, QC',        4, 'mtl6@maplestay.com',      '514-301-0006'),
(3, '700 Saint-Laurent, Montréal, QC',      1, 'mtl7@maplestay.com',      '514-301-0007'),
(3, '800 Plateau Ave, Montréal, QC',        3, 'mtl8@maplestay.com',      '514-301-0008');

-- LakeviewSuites (chaine_id = 4)
INSERT INTO HOTEL (chaine_id, adresse, categorie, email, telephone) VALUES
(4, '100 Rideau St, Ottawa, ON',        5, 'ott1@lakeviewsuites.com',      '613-401-0001'),
(4, '200 Bank St, Ottawa, ON',          4, 'ott2@lakeviewsuites.com',      '613-401-0002'),
(4, '300 Elgin St, Ottawa, ON',         3, 'ott3@lakeviewsuites.com',      '613-401-0003'),
(4, '400 Sussex Dr, Ottawa, ON',        5, 'ott4@lakeviewsuites.com',      '613-401-0004'),
(4, '500 Wellington St, Ottawa, ON',    2, 'ott5@lakeviewsuites.com',      '613-401-0005'),
(4, '600 Laurier Ave, Ottawa, ON',      4, 'ott6@lakeviewsuites.com',      '613-401-0006'),
(4, '700 Bronson Ave, Ottawa, ON',      1, 'ott7@lakeviewsuites.com',      '613-401-0007'),
(4, '800 Carling Ave, Ottawa, ON',      3, 'ott8@lakeviewsuites.com',      '613-401-0008');

-- NorthernLodge (chaine_id = 5)
INSERT INTO HOTEL (chaine_id, adresse, categorie, email, telephone) VALUES
(5, '100 Jasper Ave, Edmonton, AB',     5, 'edm1@northernlodge.com',       '780-501-0001'),
(5, '200 Whyte Ave, Edmonton, AB',      4, 'edm2@northernlodge.com',       '780-501-0002'),
(5, '300 Stony Plain Rd, Edmonton, AB', 3, 'edm3@northernlodge.com',       '780-501-0003'),
(5, '400 Gateway Blvd, Edmonton, AB',   2, 'edm4@northernlodge.com',       '780-501-0004'),
(5, '500 Calgary Trail, Edmonton, AB',  5, 'edm5@northernlodge.com',       '780-501-0005'),
(5, '600 Fort Rd, Edmonton, AB',        1, 'edm6@northernlodge.com',       '780-501-0006'),
(5, '700 118 Ave, Edmonton, AB',        4, 'edm7@northernlodge.com',       '780-501-0007'),
(5, '800 82 Ave, Edmonton, AB',         3, 'edm8@northernlodge.com',       '780-501-0008');

-- =============================================================
-- EMPLOYÉS (au moins 1 gestionnaire par hôtel)
-- On insère pour les 40 hôtels (hotel_id 1 à 40)
-- =============================================================
INSERT INTO EMPLOYE (hotel_id, nom_complet, adresse, nas, role) VALUES
-- HorizonHotels
(1,  'Alice Tremblay',    '11 King St, Toronto, ON',       '111-111-001', 'gestionnaire'),
(1,  'Bob Martin',        '12 King St, Toronto, ON',       '111-111-002', 'réceptionniste'),
(2,  'Claire Bouchard',   '21 Queen St, Toronto, ON',      '111-111-003', 'gestionnaire'),
(3,  'David Gagnon',      '31 Rideau St, Ottawa, ON',      '111-111-004', 'gestionnaire'),
(3,  'Eva Leblanc',       '32 Rideau St, Ottawa, ON',      '111-111-005', 'femme de chambre'),
(4,  'Frank Roy',         '41 Sparks St, Ottawa, ON',      '111-111-006', 'gestionnaire'),
(5,  'Grace Côté',        '51 Yonge St, Toronto, ON',      '111-111-007', 'gestionnaire'),
(6,  'Hugo Morin',        '61 Front St, Toronto, ON',      '111-111-008', 'gestionnaire'),
(7,  'Isabelle Fortin',   '71 College St, Toronto, ON',    '111-111-009', 'gestionnaire'),
(8,  'Jacques Girard',    '81 Bloor St, Toronto, ON',      '111-111-010', 'gestionnaire'),
-- PeakResorts
(9,  'Karen Smith',       '101 Granville St, Vancouver',   '222-222-001', 'gestionnaire'),
(10, 'Luc Gauthier',      '201 Burrard St, Vancouver',     '222-222-002', 'gestionnaire'),
(11, 'Marie Ouellet',     '301 Robson St, Vancouver',      '222-222-003', 'gestionnaire'),
(12, 'Nathan Bergeron',   '401 Georgia St, Vancouver',     '222-222-004', 'gestionnaire'),
(13, 'Olivia Pelletier',  '501 Hastings St, Vancouver',    '222-222-005', 'gestionnaire'),
(14, 'Pierre Lavoie',     '601 Main St, Vancouver',        '222-222-006', 'gestionnaire'),
(15, 'Quinn Desrochers',  '701 Davie St, Vancouver',       '222-222-007', 'gestionnaire'),
(16, 'Rachel Paquette',   '801 Denman St, Vancouver',      '222-222-008', 'gestionnaire'),
-- MapleStay
(17, 'Samuel Venne',      '101 Ste-Cath, Montréal',        '333-333-001', 'gestionnaire'),
(18, 'Tania Cloutier',    '201 Peel St, Montréal',         '333-333-002', 'gestionnaire'),
(19, 'Ugo Beauchemin',    '301 Sherbrooke, Montréal',      '333-333-003', 'gestionnaire'),
(20, 'Vanessa Hamel',     '401 Saint-Denis, Montréal',     '333-333-004', 'gestionnaire'),
(21, 'William Perron',    '501 Notre-Dame, Montréal',      '333-333-005', 'gestionnaire'),
(22, 'Xavier Lepage',     '601 Crescent St, Montréal',     '333-333-006', 'gestionnaire'),
(23, 'Yasmine Poirier',   '701 Saint-Laurent, Montréal',   '333-333-007', 'gestionnaire'),
(24, 'Zachary Couture',   '801 Plateau Ave, Montréal',     '333-333-008', 'gestionnaire'),
-- LakeviewSuites
(25, 'Amélie Turcot',     '101 Rideau St, Ottawa',         '444-444-001', 'gestionnaire'),
(26, 'Bruno Vaillant',    '201 Bank St, Ottawa',           '444-444-002', 'gestionnaire'),
(27, 'Camille Bélanger',  '301 Elgin St, Ottawa',          '444-444-003', 'gestionnaire'),
(28, 'Denis Chartrand',   '401 Sussex Dr, Ottawa',         '444-444-004', 'gestionnaire'),
(29, 'Élise Mercier',     '501 Wellington St, Ottawa',     '444-444-005', 'gestionnaire'),
(30, 'Félix Dion',        '601 Laurier Ave, Ottawa',       '444-444-006', 'gestionnaire'),
(31, 'Geneviève Picard',  '701 Bronson Ave, Ottawa',       '444-444-007', 'gestionnaire'),
(32, 'Henri Lalonde',     '801 Carling Ave, Ottawa',       '444-444-008', 'gestionnaire'),
-- NorthernLodge
(33, 'Ingrid Masse',      '101 Jasper Ave, Edmonton',      '555-555-001', 'gestionnaire'),
(34, 'Julien Leclerc',    '201 Whyte Ave, Edmonton',       '555-555-002', 'gestionnaire'),
(35, 'Karine Blais',      '301 Stony Plain, Edmonton',     '555-555-003', 'gestionnaire'),
(36, 'Laurent Grenier',   '401 Gateway, Edmonton',         '555-555-004', 'gestionnaire'),
(37, 'Mélissa Paradis',   '501 Calgary Trail, Edmonton',   '555-555-005', 'gestionnaire'),
(38, 'Nicolas Archambault','601 Fort Rd, Edmonton',        '555-555-006', 'gestionnaire'),
(39, 'Ophélie Simard',    '701 118 Ave, Edmonton',         '555-555-007', 'gestionnaire'),
(40, 'Pascal Richard',    '801 82 Ave, Edmonton',          '555-555-008', 'gestionnaire');

-- =============================================================
-- CHAMBRES (5 par hôtel = 200 chambres)
-- Capacités variées : simple, double, triple, suite
-- =============================================================

-- Fonction pour insérer 5 chambres par hôtel
-- hotel_id 1 à 40, prix et vues variés

INSERT INTO CHAMBRE (hotel_id, prix, commodites, capacite, vue, lit_supplementaire, etat_dommages, superficie) VALUES
-- Hôtel 1
(1, 250.00, 'TV, WiFi, Climatisation, Minibar', 'simple',  'ville',     FALSE, NULL,              25.0),
(1, 350.00, 'TV, WiFi, Climatisation, Minibar', 'double',  'ville',     TRUE,  NULL,              35.0),
(1, 450.00, 'TV, WiFi, Climatisation, Jacuzzi', 'double',  'mer',       TRUE,  NULL,              45.0),
(1, 600.00, 'TV, WiFi, Climatisation, Cuisine', 'triple',  'mer',       TRUE,  NULL,              60.0),
(1, 900.00, 'TV, WiFi, Climatisation, Salon',   'suite',   'panoramique',TRUE, NULL,              90.0),
-- Hôtel 2
(2, 180.00, 'TV, WiFi',                          'simple',  'ville',     FALSE, NULL,              22.0),
(2, 280.00, 'TV, WiFi, Climatisation',           'double',  'ville',     FALSE, NULL,              32.0),
(2, 380.00, 'TV, WiFi, Climatisation, Minibar', 'double',  'montagne',  TRUE,  NULL,              40.0),
(2, 480.00, 'TV, WiFi, Climatisation, Cuisine', 'triple',  'montagne',  TRUE,  'légère égratignure', 55.0),
(2, 700.00, 'TV, WiFi, Climatisation, Salon',   'suite',   'panoramique',TRUE, NULL,              85.0),
-- Hôtel 3
(3, 300.00, 'TV, WiFi, Climatisation, Minibar', 'simple',  'ville',     FALSE, NULL,              28.0),
(3, 400.00, 'TV, WiFi, Climatisation, Minibar', 'double',  'ville',     TRUE,  NULL,              38.0),
(3, 500.00, 'TV, WiFi, Climatisation, Jacuzzi', 'double',  'rivière',   TRUE,  NULL,              48.0),
(3, 650.00, 'TV, WiFi, Climatisation, Cuisine', 'triple',  'rivière',   TRUE,  NULL,              65.0),
(3, 950.00, 'TV, WiFi, Climatisation, Salon',   'suite',   'panoramique',TRUE, NULL,              95.0),
-- Hôtel 4
(4, 120.00, 'TV, WiFi',                          'simple',  'cour',      FALSE, 'tache sur moquette', 20.0),
(4, 200.00, 'TV, WiFi, Climatisation',           'double',  'cour',      FALSE, NULL,              30.0),
(4, 300.00, 'TV, WiFi, Climatisation, Minibar', 'double',  'ville',     TRUE,  NULL,              38.0),
(4, 420.00, 'TV, WiFi, Climatisation, Cuisine', 'triple',  'ville',     TRUE,  NULL,              52.0),
(4, 600.00, 'TV, WiFi, Climatisation, Salon',   'suite',   'ville',     TRUE,  NULL,              75.0),
-- Hôtel 5
(5, 150.00, 'TV, WiFi',                          'simple',  'ville',     FALSE, NULL,              21.0),
(5, 250.00, 'TV, WiFi, Climatisation',           'double',  'ville',     FALSE, NULL,              31.0),
(5, 350.00, 'TV, WiFi, Climatisation, Minibar', 'double',  'jardin',    TRUE,  NULL,              41.0),
(5, 450.00, 'TV, WiFi, Climatisation, Cuisine', 'triple',  'jardin',    TRUE,  NULL,              53.0),
(5, 680.00, 'TV, WiFi, Climatisation, Salon',   'suite',   'panoramique',TRUE, NULL,              80.0),
-- Hôtel 6
(6, 220.00, 'TV, WiFi, Climatisation',           'simple',  'ville',     FALSE, NULL,              24.0),
(6, 320.00, 'TV, WiFi, Climatisation, Minibar', 'double',  'ville',     TRUE,  NULL,              34.0),
(6, 420.00, 'TV, WiFi, Climatisation, Minibar', 'double',  'mer',       TRUE,  NULL,              44.0),
(6, 550.00, 'TV, WiFi, Climatisation, Cuisine', 'triple',  'mer',       TRUE,  NULL,              58.0),
(6, 850.00, 'TV, WiFi, Climatisation, Salon',   'suite',   'panoramique',TRUE, NULL,              88.0),
-- Hôtel 7
(7, 100.00, 'TV, WiFi',                          'simple',  'cour',      FALSE, 'rideau déchiré',  18.0),
(7, 160.00, 'TV, WiFi',                          'double',  'cour',      FALSE, NULL,              26.0),
(7, 240.00, 'TV, WiFi, Climatisation',           'double',  'ville',     TRUE,  NULL,              34.0),
(7, 320.00, 'TV, WiFi, Climatisation, Minibar', 'triple',  'ville',     TRUE,  NULL,              46.0),
(7, 500.00, 'TV, WiFi, Climatisation, Salon',   'suite',   'ville',     TRUE,  NULL,              70.0),
-- Hôtel 8
(8, 190.00, 'TV, WiFi, Climatisation',           'simple',  'ville',     FALSE, NULL,              23.0),
(8, 290.00, 'TV, WiFi, Climatisation, Minibar', 'double',  'ville',     FALSE, NULL,              33.0),
(8, 390.00, 'TV, WiFi, Climatisation, Jacuzzi', 'double',  'montagne',  TRUE,  NULL,              43.0),
(8, 520.00, 'TV, WiFi, Climatisation, Cuisine', 'triple',  'montagne',  TRUE,  NULL,              57.0),
(8, 780.00, 'TV, WiFi, Climatisation, Salon',   'suite',   'panoramique',TRUE, NULL,              82.0),
-- Hôtel 9
(9, 280.00, 'TV, WiFi, Climatisation, Minibar', 'simple',  'mer',       FALSE, NULL,              27.0),
(9, 380.00, 'TV, WiFi, Climatisation, Minibar', 'double',  'mer',       TRUE,  NULL,              37.0),
(9, 500.00, 'TV, WiFi, Climatisation, Jacuzzi', 'double',  'mer',       TRUE,  NULL,              50.0),
(9, 680.00, 'TV, WiFi, Climatisation, Cuisine', 'triple',  'mer',       TRUE,  NULL,              68.0),
(9, 999.00, 'TV, WiFi, Climatisation, Salon',   'suite',   'panoramique',TRUE, NULL,              100.0),
-- Hôtel 10
(10, 200.00, 'TV, WiFi, Climatisation',          'simple',  'montagne',  FALSE, NULL,              24.0),
(10, 300.00, 'TV, WiFi, Climatisation, Minibar', 'double',  'montagne',  TRUE,  NULL,              36.0),
(10, 420.00, 'TV, WiFi, Climatisation, Minibar', 'double',  'forêt',     TRUE,  NULL,              46.0),
(10, 560.00, 'TV, WiFi, Climatisation, Cuisine', 'triple',  'forêt',     TRUE,  NULL,              60.0),
(10, 820.00, 'TV, WiFi, Climatisation, Salon',   'suite',   'panoramique',TRUE, NULL,              86.0),
-- Hôtels 11 à 40 (format condensé, même structure)
(11, 170.00,'TV, WiFi','simple','ville',FALSE,NULL,20.0),(11,270.00,'TV, WiFi, Climatisation','double','ville',TRUE,NULL,32.0),(11,370.00,'TV, WiFi, Climatisation, Minibar','double','montagne',TRUE,NULL,42.0),(11,490.00,'TV, WiFi, Climatisation, Cuisine','triple','montagne',TRUE,NULL,54.0),(11,720.00,'TV, WiFi, Climatisation, Salon','suite','panoramique',TRUE,NULL,78.0),
(12,260.00,'TV, WiFi, Climatisation, Minibar','simple','mer',FALSE,NULL,26.0),(12,360.00,'TV, WiFi, Climatisation, Minibar','double','mer',TRUE,NULL,36.0),(12,480.00,'TV, WiFi, Climatisation, Jacuzzi','double','mer',TRUE,NULL,48.0),(12,630.00,'TV, WiFi, Climatisation, Cuisine','triple','mer',TRUE,NULL,63.0),(12,950.00,'TV, WiFi, Climatisation, Salon','suite','panoramique',TRUE,NULL,95.0),
(13,130.00,'TV, WiFi','simple','cour',FALSE,'légère égratignure',19.0),(13,210.00,'TV, WiFi, Climatisation','double','cour',FALSE,NULL,29.0),(13,310.00,'TV, WiFi, Climatisation, Minibar','double','ville',TRUE,NULL,39.0),(13,410.00,'TV, WiFi, Climatisation, Cuisine','triple','ville',TRUE,NULL,51.0),(13,620.00,'TV, WiFi, Climatisation, Salon','suite','ville',TRUE,NULL,72.0),
(14,110.00,'TV, WiFi','simple','cour',FALSE,NULL,18.0),(14,180.00,'TV, WiFi','double','cour',FALSE,'tache sur mur',27.0),(14,260.00,'TV, WiFi, Climatisation','double','ville',TRUE,NULL,35.0),(14,360.00,'TV, WiFi, Climatisation, Minibar','triple','ville',TRUE,NULL,47.0),(14,540.00,'TV, WiFi, Climatisation, Salon','suite','ville',TRUE,NULL,71.0),
(15,230.00,'TV, WiFi, Climatisation, Minibar','simple','forêt',FALSE,NULL,25.0),(15,330.00,'TV, WiFi, Climatisation, Minibar','double','forêt',TRUE,NULL,35.0),(15,440.00,'TV, WiFi, Climatisation, Jacuzzi','double','montagne',TRUE,NULL,46.0),(15,590.00,'TV, WiFi, Climatisation, Cuisine','triple','montagne',TRUE,NULL,62.0),(15,880.00,'TV, WiFi, Climatisation, Salon','suite','panoramique',TRUE,NULL,90.0),
(16,160.00,'TV, WiFi, Climatisation','simple','ville',FALSE,NULL,22.0),(16,260.00,'TV, WiFi, Climatisation, Minibar','double','ville',TRUE,NULL,33.0),(16,360.00,'TV, WiFi, Climatisation, Minibar','double','mer',TRUE,NULL,43.0),(16,480.00,'TV, WiFi, Climatisation, Cuisine','triple','mer',TRUE,NULL,56.0),(16,730.00,'TV, WiFi, Climatisation, Salon','suite','panoramique',TRUE,NULL,83.0),
(17,290.00,'TV, WiFi, Climatisation, Minibar','simple','ville',FALSE,NULL,28.0),(17,390.00,'TV, WiFi, Climatisation, Minibar','double','ville',TRUE,NULL,38.0),(17,510.00,'TV, WiFi, Climatisation, Jacuzzi','double','fleuve',TRUE,NULL,51.0),(17,670.00,'TV, WiFi, Climatisation, Cuisine','triple','fleuve',TRUE,NULL,67.0),(17,980.00,'TV, WiFi, Climatisation, Salon','suite','panoramique',TRUE,NULL,98.0),
(18,210.00,'TV, WiFi, Climatisation','simple','ville',FALSE,NULL,23.0),(18,310.00,'TV, WiFi, Climatisation, Minibar','double','ville',TRUE,NULL,34.0),(18,410.00,'TV, WiFi, Climatisation, Minibar','double','fleuve',TRUE,NULL,44.0),(18,540.00,'TV, WiFi, Climatisation, Cuisine','triple','fleuve',TRUE,'tache sur moquette',59.0),(18,810.00,'TV, WiFi, Climatisation, Salon','suite','panoramique',TRUE,NULL,87.0),
(19,140.00,'TV, WiFi','simple','cour',FALSE,NULL,20.0),(19,220.00,'TV, WiFi, Climatisation','double','cour',FALSE,NULL,30.0),(19,320.00,'TV, WiFi, Climatisation, Minibar','double','ville',TRUE,NULL,40.0),(19,430.00,'TV, WiFi, Climatisation, Cuisine','triple','ville',TRUE,NULL,53.0),(19,650.00,'TV, WiFi, Climatisation, Salon','suite','ville',TRUE,NULL,76.0),
(20,120.00,'TV, WiFi','simple','cour',FALSE,'rideau déchiré',18.0),(20,190.00,'TV, WiFi, Climatisation','double','cour',FALSE,NULL,28.0),(20,280.00,'TV, WiFi, Climatisation, Minibar','double','ville',TRUE,NULL,36.0),(20,380.00,'TV, WiFi, Climatisation, Cuisine','triple','ville',TRUE,NULL,48.0),(20,580.00,'TV, WiFi, Climatisation, Salon','suite','ville',TRUE,NULL,73.0),
(21,270.00,'TV, WiFi, Climatisation, Minibar','simple','fleuve',FALSE,NULL,27.0),(21,370.00,'TV, WiFi, Climatisation, Minibar','double','fleuve',TRUE,NULL,37.0),(21,490.00,'TV, WiFi, Climatisation, Jacuzzi','double','fleuve',TRUE,NULL,49.0),(21,640.00,'TV, WiFi, Climatisation, Cuisine','triple','fleuve',TRUE,NULL,64.0),(21,960.00,'TV, WiFi, Climatisation, Salon','suite','panoramique',TRUE,NULL,96.0),
(22,240.00,'TV, WiFi, Climatisation, Minibar','simple','ville',FALSE,NULL,26.0),(22,340.00,'TV, WiFi, Climatisation, Minibar','double','ville',TRUE,NULL,36.0),(22,460.00,'TV, WiFi, Climatisation, Jacuzzi','double','montagne',TRUE,NULL,47.0),(22,610.00,'TV, WiFi, Climatisation, Cuisine','triple','montagne',TRUE,NULL,62.0),(22,920.00,'TV, WiFi, Climatisation, Salon','suite','panoramique',TRUE,NULL,93.0),
(23,100.00,'TV, WiFi','simple','cour',FALSE,NULL,17.0),(23,170.00,'TV, WiFi','double','cour',FALSE,NULL,26.0),(23,250.00,'TV, WiFi, Climatisation','double','ville',TRUE,'légère égratignure',34.0),(23,350.00,'TV, WiFi, Climatisation, Minibar','triple','ville',TRUE,NULL,46.0),(23,530.00,'TV, WiFi, Climatisation, Salon','suite','ville',TRUE,NULL,70.0),
(24,180.00,'TV, WiFi, Climatisation','simple','ville',FALSE,NULL,22.0),(24,280.00,'TV, WiFi, Climatisation, Minibar','double','ville',TRUE,NULL,33.0),(24,380.00,'TV, WiFi, Climatisation, Minibar','double','fleuve',TRUE,NULL,42.0),(24,510.00,'TV, WiFi, Climatisation, Cuisine','triple','fleuve',TRUE,NULL,56.0),(24,760.00,'TV, WiFi, Climatisation, Salon','suite','panoramique',TRUE,NULL,82.0),
(25,310.00,'TV, WiFi, Climatisation, Minibar','simple','rivière',FALSE,NULL,29.0),(25,420.00,'TV, WiFi, Climatisation, Minibar','double','rivière',TRUE,NULL,39.0),(25,540.00,'TV, WiFi, Climatisation, Jacuzzi','double','rivière',TRUE,NULL,54.0),(25,700.00,'TV, WiFi, Climatisation, Cuisine','triple','rivière',TRUE,NULL,70.0),(25,1050.00,'TV, WiFi, Climatisation, Salon','suite','panoramique',TRUE,NULL,105.0),
(26,230.00,'TV, WiFi, Climatisation, Minibar','simple','ville',FALSE,NULL,25.0),(26,330.00,'TV, WiFi, Climatisation, Minibar','double','ville',TRUE,NULL,35.0),(26,440.00,'TV, WiFi, Climatisation, Jacuzzi','double','rivière',TRUE,NULL,46.0),(26,590.00,'TV, WiFi, Climatisation, Cuisine','triple','rivière',TRUE,NULL,61.0),(26,880.00,'TV, WiFi, Climatisation, Salon','suite','panoramique',TRUE,NULL,89.0),
(27,150.00,'TV, WiFi, Climatisation','simple','ville',FALSE,NULL,21.0),(27,250.00,'TV, WiFi, Climatisation, Minibar','double','ville',FALSE,NULL,31.0),(27,350.00,'TV, WiFi, Climatisation, Minibar','double','jardin',TRUE,'tache sur moquette',41.0),(27,470.00,'TV, WiFi, Climatisation, Cuisine','triple','jardin',TRUE,NULL,54.0),(27,710.00,'TV, WiFi, Climatisation, Salon','suite','panoramique',TRUE,NULL,79.0),
(28,330.00,'TV, WiFi, Climatisation, Minibar','simple','rivière',FALSE,NULL,30.0),(28,450.00,'TV, WiFi, Climatisation, Minibar','double','rivière',TRUE,NULL,40.0),(28,580.00,'TV, WiFi, Climatisation, Jacuzzi','double','rivière',TRUE,NULL,58.0),(28,750.00,'TV, WiFi, Climatisation, Cuisine','triple','rivière',TRUE,NULL,75.0),(28,1100.00,'TV, WiFi, Climatisation, Salon','suite','panoramique',TRUE,NULL,110.0),
(29,140.00,'TV, WiFi','simple','cour',FALSE,NULL,19.0),(29,220.00,'TV, WiFi, Climatisation','double','cour',FALSE,NULL,29.0),(29,320.00,'TV, WiFi, Climatisation, Minibar','double','ville',TRUE,NULL,39.0),(29,430.00,'TV, WiFi, Climatisation, Cuisine','triple','ville',TRUE,NULL,52.0),(29,650.00,'TV, WiFi, Climatisation, Salon','suite','ville',TRUE,NULL,74.0),
(30,260.00,'TV, WiFi, Climatisation, Minibar','simple','ville',FALSE,NULL,27.0),(30,360.00,'TV, WiFi, Climatisation, Minibar','double','ville',TRUE,NULL,37.0),(30,480.00,'TV, WiFi, Climatisation, Jacuzzi','double','rivière',TRUE,NULL,48.0),(30,630.00,'TV, WiFi, Climatisation, Cuisine','triple','rivière',TRUE,NULL,63.0),(30,950.00,'TV, WiFi, Climatisation, Salon','suite','panoramique',TRUE,NULL,95.0),
(31,120.00,'TV, WiFi','simple','cour',FALSE,'légère égratignure',18.0),(31,200.00,'TV, WiFi, Climatisation','double','cour',FALSE,NULL,28.0),(31,300.00,'TV, WiFi, Climatisation, Minibar','double','ville',TRUE,NULL,37.0),(31,400.00,'TV, WiFi, Climatisation, Cuisine','triple','ville',TRUE,NULL,50.0),(31,600.00,'TV, WiFi, Climatisation, Salon','suite','ville',TRUE,NULL,73.0),
(32,190.00,'TV, WiFi, Climatisation','simple','ville',FALSE,NULL,23.0),(32,290.00,'TV, WiFi, Climatisation, Minibar','double','ville',TRUE,NULL,33.0),(32,390.00,'TV, WiFi, Climatisation, Minibar','double','rivière',TRUE,NULL,43.0),(32,520.00,'TV, WiFi, Climatisation, Cuisine','triple','rivière',TRUE,NULL,57.0),(32,780.00,'TV, WiFi, Climatisation, Salon','suite','panoramique',TRUE,NULL,83.0),
(33,270.00,'TV, WiFi, Climatisation, Minibar','simple','forêt',FALSE,NULL,27.0),(33,370.00,'TV, WiFi, Climatisation, Minibar','double','forêt',TRUE,NULL,37.0),(33,490.00,'TV, WiFi, Climatisation, Jacuzzi','double','montagne',TRUE,NULL,49.0),(33,650.00,'TV, WiFi, Climatisation, Cuisine','triple','montagne',TRUE,NULL,65.0),(33,980.00,'TV, WiFi, Climatisation, Salon','suite','panoramique',TRUE,NULL,98.0),
(34,200.00,'TV, WiFi, Climatisation','simple','ville',FALSE,NULL,24.0),(34,300.00,'TV, WiFi, Climatisation, Minibar','double','ville',TRUE,NULL,35.0),(34,410.00,'TV, WiFi, Climatisation, Minibar','double','forêt',TRUE,NULL,45.0),(34,550.00,'TV, WiFi, Climatisation, Cuisine','triple','forêt',TRUE,NULL,59.0),(34,830.00,'TV, WiFi, Climatisation, Salon','suite','panoramique',TRUE,NULL,87.0),
(35,150.00,'TV, WiFi','simple','cour',FALSE,NULL,20.0),(35,240.00,'TV, WiFi, Climatisation','double','cour',FALSE,'tache sur mur',30.0),(35,340.00,'TV, WiFi, Climatisation, Minibar','double','ville',TRUE,NULL,40.0),(35,450.00,'TV, WiFi, Climatisation, Cuisine','triple','ville',TRUE,NULL,53.0),(35,680.00,'TV, WiFi, Climatisation, Salon','suite','ville',TRUE,NULL,77.0),
(36,130.00,'TV, WiFi','simple','cour',FALSE,NULL,19.0),(36,210.00,'TV, WiFi, Climatisation','double','cour',FALSE,NULL,29.0),(36,310.00,'TV, WiFi, Climatisation, Minibar','double','ville',TRUE,NULL,38.0),(36,420.00,'TV, WiFi, Climatisation, Cuisine','triple','ville',TRUE,NULL,51.0),(36,630.00,'TV, WiFi, Climatisation, Salon','suite','ville',TRUE,NULL,74.0),
(37,290.00,'TV, WiFi, Climatisation, Minibar','simple','montagne',FALSE,NULL,28.0),(37,400.00,'TV, WiFi, Climatisation, Minibar','double','montagne',TRUE,NULL,39.0),(37,530.00,'TV, WiFi, Climatisation, Jacuzzi','double','montagne',TRUE,NULL,53.0),(37,700.00,'TV, WiFi, Climatisation, Cuisine','triple','montagne',TRUE,NULL,70.0),(37,1050.00,'TV, WiFi, Climatisation, Salon','suite','panoramique',TRUE,NULL,105.0),
(38,110.00,'TV, WiFi','simple','cour',FALSE,'rideau déchiré',17.0),(38,180.00,'TV, WiFi','double','cour',FALSE,NULL,27.0),(38,270.00,'TV, WiFi, Climatisation','double','ville',TRUE,NULL,35.0),(38,370.00,'TV, WiFi, Climatisation, Minibar','triple','ville',TRUE,NULL,47.0),(38,560.00,'TV, WiFi, Climatisation, Salon','suite','ville',TRUE,NULL,72.0),
(39,240.00,'TV, WiFi, Climatisation, Minibar','simple','forêt',FALSE,NULL,26.0),(39,340.00,'TV, WiFi, Climatisation, Minibar','double','forêt',TRUE,NULL,36.0),(39,460.00,'TV, WiFi, Climatisation, Jacuzzi','double','montagne',TRUE,NULL,47.0),(39,610.00,'TV, WiFi, Climatisation, Cuisine','triple','montagne',TRUE,NULL,62.0),(39,920.00,'TV, WiFi, Climatisation, Salon','suite','panoramique',TRUE,NULL,93.0),
(40,180.00,'TV, WiFi, Climatisation','simple','ville',FALSE,NULL,22.0),(40,280.00,'TV, WiFi, Climatisation, Minibar','double','ville',TRUE,NULL,32.0),(40,380.00,'TV, WiFi, Climatisation, Minibar','double','forêt',TRUE,NULL,42.0),(40,510.00,'TV, WiFi, Climatisation, Cuisine','triple','forêt',TRUE,NULL,56.0),(40,760.00,'TV, WiFi, Climatisation, Salon','suite','panoramique',TRUE,NULL,81.0);

-- =============================================================
-- CLIENTS (10 clients de test)
-- =============================================================
INSERT INTO CLIENT (nom_complet, adresse, nas, date_inscription) VALUES
('Jean Dupont',       '123 Maple St, Ottawa, ON',      '100-000-001', '2024-01-15'),
('Sophie Tremblay',   '456 Oak Ave, Montréal, QC',     '100-000-002', '2024-02-20'),
('Marc Leblanc',      '789 Pine Rd, Toronto, ON',      '100-000-003', '2024-03-10'),
('Anne Gagnon',       '321 Elm St, Vancouver, BC',     '100-000-004', '2024-04-05'),
('Paul Martin',       '654 Cedar Blvd, Edmonton, AB',  '100-000-005', '2024-05-18'),
('Lucie Bouchard',    '987 Birch Lane, Ottawa, ON',    '100-000-006', '2024-06-22'),
('Eric Côté',         '147 Willow Ct, Montréal, QC',   '100-000-007', '2024-07-30'),
('Nadia Roy',         '258 Spruce Dr, Toronto, ON',    '100-000-008', '2024-08-14'),
('Omar Benali',       '369 Poplar Way, Vancouver, BC', '100-000-009', '2024-09-03'),
('Fatima Diallo',     '741 Walnut St, Edmonton, AB',   '100-000-010', '2024-10-11');

-- =============================================================
-- RÉSERVATIONS (quelques exemples)
-- =============================================================
INSERT INTO RESERVATION (chambre_id, client_id, date_reservation, date_debut, date_fin, statut) VALUES
(1,  1, '2026-03-01', '2026-04-10', '2026-04-15', 'en attente'),
(6,  2, '2026-03-05', '2026-04-12', '2026-04-18', 'en attente'),
(11, 3, '2026-03-10', '2026-04-20', '2026-04-25', 'en attente'),
(16, 4, '2026-03-15', '2026-05-01', '2026-05-07', 'en attente'),
(21, 5, '2026-03-20', '2026-05-10', '2026-05-14', 'en attente');

-- =============================================================
-- LOCATIONS (quelques exemples, dont une issue d'une réservation)
-- =============================================================
INSERT INTO LOCATION (chambre_id, client_id, employe_id, reservation_id, date_checkin, date_debut, date_fin) VALUES
(2,  6, 1,  NULL, '2026-04-08', '2026-04-08', '2026-04-12'),  -- location directe
(7,  7, 3,  NULL, '2026-04-09', '2026-04-09', '2026-04-11'),  -- location directe
(1,  1, 1,  1,    '2026-04-10', '2026-04-10', '2026-04-15');  -- issue d'une réservation