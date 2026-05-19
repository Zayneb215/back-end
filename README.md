# 📱 Phone Accessories Backend

API REST pour la gestion des accessoires téléphoniques, construite avec **Spring Boot 3**, **PostgreSQL** et **Redis**.

---

## 🏗️ Architecture

```
phone-accessories-backend/
├── src/main/java/com/projet/
│   ├── PhoneAccessoriesApplication.java   ← Point d'entrée
│   ├── model/
│   │   ├── Accessoire.java                ← Entité principale
│   │   ├── Categorie.java
│   │   └── Marque.java
│   ├── repository/                        ← Accès BDD (Spring Data JPA)
│   ├── service/                           ← Logique métier + Cache Redis
│   ├── controller/                        ← Endpoints REST
│   ├── dto/                               ← Objets de transfert
│   ├── exception/                         ← Gestion des erreurs
│   └── config/
│       └── RedisConfig.java               ← Configuration cache
├── src/test/                              ← Tests unitaires + intégration
├── docker-compose.yml                     ← PostgreSQL + Redis
├── init.sql                               ← Schéma + données initiales
└── README.md
```

## 🛠️ Stack technique

| Composant    | Technologie         | Version |
|--------------|---------------------|---------|
| Backend      | Spring Boot         | 3.2.5   |
| Base données | PostgreSQL          | 15      |
| Cache        | Redis               | 7       |
| ORM          | Spring Data JPA     | -       |
| Validation   | Jakarta Validation  | -       |
| Doc API      | Swagger / OpenAPI   | 2.5.0   |
| Tests        | JUnit 5 + Mockito   | -       |
| Build        | Maven               | -       |
| Java         | OpenJDK             | 17      |

---

## 🚀 Démarrage rapide

### Prérequis
- Docker & Docker Compose
- Java 17+
- Maven 3.8+

### 1. Lancer PostgreSQL + Redis avec Docker

```bash
docker-compose up -d postgres redis
```

### 2. Vérifier que les services tournent

```bash
docker-compose ps
# Les deux services doivent être "healthy"
```

### 3. Lancer l'application Spring Boot

```bash
./mvnw spring-boot:run
```

L'API est disponible sur : **http://localhost:8080**

### 4. Tester avec Swagger

Ouvrir : **http://localhost:8080/swagger-ui.html**

---

## 📡 Endpoints API

### Accessoires (`/api/accessoires`)

| Méthode | URL                          | Description                    |
|---------|------------------------------|--------------------------------|
| GET     | `/api/accessoires`           | Liste tous les accessoires     |
| GET     | `/api/accessoires/{id}`      | Détail d'un accessoire         |
| GET     | `/api/accessoires/type/{t}`  | Filtrer par type               |
| POST    | `/api/accessoires`           | Créer un accessoire            |
| PUT     | `/api/accessoires/{id}`      | Modifier un accessoire         |
| DELETE  | `/api/accessoires/{id}`      | Supprimer un accessoire        |

### Catégories (`/api/categories`)

| Méthode | URL                     | Description              |
|---------|-------------------------|--------------------------|
| GET     | `/api/categories`       | Liste toutes les catégories |
| GET     | `/api/categories/{id}`  | Détail d'une catégorie   |
| POST    | `/api/categories`       | Créer une catégorie      |
| PUT     | `/api/categories/{id}`  | Modifier une catégorie   |
| DELETE  | `/api/categories/{id}`  | Supprimer une catégorie  |

### Marques (`/api/marques`)

| Méthode | URL                  | Description           |
|---------|----------------------|-----------------------|
| GET     | `/api/marques`       | Liste toutes les marques |
| GET     | `/api/marques/{id}`  | Détail d'une marque   |
| POST    | `/api/marques`       | Créer une marque      |
| PUT     | `/api/marques/{id}`  | Modifier une marque   |
| DELETE  | `/api/marques/{id}`  | Supprimer une marque  |

---

## 🔴 Cache Redis

Les annotations suivantes sont utilisées sur les méthodes de service :

- `@Cacheable("accessoires")` → Met en cache le résultat (lectures)
- `@CacheEvict(...)` → Vide le cache après une création/modification/suppression

Durées de vie configurées dans `RedisConfig.java` :
- Cache `accessoires` : **10 minutes**
- Cache `categories` : **30 minutes**
- Cache `marques` : **30 minutes**

---

## 🧪 Tests

```bash
# Tous les tests
./mvnw test

# Tests unitaires uniquement
./mvnw test -Dtest="*ServiceTest"

# Tests d'intégration
./mvnw test -Dtest="*IntegrationTest"
```

---

## 🗄️ Base de données

Le fichier `init.sql` crée automatiquement les tables et insère des données de test au premier démarrage Docker.

**Relations :**
```
Marque      (1) ──────────── (N) Accessoire
Categorie   (1) ──────────── (N) Accessoire
```

---

## 👥 Équipe

Projet réalisé en binôme dans le cadre du module Spring Boot.

- **Backend** : Spring Boot + PostgreSQL + Redis
- **Frontend** : Next.js / Angular# back-end
