-- Module 2: drug–gene search (extends existing biomed schema).
-- Run once after biomed.drug already exists. Uses VARCHAR keys like PharmGKB drug.id.

USE biomed;

CREATE TABLE IF NOT EXISTS gene
(
    id          varchar(100) not null,
    name        varchar(500) not null,
    description text         null,
    primary key (id)
);

CREATE TABLE IF NOT EXISTS drug_gene
(
    drug_id          varchar(100) not null,
    gene_id          varchar(100) not null,
    interaction_desc text         null,
    primary key (drug_id, gene_id),
    constraint drug_gene_drug_id_fk
        foreign key (drug_id) references drug (id),
    constraint drug_gene_gene_id_fk
        foreign key (gene_id) references gene (id)
);

CREATE INDEX idx_gene_name ON gene (name);
CREATE INDEX idx_drug_gene_drug ON drug_gene (drug_id);
CREATE INDEX idx_drug_gene_gene ON drug_gene (gene_id);
