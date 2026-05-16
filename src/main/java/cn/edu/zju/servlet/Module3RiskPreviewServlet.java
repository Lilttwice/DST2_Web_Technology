package cn.edu.zju.servlet;

import cn.edu.zju.dao.DrugGeneSearchDao;
import cn.edu.zju.dto.DrugGeneAssociation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Downstream preview: loads one drug–gene row via {@link DrugGeneSearchDao#findByDrugAndGene}
 * for risk-assessment workflows (scoring not implemented in this ICA slice).
 */
@WebServlet(name = "Module3RiskPreviewServlet", urlPatterns = "/module3/preview")
public class Module3RiskPreviewServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        String drugId = req.getParameter("drugId");
        String geneId = req.getParameter("geneId");
        String ctx = req.getContextPath();
        PrintWriter w = resp.getWriter();
        w.println("<!doctype html><html><head><meta charset='utf-8'><title>Risk assessment preview</title>");
        w.println("<link rel='stylesheet' href='" + ctx + "/static/bootstrap/css/bootstrap.min.css'></head>");
        w.println("<body class='p-4'><div class='container' style='max-width:800px'>");
        w.println("<h2>Risk assessment preview</h2>");
        w.println("<p class='text-muted'>Selected drug–gene pair for downstream risk logic (lookup only in this build).</p>");

        if (drugId == null || geneId == null || drugId.trim().isEmpty() || geneId.trim().isEmpty()) {
            w.println("<div class='alert alert-info'>Open this page from a drug–gene <a href='" + ctx
                    + "/module2/search'>search result</a> or detail view to load a pair.</div>");
            w.println("</div></body></html>");
            return;
        }

        DrugGeneAssociation row = new DrugGeneSearchDao().findByDrugAndGene(drugId.trim(), geneId.trim());
        if (row == null) {
            w.println("<div class='alert alert-danger'>No association found for this drug and gene.</div>");
            w.println("<p><a href='" + ctx + "/module2/search'>Back to search</a></p></div></body></html>");
            return;
        }

        w.println("<table class='table table-sm table-bordered'>");
        w.println("<tr><th>Drug ID</th><td>" + esc(row.getDrugId()) + "</td></tr>");
        w.println("<tr><th>Drug name</th><td>" + esc(row.getDrugName()) + "</td></tr>");
        w.println("<tr><th>Gene ID</th><td>" + esc(row.getGeneId()) + "</td></tr>");
        w.println("<tr><th>Gene name</th><td>" + esc(row.getGeneName()) + "</td></tr>");
        w.println("<tr><th>Association</th><td>" + esc(row.getInteractionDesc()) + "</td></tr>");
        w.println("</table>");
        w.println("<p class='mt-3'><a href='" + ctx + "/module2/detail?drugId=" + esc(row.getDrugId())
                + "&geneId=" + esc(row.getGeneId()) + "'>View full drug–gene detail</a></p>");
        w.println("</div></body></html>");
    }

    private static String esc(String s) {
        if (s == null) {
            return "";
        }
        return s.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
    }
}
