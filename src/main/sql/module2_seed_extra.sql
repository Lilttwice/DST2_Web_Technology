-- Extra curated drug–gene rows for richer pagination demos (INSERT IGNORE, safe to re-run).
-- Run after module2_schema.sql + module2_seed.sql (+ optional module2_polish_existing_text.sql).
-- Adds more genes (FK targets) then more drug_gene links from existing PharmGKB drug names.

USE biomed;

INSERT IGNORE INTO gene (id, name, description) VALUES
    ('SLCO1B1', 'SLCO1B1', 'Solute carrier organic anion transporter family member 1B1; statin uptake and myopathy risk.'),
    ('ABCB1', 'ABCB1', 'ATP-binding cassette subfamily B member 1 (P-glycoprotein); efflux transporter.'),
    ('COMT', 'COMT', 'Catechol-O-methyltransferase; dopaminergic drug response.'),
    ('MTHFR', 'MTHFR', 'Methylenetetrahydrofolate reductase; folate pathway.'),
    ('NAT2', 'NAT2', 'N-acetyltransferase 2; acetylator phenotype for isoniazid-like substrates.'),
    ('G6PD', 'G6PD', 'Glucose-6-phosphate dehydrogenase; drug-induced haemolysis risk.'),
    ('IFNL3', 'IFNL3', 'Interferon lambda 3; interferon-based hepatitis C therapy response.'),
    ('OPRM1', 'OPRM1', 'Opioid receptor mu 1; opioid analgesic response variability.'),
    ('ADRB2', 'ADRB2', 'Adrenoceptor beta 2; bronchodilator pharmacology.'),
    ('F5', 'F5', 'Coagulation factor V; thrombophilia-related prescribing context.');

INSERT IGNORE INTO drug_gene (drug_id, gene_id, interaction_desc)
SELECT d.id, 'SLCO1B1', 'SLCO1B1 genotype may modulate systemic exposure for several statins and other substrates.'
FROM drug d WHERE LOWER(d.name) LIKE '%simvastatin%' OR LOWER(d.name) LIKE '%atorvastatin%' LIMIT 12;

INSERT IGNORE INTO drug_gene (drug_id, gene_id, interaction_desc)
SELECT d.id, 'ABCB1', 'ABCB1-mediated efflux can influence tissue distribution and drug–drug interactions.'
FROM drug d WHERE LOWER(d.name) LIKE '%digoxin%' OR LOWER(d.name) LIKE '%fexofenadine%' LIMIT 10;

INSERT IGNORE INTO drug_gene (drug_id, gene_id, interaction_desc)
SELECT d.id, 'COMT', 'COMT activity may contribute to variability in catecholamine pathway drugs.'
FROM drug d WHERE LOWER(d.name) LIKE '%levodopa%' LIMIT 8;

INSERT IGNORE INTO drug_gene (drug_id, gene_id, interaction_desc)
SELECT d.id, 'MTHFR', 'MTHFR variants are discussed in folate-antagonist and methotrexate prescribing contexts.'
FROM drug d WHERE LOWER(d.name) LIKE '%methotrexate%' LIMIT 8;

INSERT IGNORE INTO drug_gene (drug_id, gene_id, interaction_desc)
SELECT d.id, 'NAT2', 'NAT2 acetylator status informs isoniazid-related hepatotoxicity risk stratification.'
FROM drug d WHERE LOWER(d.name) LIKE '%isoniazid%' LIMIT 8;

INSERT IGNORE INTO drug_gene (drug_id, gene_id, interaction_desc)
SELECT d.id, 'G6PD', 'G6PD deficiency is a classic contraindication consideration for oxidant drugs.'
FROM drug d WHERE LOWER(d.name) LIKE '%chloroquine%' OR LOWER(d.name) LIKE '%primaquine%' LIMIT 8;

INSERT IGNORE INTO drug_gene (drug_id, gene_id, interaction_desc)
SELECT d.id, 'IFNL3', 'IFNL3 genotype historically informed interferon-containing hepatitis C regimens.'
FROM drug d WHERE LOWER(d.name) LIKE '%ribavirin%' OR LOWER(d.name) LIKE '%peginterferon%' LIMIT 6;

INSERT IGNORE INTO drug_gene (drug_id, gene_id, interaction_desc)
SELECT d.id, 'OPRM1', 'OPRM1 variation is associated with differences in opioid analgesic requirements.'
FROM drug d WHERE LOWER(d.name) LIKE '%morphine%' OR LOWER(d.name) LIKE '%oxycodone%' LIMIT 10;

INSERT IGNORE INTO drug_gene (drug_id, gene_id, interaction_desc)
SELECT d.id, 'ADRB2', 'ADRB2 polymorphisms are discussed in asthma beta-agonist response literature.'
FROM drug d WHERE LOWER(d.name) LIKE '%albuterol%' OR LOWER(d.name) LIKE '%salbutamol%' LIMIT 8;

INSERT IGNORE INTO drug_gene (drug_id, gene_id, interaction_desc)
SELECT d.id, 'F5', 'Factor V Leiden (F5) is relevant in anticoagulant decision-making in thrombophilia.'
FROM drug d WHERE LOWER(d.name) LIKE '%warfarin%' OR LOWER(d.name) LIKE '%rivaroxaban%' LIMIT 10;

INSERT IGNORE INTO drug_gene (drug_id, gene_id, interaction_desc)
SELECT d.id, 'CYP2C9', 'Additional CYP2C9-linked entries across NSAID and antiepileptic name inventory.'
FROM drug d WHERE LOWER(d.name) LIKE '%celecoxib%' OR LOWER(d.name) LIKE '%ibuprofen%' OR LOWER(d.name) LIKE '%phenytoin%' LIMIT 15;

INSERT IGNORE INTO drug_gene (drug_id, gene_id, interaction_desc)
SELECT d.id, 'CYP3A4', 'CYP3A4 is commonly co-mentioned for macrolide and azole antifungal interaction risk.'
FROM drug d WHERE LOWER(d.name) LIKE '%clarithromycin%' OR LOWER(d.name) LIKE '%ketoconazole%' LIMIT 10;

INSERT IGNORE INTO drug_gene (drug_id, gene_id, interaction_desc)
SELECT d.id, 'VKORC1', 'Additional VKORC1-linked entries for other vitamin K antagonist name matches.'
FROM drug d WHERE LOWER(d.name) LIKE '%acenocoumarol%' OR LOWER(d.name) LIKE '%phenprocoumon%' LIMIT 8;

INSERT IGNORE INTO drug_gene (drug_id, gene_id, interaction_desc)
SELECT d.id, 'UGT1A1', 'UGT1A1 promoter variation informs irinotecan toxicity monitoring in oncology protocols.'
FROM drug d WHERE LOWER(d.name) LIKE '%irinotecan%' LIMIT 8;

INSERT IGNORE INTO drug_gene (drug_id, gene_id, interaction_desc)
SELECT d.id, 'DPYD', 'DPYD testing is used to mitigate fluoropyrimidine-related severe toxicity.'
FROM drug d WHERE LOWER(d.name) LIKE '%fluorouracil%' OR LOWER(d.name) LIKE '%capecitabine%' LIMIT 10;

INSERT IGNORE INTO drug_gene (drug_id, gene_id, interaction_desc)
SELECT d.id, 'HLA-B', 'HLA-B*57:01 screening is standard before abacavir initiation.'
FROM drug d WHERE LOWER(d.name) LIKE '%abacavir%' LIMIT 8;

INSERT IGNORE INTO drug_gene (drug_id, gene_id, interaction_desc)
SELECT d.id, 'TPMT', 'Additional TPMT-linked thiopurine rows across mercaptopurine/thioguanine name variants.'
FROM drug d WHERE LOWER(d.name) LIKE '%thioguanine%' LIMIT 8;

INSERT IGNORE INTO drug_gene (drug_id, gene_id, interaction_desc)
SELECT d.id, 'EGFR', 'Additional EGFR-targeted therapy rows across afatinib/osimertinib name matches.'
FROM drug d WHERE LOWER(d.name) LIKE '%afatinib%' OR LOWER(d.name) LIKE '%osimertinib%' LIMIT 8;

INSERT IGNORE INTO drug_gene (drug_id, gene_id, interaction_desc)
SELECT d.id, 'CYP2C19', 'Additional CYP2C19 rows for proton pump inhibitors metabolised by the enzyme.'
FROM drug d WHERE LOWER(d.name) LIKE '%omeprazole%' OR LOWER(d.name) LIKE '%pantoprazole%' LIMIT 12;

INSERT IGNORE INTO drug_gene (drug_id, gene_id, interaction_desc)
SELECT d.id, 'LDLR', 'Additional LDLR rows across broader statin inventory.'
FROM drug d WHERE LOWER(d.name) LIKE '%pravastatin%' OR LOWER(d.name) LIKE '%fluvastatin%' LIMIT 12;
