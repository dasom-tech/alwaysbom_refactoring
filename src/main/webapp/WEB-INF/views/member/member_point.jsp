<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>마이포인트</title>
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
                <span class="h5">포인트</span>
            </div>
            <hr class="hr1"/>
            <div class="d-flex flex-column">
                <div class="d-flex mb-5 mt-5">
                    <div class="left">
                        <span class="h5">현재 사용 가능한 적립금</span>
                        <hr>
                        <span class="h4"><b class="text-danger"><fmt:formatNumber value="${sessionScope.member.point}" pattern="#,###" /></b>원</span>
                    </div>
                    <div class="right">
                        <span>
                            <b>·</b>
                            <strong>${sessionScope.member.name}</strong>
                            님의 쿠폰 적립 및 사용 내역입니다.
                            <br><br>
                        </span>
                        <span>
                            <b>·</b>
                            사용하기 클릭시 해당 금액만큼 포인트가 적립됩니다.
                            <br><br>
                        </span>
                        <span>
                            <b>·</b>
                            결제시 포인트 사용 가능합니다.
                        </span>
                    </div>
                </div>
            </div>
            <table class="table table-striped text-center">
                <thead>
                <tr>
                    <th scope="col" class="col-2">날짜</th>
                    <th scope="col" class="col-2">구분</th>
                    <th scope="col" class="col-3">내용</th>
                    <th scope="col" class="col-3">금액</th>
                    <th scope="col" class="col-2">사용여부</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="coupon" items="${coupons}" varStatus="status">
                    <tr>
                        <td scope="row">${coupon.cdate}</td>
                        <c:if test="${coupon.status eq '0'}">
                            <td>적립</td>
                        </c:if>
                        <c:if test="${coupon.status eq '1'}">
                            <td>사용</td>
                        </c:if>
                        <td id="couponName${status.index}">${coupon.name}</td>
                        <td><fmt:formatNumber value="${coupon.point}" pattern="#,###" /></td>
                        <c:if test="${coupon.status eq '0'}">
                        <td>
                            <button type="button" class="btn btn-danger" onclick="useCoupon(this)">사용하기</button>
                            <input type="hidden" name="idx" value="${coupon.idx}" id="idx${status.index}">
                        </td>
                        </c:if>
                        <c:if test="${coupon.status eq '1'}">
                            <td><button type="button" class="btn btn-danger" disabled>사용완료</button></td>
                        </c:if>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</div>
</div>
<script>

    async function useCoupon(btn) {
        let idx = btn.nextElementSibling.value;
        //console.log("idx: " + idx);

        let option = {
            method: "post",
            body: idx,
            headers: {
                'Content-Type': 'application/json;charset=UTF-8'
            }
        };

        let response = await fetch("/api/useCoupon", option);
        let result = await response.json();
        //console.log(result);
        location.reload();

    }
</script>
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
        width: 45%;
        max-width: 520px;
        padding: 60px 0px;
        text-align: center;
        border-right: #bfbebc 1px solid;
        background: #fff;
    }
    .right {
        float: left;
        width: 45%;
        max-width: 520px;
        padding: 30px 0px 0px 40px;
        text-align: left;
        background: #fff;
    }
</style>
