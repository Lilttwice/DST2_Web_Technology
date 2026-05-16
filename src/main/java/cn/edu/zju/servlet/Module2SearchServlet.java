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
import java.util.List;

/**
 * ICA3 Module 2 — HTTP entry for fuzzy drug/gene search + paginated list.
 * <p>
 * Report: {@code GET /module2/search?keyword=...&amp;page=...} → Servlet reads parameters,
 * calls {@link DrugGeneSearchDao}, puts model attributes, forwards to JSP (MVC “controller”).
 */
@WebServlet(name = "Module2SearchServlet", urlPatterns = "/module2/search")
public class Module2SearchServlet extends HttpServlet {

    private static final int PAGE_SIZE = 10;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        if (keyword == null) {
            keyword = "";
        }

        int page = 1;
        try {
            page = Integer.parseInt(request.getParameter("page"));
        } catch (Exception ignored) {
            // keep default
        }

        DrugGeneSearchDao dao = new DrugGeneSearchDao();
        int total = dao.countByKeyword(keyword);
        int totalPages = total == 0 ? 0 : (int) Math.ceil(total / (double) PAGE_SIZE);
        if (totalPages > 0 && page > totalPages) {
            page = totalPages;
        }
        if (page < 1) {
            page = 1;
        }

        List<DrugGeneAssociation> rows = dao.searchByKeyword(keyword, page, PAGE_SIZE);
        for (DrugGeneAssociation row : rows) {
            row.setDrugNameHtml(Module2HtmlEscape.escapeAndHighlight(row.getDrugName(), keyword));
            row.setGeneNameHtml(Module2HtmlEscape.escapeAndHighlight(row.getGeneName(), keyword));
        }

        request.setAttribute("keyword", keyword);
        request.setAttribute("page", page);
        request.setAttribute("pageSize", PAGE_SIZE);
        request.setAttribute("total", total);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("results", rows);
        request.getRequestDispatcher("/views/module2_search.jsp").forward(request, response);
    }
}
