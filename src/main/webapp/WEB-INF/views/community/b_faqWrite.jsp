<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>새늘봄
        |자주 묻는 질문</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ include file="../main/b_import.jspf" %>
    <script src="https://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
<%@ include file="../main/b_header.jspf" %>
<div class="d-flex justify-content-center">
    <div id="container">
        <h2>자주 묻는 질문 입력</h2>
        <div>
            <form class="row g-3" method="post">
                <div class="form-floating">
                    <select class="form-select" id="floatingSelect" name="category" aria-label="Floating label select example">
                        <option disabled>카테고리</option>
                        <c:forEach var="cate" items="${category}">
                            <c:if test="${cate eq vo.category}">
                                <option value="${cate}" selected>${cate}</option>
                            </c:if>
                            <c:if test="${cate ne vo.category}">
                                <option value="${cate}">${cate}</option>
                            </c:if>
                        </c:forEach>
                    </select>
                    <label for="floatingSelect">카테고리</label>
                </div>
                <div class="md-3">
                    <label for="question" class="form-label">Question</label>
                    <input type="text" class="form-control" name="question" id="question" value="${vo.question}" placeholder="질문입력" autocomplete="off">
                </div>
                <div class="form-floating">
                    <textarea class="form-control" placeholder="내용을 입력하세요" id="answer" name="answer" style="height: 200px">${vo.answer}</textarea>
                    <label for="answer">Answer</label>
                </div>
                <c:if test="${empty vo.idx}">
                <div class="file-wrap">
                    <button type="button" class="btn btn-secondary" onclick="faqUpload(this.form)">추가</button>
                </div>
                </c:if>
                <c:if test="${not empty vo.idx}">
                    <div class="file-wrap">
                        <input type="hidden" name="idx" id="idx" value="${vo.idx}">
                        <button type="button" class="btn btn-secondary" onclick="faqUpdate(this.form)">수정</button>
                    </div>
                </c:if>
            </form>
        </div>
    </div>
</div>

<%@ include file="../main/b_footer.jspf"%>
</body>
<script>
    function faqUpload(form) {
        let formData = $("form").serialize();
        $.ajax({
            url: '/admin/faq/api/insert',
            type: 'POST',
            dataType: "json",
            data: formData,
            success: function (data) {
                location.href="/adnin/community/goFaq";
            }
        });
    }

    function faqUpdate(form) {
        let formData = $("form").serialize();
        $.ajax({
            url: '/admin/faq/api/update',
            type: 'POST',
            dataType: "json",
            data: formData,
            success: function (data) {
                location.href="/adnin/community/goFaq";
            }
        });
    }
</script>
</html>

