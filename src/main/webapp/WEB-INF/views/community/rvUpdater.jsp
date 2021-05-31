<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>새늘봄
        || 리뷰 작성</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@ include file="../main/import.jspf" %>
    <script src="/static/ckeditor5-build-classic/ckeditor.js"></script>
    <link rel="stylesheet" href="/static/bootstrap-datepicker/bootstrap-datepicker.css">
    <script src="/static/bootstrap-datepicker/bootstrap-datepicker.js"></script>
<style>
    body{
    }

    .fa-star {
        color: #00000033;
        padding: 0 4px;
    }

    .clickedStar{
        color: #000000dd;
    }

    .starPicker{
        font-size: 3rem !important;
        cursor: pointer;
        transition: .3s;
        -webkit-transition: .3s;
        margin-top: 1rem;
    }

    .radioBtnStar{
        display: none;
    }

    .ratingDiv{
        text-align:center;
        margin-top:8em;
    }

    label {
        color: #000000;
        font-family: 'Montserrat', sans-serif;
        font-weight:100;
    }

    .form-group{
        display: flex;
        justify-content: center;
        margin-top:.2rem;
    }

</style>

</head>
<body>
<%@ include file="../main/header.jspf" %>
<div id="container" class="mx-auto">
    <h2>리뷰 작성</h2>
    <div>
        <form class="row g-3" method="post" action="/admin/community/updateReview" enctype="multipart/form-data">
            <div class="md-3">
                <label class="form-label">${reviewDto.category}</label>
                <input type="hidden" class="form-control" name="memberId" id="memberId" value="${member.id}">
                <input type="hidden" class="form-control" name="category" id="category" value="${reviewDto.category}">
                <input type="hidden" class="form-control" name="oidx" id="oidx" value="${oidx}">
                <input type="hidden" class="form-control" name="idx" id="idx" value="${reviewDto.idx}">
                <c:if test="${reviewDto.category == '꽃다발'}">
                    <input type="hidden" class="form-control" name="flowerIdx" id="flowerIdx" value="${reviewDto.flowerIdx}">
                </c:if>
                <c:if test="${reviewDto.category eq '정기구독'}">
                    <input type="hidden" class="form-control" name="subsIdx" id="subsIdx" value="${reviewDto.subsIdx}">
                </c:if>
                <c:if test="${reviewDto.category eq '소품'}">
                    <input type="hidden" class="form-control" name="productIdx" id="productIdx" value="${reviewDto.productIdx}">
                </c:if>
                <c:if test="${reviewDto.category eq '클래스'}">
                    <input type="hidden" class="form-control" name="fclassIdx" id="fclassIdx" value="${reviewDto.fclassIdx}">
                </c:if>
            </div>
            <div class="md-3">
                <label for="name" class="form-label">제목</label>
                <input type="text" class="form-control" name="name" id="name" value="${reviewDto.name}"
                       placeholder="제목을 적어주세요" autocomplete="off">
            </div>
       <%--     <div class="md-3">
                <label for="file1" class="form-label">이미지</label>
                <input type="file" name="file" class="form-control text-secondary" id="file1" onchange="preview(this, 'img1')">
                <img src="" alt="사진" class="card-img-bottom d-none text-secondary" id="img1">
            </div>
--%>

            <div class="card col-4">
                <div class="card-header mb-3">
                    <label for="file1">썸네일이미지</label>
                    <input type="file" name="file" class="form-control text-secondary" id="file1" onchange="preview(this, 'img1')">
                </div>
                <img src="${reviewDto.image}" alt="사진" class="card-img-bottom d-none text-secondary" id="img1">
            </div>
            <div class="md-3">
                <label class="form-label" for="content">내용</label>
                <textarea class="form-control" name="content" id="content">${reviewDto.content}</textarea>
            </div>
            <div class="ratingDiv">
                <label>별점</label>
                <div class="form-group">
                    <input class="star1 radioBtnStar" type="radio" id="star1" name="comment" value="1" required>
                    <label for="star1"><i class="starPicker starIcon1 fa fa-star"></i></label>

                    <input class="star2 radioBtnStar" type="radio" id="star2" name="comment" value="2">
                    <label for="star2"><i class="starPicker starIcon2 fa fa-star"></i></label>

                    <input class="star3 radioBtnStar" type="radio" id="star3" name="comment" value="3">
                    <label for="star3"><i class="starPicker starIcon3 fa fa-star"></i></label>

                    <input class="star4 radioBtnStar" type="radio" id="star4" name="comment" value="4">
                    <label for="star4"><i class="starPicker starIcon4 fa fa-star"></i></label>

                    <input class="star5 radioBtnStar" type="radio" id="star5" name="comment" value="5">
                    <label for="star5"><i class="starPicker starIcon5 fa fa-star"></i></label>
                </div>
            </div>

            <div class="md-3">
                <%--onclick="faqUpload(this.form)--%>
                <button type="submit" class="btn btn-secondary me-2">수정</button>
                <button type="button" class="btn btn-secondary" onclick="location.href='/myPage'">취소</button>
            </div>
        </form>
    </div>
</div>
<%@ include file="../main/b_footer.jspf" %>

<script>
    function preview(file, id) {
        let img = document.querySelector("#" + id);

        let reader = new FileReader();
        reader.onload = function(e) {
            img.setAttribute("src", e.target.result.toString());
            img.classList.remove("d-none");
        }
        reader.readAsDataURL(file.files[0]);
    }
    if(document.querySelector(".starIcon1") != undefined){

        // initialize the rating stars list as a global variable to reuse it later
        let stars = [];

        // init the stars query selectors
        function starQueryInit(){
            // create the querySelector of each 5 stars and push it to the stars list
            for(let i=1; i <= 5; i++){
                stars.push(document.querySelector(".starIcon"+i));
            }
        }

        // remove the clickedStar class on every stars
        function removeClickedStar(){
            for(let i = 0; i < stars.length; i++){
                stars[i].classList.remove("clickedStar");
            }
        }

        // add the clickedStar function when clicked and check his radio button
        function addClickedStar(numStar){
            // clickedStar function when clicked
            for(let i = 0; i < numStar; i++){
                stars[i].classList.add("clickedStar");
            }
            // check his radio button
            document.querySelector("input[type=radio].star"+numStar).checked = true;
            let checkedValue = document.querySelector('input[name="comment"]:checked').value;
            console.log(checkedValue);
        }

        // translate hover effect
        function translateHover(numStar, translateY){
            for(let i = 0; i < numStar; i++){
                stars[i].style.transform = translateY;
            }
        }

        function createRatingEventListeners(){
            // create the translateY up and down values
            let translateLst = ["translateY(-5px)", "translateY(0px)"];
            // iterate over the stars and add event listeners
            for(let i = 0; i < stars.length; i++){
                // set the number of star value
                let numStar = i+1;

                // hover effect translateY up and down
                // add the up translateY hover effect
                stars[i].addEventListener("mouseover", ()=>{
                    translateHover(numStar, translateLst[0]);
                });
                // add the up translateY hover effect
                stars[i].addEventListener("mouseout", ()=>{
                    translateHover(numStar, translateLst[1]);
                });

                // click event listener (change color and check the radio button)
                stars[i].addEventListener("click", ()=> {
                    // remove all the clickedStar
                    removeClickedStar();
                    // add clickedStar and check his radio button
                    addClickedStar(numStar);
                });
            }
        }

        // init the stars query selectors
        starQueryInit();
        // create the events listeners
        createRatingEventListeners();
    }


</script>


<script src="/static/js/imageUploader.js"></script>
<script>
    $(function (){
        let star = '${reviewDto.star}';
        star = Math.floor(star);
        document.querySelector("input[type=radio].star"+star).checked = true;
        let checkedValue = document.querySelector('input[name="comment"]:checked').value;
        addClickedStar(star);
    });
</script>
</body>
</html>
