<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>1:1문의</title>
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
                <div class="col-12 border-info d-flex justify-content-center p-4">
                    <div class="col-12">
                        <div class="d-flex text-secondary">
                            <span class="h5 fw-bold name-color">${sessionScope.member.name}</span>
                            <span>님의 문의 내역입니다.</span>
                        </div>
                        <hr class="hr1"/>
                        <p>
                        <span>- 1:1 문의 게시판 운영 시간 : 월 ~ 금 10:00 ~18:00</span>
                        </p>
                        <p>
                        <span>- 운영 시간 내에는 2시간 이내에 답변을 드리나, 문의가 많을 때는 다소 지연될 수 있습니다.</span>
                        </p>
                        <div class="btn">
                            <button type="button" class="btn btn-outline-secondary" onclick="location.href='/community/goFaq'">자주 묻는 질문</button>
                            <button type="button" class="btn btn-outline-secondary" onclick="location.href='/question/create'">1:1 문의하기</button>
                        </div>
                        <table class="table table-striped text-center">
                            <thead>
                            <tr>
<%--                                이거 냅둘게용--%>
                                <th scope="col" class="col-2">번호</th>
                                <th scope="col" class="col-2">작성일</th>
                                <th scope="col" class="col-3">제목</th>
                                <th scope="col" class="col-3">상태</th>
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
                                    <td>${coupon.point}</td>
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
</div>
<%@ include file="../main/footer.jspf" %>
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
</html>
