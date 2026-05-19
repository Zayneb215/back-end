-- ═══════════════════════════════════════════════════════
--  Schéma SQL initial - Phone Accessories
--  Exécuté automatiquement par Docker au premier démarrage
-- ═══════════════════════════════════════════════════════

-- Créer la base si elle n'existe pas
-- (Docker la crée déjà via POSTGRES_DB, donc juste au cas où)

-- ─────────────────────────────────────────
--  TABLE : marques
-- ─────────────────────────────────────────
CREATE TABLE IF NOT EXISTS marques (
    id           BIGSERIAL PRIMARY KEY,
    nom          VARCHAR(100) NOT NULL UNIQUE,
    description  VARCHAR(500),
    pays_origine VARCHAR(100)
);

-- ─────────────────────────────────────────
--  TABLE : categories
-- ─────────────────────────────────────────
CREATE TABLE IF NOT EXISTS categories (
    id          BIGSERIAL PRIMARY KEY,
    nom         VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(500)
);

-- ─────────────────────────────────────────
--  TABLE : accessoires
-- ─────────────────────────────────────────
CREATE TABLE IF NOT EXISTS accessoires (
    id           BIGSERIAL PRIMARY KEY,
    nom          VARCHAR(200) NOT NULL,
    prix         NUMERIC(10, 2) NOT NULL CHECK (prix > 0),
    stock        INTEGER NOT NULL DEFAULT 0 CHECK (stock >= 0),
    type         VARCHAR(100) NOT NULL,
    description  VARCHAR(1000),
    image_url    VARCHAR(500),
    reference    VARCHAR(100) UNIQUE,
    marque_id    BIGINT NOT NULL REFERENCES marques(id)    ON DELETE RESTRICT,
    categorie_id BIGINT NOT NULL REFERENCES categories(id) ON DELETE RESTRICT
);

-- Index pour accélérer les recherches fréquentes
CREATE INDEX IF NOT EXISTS idx_accessoires_marque    ON accessoires(marque_id);
CREATE INDEX IF NOT EXISTS idx_accessoires_categorie ON accessoires(categorie_id);
CREATE INDEX IF NOT EXISTS idx_accessoires_type      ON accessoires(type);
CREATE INDEX IF NOT EXISTS idx_accessoires_prix      ON accessoires(prix);

-- ─────────────────────────────────────────
--  DONNÉES DE TEST (jeu de données initial)
-- ─────────────────────────────────────────

-- Marques
INSERT INTO marques (nom, description, pays_origine) VALUES
    ('Samsung',  'Leader mondial de l''électronique',       'Corée du Sud'),
    ('Apple',    'Accessoires officiels iPhone',            'États-Unis'),
    ('Anker',    'Spécialiste de la recharge rapide',       'Chine'),
    ('Belkin',   'Accessoires de qualité premium',          'États-Unis'),
    ('Baseus',   'Accessoires innovants à prix abordable',  'Chine')
ON CONFLICT (nom) DO NOTHING;

-- Catégories
INSERT INTO categories (nom, description) VALUES
    ('Coques',           'Protection pour téléphones'),
    ('Chargeurs',        'Chargeurs rapides et câbles'),
    ('Audio',            'Écouteurs, casques et enceintes'),
    ('Protection écran', 'Verres trempés et films'),
    ('Supports',         'Supports voiture et bureau')
ON CONFLICT (nom) DO NOTHING;

-- Accessoires (exemples)
INSERT INTO accessoires (nom, prix, stock, type, description, reference, marque_id, categorie_id) VALUES
    ('Coque Samsung Galaxy S24 Ultra Transparente', 29.99, 150, 'Coque',
     'Coque transparente ultra-fine, protection anti-chocs', 'SAM-COQ-S24U-TR',
     (SELECT id FROM marques WHERE nom='Samsung'),
     (SELECT id FROM categories WHERE nom='Coques')),

    ('Chargeur Rapide 65W USB-C Anker', 49.99, 80, 'Chargeur',
     'Charge ultra-rapide 65W, compatible tous smartphones', 'ANK-CHG-65W-C',
     (SELECT id FROM marques WHERE nom='Anker'),
     (SELECT id FROM categories WHERE nom='Chargeurs')),

    ('Écouteurs Apple EarPods USB-C', 19.99, 200, 'Écouteurs',
     'Écouteurs filaires officiels Apple USB-C', 'APL-EAR-USBC',
     (SELECT id FROM marques WHERE nom='Apple'),
     (SELECT id FROM categories WHERE nom='Audio')),

    ('Verre Trempé iPhone 15 Pro Belkin', 14.99, 300, 'Verre trempé',
     'Protection écran 9H, installation facile', 'BLK-VT-IP15P',
     (SELECT id FROM marques WHERE nom='Belkin'),
     (SELECT id FROM categories WHERE nom='Protection écran')),

    ('Support Voiture Magnétique Baseus', 24.99, 120, 'Support',
     'Support magnétique universel pour tableau de bord', 'BAS-SUP-MAG-V',
     (SELECT id FROM marques WHERE nom='Baseus'),
     (SELECT id FROM categories WHERE nom='Supports'))

ON CONFLICT (reference) DO NOTHING;