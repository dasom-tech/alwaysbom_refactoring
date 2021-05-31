<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul id ="ulTable" class="accordion">
<li>
    <ul>
        <li>별점</li>
        <li>제목</li>
        <li>작성일</li>
        <li>작성자</li>
        <li>좋아요</li>
    </ul>
</li>
<!-- 게시물이 출력될 영역 -->
<c:forEach var="bestAllList" items="${bestRList}">
    <li>
        <ul id="acco_click">
            <li class="text-center"><div>${bestAllList.star}</div></li>
            <li class="text-center">${bestAllList.name}</li>
            <li class="text-center"><div>${bestAllList.regDate}</div></li>
            <li class="text-center"><div>${bestAllList.memberId}</div></li>
            <li class="text-center"><div>${bestAllList.likeCount}</div></li>
        </ul>
        <div class="accordion_count">
            <div>
                <p>${bestAllList.content}</p>
            </div>

            <div>
                <c:if test="${not empty bestAllList.image}">
                    <div>
                        <img src="/static/upload/community/review/${bestAllList.image}">
                    </div>
                </c:if>
            </div>
        </div>
    </li>
</c:forEach>
</ul>
<%--페이징 처리--%>
<ol class="paging">
<c:choose>
    <c:when test="${pvo.nowBlock eq 1}">
        <li class="disable"><i class="fas fa-angle-double-left"></i></li>
        <li class="disable"><i class="fas fa-angle-left"></i></li>
    </c:when>
    <c:when test="${pvo.nowBlock > 1}">
        <li onclick='goPage("allList", "${param.category}", "1")'><i class="fas fa-angle-double-left"></i></li>
        <li onclick='goPage("allList", "${param.category}", "${pvo.nowPage - 1}")'><i class="fas fa-angle-left"></i></li>
    </c:when>
</c:choose>

<c:forEach var="pageNo" begin="${pvo.beginPage}" end="${pvo.endPage}">
    <c:if test="${pageNo == pvo.nowPage }">
        <li class="now">${pageNo}</li>
    </c:if>
    <c:if test="${pageNo ne pvo.nowPage}">
        <li onclick='goPage("allList", "${param.category}", "${pageNo}")'>${pageNo},"${pvo.beginPage} end=${pvo.endPage}" </li>
    </c:if>
</c:forEach>

<c:choose>
    <c:when test="${pvo.nowBlock eq pvo.totalBlock}">
        <li class="disable"><i class="fas fa-angle-right"></i></li>
        <li class="disable"><i class="fas fa-angle-double-right"></i></li>
    </c:when>
    <c:when test="${pvo.nowBlock < pvo.totalBlock}">
        <li onclick='goPage("allList", "${param.category}", "${pvo.nowPage + 1}")'><i class="fas fa-angle-right"></i></li>
        <li onclick='goPage("allList", "${param.category}", "${pvo.totalPage}")'><i class="fas fa-angle-double-right"></i></li>
    </c:when>
</c:choose>
</ol>