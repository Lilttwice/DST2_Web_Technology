<%--
  ICA3 Module 2 — drug–gene detail (prose sections for readability).
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>

<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Drug–gene detail</title>
    <link href="<%=request.getContextPath()%>/static/bootstrap/css/bootstrap.css" rel="stylesheet">
    <script src="<%=request.getContextPath()%>/static/jquery/jquery-3.4.1.js"></script>
    <script src="<%=request.getContextPath()%>/static/bootstrap/js/bootstrap.bundle.min.js"></script>
    <link href="<%=request.getContextPath()%>/static/css/app.css" rel="stylesheet">
    <style>
        mark { background-color: #fff3cd; padding: 0 .1em; }
        .detail-prose p { margin-bottom: 0.75rem; line-height: 1.55; }
        .detail-prose p:last-child { margin-bottom: 0; }
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
                <h2>Drug–gene detail</h2>
            </div>

            <c:if test="${notFound}">
                <div class="alert alert-warning">Record not found (check drug id / gene id).</div>
            </c:if>

            <c:if test="${drugGene != null}">
                <p class="mb-4">
                    <c:url var="backUrl" value="/module2/search">
                        <c:param name="keyword" value="${keyword}"/>
                        <c:param name="page" value="1"/>
                    </c:url>
                    <a href="${backUrl}" class="btn btn-link pl-0">&laquo; Back to search</a>
                </p>

                <section class="mb-4">
                    <h4 class="h5 text-muted">Drug</h4>
                    <div class="detail-prose border rounded bg-light p-3">
                        <p><strong>Identifier:</strong> <c:out value="${drugGene.drugId}"/></p>
                        <p><strong>Name:</strong> <c:out escapeXml="false" value="${drugGene.drugNameHtml}"/></p>
                        <p><strong>Class (obj_cls):</strong> <c:out value="${drugGene.drugObjCls}"/></p>
                        <p><strong>External URL:</strong>
                            <c:choose>
                                <c:when test="${empty drugGene.drugUrl or drugGene.drugUrl == ''}">
                                    <span class="text-muted">Not available in the imported record.</span>
                                </c:when>
                                <c:otherwise>
                                    <c:out value="${drugGene.drugUrl}"/>
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                </section>

                <section class="mb-4">
                    <h4 class="h5 text-muted">Gene</h4>
                    <div class="detail-prose border rounded bg-light p-3">
                        <p><strong>Identifier:</strong> <c:out value="${drugGene.geneId}"/></p>
                        <p><strong>Symbol / name:</strong> <c:out escapeXml="false" value="${drugGene.geneNameHtml}"/></p>
                        <p><strong>Description:</strong></p>
                        <p><c:out escapeXml="false" value="${geneDescHtml}"/></p>
                    </div>
                </section>

                <section class="mb-4">
                    <h4 class="h5 text-muted">Association summary</h4>
                    <div class="detail-prose border rounded p-3">
                        <p><c:out escapeXml="false" value="${interactionHtml}"/></p>
                    </div>
                </section>

                <p class="mt-3">
                    <c:url var="riskPreviewUrl" value="/module3/preview">
                        <c:param name="drugId" value="${drugGene.drugId}"/>
                        <c:param name="geneId" value="${drugGene.geneId}"/>
                    </c:url>
                    <a class="btn btn-outline-primary btn-sm" href="${riskPreviewUrl}">Open risk assessment preview</a>
                </p>
            </c:if>
        </main>
    </div>
</div>
</body>
</html>
