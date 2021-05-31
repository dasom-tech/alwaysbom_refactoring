<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<html>
    <head>
        <title>이벤트</title>
        <%@ include file="../main/import.jspf"%>
        <link rel="stylesheet" href="../../../static/css/item/list.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    </head>
<body>
<%@ include file="../main/header.jspf" %>
<div class="big-image">
    <img src="${eventVo.image1}" alt="이벤트배너" class="col-12">
</div>

<div id="container" class="mx-auto mt-3">

    <div id="detail-area" class="mb-3 col-12 border-bottom">
        <div class="w-auto overflow-auto d-flex flex-column justify-content-center">${eventVo.content}</div>
    </div>
    <!-- Reply Form {s} -->
        <c:if test="${sessionScope.member != null}">
    <div class="my-3 p-3 bg-white rounded shadow-sm" style="padding-top: 10px">
        <form name="form" id="form" action="/community/eco/addEcomment" method="post">
            <div class="row">
                <div class="col-sm-10">
                    <textarea name="content" id="content" class="form-control" rows="3" placeholder="댓글을 입력해 주세요"></textarea>
                </div>
                <div class="col-sm-2">
                    <input type="hidden" id="memberId" name="memberId" value="${member.id}"/>
                    <input type="hidden" id="eventIdx" name="eventIdx" value="${eventVo.idx}">
                    <button type="submit" class="btn btn-sm btn-primary" id="btnReplyAdd" style="width: 100%; margin-top: 10px"> 저 장 </button>
                </div>
            </div>
        </form>
    </div>
        </c:if>
    <!-- Reply Form {e} -->
    <!-- Reply List {s}-->
    <div class="my-3 p-3 bg-white rounded shadow-sm" style="padding-top: 10px">
        <h6 class="border-bottom pb-2 mb-0">Reply list</h6>
        <div id="replyList">
            <c:if test="${empty ecoList}">
                <span>등록된 댓글이 없습니다.</span>
            </c:if>
            <c:forEach var="eco" items="${ecoList}">
<%--            <div class="media text-muted pt-3" id="${eco.idx}">--%>
<%--                <span class="bd-placeholder-img mr-2 rounded" width="32" height="32" focusable="false" role="img">--%>
<%--                    <i class="far fa-comment-dots"></i>--%>
<%--                </span>--%>
<%--                <p class="media-body pb-3 mb-0 small lh-125 border-bottom horder-gray">--%>
<%--                    <span class="d-block">--%>
<%--                        <strong class="text-gray-dark">${eco.memberId}</strong>--%>
<%--                        <span style="padding-left: 7px; font-size: 9pt;">--%>
<%--                            <button type="button" class="px-2 btn btn-sm btn-light" onclick="fn_editReply('${eco.idx}', '${eco.memberId}', '${eco.content}')">수정</button>--%>
<%--                            <button type="button" class="px-2 btn btn-sm btn-warning" onclick="fn_deleteReply('${eco.idx}')" >삭제</button>--%>
<%--                            <button type="button" class="px-2 btn-sm btn btn-danger" onclick="fn_reportReply('${eco.idx}')" >신고</button>--%>
<%--                        </span>--%>
<%--                    </span>--%>
<%--                    ${eco.content}--%>
<%--                </p>--%>
<%--            </div>--%>
            </c:forEach>
        </div>
    </div>
    <!-- Reply List {e}-->
</div>
<%@ include file="../main/footer.jspf" %>
</body>
<script>
    $(function (){
        showReplyList();
    });

    function showReplyList(){
        let memid = '${member.id}'
        let eid = '${eventVo.idx}'
        let eidx = {
            "idx": eid
        }
        let adminId = '${admin.id}'
        $.ajax({
            url: '/api/community/eco/ecommentList',
            data: eidx,
            type: 'post',
            dataType: 'json',
            success: function (result) {
                let htmls = '';
                if(result.length < 1) {
                    htmls += '<span>등록된 댓글이 없습니다.</span>';
                } else {
                    $(result).each(function(){
                        htmls += '<div class="media text-muted pt-3" id="idx-' + this.idx + '">'
                        + '<span class="bd-placeholder-img mr-2 rounded" width="32" height="32" focusable="false" role="img">'
                        +   '<i class="far fa-comment-dots"></i>'
                            + '<span>' + this.regDate + '</span>'
                        + '</span>'
                        + ' <p class="media-body pb-3 mb-0 small lh-125 border-bottom horder-gray">'
                        + '<span class="d-block">'
                        + '<strong class="text-gray-dark">' + this.memberId.substring(0,4) + '***</strong>'
                        + '<span id="eco-span" class="eco-span">';
                        if(memid == this.memberId || adminId == 'admin'){
                        htmls += '<button type="button" class="px-2 btn btn-sm btn-light" onclick="fn_editReply(`' + this.idx +'`, `' + this.memberId + '`, `' + this.content + '`)">수정</button>'
                        + '<button type="button" class="px-2 btn btn-sm btn-warning" onclick="fn_deleteReply(`' + this.idx + '`)" >삭제</button>';
                        }
                        htmls += '<button type="button" class="px-2 btn-sm btn btn-danger" onclick="fn_reportReply(`' + this.idx + '`)" >신고</button>';
                        htmls += '<span class="d-block">' + this.content + '</span>'
                        + '</sapn>'
                        + '</sapn>'
                        +    '</p>'
                        +'</div>';
                    });
                }
                $("#replyList").html(htmls);
            }
        });
    }
    function fn_editReply(idx, member_id, content) {
        let memid = '${member.id}';
        let eidx = {
            "idx": idx,
            "content": content,
            "memberId": memid

        }
        $.ajax({
            url: '/api/community/eco/ecommentUpdate',
            data: eidx,
            type: 'post',
            dataType: 'json',
            success: function (result) {
                let htmls = '';
                htmls += '<div class="media text-muted pt-3" id="idx-' + result.idx + '">'
                    + '<span class="bd-placeholder-img mr-2 rounded" width="32" height="32" focusable="false" role="img">'
                    +   '<i class="far fa-comment-dots"></i>'
                    + '</span>'
                    + '<p class="media-body pb-3 mb-0 small lh-125 border-bottom horder-gray">'
                    + '<span class="d-block">'
                    + '<strong class="text-gray-dark">' + memid + '</strong>'
                    + '<span id="eco-span" class="eco-span">'
                    + '<button type="button" class="px-2 btn btn-sm btn-light" onclick="fn_updateReply(`' + result.idx +'`)">수정</button>'
                    + '<button type="button" class="px-2 btn-sm btn btn-danger" onclick="showReplyList()" >취소</button>'
                    + '</sapn>'
                    + '</sapn>'
                    + '<textarea name="editContent" id="editContent" class="form-control" rows="3">' + result.content
                    + '</textarea>'
                    + '</p>'
                    + '</div>'
                $('#idx-' + idx).replaceWith(htmls);

                $('#idx-' + idx + ' #editContent').focus();
            }
        });
    }


    
    function fn_updateReply(rid){

        let memid = '${member.id}';
        let replyEditContent = $('#editContent').val();
        console.log(rid);
        console.log(replyEditContent);
        let sendData = {
            "idx": rid,
            "content": replyEditContent,
            "memberId": memid

        }

        $.ajax({
            url: '/api/community/eco/ecommentUpdateSend',
            data: sendData,
            type: 'post',
            dataType: 'json',
            success: function (result) {

                console.log(result);
                showReplyList();
            }
        });
    }

    function fn_deleteReply(rid){
        let memid = '${member.id}';
        let sendData = {
            "idx": rid,
            "memberId": memid
        };
        $.ajax({
            url: '/api/community/eco/ecommentDeleteSend',
            data: sendData,
            type: 'post',
            dataType: 'json',
            success: function (result) {
                console.log(result);
                showReplyList();
            }
        });
    }
    function fn_reportReply(idx) {
        let memid = '${member.id}';
        let sendData = {
            "idx": idx,
            "memberId": memid
        };
        $.ajax({
            url: '/api/community/eco/ecommentReport',
            data: sendData,
            type: 'post',
            dataType: 'json',
            success: function (result) {
                console.log(result);
                alert("게시글 확인 후 처리하겠습니다.")

                showReplyList();
            }
        });
    }

</script>
    <style>
        .big-image{
            width: 100vw;
        }
        .eco-span{
            padding-left: 7px; font-size: 9pt;
        }
    </style>
</html>
<%--width: 100vw; height: 800~1000px;--%>

<%--<div class="media text-muted pt-3" id="${eco.idx}">--%>
<%--                <span class="bd-placeholder-img mr-2 rounded" width="32" height="32" focusable="false" role="img">--%>
<%--                    <i class="far fa-comment-dots"></i>--%>
<%--                </span>--%>
<%--    <p class="media-body pb-3 mb-0 small lh-125 border-bottom horder-gray">--%>
<%--                    <span class="d-block">--%>
<%--                        <strong class="text-gray-dark">${eco.memberId}</strong>--%>
<%--                        <span style="padding-left: 7px; font-size: 9pt;">--%>
<%--                            <button type="button" class="px-2 btn btn-sm btn-light" onclick="fn_editReply('${eco.idx}', '${eco.memberId}', '${eco.content}')">수정</button>--%>
<%--                            <button type="button" class="px-2 btn btn-sm btn-warning" onclick="fn_deleteReply('${eco.idx}')" >삭제</button>--%>
<%--                            <button type="button" class="px-2 btn-sm btn btn-danger" onclick="fn_reportReply('${eco.idx}')" >신고</button>--%>
<%--                        </span>--%>
<%--                    </span>--%>
<%--        ${eco.content}--%>
<%--    </p>--%>
<%--</div>--%>
