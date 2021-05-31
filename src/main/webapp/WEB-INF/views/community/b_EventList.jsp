<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Event List</title>
    <%@ include file="../main/b_import.jspf" %>
    <style>
        header {
            z-index: 10;
        }
        .classes {
            padding: 0 0 0 30px;
        }
        .class-li-wrap, .branch-li {
            margin: 50px 0;
        }
        .scale-up:hover {
            transition-duration: 0.2s;
            transform: scale(1.1);
        }
        .height-320px {
            height: 320px;
        }

    </style>
</head>
<body>
<%@ include file="../main/b_header.jspf" %>
<div id="container" class="d-flex mx-auto">
    <div class="col-2 d-flex justify-content-center">
        <div class="branch-li p-4 d-flex flex-column align-items-center">
            <table class="table">
                <tbody>
                <tr>
                    <th><a href="/admin/community/eventList" class="text-decoration-none">진행중인 이벤트</a></th>
                </tr>
                <tr>
                    <th><a href="/admin/community/eventOldList" class="text-decoration-none">지난 이벤트</a></th>
                </tr>
            </table>
        </div>
    </div>
    <div class="col-10 bg-gradient">
        <div class="class-li-wrap">
            <h3 class="classes">이벤트</h3>
            <ul class="d-flex flex-wrap">
                <c:forEach var="event" items="${eventList}">
                        <li class="col-4 card p-4">
                            <div>
                                <a href="/admin/event/detail?idx=${event.idx}">
                                    <input type="hidden" name="idx" value="${event.idx}">
                                    <div class="overflow-hidden height-320px">
                                        <img src="${event.thumb}" alt="썸네일이미지"
                                             class="card-img-top scale-up">
                                    </div>
                                </a>
                            </div>
                            <div class="fw-bold mb-2">${event.name}</div>
                            <div class="mb-2">
                                <span class="text-secondary">
                               ${event.startDate} ~ ${event.endDate}</span>
                            </div>
                        </li>
                </c:forEach>
                <li class="col-4 card p-4" style="min-height: 400px;">
                    <a class="w-100 h-100 btn btn-outline-secondary d-flex align-items-center justify-content-center"
                       href="/admin/community/addEventList">
                        <i class="fa fa-plus h1"></i>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</div>
<%@ include file="../main/b_footer.jspf" %>
</body>
</html>
