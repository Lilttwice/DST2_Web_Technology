package cn.edu.zju.servlet;

import cn.edu.zju.dao.DrugGeneSearchDao;
import cn.edu.zju.dto.DrugGeneAssociation;
import cn.edu.zju.util.Module2HtmlEscape;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * ICA3 Module 2 — detail view for one (drug id, gene id) pair.
 * <p>
 * Report: stable URL for other modules — {@code GET /module2/detail?drugId=...&amp;geneId=...}
 * Optional {@code keyword} repeats the search term for consistent highlighting in the UI.
 */
@WebServlet(name = "Module2DetailServlet", urlPatterns = "/module2/detail")
public class Module2DetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String drugId = request.getParameter("drugId");
        String geneId = request.getParameter("geneId");
        String keyword = request.getParameter("keyword");
        if (keyword == null) {
            keyword = "";
        }

        DrugGeneSearchDao dao = new DrugGeneSearchDao();
        DrugGeneAssociation row = null;
        if (drugId != null && geneId != null && !drugId.trim().isEmpty() && !geneId.trim().isEmpty()) {
            row = dao.findByDrugAndGene(drugId.trim(), geneId.trim());
        }

        if (row != null) {
            row.setDrugNameHtml(Module2HtmlEscape.escapeAndHighlight(row.getDrugName(), keyword));
            row.setGeneNameHtml(Module2HtmlEscape.escapeAndHighlight(row.getGeneName(), keyword));
            request.setAttribute("drugGene", row);
            request.setAttribute("keyword", keyword);
            request.setAttribute("geneDescHtml",
                    Module2HtmlEscape.escapeAndHighlight(row.getGeneDescription(), keyword));
            request.setAttribute("interactionHtml",
                    Module2HtmlEscape.escapeAndHighlight(row.getInteractionDesc(), keyword));
        } else {
            request.setAttribute("notFound", Boolean.TRUE);
        }

        request.getRequestDispatcher("/views/module2_detail.jsp").forward(request, response);
    }
}
