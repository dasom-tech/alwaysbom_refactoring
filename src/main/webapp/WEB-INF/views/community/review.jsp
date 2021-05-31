<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE HTML>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>리뷰게시판</title>
    <%@ include file="../main/import.jspf"%>
    <link rel="stylesheet" href="/static/css/community/review/review.css">
    <style>

        ul, li{
            list-style:none;
/*            text-align:center;
            padding:0;
            margin:0;*/
        }

        #mainWrapper{
            width: 1000px;
            margin: 0 auto; /*가운데 정렬*/
        }

        #mainWrapper > ul > li:first-child {
            text-align: center;
            font-size:14pt;
            height:40px;
            vertical-align:middle;
            line-height:30px;
        }

        #ulTablebar > li:first-child > ul > li {
            background-color:black;
            font-weight:bold;
            text-align:center;
        }
        #ulTable > li:first-child > ul > li {
            text-align:center;
        }

        #ulTable > li > ul > button, #ulTablebar > li > ul {
            clear:both;
            padding:0px;
            position:relative;
            min-width:40px;
        }
        #ulTable > li > ul > button > li, #ulTablebar > li > ul > li {
            float:left;
            font-size:10pt;
            border-bottom:2px solid silver;
            vertical-align:baseline;
        }

        .titleBtn {
            border: 1px solid #939393;
            background-color: black;
            border-radius: 0;
            padding: 10px 0 10px 0;
        }
        .titleBtn:hover {
            background-color: #323232;
            text-decoration-color: black;
        }
        .reviewCategory radio {
            background-color: #dbd8d8; !important;
        }


        #ulTable > li > ul > button > li:first-child, #ulTablebar > li > ul > li:first-child              /* {width:10%; height: 40px;}*/ /*No 열 크기*/
        #ulTable > li > ul > button > li:first-child +li, #ulTablebar > li > ul > li:first-child +li           /*{width:40%; height: 40px;}*/ /*제목 열 크기*/
        #ulTable > li > ul > button > li:first-child +li+li, #ulTablebar > li > ul > li:first-child +li+li       /* {width:20%; height: 40px;}*/ /*작성일 열 크기*/
        #ulTable > li > ul > button > li:first-child +li+li+li, #ulTablebar > li > ul > li:first-child +li+li+li     /*{width:20%; height: 40px;}*/ /*작성자 열 크기*/
        #ulTable > li > ul > button > li:first-child +li+li+li+li, #ulTablebar > li > ul > li:first-child +li+li+li+li/*{width:10%; height: 40px;}*/ /*조회수 열 크기*/

       /* #ulTable > li > ul > button > li:first-child               {width:10%; height: 40px; background-color: whitesmoke;} !*No 열 크기*!
        #ulTable > li > ul > button > li:first-child +li           {width:40%; height: 40px; background-color: whitesmoke;} !*제목 열 크기*!
        #ulTable > li > ul > button > li:first-child +li+li        {width:20%; height: 40px; background-color: whitesmoke;} !*작성일 열 크기*!
        #ulTable > li > ul > button > li:first-child +li+li+li     {width:20%; height: 40px; background-color: whitesmoke;} !*작성자 열 크기*!
        #ulTable > li > ul > button > li:first-child +li+li+li+li  {width:10%; height: 40px; background-color: whitesmoke;} *//*조회수 열 크기*/
  /*      .accordion-button{
            color: whitesmoke;
        }*/
        .headacco {
            padding: 0px;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>
        $(function (){
            let cate = '${param.category}';
            if(cate == '정기구독'){
                document.querySelector("input[type=radio].subsCate").checked = true;
                let checkedValue = document.querySelector('input[name="subsCate"]:checked').value;
            }
            if(cate == '꽃다발'){
                document.querySelector("input[type=radio].flowerCate").checked = true;
                let checkedValue = document.querySelector('input[name="flowerCate"]:checked').value;
            }
            if(cate == '클래스'){
                document.querySelector("input[type=radio].fClassCate").checked = true;
                let checkedValue = document.querySelector('input[name="fClassCate"]:checked').value;
            }
            if(cate == '소품샵'){
                document.querySelector("input[type=radio].productCate").checked = true;
                let checkedValue = document.querySelector('input[name="productCate"]:checked').value;
            }
            if(cate == ''){
                document.querySelector("input[type=radio]").checked = true;
                let checkedValue = document.querySelector('input[name="allReviewCate"]:checked').value;
            }


                // $("input:radio[name='allReviewCate']:radio[value='']").prop('checked', true);
                // let checkedValue = document.querySelector('input[id="allReviewCate"]:checked').val;
                // document.getElementsBy('allReviewCate').checked = true;
            // document.querySelector("input[type=radio].star"+numStar).checked = true;
            // let checkedValue = document.querySelector('input[name="comment"]:checked').value;
        });
    </script>
</head>
<body>
<%@ include file="../main/header.jspf" %>
<div id="container" class="mx-auto">
<%--    <div class="fs-2 mt-5 mb-3">
        리뷰게시판
    </div>--%>

    <!-- 카테고리 탭 (라디오버튼) -->
<%--    <div class="d-flex align-items-baseline review-category col-12 justify-content-around">
        <label>
            <input type="radio" name="reviewCategory" class="d-none" checked="" onclick="location.href='/community/goReview'">
            <span class="d-block text-center py-3 px-5 btn-rev">전체</span>
        </label>
        <label>
            <input type="radio" name="reviewCategory" class="d-none" onclick="switchCategory('#bestReview', '#thisReview')">
            <span class="d-block text-center py-3 px-5 btn-rev">꽃 정기구독</span>
        </label>
        <label>
            <input type="radio" name="reviewCategory" class="d-none" onclick="switchCategory('#bestReview', '#thisReview')">
            <span class="d-block text-center py-3 px-5 btn-rev">꽃다발</span>
        </label>
        <label>
            <input type="radio" name="reviewCategory" class="d-none" onclick="switchCategory('#bestReview', '#thisReview')">
            <span class="d-block text-center py-3 px-5 btn-rev">소품샵</span>
        </label>
    </div> --%><!-- 카테고리 탭 닫기 -->
    <!-- 검색 폼 영역 -->
    <div class="nav">
    <div class="col d-flex col-8 fs-2 mt-5 mb-3">
        리뷰게시판
    </div>

    <div class="col d-flex justify-content-end">

        <form id="review-form" class="d-flex" method="post">
            <ul>
                <li id='liSearchOption' class="col list-group list-group-horizontal nav-item pt-5">
                    <div class="row mx-3">
                        <input class="form-control" type="search" placeholder="Search" aria-label="Search" name="search" autocomplete="off">
                    </div>
                    <div class="">
                        <button class="btn btn-outline-dark" type="button" onclick="goSearch(this.form)">검색</button>
                    </div>
                </li>
            </ul>
        </form>
    </div>
    </div>
    <div class="d-flex align-items-baseline review-category col-12 justify-content-around mt-0">
        <label>
            <input type="radio" name="allReviewCate" class="d-none tabCategory allReviewCate" id="allReviewCate" onclick="location.href='/community/goReview'">
            <span class="d-block text-center py-3 px-5 btn-rev">전체</span>
        </label>
        <label>
            <input type="radio" name="subsCate" class="d-none tabCategory subsCate" id="subsCate" onclick="goCateBest('정기구독')">
            <span class="d-block text-center py-3 px-5 btn-rev">꽃 정기구독</span>
        </label>
        <label>
            <input type="radio" name="flowerCate" class="d-none tabCategory flowerCate" id="flowerCate" onclick="goCateBest('꽃다발')">
            <span class="d-block text-center py-3 px-5 btn-rev">꽃다발</span>
        </label>
        <label>
            <input type="radio" name="fClassCate" class="d-none tabCategory fClassCate" id="fClassCate" onclick="goCateBest('클래스')">
            <span class="d-block text-center py-3 px-5 btn-rev">클래스</span>
        </label>
        <label>
            <input type="radio" name="productCate" class="d-none tabCategory productCate" id="productCate" onclick="goCateBest('소품샵')">
            <span class="d-block text-center py-3 px-5 btn-rev">소품샵</span>
        </label>
    </div> <!-- 카테고리 탭 닫기 -->








    <!----------------동호 작업분----------------------->
    <div id="mainWrapper" class="pt-2">
       <ul>
            <!-- 게시판 제목 -->
<%--            <li>리뷰 게시판</li>--%>
<%--            <!-- 게시판 목록  -->--%>
<%--            <li>--%>

                <%--전체 정기구독 꽃다발 --- 탭 --%>
               <%-- <ul class="nav nav-pills nav-justified">
                    <li class="nav-item align-items-baseline review-category justify-content-around">
                        <a class="btn-rev" href="/community/goReview">전체</a>
                    </li>
                    <li class="nav-item align-items-baseline review-category justify-content-around">
&lt;%&ndash;                            <a href="#" onclick='goAllList("best", "정기구독")'>정기구독</a>&ndash;%&gt;
                        <a class="btn-rev" href="#" onclick='goCateBest("정기구독")'>정기구독</a>
                    </li>
                    <li class="nav-item align-items-baseline review-category justify-content-around">
&lt;%&ndash;                            <a href="#" onclick='goAllList("best", "꽃다발")'>꽃다발</a>&ndash;%&gt;
                        <a class="btn-rev" href="#" onclick='goCateBest("꽃다발")'>꽃다발</a>
                    </li>
                    <li class="nav-item align-items-baseline review-category justify-content-around">
&lt;%&ndash;                            <a href="#" onclick='goAllList("best", "클래스")'>클래스</a>&ndash;%&gt;
                        <a class="btn-rev" href="#" onclick='goCateBest("클래스")'>클래스</a>
                    </li>
                    <li class="nav-item align-items-baseline review-category justify-content-around">
&lt;%&ndash;                            <a href="#" onclick='goAllList("best", "소품샵")'>소품샵</a>&ndash;%&gt;
                        <a class="btn-rev" href="#" onclick='goCateBest("소품샵")'>소품샵</a>
                    </li>

                </ul>--%>
                <ul class="nav justify-content-around reviewBox col-12 pt-4" id="review-bar">
                    <li id="best" class="nav-item-3 btn btn-warning btn-outline-warning col-6 pe-1">
                        <a class="nav-link text-dark" id="${param.category}" href="#" onclick='goBestList("best", "${param.category}")'>베스트 리뷰</a>
                    </li>
                    <li id="all" class="nav-item-3 btn btn-outline-warning col-6 ps-1">
                        <a class="nav-link text-dark" id="${param.category}" href="#" onclick='goAllList("allList", "${param.category}")'>전체리뷰</a>
                    </li>
                </ul>
           <div class="pt-3">
                <span id ="ulTablebar">
                    <li>
                        <ul class="d-flex col-12 text-center px-0 ps-0">
                                    <li class="col-2 btn titleBtn text-light">별점</li>
                                    <li class="col-4 btn titleBtn text-light">제목</li>
                                    <li class="col-2 btn titleBtn text-light">작성일</li>
                                    <li class="col-2 btn titleBtn text-light">작성자</li>
                                    <li class="col-2 btn titleBtn text-light">좋아요</li>
                        </ul>
                    </li>
                </span>
           </div>
                    <!-- 게시물이 출력될 영역 -->
                <div id="ulTable" class="accordion accordion-flush">
                    <c:forEach var="bestAllList" items="${bestRList}">
                    <span class='allBoxes accordion-item'>
                        <ul id="head${bestAllList.idx}" class="accordion-header headacco col-12 text-center ps-0 pe-1">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#col${bestAllList.idx}" aria-expanded="false" aria-controls="col${bestAllList.idx}">
                                <li class="justify-content-center col-2">
                                    <div class="my-auto">
                                        <c:if test="${bestAllList.star eq 5}">
                                            <i class="fas fa-star text-warning"></i>
                                            <i class="fas fa-star text-warning"></i>
                                            <i class="fas fa-star text-warning"></i>
                                            <i class="fas fa-star text-warning"></i>
                                            <i class="fas fa-star text-warning"></i>
                                        </c:if>
                                        <c:if test="${bestAllList.star eq 4}">
                                            <i class="fas fa-star text-warning"></i>
                                            <i class="fas fa-star text-warning"></i>
                                            <i class="fas fa-star text-warning"></i>
                                            <i class="fas fa-star text-warning"></i>
                                            <i class="far fa-star text-warning"></i>
                                        </c:if>

                                        <c:if test="${bestAllList.star eq 3}">
                                            <i class="fas fa-star text-warning"></i>
                                            <i class="fas fa-star text-warning"></i>
                                            <i class="fas fa-star text-warning"></i>
                                            <i class="far fa-star text-warning"></i>
                                            <i class="far fa-star text-warning"></i>
                                        </c:if>
                                        <c:if test="${bestAllList.star eq 2}">
                                            <i class="fas fa-star text-warning"></i>
                                            <i class="fas fa-star text-warning"></i>
                                            <i class="far fa-star text-warning"></i>
                                            <i class="far fa-star text-warning"></i>
                                            <i class="far fa-star text-warning"></i>
                                        </c:if>
                                        <c:if test="${bestAllList.star eq 1}">
                                            <i class="fas fa-star text-warning"></i>
                                            <i class="far fa-star text-warning"></i>
                                            <i class="far fa-star text-warning"></i>
                                            <i class="far fa-star text-warning"></i>
                                            <i class="far fa-star text-warning"></i>
                                        </c:if>
                                        <c:if test="${bestAllList.star eq 0}">
                                            <i class="far fa-star text-warning"></i>
                                            <i class="far fa-star text-warning"></i>
                                            <i class="far fa-star text-warning"></i>
                                            <i class="far fa-star text-warning"></i>
                                            <i class="far fa-star text-warning"></i>
                                        </c:if>
                                    </div>
                                </li>
                                <li class="d-flex justify-content-center col-4"><span class="d-flex my-auto">${bestAllList.name}</span></li>
                                <li class="d-flex justify-content-center col-2"><span class="d-flex my-auto">${bestAllList.regDate}</span></li>
                                <c:set var = "member_id" value = "${fn:substring(bestAllList.memberId, 0, 4)}" />
                                <li class="d-flex justify-content-center idCut col-2"><span class="d-flex my-auto">${member_id}***</span></li>
                                <li class="d-flex justify-content-center col-2"><span class="d-flex my-auto">${bestAllList.likeCount}</span></li>
                            </button>
                        </ul>

                        <div id="col${bestAllList.idx}" class="accordion-collapse collapse" aria-labelledby="head${bestAllList.idx}" data-bs-parent="#ulTable">
                            <div class="accordion-body">
                                <div class="d-flex justify-content-center">
                                    <p>${bestAllList.content}</p>
                                </div>

                                <div class="d-flex justify-content-center">
                                    <c:if test="${not empty bestAllList.image}">
                                        <div>
                                            <img src="${bestAllList.image}" alt="사진" style="max-width: 450px">
                                        </div>
                                    </c:if>
                                </div>
                                    <div class="d-flex justify-content-end">
                                        <c:if test="${bestAllList.hasReview}">
                                        <button class="btn like"
                                                onclick="goLike('${member.id}', '${bestAllList.idx}')"><i class="fas fa-thumbs-up text-dark fa-2x"></i>
                                        </button>
                                        </c:if>
                                        <c:if test="${!bestAllList.hasReview}">
                                            <button class="btn like"
                                                    onclick="goLike('${member.id}', '${bestAllList.idx}')"><i class="far fa-thumbs-up text-dark fa-2x"></i>
                                            </button>
                                        </c:if>
                                    </div>
                                <div class="d-flex justify-content-center">
                                    <c:if test="${member.id == bestAllList.memberId || member.id == 'admin' || admin.id == 'admin'}">
                                            <button type="button" class="btn btn-secondary mx-2"
                                                    onclick="goUpdate(this.form, ${bestAllList.idx})">수정
                                            </button>
                                            <button type="button" class="btn btn-outline-danger"
                                                    onclick="goDelete(${bestAllList.idx})">삭제
                                            </button>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </span>
                    </c:forEach>
                </div>
            </li>
            <li>
            </li>
        </ul>
       <button id="searchMoreNotify" class="btn btn-outline-primary btn-block col-sm-10 mx-auto" style="display: none">더 보기</button>
   </div>
</div> <!-- #container 닫기 -->

<%@ include file="../main/footer.jspf"%>
</body>
<script>
    // $(".like").click(function (){
    //     if($(this).children().hasClass("far")){
    //         $(this).children().removeClass("far");
    //         $(this).children().addClass("fas");
    //     } else{
    //         $(this).children().removeClass("fas");
    //         $(this).children().addClass("far");
    //     }
    //
    // });

    // $(function (){
    //     let cutid = $('.idCut').text().substring(0,4);
    //     console.log(cutid);
    //     // $('.idCut').text() = string.substr(0,4);
    //
    // });
    function goUpdate(form, reviewIdx) {
       location.href = "/community/event/updateWrite?reviewIdx=" + reviewIdx;
    }

    function goLike(memberId, reviewIdx, bt) {
        if(memberId == null || memberId == ''){
            alert("로그인이 필요합니다.");
            return;
        }
        if($("this").children("button").hasClass("fas")){
        }
        if($("this").children("button").hasClass("far")){
        }
        if($(this).hasClass("toggleStyle")) {
            $(this).removeClass("toggleStyle");
        }
        let data = {"memberId": memberId, "reviewIdx": reviewIdx};
        $.ajax({
            url: '/admin/question/likeCheck',
            type: 'get',
            dataType: 'json',
            data: data,
            success: function (result){
                location.reload();
            }
        });

    }

    function goCateBest(category) {
        location.href="/community/category/goReview?category="+category;
    }

    function goSearch(form) {
        let listList = new Array();
<%--        <c:forEach items="${likeList}" var="like">--%>
<%--        listList.push({idx: ${like.idx}--%>
<%--            ,reviewIdx: ${like.reviewIdx}--%>
<%--            ,memberId: "${like.memberId}"});--%>
<%--        </c:forEach>--%>
        // for(let i=0;i<listList.length; i++){
        //     console.log(listList[i].idx);
        //     console.log(listList[i].memberId);
        //     console.log(listList[i].reviewIdx);
        // }
        let formData = $(form).serialize();
            // new FormData(document.querySelector('#review-form'));
            // $(form).serialize();
        let id = '${member.id}';
        let adminId = '${admin.id}';
        $.ajax({
            url: '/question/searchReview',
            type: 'post',
            dataType: 'json',
            data: formData,
            // processData: false,
            // contentType: false,
            success: function (result){
                console.log(result);
                let resultBar = "";
                let ultable = "";
                let dispHtml = "";
                resultBar += '<li class="nav-item-3 btn btn-outline-warning col-6 pe-1">'
                    + '<span class="nav-link text-dark">검색결과</span>'
                    + '</li>';

                ultable += '<div class="pt-3">'
                + '<span id="ulTablebar">'
                + '<ul class="d-flex col-12 text-center px-0">'
                + '<li class="col-2 btn titleBtn text-light">별점</li>'
                + '<li class="col-4 btn titleBtn text-light">제목</li>'
                + '<li class="col-2 btn titleBtn text-light">작성일</li>'
                + '<li class="col-2 btn titleBtn text-light">작성자</li>'
                + '<li class="col-2 btn titleBtn text-light">좋아요</li>'
                + '</ul></span></div>';
                 // '<li> <ul> <li>별점</li> <li>제목</li> <li>작성일</li> <li>작성자</li> <li>좋아요</li> </ul> </li>';
                if(result.length < 1){
                    dispHtml += '<div class="col fs-2 mt-5 mb-3 text-center">검색결과가 없습니다.</div>';
                }
                $.each(result, function (i, item) {
                    dispHtml += '<span class="allBoxes accordion-item">';
                    dispHtml +=   '<ul id="head' + this.idx + '" class="accordion-header headacco col-12 text-center ps-0 pe-1">';
                    dispHtml += '<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#col' + this.idx + '" aria-expanded="false" aria-controls="col' + this.idx + '">'
                    dispHtml +=   '<li class="justify-content-center col-2"><div class="my-auto">';

                    if(this.star == 5){
                        dispHtml += '<i class="fas fa-star text-warning"></i>'
                            + '<i class="fas fa-star text-warning"></i>'
                            + '<i class="fas fa-star text-warning"></i>'
                            + '<i class="fas fa-star text-warning"></i>'
                            + '<i class="fas fa-star text-warning"></i>';
                    }
                    if(this.star == 4){
                        dispHtml += '<i class="fas fa-star text-warning"></i>'
                            + '<i class="fas fa-star text-warning"></i>'
                            + '<i class="fas fa-star text-warning"></i>'
                            + '<i class="fas fa-star text-warning"></i>'
                            + '<i class="far fa-star text-warning"></i>';
                    }
                    if(this.star == 3){
                        dispHtml += '<i class="fas fa-star text-warning"></i>'
                            + '<i class="fas fa-star text-warning"></i>'
                            + '<i class="fas fa-star text-warning"></i>'
                            + '<i class="far fa-star text-warning"></i>'
                            + '<i class="far fa-star text-warning"></i>';
                    }
                    if(this.star == 2){
                        dispHtml += '<i class="fas fa-star text-warning"></i>'
                            + '<i class="fas fa-star text-warning"></i>'
                            + '<i class="far fa-star text-warning"></i>'
                            + '<i class="far fa-star text-warning"></i>'
                            + '<i class="far fa-star text-warning"></i>';
                    }
                    if(this.star == 1){
                        dispHtml += '<i class="fas fa-star text-warning"></i>'
                            + '<i class="far fa-star text-warning"></i>'
                            + '<i class="far fa-star text-warning"></i>'
                            + '<i class="far fa-star text-warning"></i>'
                            + '<i class="far fa-star text-warning"></i>';
                    }
                    if(this.star == 0){
                        dispHtml += '<i class="far fa-star text-warning"></i>'
                            + '<i class="far fa-star text-warning"></i>'
                            + '<i class="far fa-star text-warning"></i>'
                            + '<i class="far fa-star text-warning"></i>'
                            + '<i class="far fa-star text-warning"></i>';
                    }

                    dispHtml += '</div></li>';

                    dispHtml +=   '<li class="d-flex justify-content-center col-4"><span class="d-flex my-auto"><span class="d-flex my-auto">' + this.name + '</span></li>'
                        + '<li class="d-flex justify-content-center col-2"><span class="d-flex my-auto">' + this.regDate + '</span></li>'
                        + '<li class="d-flex justify-content-center idCut col-2"><span class="d-flex my-auto">' +this.memberId.substring(0,4) + '***</span></li>'
                        + '<li class="d-flex justify-content-center col-2"><span class="d-flex my-auto">' +  this.likeCount + '</span></li></<button>'
                        + '</ul>'

                        + '<div id="col' + this.idx + '" class="accordion-collapse collapse" aria-labelledby="head' + this.idx + '" data-bs-parent="#ulTable">'
                        + '<div class="accordion-body">'
                        + '<div class="d-flex justify-content-center">'
                        +   '<p>' + item.content + '</p>'
                        + '</div>'

                        + '<div class="d-flex justify-content-center">';
                    if(this.image != null) {
                        dispHtml += '<div>'
                            + '<img src="' + this.image + '" alt="사진">'
                            + '</div>';
                    }
                    dispHtml += "</div>";

                    dispHtml += '<div class="d-flex justify-content-end">';
                    if(this.hasReview){
                        dispHtml += '<button class="btn" onclick="goLike(`' + id + '`, ' + this.idx + ')"><i class="fas fa-thumbs-up text-dark fa-2x"></i></button>';
                    } else {
                        dispHtml += '<button class="btn" onclick="goLike(`' + id + '`, `' + this.idx + '`)"><i class="far fa-thumbs-up text-dark fa-2x"></i></button>';
                    }
                    dispHtml += '</div>'
                        + '<div class="d-flex justify-content-center">';
                    if(this.memberId == id || adminId == 'admin'){
                        dispHtml += '<button type="button" class="btn btn-secondary mx-2"'
                            + 'onclick="goUpdate(this.form,' + this.idx + ')">수정'
                            + '</button>'
                            + '<button type="button" class="btn btn-outline-danger"'
                            + 'onclick="goDelete(' + this.idx + ')">삭제'
                            + '</button>';
                    }
                    dispHtml += '</div>';

                    dispHtml += "</div></div></li>";
                });
                $("#review-bar").html(resultBar);
                $("#ulTablebar").html(ultable);
                $("#ulTable").html(dispHtml);
            }
        });

    }

    function goAllList(tab, paramType) {
        $("#all").addClass('btn-warning');
        $("#best").removeClass('btn-warning')
        $('.allBoxes').remove();
        $("#searchMoreNotify").css("display", "block");
        let startIndex = 1;	// 인덱스 초기값
        let searchStep = 5;	// 5개씩 로딩
        let _endIndex = 5;
        goApiAllList(startIndex, searchStep, _endIndex);
        // $(".accordion_count").css("display", "none");
    }

    function goApiAllList(startIndex, searchStep, _endIndex){
        // 읽은 알림 총 갯수
        let oldListCnt = '${oldListCnt}';
        console.log('${oldListCnt}');

        // 조회 인덱스
        // let startIndex = 1;	// 인덱스 초기값
        // let searchStep = 1;	// 5개씩 로딩

        // 페이지 로딩 시 첫 실행
        readOldNotify(startIndex, _endIndex);

        // $(".accordion_count").css("display", "none");

        // 더보기 클릭시
        $('#searchMoreNotify').click(function(e){
            e.stopPropagation();
            e.preventDefault();
            e.stopImmediatePropagation();
            startIndex = 1;
            _endIndex += searchStep;	// endIndex설정



            console.log(startIndex + "클릭할떄 발생" + searchStep);
            readOldNotify(startIndex, _endIndex);
            if(_endIndex >= oldListCnt){
                $("#searchMoreNotify").css("display", "none");
            }
            // $(".accordion_count").css("display", "none");
        });

        // 더보기 실행함수 **
        function readOldNotify(index, _endIndex){
            let listList = new Array();
            <c:forEach items="${likeList}" var="like">
            listList.push({idx: ${like.idx}
                ,reviewIdx: ${like.reviewIdx}
                ,memberId: "${like.memberId}"});
            </c:forEach>
            for(let i=0;i<listList.length; i++){
                console.log(listList[i].idx);
                console.log(listList[i].memberId);
                console.log(listList[i].reviewIdx);
            }
            // _endIndex = index+searchStep-1;	// endIndex설정
            // $(".accordion_count").css("display", "none");
            let id = '${member.id}';
            let adminId = '${admin.id}';
            console.log(index + "index");
            console.log(searchStep + "search")
            console.log(_endIndex + "_endIndex");
            $.ajax({
                type: "post",
                async: "true",
                dataType: "json",
                data: {
                    category : '${category}',
                    startIndex: index,
                    endIndex: _endIndex
                },
                url: "/community/api/category/goAllReview",
                success: function (result) {
                    console.dir(result);
                    let dispHtml = "";
                    $.each(result, function (i, item) {
                        dispHtml += '<span class="allBoxes accordion-item">';
                        dispHtml +=   '<ul id="head' + this.idx + '" class="accordion-header headacco col-12 text-center ps-0 pe-1">';
                        dispHtml += '<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#col' + this.idx + '" aria-expanded="false" aria-controls="col' + this.idx + '">'
                        dispHtml +=   '<li class="justify-content-center col-2"><div class="my-auto">';

                        if(this.star == 5){
                            dispHtml += '<i class="fas fa-star text-warning"></i>'
                                + '<i class="fas fa-star text-warning"></i>'
                                + '<i class="fas fa-star text-warning"></i>'
                                + '<i class="fas fa-star text-warning"></i>'
                                + '<i class="fas fa-star text-warning"></i>';
                        }
                        if(this.star == 4){
                            dispHtml += '<i class="fas fa-star text-warning"></i>'
                                + '<i class="fas fa-star text-warning"></i>'
                                + '<i class="fas fa-star text-warning"></i>'
                                + '<i class="fas fa-star text-warning"></i>'
                                + '<i class="far fa-star text-warning"></i>';
                        }
                        if(this.star == 3){
                            dispHtml += '<i class="fas fa-star text-warning"></i>'
                                + '<i class="fas fa-star text-warning"></i>'
                                + '<i class="fas fa-star text-warning"></i>'
                                + '<i class="far fa-star text-warning"></i>'
                                + '<i class="far fa-star text-warning"></i>';
                        }
                        if(this.star == 2){
                            dispHtml += '<i class="fas fa-star text-warning"></i>'
                                + '<i class="fas fa-star text-warning"></i>'
                                + '<i class="far fa-star text-warning"></i>'
                                + '<i class="far fa-star text-warning"></i>'
                                + '<i class="far fa-star text-warning"></i>';
                        }
                        if(this.star == 1){
                            dispHtml += '<i class="fas fa-star text-warning"></i>'
                                + '<i class="far fa-star text-warning"></i>'
                                + '<i class="far fa-star text-warning"></i>'
                                + '<i class="far fa-star text-warning"></i>'
                                + '<i class="far fa-star text-warning"></i>';
                        }
                        if(this.star == 0){
                            dispHtml += '<i class="far fa-star text-warning"></i>'
                                + '<i class="far fa-star text-warning"></i>'
                                + '<i class="far fa-star text-warning"></i>'
                                + '<i class="far fa-star text-warning"></i>'
                                + '<i class="far fa-star text-warning"></i>';
                        }

                        dispHtml += '</div></li>';

                        dispHtml +=   '<li class="d-flex justify-content-center col-4"><span class="d-flex my-auto"><span class="d-flex my-auto">' + this.name + '</span></li>'
                            + '<li class="d-flex justify-content-center col-2"><span class="d-flex my-auto">' + this.regDate + '</span></li>'
                            + '<li class="d-flex justify-content-center idCut col-2"><span class="d-flex my-auto">' +this.memberId.substring(0,4) + '***</span></li>'
                            + '<li class="d-flex justify-content-center col-2"><span class="d-flex my-auto">' +  this.likeCount + '</span></li></<button>'
                            + '</ul>'

                            + '<div id="col' + this.idx + '" class="accordion-collapse collapse" aria-labelledby="head' + this.idx + '" data-bs-parent="#ulTable">'
                            + '<div class="accordion-body">'
                            + '<div class="d-flex justify-content-center">'
                            +   '<p>' + item.content + '</p>'
                            + '</div>'

                            + '<div class="d-flex justify-content-center">';
                        if(this.image != null) {
                            dispHtml += '<div>'
                                + '<img src="' + this.image + '" alt="사진">'
                                + '</div>';
                        }
                        dispHtml += "</div>";

                        dispHtml += '<div class="d-flex justify-content-end">';
                        if(this.hasReview){
                            dispHtml += '<button class="btn" onclick="goLike(`' + id + '`, ' + this.idx + ')"><i class="fas fa-thumbs-up text-dark fa-2x"></i></button>';
                        } else {
                            dispHtml += '<button class="btn" onclick="goLike(`' + id + '`, `' + this.idx + '`)"><i class="far fa-thumbs-up text-dark fa-2x"></i></button>';
                        }
                        dispHtml += '</div>'
                            + '<div class="d-flex justify-content-center">';
                        if(this.memberId == id || adminId == 'admin'){
                            dispHtml += '<button type="button" class="btn btn-secondary mx-2"'
                                + 'onclick="goUpdate(this.form,' + this.idx + ')">수정'
                                + '</button>'
                                + '<button type="button" class="btn btn-outline-danger"'
                                + 'onclick="goDelete(' + this.idx + ')">삭제'
                                + '</button>';
                        }
                        dispHtml += '</div>';

                        dispHtml += "</div></div></li>";
                    });

                    // $(dispHtml).html("#ulTable");
                    $("#ulTable").html(dispHtml);
                                      // 더보기 버튼 삭제
                    if(_endIndex > oldListCnt){
                        $("#searchMoreNotify").css("display", "none");
                    }
                    //$(".accordion_count").css("display", "none");

                    // $(".accordion ul").click(function(){
                    //     $(this).next(".accordion_count").slideToggle("fast")
                    //         .siblings(".accordion_count:visible").slideUp("fast")
                    //     $(this).stop().toggleClass("active");
                    // });
                }
            });
        }
    }


    function goBestList(tab, paramType) {
        $("#best").addClass('btn-warning');
        $("#all").removeClass('btn-warning')
        // for(let i=0;i<listList.length; i++){
        //     console.log(listList[i].idx);
        //     console.log(listList[i].memberId);
        //     console.log(listList[i].reviewIdx);
        // }
        $("#searchMoreNotify").css("display", "none");
        let id = '${member.id}';
        let adminId = '${admin.id}';
        let dataParam = {
            category : paramType
        };
        $.ajax({
            url: '/community/api/category/goBestReview',
            type: 'post',
            dataType: "json",
            data: dataParam,
            success: function (result) {
               let dispHtml = "";
                $.each(result, function (i, item) {
                    dispHtml += '<span class="allBoxes accordion-item">';
                    dispHtml +=   '<ul id="head' + this.idx + '" class="accordion-header headacco col-12 text-center ps-0 pe-1">';
                    dispHtml += '<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#col' + this.idx + '" aria-expanded="false" aria-controls="col' + this.idx + '">'
                    dispHtml +=   '<li class="justify-content-center col-2"><div class="my-auto">';

                    if(this.star == 5){
                        dispHtml += '<i class="fas fa-star text-warning"></i>'
                            + '<i class="fas fa-star text-warning"></i>'
                            + '<i class="fas fa-star text-warning"></i>'
                            + '<i class="fas fa-star text-warning"></i>'
                            + '<i class="fas fa-star text-warning"></i>';
                    }
                    if(this.star == 4){
                        dispHtml += '<i class="fas fa-star text-warning"></i>'
                            + '<i class="fas fa-star text-warning"></i>'
                            + '<i class="fas fa-star text-warning"></i>'
                            + '<i class="fas fa-star text-warning"></i>'
                            + '<i class="far fa-star text-warning"></i>';
                    }
                    if(this.star == 3){
                        dispHtml += '<i class="fas fa-star text-warning"></i>'
                            + '<i class="fas fa-star text-warning"></i>'
                            + '<i class="fas fa-star text-warning"></i>'
                            + '<i class="far fa-star text-warning"></i>'
                            + '<i class="far fa-star text-warning"></i>';
                    }
                    if(this.star == 2){
                        dispHtml += '<i class="fas fa-star text-warning"></i>'
                            + '<i class="fas fa-star text-warning"></i>'
                            + '<i class="far fa-star text-warning"></i>'
                            + '<i class="far fa-star text-warning"></i>'
                            + '<i class="far fa-star text-warning"></i>';
                    }
                    if(this.star == 1){
                        dispHtml += '<i class="fas fa-star text-warning"></i>'
                            + '<i class="far fa-star text-warning"></i>'
                            + '<i class="far fa-star text-warning"></i>'
                            + '<i class="far fa-star text-warning"></i>'
                            + '<i class="far fa-star text-warning"></i>';
                    }
                    if(this.star == 0){
                        dispHtml += '<i class="far fa-star text-warning"></i>'
                            + '<i class="far fa-star text-warning"></i>'
                            + '<i class="far fa-star text-warning"></i>'
                            + '<i class="far fa-star text-warning"></i>'
                            + '<i class="far fa-star text-warning"></i>';
                    }

                    dispHtml += '</div></li>';

                    dispHtml +=   '<li class="d-flex justify-content-center col-4"><span class="d-flex my-auto"><span class="d-flex my-auto">' + this.name + '</span></li>'
                        + '<li class="d-flex justify-content-center col-2"><span class="d-flex my-auto">' + this.regDate + '</span></li>'
                        + '<li class="d-flex justify-content-center idCut col-2"><span class="d-flex my-auto">' +this.memberId.substring(0,4) + '***</span></li>'
                        + '<li class="d-flex justify-content-center col-2"><span class="d-flex my-auto">' +  this.likeCount + '</span></li></<button>'
                        + '</ul>'

                        + '<div id="col' + this.idx + '" class="accordion-collapse collapse" aria-labelledby="head' + this.idx + '" data-bs-parent="#ulTable">'
                        + '<div class="accordion-body">'
                        + '<div class="d-flex justify-content-center">'
                        +   '<p>' + item.content + '</p>'
                        + '</div>'

                        + '<div class="d-flex justify-content-center">';
                    if(this.image != null) {
                        dispHtml += '<div>'
                            + '<img src="' + this.image + '" alt="사진">'
                            + '</div>';
                    }
                    dispHtml += "</div>";

                    dispHtml += '<div class="d-flex justify-content-end">';
                    if(this.hasReview){
                        dispHtml += '<button class="btn" onclick="goLike(`' + id + '`, ' + this.idx + ')"><i class="fas fa-thumbs-up text-dark fa-2x"></i></button>';
                    } else {
                        dispHtml += '<button class="btn" onclick="goLike(`' + id + '`, `' + this.idx + '`)"><i class="far fa-thumbs-up text-dark fa-2x"></i></button>';
                    }
                    dispHtml += '</div>'
                        + '<div class="d-flex justify-content-center">';
                    if(this.memberId == id || adminId == 'admin'){
                        dispHtml += '<button type="button" class="btn btn-secondary mx-2"'
                            + 'onclick="goUpdate(this.form,' + this.idx + ')">수정'
                            + '</button>'
                            + '<button type="button" class="btn btn-outline-danger"'
                            + 'onclick="goDelete(' + this.idx + ')">삭제'
                            + '</button>';
                    }
                    dispHtml += '</div>';

                    dispHtml += "</div></div></span>";
                });
                $("#ulTable").html(dispHtml);
            }
        });
    }
    function goDelete(idx) {
        location.href="/community/category/deleteReview?idx=" + idx;
    }
</script>

</html>