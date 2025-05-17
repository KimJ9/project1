<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); %>
<% response.setHeader("Pragma", "no-cache"); %>
<% response.setHeader("Expires", "0"); %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>SQL 실행</title>
    <style>
        body { font-family: 'Malgun Gothic', Arial, sans-serif; margin: 20px; background-color: #f5f5f5; }
        .form-container { background-color: #fff; padding: 20px; border: 1px solid #ddd; border-radius: 5px; margin-bottom: 20px; }
        textarea { width: 100%; height: 100px; padding: 5px; border: 1px solid #ddd; border-radius: 3px; font-size: 14px; }
        button { padding: 6px 12px; background-color: #007bff; color: white; border: none; border-radius: 3px; cursor: pointer; font-size: 14px; margin-right: 5px; }
        button:hover { background-color: #0056b3; }
        table { border-collapse: collapse; width: 100%; margin-top: 10px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        .error { color: red; margin-top: 10px; }
        .message { color: green; margin-top: 10px; }
        .status { color: green; margin-bottom: 10px; }
        .pagination { text-align: center; margin-top: 20px; }
        .pagination a, .pagination span { margin: 0 5px; padding: 5px 10px; text-decoration: none; color: #007bff; border: 1px solid #ddd; border-radius: 3px; }
        .pagination a:hover { background-color: #f0f0f0; }
        .pagination .current { background-color: #007bff; color: white; border-color: #007bff; }
    </style>
</head>
<body>
    <h2>SQL 실행 : 테이블명 tour</h2>
    <c:if test="${not empty connectionStatus}">
        <p class="${connectionStatus.contains('연결 안됨') ? 'error' : 'status'}">
            연결 상태: ${connectionStatus}
        </p>
    </c:if>
    <div class="form-container">
        <form id="sqlForm" action="${pageContext.request.contextPath}/executeSql" method="post">
            <textarea name="sqlQuery" placeholder="SQL 쿼리를 입력하세요..."><c:out value="${sqlQuery != null ? sqlQuery : ''}" /></textarea><br>
            <input type="hidden" name="pageNo" value="1">
            <button type="submit">실행</button>
            <button type="button" onclick="executeSelectQuery()">조회</button>
        </form>
    </div>

    <c:if test="${not empty errorMessage && not empty sqlQuery}">
        <p class="error">${errorMessage}</p>
    </c:if>

    <c:forEach var="result" items="${results}">
        <h3>쿼리: <c:out value="${result.query}" /></h3>
        <p>총 행 수: <c:out value="${result.totalRows}" /></p>
        <c:choose>
            <c:when test="${not empty result.message}">
                <p class="message">${result.message}</p>
            </c:when>
            <c:when test="${not empty result.columns}">
                <table>
                    <tr>
                        <c:forEach var="column" items="${result.columns}">
                            <th><c:out value="${column}" /></th>
                        </c:forEach>
                    </tr>
                    <c:forEach var="row" items="${result.rows}">
                        <tr>
                            <c:forEach var="cell" items="${row}">
                                <td><c:out value="${cell != null ? cell : ''}" escapeXml="true" /></td>
                            </c:forEach>
                        </tr>
                    </c:forEach>
                </table>
                <%-- <p>표시된 행 수: <c:out value="${result.rows.size()}" /></p> --%>
                <c:if test="${result.totalRows > 0}">
                    <%-- <p>페이지네이션 정보: totalRows=${result.totalRows}, itemsPerPage=20</p> --%>
                    <c:set var="currentPage" value="${param.pageNo != null && param.pageNo != '' ? param.pageNo : 1}" />
                    <c:set var="itemsPerPage" value="20" />
                    <c:set var="totalPages" value="${(result.totalRows + itemsPerPage - 1) / itemsPerPage}" />
                    <fmt:parseNumber var="totalPagesInt" value="${totalPages}" integerOnly="true" />
                    <%-- <p>계산된 총 페이지: <c:out value="${totalPagesInt}" /></p> --%>
                    <c:set var="pageGroupSize" value="10" />
                    <c:set var="currentGroup" value="${(currentPage - 1) / pageGroupSize}" />
                    <fmt:parseNumber var="currentGroupInt" value="${currentGroup}" integerOnly="true" />
                    <c:set var="startPage" value="${currentGroupInt * pageGroupSize + 1}" />
                    <c:set var="endPage" value="${startPage + pageGroupSize - 1}" />
                    <c:if test="${endPage > totalPagesInt}">
                        <c:set var="endPage" value="${totalPagesInt}" />
                    </c:if>
                    <%-- <p>startPage: <c:out value="${startPage}" />, endPage: <c:out value="${endPage}" />, currentPage: <c:out value="${currentPage}" /></p> --%>
                    <div class="pagination">
                        <c:if test="${currentPage > 1}">
                            <c:url var="firstPage" value="/executeSql">
                                <c:param name="sqlQuery" value="${result.query}" />
                                <c:param name="pageNo" value="1" />
                            </c:url>
                            <a href="${firstPage}"><<</a>
                        </c:if>
                        <c:if test="${startPage > 1}">
                            <c:url var="prevGroup" value="/executeSql">
                                <c:param name="sqlQuery" value="${result.query}" />
                                <c:param name="pageNo" value="${startPage - 1}" />
                            </c:url>
                            <a href="${prevGroup}"><</a>
                        </c:if>
                        <c:forEach begin="${startPage}" end="${endPage}" var="i">
                            <c:choose>
                                <c:when test="${i == currentPage}">
                                    <span class="current">${i}</span>
                                </c:when>
                                <c:otherwise>
                                    <c:url var="pageLink" value="/executeSql">
                                        <c:param name="sqlQuery" value="${result.query}" />
                                        <c:param name="pageNo" value="${i}" />
                                    </c:url>
                                    <a href="${pageLink}">${i}</a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                        <c:if test="${endPage < totalPagesInt}">
                            <c:url var="nextGroup" value="/executeSql">
                                <c:param name="sqlQuery" value="${result.query}" />
                                <c:param name="pageNo" value="${endPage + 1}" />
                            </c:url>
                            <a href="${nextGroup}">></a>
                        </c:if>
                        <c:if test="${currentPage < totalPagesInt}">
                            <c:url var="lastPage" value="/executeSql">
                                <c:param name="sqlQuery" value="${result.query}" />
                                <c:param name="pageNo" value="${totalPagesInt}" />
                            </c:url>
                            <a href="${lastPage}">>></a>
                        </c:if>
                    </div>
                </c:if>
            </c:when>
        </c:choose>
    </c:forEach>

    <script>
        function executeSelectQuery() {
            console.log('executeSelectQuery called');
            try {
                const form = document.getElementById('sqlForm');
                const textarea = form.querySelector('textarea[name="sqlQuery"]');
                if (!form || !textarea) {
                    console.error('Form or textarea not found');
                    return;
                }
                textarea.value = 'select * from tour order by f일련번호 desc';
                // pageNo를 1로 설정
                let pageNoInput = form.querySelector('input[name="pageNo"]');
                if (!pageNoInput) {
                    pageNoInput = document.createElement('input');
                    pageNoInput.type = 'hidden';
                    pageNoInput.name = 'pageNo';
                    form.appendChild(pageNoInput);
                }
                pageNoInput.value = '1';
                console.log('Form submitting with query:', textarea.value, 'pageNo:', pageNoInput.value);
                form.submit();
            } catch (error) {
                console.error('Error in executeSelectQuery:', error);
            }
        }
    </script>
</body>
</html>
