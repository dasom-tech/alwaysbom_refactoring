<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원 등급</title>
    <%@ include file="../main/import.jspf" %>
</head>
<body>
<%@ include file="../main/header.jspf" %>
<div id="container" class="mx-auto d-flex flex-column user-select-none">
<%@ include file="../member/mypage_header.jspf" %>
    <div class="d-flex">
    <%@ include file="../member/mypage_menu.jspf" %>
        <div class="col-10 border-info d-flex justify-content-center p-4">
            <div class="col-12" id="contentPane">
                <div class="col-12">
                    <div class="d-flex text-secondary">
                        <span class="h5 fw-bold name-color">${sessionScope.member.name}</span>
                        <span>님의 회원등급</span>
                    </div>
                    <hr class="hr1"/>
                    <div class="d-flex flex-column col-12">
                        <div class="d-flex mb-5 mt-5 col-12">
                            <div class="left col-6">
                                <c:if test="${sessionScope.member.grade eq '데이지'}">
                                <span><img src="/static/image/daisy.jpg" alt="데이지" class="d-block rounded-circle w-100"></span>
                                </c:if>
                                <c:if test="${sessionScope.member.grade eq '자스민'}">
                                    <span><img src="/static/image/jasmin.jpg" alt="자스민" class="d-block rounded-circle w-100"></span>
                                </c:if>
                                <c:if test="${sessionScope.member.grade eq '무궁화'}">
                                    <span><img src="/static/image/mugunghwa.jpg" alt="무궁화" class="d-block rounded-circle w-100"></span>
                                </c:if>
                            </div>
                            <div class="right col-6">
                                <div class="d-flex mb-5 mt-5">
                                    <span>
                                        ${sessionScope.member.name}님의 회원등급은 <b class="text-warning h5">${sessionScope.member.grade}</b>입니다.
                                        <br><br>
                                    </span>
                                </div>
                                <hr class="hr1"/>
                                <div class="mb-5 mt-5">
                                    <span>
                                        <b>·</b>
                                        [배송완료] 기준으로 등급이 산정됩니다.
                                        <br><br>
                                    </span>
                                    <span>
                                        <b>·</b>
                                        등급 산정에 클래스 이용 내역은 반영되지 않습니다.
                                        <br><br>
                                    </span>
                                    <span>
                                        <b>·</b>
                                        <strong>매월 1일</strong>
                                        새로운 등급이 부여됩니다.
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="mb-3">
                        <strong class="h5">등급별 혜택 안내</strong>
                    </div>
                    <hr class="hr1"/>
                    <div class="text-center">
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th scope="col"></th>
                                <th scope="col"><img src="/static/image/mugunghwa.jpg" alt="무궁화" width="120" height="120" class="d-block rounded-circle"></th>
                                <th scope="col"><img src="/static/image/jasmin.jpg" alt="자스민" width="120" height="120" class="d-block rounded-circle"></th>
                                <th scope="col"><img src="/static/image/daisy.jpg" alt="데이지" width="120" height="120" class="d-block rounded-circle"></th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <th scope="row">등급 조건(구매 금액)</th>
                                <td>50만원 이상</td>
                                <td>10만원 이상</td>
                                <td>회원 가입시</td>
                            </tr>
                            <tr>
                                <th scope="row">승급시 혜택</th>
                                <td>5,000 포인트 적립</td>
                                <td>3,000 포인트 적립</td>
                                <td>1,000 포인트 적립</td>
                            </tr>
                            <tr>
                                <th scope="row">상시 혜택</th>
                                <td>2% 상시 할인</td>
                                <td>2% 상시 할인</td>
                                <td></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<%@ include file="../main/footer.jspf"%>
</html>
<style>
    .pointBox {
        padding-top: 50px;
        padding-bottom: 50px;
    }
    .left {
        float: left;
        max-width: 520px;
        padding: 30px 30px 30px 30px;
        text-align: center;
        border-right: #bfbebc 1px solid;
        background: #fff;
    }
    .right {
        float: left;
        max-width: 520px;
        padding: 30px 30px 30px 30px;
        text-align: left;
        background: #fff;
    }
</style>
