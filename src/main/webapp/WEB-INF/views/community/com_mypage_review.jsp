<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>1:1문의</title>
    <%@ include file="../main/import.jspf" %>
    <script src="https://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
<%@ include file="../main/header.jspf" %>
<div id="container" class="mx-auto d-flex flex-column user-select-none">
    <%@ include file="../member/mypage_header.jspf" %>
    <div class="h-85 d-flex">
        <%@ include file="../member/mypage_menu.jspf" %>
        <div class="col-10 border-info d-flex justify-content-center p-4">
            <div class="col-12 h-100" id="contentPane">
                <div class="col-12 border-info d-flex justify-content-center p-4">
                    <div class="col-12">
                        <div class="d-flex text-secondary">
                            <span class="h5 fw-bold name-color">${sessionScope.member.name}</span>
                            <span>님의 상품 후기 입니다.</span>
                        </div>
                        <hr class="hr1"/>
                        <p>
                            <span>- 새늘봄의 꽃이, 일상에 얼마나 큰 행복이 될 수 있는지</span>
                        </p>
                        <p>
                            <span>- 더 많은 분들이 알 수 있도록 후기를 남겨 주세요.</span>
                        </p>
                        <div class="d-flex pb-3 col-11">
                            <button type="button" class="btn btn-warning col-6 me-2" onclick="location.href='/community/com_mypage_review'">작성 가능한 후기</button>
                            <button type="button" class="btn btn-warning col-6 ms-2" onclick="goReview()">내가 작성한 후기</button>
                        </div>
<%--                        <div class="col-11 d-flex pb-3 justify-content-end border-bottom pt-2">--%>
<%--                            <button type="button" class="btn btn-warning col-2" onclick="location.href='/question/create'">1:1 문의</button>--%>
<%--                        </div>--%>

                        <div class="col-11 h-100" id="orderList">
                            <%--내용 반복문--%>
                            <c:forEach var="order" items="${orderList}" varStatus="status">
                                <c:forEach var="oitem" items="${orderList.get(status.index).olist}">
                                 <c:if test="${oitem.reviewCheck == 0}">
                                    <div class="bb-1 p-3" id="bord-color">
                                        <a href="javascript:void(0);" onClick="goWrite('${oitem.category}', '${oitem.name}', ${oitem.idx}); return false"
                                           class="d-flex justify-content-start ps-2">
                                            <span class="pe-2">${oitem.idx}</span>
                                            <span class="pe-2"> 이름 : ${oitem.name}</span>
                                            <span class="pe-2"> 가격 : ${oitem.price}</span>
                                            <span class="pe-2"> 상품 : ${oitem.options}</span>
                                            <span class="dateCut"> 주문날짜 : ${oitem.requestDate}</span>
                                        </a>
                                    </div>
                                 </c:if>
                                </c:forEach>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="../main/footer.jspf" %>
<script>
    function goWrite(category, name, idx){
        console.log(category + idx  + name);
        location.href = "/community/event/reviewWrite?category=" + category + "&idx=" + idx + "&name=" + name;
    }
    function updateWrite(category, name, idx, reviewIdx){
        console.log(category + idx  + name);
        location.href = "/community/event/updateWrite?category=" + category + "&idx=" + idx + "&name=" + name + "&reviewIdx=" + reviewIdx;
    }

    function updateFclassWrite(category, name, reviewIdx, idx) {
        location.href = "/community/event/updateFclassWrite?category=" + category + "&idx=" + idx + "&reviewIdx=" + reviewIdx;
    }

    function goReview() {
        $.ajax({
            url: '/community/api/myPageReviewe',
            type: 'get',
            dataType: 'json',
            success: function (data){
                let htmls = '';
                $.each(data, function (i, item) {
                    console.log(this.olist);
                    $.each(this.olist, function (j, oli) {
                        console.log(this.name);
                        if(this.reviewCheck == 1){
                            htmls += '<div class="bb-1 p-3" id="bord-color">'
                            + '<a href="javascript:void(0);" onClick="updateWrite(`' + oli.category + '`, `' + oli.name + '`, `' + oli.idx + '`, `' + oli.reviewIdx + '`); return false" class="d-flex justify-content-start ps-2">'
                            + '<span class="link pe-2 text-dark">' + oli.idx + '</span>'
                            + '<span class="link pe-2 text-dark"> 이름 :' + oli.name + '</span>'
                            + '<span class="link pe-2 text-dark"> 가격 :' + oli.price + '</span>'
                            + '<span class="link pe-2 text-dark"> 상품 :' + oli.options + '</span>'
                            + '<span class="dateCut"> 주문날짜 : ' + new Date(oli.requestDate).toLocaleDateString() + '</span>'
                            + '</a></div>';
                        }
                    });
                });
                $("#orderList").html(htmls);
                oFclassList(1);
            }
        });
    }

    function classWrite(category, fidx, idx) {
        location.href = "/community/classWriter?category=" + category + "&fidx="+fidx + "&idx=" + idx;
    }
    $(function (){
        let check = 0;
        oFclassList(check)
    });

    function oFclassList(checkNum) {
        let sendData = {
            "check": checkNum
        }
        $.ajax({
            url: '/community/api/myPageReviewFclass',
            type: 'get',
            dataType: 'json',
            data: sendData,
            success: function (data){
                let htmls = '';
                $.each(data, function (j, oli) {
                    htmls += '<div class="bb-1 p-3" id="bord-color">';
                    if(checkNum == 0) {
                       htmls += '<a href="javascript:void(0);" onClick="classWrite(`클래스` ,`' + oli.fclassIdx + '`,`' + oli.idx + '`); return false" class="d-flex justify-content-start ps-2">';
                    } else {
                        htmls += '<a href="javascript:void(0);" onClick="updateFclassWrite(`클래스` ,`' + oli.fclassIdx + '`,`' + oli.reviewIdx + '`,`' + oli.idx + '`); return false" class="d-flex justify-content-start ps-2">';
                    }
                        htmls += '<span class="pe-2">' + oli.idx + '</span>'
                        + '<span class="pe-2"> 지점 :' + oli.branchName + '</span>'
                        + '<span class="pe-2"> 가격 :' + oli.payTotal + '</span>'
                        + '<span class="pe-2"> 상품 :' + oli.fclassName + '</span>'
                        + '<span class="dateCut"> 주문날짜 : ' +  new Date(oli.payDate).toLocaleDateString()
                        + '</span>'
                        + '</a></div>';
                });
                $("#orderList").append(htmls);
            }
        });
    }

</script>


</body>
<style>
    #bord-color{
        background-color: #FFFFFF;
    }
    #bord-color a {
        color: black;
    }
    #bord-color a:hover {
        color: #fc7771;
    }
</style>
</html>
