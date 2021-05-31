<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>새늘봄
        |1:1 문의</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ include file="../main/import.jspf" %>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <style>

    </style>
</head>
<body>
<%@ include file="../main/header.jspf" %>
<div class="d-flex justify-content-center">
    <div id="container">
        <h3>1:1 문의</h3>
        <div class="my_epilogue_wrap">

            <!-- 1:1 문의 작성 폼 -->
            <div>
                <div class="epilogue_write_form inquiry">
                    <form id="question-form" method="post" enctype="multipart/form-data">
                        <div class="row g-3 align-items-center">
                            <div class="col-auto">
                                <label for="name" class="col-form-label">제목</label>
                            </div>
                            <div class="mb-3">
                                <input type="text" id="name" name="name" class="form-control" autocomplete="off">
                            </div>
                            <div class="col-auto">
                                <label for="content" class="col-form-label">내용</label>
                            </div>
                            <div class="mb-3">
                                <textarea class="form-control" placeholder="내용을 입력하세요. 주문번호를 입력하시면 정확한 답변이 가능합니다." id="content" name="content" style="height: 200px"></textarea>
                            </div>
                            <%--<input type="text" id="d" class="form-control">
                                        </div>--%>
                            <div class="mb-3">
                                <label for="file" class="form-label">이미지</label>
                                <input class="form-control" type="file" id="file" name="file">
                            </div>
                            <div class="form-check mb-3">
                                <div class="td"><span class="txt">답변 받기</span></div>
                                <input class="label checked" type="checkbox" value="1" id="emailSend" name="emailSend">
                                <label class="form-check-label" for="emailSend">E-Mail</label>
                            </div>
                            <div class="file-wrap">
                                <button type="button" class="btn btn-secondary" onclick="questionUpload()">등록하기</button>
                            </div>
                            <%--<div class="col-auto">
                                <span id="numnumline" class="form-text">
                                  주문번호
                                </span>
                            </div>--%>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="../main/footer.jspf"%>
</body>
<script>


    function questionUpload() {
        let formData = new FormData(document.querySelector("#question-form"));
            // $("#question-form").serialize();
        // let formData = $('form').serialize();
            // new FormData(document.querySelector("#question-form"));
            // $(form).serialize();
        $.ajax({
            url: '/admin/question/api/writeQuest',
            method: "post",
            processData: false,
            contentType: false,
            data: formData,
            dataType: "json",
            success: function(result) {
                // alert("result");
                location.href = "/myPage_faq_main";
            }
        });
    }

</script>
</html>
