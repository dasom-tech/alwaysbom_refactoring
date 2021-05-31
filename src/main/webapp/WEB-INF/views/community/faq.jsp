<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>새늘봄
        |자주 묻는 질문</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <%@ include file="../main/import.jspf" %>
    <script>
        async function goFaqList(faqType) {
            $(".cate").removeClass("btn-dark");
            $(faqType).addClass("btn-dark");
            let category = {
                category : faqType.getAttribute("id")
            }

            let options = {
                method : 'POST',
                body: new URLSearchParams(category)
            };

            let response = await fetch("/community/api/gogoFaq", options);
            let result = await response.json();
            console.log(result);

            let dispHtml = "";
            for (let data of result) {
                dispHtml += '<div class="accordion-item">';
                dispHtml += '<h3 class="accordion-header" id="flushHead'+ data.idx +'">';
                dispHtml += '<button class="accordion-button collapsed btn-secondary" type="button" data-bs-toggle="collapse" data-bs-target="#flushColl'+ data.idx +'" aria-expanded="false" aria-controls="flushColl'+ data.idx +'">';
                dispHtml += data.question;
                dispHtml += '</button>';
                dispHtml += '</h3>'
                dispHtml += '<div id="flushColl'+ data.idx +'" class="accordion-collapse collapse" aria-labelledby="flushHead'+ data.idx +'" data-bs-parent="#accordionFlushExample">';
                dispHtml += '<div class="accordion-body">';
                dispHtml += data.answer;
                dispHtml += "</div>";
                dispHtml += "</div>";
                dispHtml += "</div>";
                // dispHtml += '<ul class="dropdown-menu">';
                // dispHtml += "<li>";
                // dispHtml += data.answer;
                // dispHtml += "</li>";
                // dispHtml += "</ul>";
                // dispHtml += "</div>";

                // dispHtml += "<li>";
                // dispHtml += "<p>" + data.question + "</p>";
                // dispHtml += "<p>" + data.answer + "</p>";
                // dispHtml += "</li>";
            }
            document.querySelector("#accordionFlushExample").innerHTML = dispHtml;

            /*
            $.ajax({
                url: '/gogoFaq',
                type: 'POST',
                dataType: "json",
                data: category,
                success: function (data) {
                    console.log(data);
                    let dispHtml = "<li>"
                    $.each(data, function () {
                        dispHtml += "<p>" + this.question + "</p>";
                        dispHtml += "<p>" + this.answer + "</p>";
                        dispHtml += "</li>";
                    });
                    $("#faqList").html(dispHtml);
                }
            });
            */
        }

        $(function () {

            let startFaqType = document.querySelector("#FAQ");
            $(".cate").removeClass("btn-dark");
            $("#FAQ").addClass("btn-dark");
            goFaqList(startFaqType);
        });
    </script>
</head>


<body>
<%@ include file="../main/header.jspf" %>
<div class="d-flex justify-content-center">
    <div id="container">
        <div class="py-3">
                <h2 class="mx-auto d-inline-block col-9">자주 묻는 질문</h2>
                <a href="/myPage_faq_main" class="mx-auto d-inline-block col-2 btn btn-secondary">1:1 문의하기</a><%--로그인 처리--%>
        </div>
        <div>

            <div class="d-flex align-items-baseline review-category col-12 justify-content-around mt-0 pt-0 pb-3">
                <c:forEach var="category" items="${category}">
                    <label class="" id="list-${category}">
                        <a class="d-block text-center btn btn-dark py-2 px-5 btn-rev cate" id="${category}" href="#" onclick="goFaqList(this)">${category}</a>
                    </label>

                </c:forEach>
            </div>
     <%--       <ul class="nav justify-content-around faqBox">
                <c:forEach var="category" items="${category}">
                    <li class="nav-item-3" id="${category}">
                        <a class="nav-link" id="${category}" href="#" onclick="goFaqList(this)">${category}</a>
                    </li>
                </c:forEach>
            </ul>--%>
            <%--            <div>
                            <ul id="faqList">
                            </ul>
                        </div>--%>
            <div class="accordion accordion-flush" id="accordionFlushExample">

            </div>

        </div>
    </div>
</div>

<%@ include file="../main/footer.jspf"%>
</body>
<script>
// JSON.stringify(obj)  =>  {"a":"hi", "b":,"hello"}
// new URLSearchParams(obj) => a=hi&b=hello


</script>
</html>

