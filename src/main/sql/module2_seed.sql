-- Sample gene rows + drug_gene links for Module 2 (professional wording for reports/demos).
-- Safe to run multiple times: uses INSERT IGNORE where appropriate.

USE biomed;

INSERT IGNORE INTO gene (id, name, description) VALUES
    ('CYP2C9', 'CYP2C9', 'Cytochrome P450 2C9; metabolises many clinically used drugs.'),
    ('VKORC1', 'VKORC1', 'Vitamin K epoxide reductase complex subunit 1; relevant to anticoagulant pharmacology.'),
    ('CYP2C19', 'CYP2C19', 'Cytochrome P450 2C19; affects activation and clearance of several antiplatelet and psychotropic agents.'),
    ('CYP3A4', 'CYP3A4', 'Cytochrome P450 3A4; major hepatic and intestinal enzyme for drug metabolism.'),
    ('TPMT', 'TPMT', 'Thiopurine S-methyltransferase; guides thiopurine dosing in oncology and immunology.'),
    ('EGFR', 'EGFR', 'Epidermal growth factor receptor; predictive biomarker for selected targeted therapies.'),
    ('LDLR', 'LDLR', 'Low-density lipoprotein receptor; central to lipid-lowering pharmacology.'),
    ('UGT1A1', 'UGT1A1', 'UDP glucuronosyltransferase 1A1; relevant to irinotecan and other substrates.'),
    ('DPYD', 'DPYD', 'Dihydropyrimidine dehydrogenase; fluoropyrimidine toxicity risk factor.'),
    ('HLA-B', 'HLA-B', 'HLA class I molecule; pharmacogenomic associations include severe cutaneous adverse reactions for some drugs.');

INSERT IGNORE INTO drug_gene (drug_id, gene_id, interaction_desc)
SELECT d.id, 'CYP2C9', 'Warfarin response and maintenance dose are influenced by CYP2C9 genotype in combination with other factors.'
FROM drug d
WHERE LOWER(d.name) LIKE '%warfarin%'
LIMIT 15;

INSERT IGNORE INTO drug_gene (drug_id, gene_id, interaction_desc)
SELECT d.id, 'VKORC1', 'VKORC1 variants contribute to inter-individual variability in warfarin dose requirements.'
FROM drug d
WHERE LOWER(d.name) LIKE '%warfarin%'
LIMIT 15;

INSERT IGNORE INTO drug_gene (drug_id, gene_id, interaction_desc)
SELECT d.id, 'CYP2C19', 'CYP2C19 loss-of-function alleles reduce active metabolite formation for clopidogrel and affect antiplatelet efficacy.'
FROM drug d
WHERE LOWER(d.name) LIKE '%clopidogrel%'
LIMIT 15;

INSERT IGNORE INTO drug_gene (drug_id, gene_id, interaction_desc)
SELECT d.id, 'LDLR', 'LDL receptor biology underpins LDL-lowering therapy; genotype may modulate response in selected contexts.'
FROM drug d
WHERE LOWER(d.name) LIKE '%atorvastatin%' OR LOWER(d.name) LIKE '%rosuvastatin%'
LIMIT 15;

INSERT IGNORE INTO drug_gene (drug_id, gene_id, interaction_desc)
SELECT d.id, 'TPMT', 'TPMT deficiency increases risk of myelosuppression with standard thiopurine dosing.'
FROM drug d
WHERE LOWER(d.name) LIKE '%azathioprine%' OR LOWER(d.name) LIKE '%mercaptopurine%'
LIMIT 15;

INSERT IGNORE INTO drug_gene (drug_id, gene_id, interaction_desc)
SELECT d.id, 'EGFR', 'EGFR mutation status guides eligibility for EGFR-targeted tyrosine kinase inhibitors.'
FROM drug d
WHERE LOWER(d.name) LIKE '%erlotinib%' OR LOWER(d.name) LIKE '%gefitinib%'
LIMIT 15;

INSERT IGNORE INTO drug_gene (drug_id, gene_id, interaction_desc)
SELECT d.id, 'CYP3A4', 'CYP3A4-mediated metabolism contributes to diazepam clearance and drug–drug interaction risk.'
FROM drug d
WHERE LOWER(d.name) LIKE '%diazepam%'
LIMIT 15;
