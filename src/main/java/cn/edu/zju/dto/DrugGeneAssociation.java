package cn.edu.zju.dto;

/**
 * ICA3 Module 2 — one row of a drug–gene association (search list or detail).
 * Maps to joined columns from {@code drug}, {@code gene}, and {@code drug_gene}.
 * <p>
 * For your report: this is the DTO passed from Servlet → JSP (and later reusable
 * by a risk-assessment module as a plain Java object).
 */
public class DrugGeneAssociation {

    private String drugId;
    private String drugName;
    private String drugObjCls;
    private String drugUrl;
    private String geneId;
    private String geneName;
    private String geneDescription;
    private String interactionDesc;

    /** Safe HTML snippets for list view (escape + optional &lt;mark&gt;). Set in servlet. */
    private String drugNameHtml;
    private String geneNameHtml;

    public DrugGeneAssociation() {
    }

    public DrugGeneAssociation(String drugId, String drugName, String drugObjCls, String drugUrl,
                               String geneId, String geneName, String geneDescription, String interactionDesc) {
        this.drugId = drugId;
        this.drugName = drugName;
        this.drugObjCls = drugObjCls;
        this.drugUrl = drugUrl;
        this.geneId = geneId;
        this.geneName = geneName;
        this.geneDescription = geneDescription;
        this.interactionDesc = interactionDesc;
    }

    public String getDrugId() {
        return drugId;
    }

    public void setDrugId(String drugId) {
        this.drugId = drugId;
    }

    public String getDrugName() {
        return drugName;
    }

    public void setDrugName(String drugName) {
        this.drugName = drugName;
    }

    public String getDrugObjCls() {
        return drugObjCls;
    }

    public void setDrugObjCls(String drugObjCls) {
        this.drugObjCls = drugObjCls;
    }

    public String getDrugUrl() {
        return drugUrl;
    }

    public void setDrugUrl(String drugUrl) {
        this.drugUrl = drugUrl;
    }

    public String getGeneId() {
        return geneId;
    }

    public void setGeneId(String geneId) {
        this.geneId = geneId;
    }

    public String getGeneName() {
        return geneName;
    }

    public void setGeneName(String geneName) {
        this.geneName = geneName;
    }

    public String getGeneDescription() {
        return geneDescription;
    }

    public void setGeneDescription(String geneDescription) {
        this.geneDescription = geneDescription;
    }

    public String getInteractionDesc() {
        return interactionDesc;
    }

    public void setInteractionDesc(String interactionDesc) {
        this.interactionDesc = interactionDesc;
    }

    public String getDrugNameHtml() {
        return drugNameHtml;
    }

    public void setDrugNameHtml(String drugNameHtml) {
        this.drugNameHtml = drugNameHtml;
    }

    public String getGeneNameHtml() {
        return geneNameHtml;
    }

    public void setGeneNameHtml(String geneNameHtml) {
        this.geneNameHtml = geneNameHtml;
    }
}
