<%--
  ICA3 Module 2 — search form + paginated results (drug–gene associations).
  For report: View layer; table cells use pre-escaped HTML from servlet (highlight).
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>

<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Drug–gene search</title>
    <link href="<%=request.getContextPath()%>/static/bootstrap/css/bootstrap.css" rel="stylesheet">
    <script src="<%=request.getContextPath()%>/static/jquery/jquery-3.4.1.js"></script>
    <script src="<%=request.getContextPath()%>/static/bootstrap/js/bootstrap.bundle.min.js"></script>
    <link href="<%=request.getContextPath()%>/static/css/app.css" rel="stylesheet">
    <style>
        mark { background-color: #fff3cd; padding: 0 .1em; }
    </style>
</head>
<body>
<jsp:include page="head.jsp"/>

<div class="container-fluid">
    <div class="row">
        <jsp:include page="nav.jsp">
            <jsp:param name="active" value="module2"/>
        </jsp:include>

        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h2>Drug–gene search</h2>
            </div>

            <p class="text-muted">Fuzzy match on <strong>drug name</strong> or <strong>gene name</strong> in
                <code>drug</code> / <code>gene</code> / <code>drug_gene</code>. Empty search lists all associations (paginated).</p>

            <form class="form-inline mb-4" method="get" action="<%=request.getContextPath()%>/module2/search">
                <label class="sr-only" for="keyword">Keyword</label>
                <input class="form-control mr-sm-2" type="search" id="keyword" name="keyword"
                       placeholder="e.g. warfarin or CYP2C9" value="<c:out value='${keyword}'/>" style="min-width: 16rem;">
                <input type="hidden" name="page" value="1">
                <button class="btn btn-primary my-2 my-sm-0" type="submit">Search</button>
            </form>

            <c:if test="${total == 0}">
                <div class="alert alert-info">No matching drug–gene rows.</div>
            </c:if>

            <c:if test="${total > 0}">
                <p><strong>${total}</strong> row(s). Page <strong>${page}</strong>
                    <c:if test="${totalPages > 0}"> of <strong>${totalPages}</strong></c:if>
                </p>

                <div class="table-responsive">
                    <table class="table table-striped table-sm">
                        <thead>
                        <tr>
                            <th>Drug ID</th>
                            <th>Drug (highlight)</th>
                            <th>Gene ID</th>
                            <th>Gene (highlight)</th>
                            <th></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${results}" var="row">
                            <tr>
                                <td><c:out value="${row.drugId}"/></td>
                                <td><c:out escapeXml="false" value="${row.drugNameHtml}"/></td>
                                <td><c:out value="${row.geneId}"/></td>
                                <td><c:out escapeXml="false" value="${row.geneNameHtml}"/></td>
                                <td>
                                    <c:url var="detailUrl" value="/module2/detail">
                                        <c:param name="drugId" value="${row.drugId}"/>
                                        <c:param name="geneId" value="${row.geneId}"/>
                                        <c:param name="keyword" value="${keyword}"/>
                                    </c:url>
                                    <a class="btn btn-sm btn-outline-secondary" href="${detailUrl}">Detail</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>

                <c:if test="${totalPages > 1}">
                    <nav aria-label="pagination">
                        <ul class="pagination">
                            <c:forEach begin="1" end="${totalPages}" var="p">
                                <li class="page-item ${p == page ? 'active' : ''}">
                                    <c:url var="pageUrl" value="/module2/search">
                                        <c:param name="keyword" value="${keyword}"/>
                                        <c:param name="page" value="${p}"/>
                                    </c:url>
                                    <a class="page-link" href="${pageUrl}">${p}</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </nav>
                </c:if>
            </c:if>
        </main>
    </div>
</div>
</body>
</html>
