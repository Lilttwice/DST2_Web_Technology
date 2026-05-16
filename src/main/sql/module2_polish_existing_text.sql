-- One-time cleanup: replace older "seed / demo only" wording already stored in your DB.
-- Run in MySQL Workbench after module2_seed.sql (old version) was applied.

USE biomed;

UPDATE gene SET description = 'Cytochrome P450 2C9; metabolises many clinically used drugs.' WHERE id = 'CYP2C9';
UPDATE gene SET description = 'Vitamin K epoxide reductase complex subunit 1; relevant to anticoagulant pharmacology.' WHERE id = 'VKORC1';
UPDATE gene SET description = 'Cytochrome P450 2C19; affects activation and clearance of several antiplatelet and psychotropic agents.' WHERE id = 'CYP2C19';
UPDATE gene SET description = 'Cytochrome P450 3A4; major hepatic and intestinal enzyme for drug metabolism.' WHERE id = 'CYP3A4';
UPDATE gene SET description = 'Thiopurine S-methyltransferase; guides thiopurine dosing in oncology and immunology.' WHERE id = 'TPMT';
UPDATE gene SET description = 'Epidermal growth factor receptor; predictive biomarker for selected targeted therapies.' WHERE id = 'EGFR';
UPDATE gene SET description = 'Low-density lipoprotein receptor; central to lipid-lowering pharmacology.' WHERE id = 'LDLR';
UPDATE gene SET description = 'UDP glucuronosyltransferase 1A1; relevant to irinotecan and other substrates.' WHERE id = 'UGT1A1';
UPDATE gene SET description = 'Dihydropyrimidine dehydrogenase; fluoropyrimidine toxicity risk factor.' WHERE id = 'DPYD';
UPDATE gene SET description = 'HLA class I molecule; pharmacogenomic associations include severe cutaneous adverse reactions for some drugs.' WHERE id = 'HLA-B';

UPDATE drug_gene SET interaction_desc =
    'Warfarin response and maintenance dose are influenced by CYP2C9 genotype in combination with other factors.'
WHERE gene_id = 'CYP2C9' AND (interaction_desc LIKE '%Seed%' OR interaction_desc LIKE '%demo%');

UPDATE drug_gene SET interaction_desc =
    'VKORC1 variants contribute to inter-individual variability in warfarin dose requirements.'
WHERE gene_id = 'VKORC1' AND (interaction_desc LIKE '%Seed%' OR interaction_desc LIKE '%demo%');

UPDATE drug_gene SET interaction_desc =
    'CYP2C19 loss-of-function alleles reduce active metabolite formation for clopidogrel and affect antiplatelet efficacy.'
WHERE gene_id = 'CYP2C19' AND (interaction_desc LIKE '%Seed%' OR interaction_desc LIKE '%demo%');

UPDATE drug_gene SET interaction_desc =
    'LDL receptor biology underpins LDL-lowering therapy; genotype may modulate response in selected contexts.'
WHERE gene_id = 'LDLR' AND (interaction_desc LIKE '%Seed%' OR interaction_desc LIKE '%demo%');

UPDATE drug_gene SET interaction_desc =
    'TPMT deficiency increases risk of myelosuppression with standard thiopurine dosing.'
WHERE gene_id = 'TPMT' AND (interaction_desc LIKE '%Seed%' OR interaction_desc LIKE '%demo%');

UPDATE drug_gene SET interaction_desc =
    'EGFR mutation status guides eligibility for EGFR-targeted tyrosine kinase inhibitors.'
WHERE gene_id = 'EGFR' AND (interaction_desc LIKE '%Seed%' OR interaction_desc LIKE '%demo%');

UPDATE drug_gene SET interaction_desc =
    'CYP3A4-mediated metabolism contributes to diazepam clearance and drug–drug interaction risk.'
WHERE gene_id = 'CYP3A4' AND (interaction_desc LIKE '%Seed%' OR interaction_desc LIKE '%demo%');
