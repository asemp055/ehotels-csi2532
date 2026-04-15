# Rapport du projet e-Hotels

## 1. SGBD utilisé

Le système de gestion de base de données choisi pour ce projet est **PostgreSQL**.

Ce choix a été fait pour plusieurs raisons :
- PostgreSQL est robuste et bien adapté aux bases relationnelles
- Il prend en charge les contraintes d'intégrité comme les clés primaires, clés étrangères et `CHECK`
- Il permet l'utilisation de **triggers** et de **fonctions PL/pgSQL**
- Il convient bien à un projet de gestion comme e-Hotels, où les relations entre chaînes, hôtels, chambres, clients, employés, réservations et locations sont nombreuses

Dans notre projet, PostgreSQL est utilisé pour :
- Créer la structure relationnelle de la base
- Appliquer les contraintes d'intégrité
- Exécuter les requêtes de recherche, insertion, mise à jour et suppression
- Automatiser certaines mises à jour avec des triggers

## 2. Technologies utilisées

Le projet repose sur plusieurs technologies, séparées entre la base de données, le backend et le frontend.

### Base de données

- **PostgreSQL 14+**
- **SQL** et **PL/pgSQL** pour les triggers et automatisations

### Backend

Le backend est développé en **Java pur**, sans framework lourd.

Technologies et composants utilisés :
- **Java 17+**
- **JDBC** (postgresql-42.7.10.jar) pour la connexion à PostgreSQL
- **HttpServer** natif de Java pour exposer les routes HTTP
- Requêtes SQL brutes avec `PreparedStatement` pour la sécurité

**Fichiers principaux** :
- `Main.java` : Point d'entrée de l'application
- `DB.java` : Gestion des connexions à la base de données
- `ChambreHandler.java` : Gestion des routes pour les chambres
- `ClientHandler.java` : Gestion des routes pour les clients
- `EmployeeHandler.java` : Gestion des routes pour les employés
- `ReservationHandler.java` : Gestion des routes pour les réservations
- `Util.java` : Utilitaires et fonctions générales

Le backend sert à :
- Recevoir les requêtes du frontend
- Interroger la base de données
- Retourner des réponses JSON
- Gérer les opérations CRUD sur les clients, chambres, réservations, locations et employés

### Frontend

Le frontend a été développé avec des technologies web simples et légères :
- **HTML5**
- **CSS3**
- **JavaScript vanilla** (sans framework)

L'interface comprend **2 pages principales** :
- `index.html` : Recherche et affichage des chambres disponibles avec filtres
- `gestion.html` : Panneau d'administration pour la gestion des réservations, locations et clients

### Outils complémentaires

- **Visual Studio Code** pour le développement
- **GitHub** pour la gestion du projet et du contrôle de version

## 3. Guide d'installation

### 3.1 Prérequis

Avant d'exécuter le projet, il faut installer :
- **PostgreSQL 14+** (Windows)
- **Java JDK 17+**
- Un navigateur web moderne (Chrome, Firefox, Edge)
- **Git** (optionnel)

### 3.2 Création de la base de données

Créer d'abord une base de données nommée `ehotels`.

Ouvrez `psql` (invite de commande PostgreSQL) et exécutez :

```sql
CREATE DATABASE ehotels;
```

### 3.3 Importation de la structure et des données

Exécutez ensuite les fichiers SQL dans l'ordre suivant, depuis PowerShell ou CMD :

```powershell
psql -U postgres -d ehotels -f sql/schema.sql
psql -U postgres -d ehotels -f sql/data.sql
psql -U postgres -d ehotels -f sql/views.sql
```

**Note** : Remplacez `postgres` par votre utilisateur PostgreSQL si différent.

### 3.4 Configuration du backend

Vérifiez les paramètres de connexion à la base de données dans `DB.java` :

```java
private static final String DB_URL = "jdbc:postgresql://localhost:5432/ehotels";
private static final String DB_USER = "postgres";
private static final String DB_PASSWORD = "votre_mot_de_passe";
```

Adaptez ces valeurs selon votre configuration locale de PostgreSQL.

### 3.5 Compilation et lancement du backend

Depuis le dossier racine du projet, compilez tous les fichiers Java du backend :

```powershell
javac -cp "lib/postgresql-42.7.10.jar" -d build src/backend/*.java
```

Puis lancez l'application via `Main.java` :

```powershell
java -cp ".;build;lib/postgresql-42.7.10.jar" Main
```

Le serveur écoute sur : **http://localhost:8000**

Ou utilisez le script `run.bat` :

```powershell
.\run.bat
```

Vous devriez voir :
```text
Server started on port 8000
Database connected successfully
```

### 3.6 Accès au frontend

Le frontend se trouve dans `src/frontend/`.

Ouvrez directement le fichier `index.html` dans votre navigateur ou utilisez un serveur local :

```powershell
python -m http.server 8080
```

Puis accédez à : **http://localhost:8080** (ou directement à `file:///chemin/vers/index.html`)

**Pages disponibles** :
- `index.html` : Page d'accueil avec recherche de chambres
- `gestion.html` : Panneau d'administration

## 4. Structure du projet

```
ehotels-csi2532/
├── src/
│   ├── backend/
│   │   ├── Main.java
│   │   ├── DB.java
│   │   ├── ChambreHandler.java
│   │   ├── ClientHandler.java
│   │   ├── EmployeeHandler.java
│   │   ├── ReservationHandler.java
│   │   └── Util.java
│   └── frontend/
│       ├── index.html
│       ├── gestion.html
│       ├── css/
│       │   └── style.css
│       └── js/
│           ├── index.js
│           └── gestion.js
├── sql/
│   ├── schema.sql
│   ├── data.sql
│   └── views.sql
├── lib/
│   └── postgresql-42.7.10.jar
├── build/
├── run.bat
├── README.md
└── rapport/
    └── rapport.md
```

## 5. DDL - Création de la base de données

Le fichier principal de création est `sql/schema.sql`.

La base de données comprend les tables suivantes :

### 5.1 CHAINE

Stocke les informations sur chaque chaîne hôtelière :

| Colonne | Type | Description |
|---------|------|-------------|
| id_chaine | SERIAL | Identifiant unique (PK) |
| nom_chaine | VARCHAR(100) | Nom de la chaîne |
| adresse_siege | VARCHAR(255) | Adresse du siège social |
| nb_hotels | INTEGER | Nombre d'hôtels (mis à jour par trigger) |
| email | VARCHAR(100) | Email de contact |
| telephone | VARCHAR(20) | Téléphone |

### 5.2 HOTEL

Représente les hôtels appartenant à une chaîne :

| Colonne | Type | Description |
|---------|------|-------------|
| id_hotel | SERIAL | Identifiant unique (PK) |
| id_chaine | INTEGER | Référence à CHAINE (FK) |
| adresse | VARCHAR(255) | Adresse de l'hôtel |
| categorie | INTEGER | Catégorie de 1 à 5 étoiles (CHECK 1-5) |
| nb_chambres | INTEGER | Nombre de chambres (mis à jour par trigger) |
| email | VARCHAR(100) | Email |
| telephone | VARCHAR(20) | Téléphone |

### 5.3 CHAMBRE

Décrit les chambres disponibles dans un hôtel :

| Colonne | Type | Description |
|---------|------|-------------|
| id_chambre | SERIAL | Identifiant unique (PK) |
| id_hotel | INTEGER | Référence à HOTEL (FK) |
| prix_nuit | DECIMAL(10,2) | Prix par nuit (CHECK > 0) |
| commodites | TEXT | Liste des commodités |
| capacite | INTEGER | Nombre de personnes (CHECK 1-6) |
| vue | VARCHAR(50) | Type de vue |
| lit_supplementaire | BOOLEAN | Présence d'un lit supplémentaire |
| etat_dommages | TEXT | Description des dommages |
| superficie | DECIMAL(8,2) | Surface en m² |

### 5.4 CLIENT

Contient les informations des clients :

| Colonne | Type | Description |
|---------|------|-------------|
| id_client | SERIAL | Identifiant unique (PK) |
| nom_complet | VARCHAR(100) | Nom et prénom |
| adresse | VARCHAR(255) | Adresse |
| nas | VARCHAR(12) | Numéro d'assurance sociale (UNIQUE) |
| date_inscription | DATE | Date d'inscription |

### 5.5 EMPLOYE

Contient les informations sur les employés :

| Colonne | Type | Description |
|---------|------|-------------|
| id_employe | SERIAL | Identifiant unique (PK) |
| id_hotel | INTEGER | Référence à HOTEL (FK) |
| nom_complet | VARCHAR(100) | Nom et prénom |
| adresse | VARCHAR(255) | Adresse |
| nas | VARCHAR(12) | Numéro d'assurance sociale (UNIQUE) |
| role | VARCHAR(50) | Rôle (réceptionniste, nettoyeur, etc.) |

### 5.6 RESERVATION

Enregistre les réservations :

| Colonne | Type | Description |
|---------|------|-------------|
| id_reservation | SERIAL | Identifiant unique (PK) |
| id_chambre | INTEGER | Référence à CHAMBRE (FK) |
| id_client | INTEGER | Référence à CLIENT (FK) |
| date_reservation | TIMESTAMP | Date de la réservation |
| date_debut | DATE | Date d'arrivée |
| date_fin | DATE | Date de départ |
| statut | VARCHAR(20) | Statut (pending, confirmed, cancelled) |

**Contrainte CHECK** : `date_fin > date_debut`

### 5.7 LOCATION

Enregistre les locations :

| Colonne | Type | Description |
|---------|------|-------------|
| id_location | SERIAL | Identifiant unique (PK) |
| id_chambre | INTEGER | Référence à CHAMBRE (FK) |
| id_client | INTEGER | Référence à CLIENT (FK) |
| id_employe | INTEGER | Référence à EMPLOYE (FK) |
| id_reservation | INTEGER | Référence à RESERVATION (FK, nullable) |
| date_checkin | TIMESTAMP | Date et heure du check-in |
| date_debut | DATE | Date de début du séjour |
| date_fin | DATE | Date de fin du séjour |

## 6. Contraintes d'intégrité

Le schéma contient plusieurs contraintes importantes :

- **Clés primaires** : Toutes les tables
- **Clés étrangères** : Entre les tables reliées (cascade update/delete si applicable)
- **Contraintes `CHECK`** : 
  - Catégories d'hôtel : 1-5
  - Prix des chambres : > 0
  - Capacité : 1-6 personnes
  - Dates : `date_fin > date_debut`
- **Unicité** : NAS pour clients et employés

**Exemples de contraintes** :
- Un hôtel ne peut pas exister sans chaîne
- Une chambre ne peut pas exister sans hôtel
- Une réservation doit avoir une date de fin postérieure à la date de début
- Une location doit respecter les dates de séjour

## 7. Requêtes et triggers

### Requêtes SQL principales

- **Recherche de chambres** : Avec filtres (prix, capacité, disponibilité)
- **CRUD Clients** : Insertion, lecture, modification, suppression
- **CRUD Réservations** : Création et gestion
- **CRUD Locations** : Insertion et historique
- **Consultation d'hôtels et employés**

### Triggers PL/pgSQL

1. **`trg_update_nb_hotels`**
   - Met à jour automatiquement `nb_hotels` dans `CHAINE` lors de l'ajout ou de la suppression d'un hôtel

2. **`trg_update_nb_chambres`**
   - Met à jour automatiquement `nb_chambres` dans `HOTEL` lors de l'ajout ou de la suppression d'une chambre

3. **`trg_confirmer_reservation`**
   - Met à jour le statut d'une réservation lorsqu'elle est convertie en location

Ces triggers automatisent les règles de gestion sans intervention manuelle.

## Conclusion

Le projet e-Hotels repose sur une base de données relationnelle solide construite avec **PostgreSQL**, reliée à un backend **Java pur** lancé via `Main.java` et à un frontend **web vanilla** avec 2 pages HTML (`index.html` et `gestion.html`). L'ensemble permet de gérer la recherche de chambres, les réservations, les locations, les clients et les employés, tout en respectant les principales contraintes et exigences du cahier des charges.