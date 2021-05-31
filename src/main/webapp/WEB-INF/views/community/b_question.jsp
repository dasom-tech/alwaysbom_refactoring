<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>1:1</title>
    <%@ include file="../main/b_import.jspf" %>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <style>
        .bottom-line {
            border-bottom: 1px solid silver;
        }

        .toggleBtn {
            display: none;
        }

        .disflex {
            display: flex;
        }

        .checkpadding {
            padding-right: 120px;
        }

        .accoque:hover {
            background-color: #eaeaea;
            cursor: pointer;
        }

        .nopadding {
            padding: 0px;
        }

        @media (min-width: 1024px) {
            .reBoard {
                padding-right: 10px;
            }
        }
    </style>
    <script>



        $(function () {
            let answer = '${param.answer}';
            console.log(answer);
            if(answer == '' || answer == null){
                $("#goAnswer").removeClass("btn-dark");
                $("#goAnswer").removeClass("btn-light");
                $("#noAnswer").removeClass("btn-dark");
                $("#noAnswer").removeClass("btn-light");

                $("#noAnswer").addClass("btn-dark");
                $("#goAnswer").addClass("btn-light");
            }
            if(answer == 'answer'){
                $("#goAnswer").removeClass("btn-dark");
                $("#goAnswer").removeClass("btn-light");
                $("#noAnswer").removeClass("btn-dark");
                $("#noAnswer").removeClass("btn-light");
                $("#noAnswer").addClass("btn-light");
                $("#goAnswer").addClass("btn-dark");
            }

            if(${param.answer != 'answer'}){
                let angle = 0;
                angle += 180;
                $('.accoque').find('.checkv').css({'transform': 'rotate(' + angle + 'deg)'});
                $('.accoque').next(".toggleBtn").slideDown("fast");
            }

            $('.accoque').click(function () {
                let angle = 0;
                console.log(angle);

                if ($(this).next(".toggleBtn").is(":visible")) {
                    angle += 360;
                    // $(this).find('.checkv').rotate(angle);
                    $(this).find('.checkv').css({'transform': 'rotate(' + angle + 'deg)'});
                    $(this).next(".toggleBtn").slideUp("fast");
                } else {
                    // $(this).next(".toggleBtn").removeClass("d-none");
                    angle += 180;
                    $(this).find('.checkv').css({'transform': 'rotate(' + angle + 'deg)'});
                    $(this).next(".toggleBtn").slideDown("fast");
                }
            });
        });



    </script>
</head>
<body>
<%@ include file="../main/b_header.jspf" %>
<div class="d-flex justify-content-center">
    <div id="container" class="mx-auto">
        <h2>1:1 관리자 문의 게시판 입니다.</h2>
        <div class="mx-5">
            <ul class="nav justify-content-around reviewBox col-12 py-3">
                <li class="nav-item-3 col-6 px-2">
                    <a class="nav-link btn btn-dark" id="noAnswer" href="#" onclick='goAnswer("")'>미답변</a>
                </li>
                <li class="nav-item-3 col-6 px-2">
                    <a class="nav-link btn btn-dark" id="goAnswer" href="#" onclick='goAnswer("answer")'>답변</a>
                </li>
            </ul>


            <ul class="nav row table mx-auto">
                <li>
                    <div class="row row-cols-5 mx-auto bottom-line accoque reBoard nopadding">
                        <span class="text-center col-2 nopadding">번호</span>
                        <span class="text-center col-2 nopadding">작성일</span>
                        <span class="text-center col-5 nopadding">제목</span>
                        <span class="text-center col-2 nopadding">상태</span>
                        <span class="text-center col-1 nopadding"></span>
                    </div>

                </li>
                <c:forEach var="quList" items="${questlist}">
                    <li>

                        <div class="row row-cols-5 mx-auto bottom-line accoque reBoard nopadding">
                            <span class="text-center col-2 nopadding">${quList.idx}</span>
                            <span class="text-center col-2 nopadding">${quList.questionDate}</span>
                            <span class="text-center col-5 nopadding">${quList.name}</span>
                            <c:if test="${empty quList.answer}">
                                <span class="text-center col-2 nopadding">${quList.memberId}</span>
                            </c:if>
                            <c:if test="${not empty quList.answer}">
                                <span class="text-center col-2 nopadding">${quList.memberId}</span>
                            </c:if>
                            <span class="text-center col-1 nopadding"><img src="/static/icons/up.svg"
                                                                           class="rounded- mx-auto checkv" alt="V"
                                                                           title="V"></span>
                        </div>

                        <div class="row bottom-line text-center toggleBtn disflex" style="display: none">
                            <c:if test="${not empty quList.image}">
                                <div class="col">
                                    <img src="${quList.image}" class="rounded-" alt="questimg" title="문의사진" style="height: 400px; width: 600px;">
                                </div>
                            </c:if>
                            <div class="col">
                                <span>${quList.content}</span>
                            </div>
                        </div>

                        <div>
                            <div class="row row-cols-5 mx-auto bottom-line accoque reBoard nopadding">
                                <span class="text-center col-2 nopadding">
                                    <img src="/static/icons/right.svg" alt="answer" title="화살표">
                                </span>
                                <span class="text-center col-2 nopadding">${quList.answerDate}</span>
                                <span class="text-center col-5 nopadding">${quList.answerTitle}</span>
                                <c:if test="${empty quList.answer}">
                                    <span class="text-center col-2 nopadding">미답변</span>
                                </c:if>
                                <c:if test="${not empty quList.answer}">
                                    <span class="text-center col-2 nopadding">답변완료</span>
                                </c:if>
                                <span class="text-center col-1 nopadding"><img src="/static/icons/up.svg"
                                                                               class="rounded- mx-auto checkv" alt="V"
                                                                               title="V"></span>
                            </div>
                            <form  method="get" class="form-floating bottom-line toggleBtn">
                                <div class="row d-flex mb-2">
                                <c:if test="${not empty quList.answer}">
                                    <div class="col form-floating">
                                        <span>${quList.answer}</span>
                                    </div>
                                </c:if>
                                    <div class="col justify-content-center">
                                        <div>
                                            <c:if test="${empty quList.answer}">
                                            <div class="mb-3">
                                                <label for="emTitle" class="form-label">제목</label>
                                                <input id="emtitle" type="text" name="answerTitle" class="form-control mb-1" placeholder="제목"
                                                style="width: 500px;" autocomplete="off">
                                            </div>
                                            </c:if>
                                            <c:if test="${not empty quList.answer}">
                                            <div class="mb-3">
                                                <label for="title" class="form-label">제목</label>
                                                <input id="title" type="text" name="answerTitle" class="form-control mb-1" placeholder="제목"
                                                value="${quList.answerTitle}" style="width: 500px;" autocomplete="off">
                                            </div>
                                            </c:if>
                                        </div>
                                        <div>
                                            <label for="answer">Answer</label>
                                            <textarea class="form-control" placeholder="내용을 입력하세요" id="answer"
                                                      name="answer" style="height: 200px; width: 500px;">${quList.answer}
                                            </textarea>
                                        </div>
                                    </div>
                                </div>
                                <div class="d-flex justify-content-center">
                                    <c:if test="${empty quList.answer}">
                                        <button type="button" class="btn btn-secondary"
                                                onclick="goUpdate(this.form, '${quList.idx}')">추가
                                        </button>
                                    </c:if>
                                    <c:if test="${not empty quList.answer}">
                                    <button type="button" class="btn btn-secondary mx-2"
                                            onclick="goUpdate(this.form, ${quList.idx})">수정
                                    </button>
                                    </c:if>
                                    <button type="button" class="btn btn-outline-danger"
                                            onclick="goDelete(${quList.idx})">삭제
                                    </button>
                                </div>
                            </form>

                        </div>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>

<%@ include file="../main/b_footer.jspf" %>
</body>

<script>


    function goAnswer(answer) {


        location.href="/admin/community/question?answer="+answer;
    }

    function goUpdate(form, idx) {
        // console.log(new FormData(form));
        let formData = new FormData(form);
        formData.append('idx', idx);
//         for (let key of formData.keys()) {
//             console.log(key);
//         }
//
// // FormData의 value 확인
//         for (let value of formData.values()) {
//             console.log(value);
//         }

        $.ajax({
            url: '/admin/question/api/addAnswer',
            type: 'post',
            dataType: 'json',
            data: formData,
            cache: false,
            contentType: false,
            processData: false,
            success: function (data){
                location.href="/admin/community/question";
            }
        });
    }
    
    function goDelete(idx) {
        location.href="/admin/question/api/deleteAnswer?idx="+idx;
    }
</script>
</html>


<%--

<!DOCTYPE HTML>
<html lang="ko">
<head>
    <title>새늘봄
        |1 vs 1</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">


</head>
--%>


<%--

                            <div class="row bottom-line toggleBtn d-flex">
                                <div class="col form-floating">
                                    답변내용답변내용답변내용답변내용답변내용답변내용답변내용답변내용답변내용
                                </div>
                                &lt;%&ndash;<div class="col">&ndash;%&gt;
                                <form method="post" class="form-floating">
                                    <div class="row d-block justify-content-center">
                                        <div class="col">
                                            <label for="answer">Answer</label>
                                            <textarea class="form-control" placeholder="내용을 입력하세요" id="answer"
                                                      name="answer"
                                                      style="height: 200px; width: 300px;">
                                            </textarea>
                                        </div>
                                        <div class="col d-flex justify-content-center">
                                            <button type="button" class="btn btn-secondary"
                                                    onclick="goUpdate(this.form, ${quList.idx})">추가
                                            </button>
                                            <button type="button" class="btn btn-secondary"
                                                    onclick="goUpdate(this.form, ${quList.idx})">수정
                                            </button>
                                            <button type="button" class="btn btn-outline-danger"
                                                    onclick="goDelete(this.form, ${quList.idx})">삭제
                                            </button>
                                        </div>
                                    </div>
                                </form>
                                &lt;%&ndash;</div>&ndash;%&gt;
                            </div>--%>





