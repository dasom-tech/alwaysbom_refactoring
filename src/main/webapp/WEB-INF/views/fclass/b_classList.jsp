<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>fclass mainView</title>
    <%@ include file="../main/b_import.jspf" %>
    <style>
        header {
            z-index: 10;
        }

        .scheduleBox {
            padding: 10px;
            margin: 60px 0;
            border-radius: 3px;
            background-color: #0c4128;
            color: white;
            text-decoration: none;
        }
        .scheduleBox:hover {
            background-color: #0f5132;
            color: white;
        }

        .btnColor {
            color: white;
            text-decoration: none;
        }

        .btnColor:hover {
            color: white;
        }

        .classes {
            padding: 0 0 0 30px;
        }

        .class-li-wrap, .branch-li {
            margin: 50px 0;
        }

        .branch-li-wrap {
            list-style: none;
        }

        .scale-up:hover {
            transition-duration: 0.2s;
            transform: scale(1.1);
        }
        .red {
            color: red;
        }
        .branch-box {
            border-radius: 12px;
            width: 60px;
            text-align: center;
        }
        .height-320px {
            height: 320px;
        }
        .box {
            display: flex;
        }

        .square {
            width: 290px;
            position: relative;
            overflow: hidden;
            border: none;
        }

        .square:after {
            content: "";
            display: block;
            padding-bottom: 100%;
        }

        .inner {
            position: absolute;
            width: 100%;
            height: 100%;
        }

        .inner img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

    </style>
</head>
<body>
<%@ include file="../main/b_header.jspf" %>
<div id="container" class="d-flex mx-auto">
    <div class="col-2 d-flex justify-content-center">
        <div class="branch-li p-4 d-flex flex-column align-items-center">
            <a href="/admin/fclass/selectClass" class="scheduleBox">클래스 일정관리</a>
            <table class="table">
                <thead>
                <tr>
                    <th scope="col">지점</th>
                </tr>
                </thead>
                <tbody>
                    <c:forEach var="branch" items="${branchList}">
                <tr>
                        <th>${branch.name}</th>
                </tr>
                    </c:forEach>
            </table>
            <button type="button" class="btn btn-success">
                <a class="btnColor" href="/admin/fclass/branch">지점관리</a>
            </button>
        </div>
    </div>
    <div class="col-10 bg-gradient">
        <div class="class-li-wrap">
            <h3 class="classes">One-day class</h3>
            <h3 class="classes">원데이클래스</h3>
            <ul class="d-flex flex-wrap">
                <c:forEach var="fclass" items="${classList}">
                    <c:if test="${fclass.category eq '원데이클래스'}">
                        <li class="col-4 card p-4">
                            <div class="box">
                                <div class="square">
                                    <a href="/admin/fclass/detail?idx=${fclass.idx}">
                                        <input type="hidden" name="idx" value="${fclass.idx}">

                                        <div class="overflow-hidden height-320px inner">
                                            <img src="${fclass.image1}" alt="꽃"
                                                 class="card-img-top scale-up">
                                        </div>
                                    </a>
                                </div>
                            </div>
                            <div class="fw-bold mb-2">${fclass.name}</div>
                            <div class="mb-2">
                                <span class="red">${fclass.discountRate}%</span>
                                <span class="text-decoration-line-through text-secondary">
                                    <fmt:formatNumber value="${fclass.price}" pattern="#,###"/>원</span>
                                <span><fmt:formatNumber value="${fclass.finalPrice}" pattern="#,###"/>원</span>
                            </div>
<%--                            <div>${fclass.category}</div>--%>
                            <ul class="border-0 d-flex m-0 p-0">
                                <c:forEach var="bvo" items="${fclass.branchList}">
                                    <li class="branch-box list-unstyled p-1 me-1 fw-bold"  style="color: ${bvo.color}; border: 2px solid ${bvo.color}; font-size: 0.75rem;">${bvo.name}</li>
                                </c:forEach>
                            </ul>
                        </li>
                    </c:if>
                </c:forEach>
                <li class="col-4 card p-4" style="min-height: 400px;">
                    <a class="w-100 h-100 btn btn-outline-secondary d-flex align-items-center justify-content-center"
                       href="/admin/fclass/addClass">
                        <i class="fa fa-plus h1"></i>
                    </a>
                </li>
            </ul>
        </div>
        <div class="class-li-wrap">
            <h3 class="classes">Florist class</h3>
            <h3 class="classes">플로리스트 클래스</h3>
            <ul class="d-flex flex-wrap">
                <c:forEach var="fclass" items="${classList}">
                    <c:if test="${fclass.category eq '플로리스트'}">
                        <li class="col-4 card p-4">
                            <div class="box">
                                <div class="square">
                                    <a href="/admin/fclass/detail?idx=${fclass.idx}">
                                        <input type="hidden" name="idx" value="${fclass.idx}">

                                        <div class="overflow-hidden height-320px inner">
                                            <img src="${fclass.image1}" alt="꽃"
                                                 class="card-img-top  scale-up">
                                        </div>
                                    </a>
                                </div>
                            </div>
                            <div class="fw-bold mb-2">${fclass.name}</div>
                            <div class="mb-2">
                                <span class="red">${fclass.discountRate}%</span>
                                <span class="text-decoration-line-through text-secondary">
                                    <fmt:formatNumber value="${fclass.price}" pattern="#,###"/>원</span>
                                <span><fmt:formatNumber value="${fclass.finalPrice}" pattern="#,###"/>원</span>
                            </div>
<%--                            <div>${fclass.category}</div>--%>
                            <ul class="border-0 d-flex m-0 p-0">
                                <c:forEach var="bvo" items="${fclass.branchList}">
                                    <li class="branch-box list-unstyled p-1 me-1 fw-bold"  style="color: ${bvo.color}; border: 2px solid ${bvo.color}; font-size: 0.75rem;">${bvo.name}</li>
                                </c:forEach>
                            </ul>
                        </li>
                    </c:if>
                </c:forEach>
                <li class="col-4 card p-4" style="min-height: 400px;">
                    <a class="w-100 h-100 btn btn-outline-secondary d-flex align-items-center justify-content-center"
                       href="/admin/fclass/addClass">
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
