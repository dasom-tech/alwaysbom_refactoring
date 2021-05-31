<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>fclass mainView</title>
    <%@ include file="../main/import.jspf" %>
    <style>
        .small:hover {
            transform: scale(1.05);
            transition-duration: 0.3s;
        }
    </style>
</head>
<body>
<%@ include file="../main/header.jspf" %>
<div id="container" class="mx-auto p-5">
    <h2>여기는 디테일입니다</h2>
    ${classInfo.name}
    <a href="/admin/fclass/classList">리스트로</a>

    <div class="d-flex">
        <div id="content" class="col-6 d-flex flex-column align-items-center justify-content-center bg-info">
            <div id="bigImages" class="w-100 mb-3">
                <img id="big" src="/static/upload/fclass/class/${classInfo.image1}" class="w-100">
            </div>
            <div id="smallImages" class="w-100 d-flex overflow-hidden">
                <img class="small col-4 pe-3" src="/static/upload/fclass/class/${classInfo.image1}">
                <img class="small col-4" src="/static/upload/fclass/class/${classInfo.image2}">
                <img class="small col-4 ps-3" src="/static/upload/fclass/class/${classInfo.image3}">
            </div>
        </div>
        <div class="col-6 d-flex bg-success">
            <div>${classInfo.subheader}</div>
            <div>${classInfo.name}</div>
            <span>${classInfo.discountRate}%</span> <span>${classInfo.price}</span>
            <div>
                <span>지점</span>
                <span></span>
            </div>
        </div>
    </div>

</div>
<%@ include file="../main/footer.jspf" %>
<script>
    let bigPic = document.querySelector("#big");
    let smallPics = document.querySelectorAll(".small");
    for(let i = 0; i < smallPics.length; i++) {
        smallPics[i].addEventListener("click", changepic);
    }

    function changepic() {
        let smallPicAttribute = this.getAttribute("src");
        bigPic.setAttribute("src", smallPicAttribute);
    }
</script>
</body>
</html>