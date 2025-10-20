CREATE TABLE COUNTRY (
    country_id   NUMBER(5,0) PRIMARY KEY,
    country_name VARCHAR2(200) NOT NULL
);

CREATE TABLE REGION (
    region_id   NUMBER(10,0) PRIMARY KEY,
    region_name VARCHAR2(200) NOT NULL,
    country_id  NUMBER(5,0) NOT NULL,
    CONSTRAINT fk_region_country
        FOREIGN KEY (country_id)
        REFERENCES COUNTRY(country_id)
);

CREATE TABLE FARMING (
    farming_id   NUMBER(5,0) PRIMARY KEY,
    farming_type VARCHAR2(200) NOT NULL
);

CREATE TABLE PRODUCER (
    producer_id   NUMBER(10,0) PRIMARY KEY,
    producer_name VARCHAR2(2000) NOT NULL,
    region_id     NUMBER(10,0) NOT NULL,
    CONSTRAINT fk_producer_region
        FOREIGN KEY (region_id)
        REFERENCES REGION(region_id)
);

CREATE TABLE PRODUCER_FARMING (
    producer_id NUMBER(10,0) NOT NULL,
    farming_id  NUMBER(5,0) NOT NULL,
    CONSTRAINT pk_producer_farming PRIMARY KEY (producer_id, farming_id),
    CONSTRAINT fk_pf_producer FOREIGN KEY (producer_id)
        REFERENCES PRODUCER(producer_id),
    CONSTRAINT fk_pf_farming FOREIGN KEY (farming_id)
        REFERENCES FARMING(farming_id)
);

CREATE TABLE WINE (
    wine_name    VARCHAR2(2000) PRIMARY KEY,
    producer_id  NUMBER(10,0) NOT NULL,
    price        NUMBER(10,2),
    wine_type    VARCHAR2(100),
    vintage      VARCHAR2(50),        
    bottle_size  VARCHAR2(50),
    region_id    NUMBER(10,0),
    farming_id   NUMBER(5,0),
    CONSTRAINT fk_wine_producer FOREIGN KEY (producer_id)
        REFERENCES PRODUCER(producer_id),
    CONSTRAINT fk_wine_region FOREIGN KEY (region_id)
        REFERENCES REGION(region_id),
    CONSTRAINT fk_wine_farming FOREIGN KEY (farming_id)
        REFERENCES FARMING(farming_id)
);

CREATE TABLE GRAPE (
    grape_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    grape_varietal VARCHAR2(2000) NOT NULL UNIQUE
);

CREATE TABLE WINE_GRAPE (
    wine_name     VARCHAR2(2000) NOT NULL,
    grape_varietal VARCHAR2(2000) NOT NULL,
    CONSTRAINT pk_wine_grape PRIMARY KEY (wine_name, grape_varietal),
    CONSTRAINT fk_wg_wine FOREIGN KEY (wine_name)
        REFERENCES WINE(wine_name)
);



INSERT INTO COUNTRY (country_id, country_name)
SELECT DISTINCT country_id, country_name
FROM STG_REGION
WHERE country_id IS NOT NULL;

INSERT INTO REGION (region_id, region_name, country_id)
SELECT DISTINCT region_id, region_name, country_id
FROM STG_REGION r
WHERE region_id IS NOT NULL
  AND country_id IS NOT NULL;

INSERT INTO FARMING (farming_id, farming_type)
SELECT DISTINCT farming_id, farming_type
FROM STG_FARMING
WHERE farming_id IS NOT NULL;

INSERT INTO PRODUCER (producer_id, producer_name, region_id)
SELECT DISTINCT producer_id, producer_name, region_id
FROM STG_GROWER g
WHERE producer_id IS NOT NULL
  AND region_id IS NOT NULL;

INSERT INTO PRODUCER_FARMING (producer_id, farming_id)
SELECT DISTINCT producer_id, farming_id
FROM STG_GROWER g
WHERE producer_id IS NOT NULL
  AND farming_id IS NOT NULL;

INSERT INTO WINE (wine_name, producer_id, price, wine_type, vintage, bottle_size, region_id, farming_id)
SELECT wine_name,
       producer_id,
       price,
       wine_type,
       vintage,
       bottle_size,
       region_id,
       farming_id
FROM (
    SELECT w.wine_name,
           p.producer_id,
           w.price,
           w.wine_type,
           w.vintage,
           w.bottle_size,
           r.region_id,
           f.farming_id,
           ROW_NUMBER() OVER (PARTITION BY w.wine_name ORDER BY NULL) AS rn
    FROM STG_WINE w
    JOIN PRODUCER p ON w.producer_name = p.producer_name
    JOIN REGION r ON w.region_name = r.region_name
    JOIN FARMING f ON w.farming_type = f.farming_type
) t
WHERE rn = 1;

INSERT INTO GRAPE (grape_varietal)
SELECT DISTINCT grape_varietal
FROM STG_WINE
WHERE grape_varietal IS NOT NULL;

INSERT INTO WINE_GRAPE (wine_name, grape_id)
SELECT DISTINCT w.wine_name, g.grape_id
FROM STG_WINE s
JOIN WINE w ON s.wine_name = w.wine_name
JOIN GRAPE g ON s.grape_varietal = g.grape_varietal;

  
