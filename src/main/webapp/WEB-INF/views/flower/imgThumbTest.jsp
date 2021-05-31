<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <%@ include file="../main/import.jspf"%>
</head>
<body>
<div id="container" class="mx-auto">
    <!-- First modal dialog -->
    <div class="modal fade" id="reviewPossible" aria-hidden="true" aria-labelledby="..." tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="fs-19 p-5 mb-3">
                    고객님께서는 이미 해당 상품을
                    구매하신 이력이 있으시네요.<br><br>
                    상품이 마음에 드셨나요?<br><br>
                    리뷰를 작성해주시면 200포인트를 적립해드려요.<br>
                    (사진 첨부시 +100P!)
                </div>
                <div class="modal-footer">
                    <!-- Toogle to second dialog -->
                    <button class="btn btn-dark" data-bs-target="#writingReview" data-bs-toggle="modal"
                            data-bs-dismiss="modal">리뷰 쓰기</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Second modal dialog -->
    <div class="modal fade " id="writingReview" tabindex="-1" aria-labelledby="writingReviewLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered ">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="writingReviewLabel">리뷰 쓰기</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="mb-3">
                            <label for="review-title" class="col-form-label">리뷰 제목</label>
                            <input type="text" class="form-control" id="review-title">
                        </div>
                        <div class="mb-3">
                            <label for="review-file" class="col-form-label">사진 첨부</label>
                            <input type="file" class="form-control text-secondary" id="review-file" aria-describedby="inputGroupFileAddon04" aria-label="Upload">
                        </div>
                        <div class="mb-3">
                            <label for="review-content" class="col-form-label">내용</label>
                            <textarea class="form-control" id="review-content"></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="review-star" class="col-form-label">별점</label>
                            <div class="d-flex btn-group text-warning fs-2 ps-3 pb-1" role="group" id="review-star">
                                <label class="btn-radio">
                                    <input type="radio" class="btn-check" name="starPoint" value="1" autocomplete="off">
                                    <i class="fas fa-star"></i>
                                </label>
                                <label class="btn-radio">
                                    <input type="radio" class="btn-check" name="starPoint" value="2" autocomplete="off">
                                    <i class="fas fa-star"></i>
                                </label>
                                <label class="btn-radio">
                                    <input type="radio" class="btn-check" name="starPoint" value="3" autocomplete="off">
                                    <i class="fas fa-star"></i>
                                </label>
                                <label class="btn-radio">
                                    <input type="radio" class="btn-check" name="starPoint" value="4" autocomplete="off">
                                    <i class="fas fa-star"></i>
                                </label>
                                <label class="btn-radio">
                                    <input type="radio" class="btn-check" name="starPoint" value="5" autocomplete="off">
                                    <i class="fas fa-star"></i>
                                </label>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    <button type="button" class="btn btn-dark" onclick="closeModal()">리뷰 등록하기</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Open first dialog -->
    <a data-bs-toggle="modal" href="#reviewPossible" role="button">리뷰쓰기</a>


    <!-- Button trigger modal -->
    <a data-bs-toggle="modal" data-bs-target="#loginModal">
        리뷰쓰기 2
    </a>

    <!-- Modal -->
    <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="loginModalLabel">새늘봄의 회원이신가요?</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body fs-19">
                    로그인 이후 이용 가능한 서비스입니다.<br>로그인 화면으로 이동하시려면 '이동'을 눌러주세요.
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-dark">이동</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>





</div>
<script>
    let $stars = document.querySelectorAll("[name=starPoint]");
    let $starIcons = document.querySelectorAll("[name=starPoint] + i");
    for (const $star of $stars) {
        $star.onchange = function(){
            console.log(this.value);
            const starPoint = parseInt(this.value);
            $starIcons.forEach(($starIcon, index) =>{
                let className = "fas fa-star";
                if (starPoint <= index) {
                    className = "far fa-star";
                }
                $starIcon.className = className;
            })
        }
    }
    function closeModal() {
        console.log(33);
        let myModalEl = document.querySelector('#writingReview');
        let myModal = bootstrap.Modal.getInstance(myModalEl);
        myModal.hide();
    }
</script>
</body>
</html>
<style>
    #container {
        width: 1280px;
        background-color: #ffe881;
    }
    .btn-radio {
        cursor: pointer;
    }
    .btn-radio:hover {
        color: #ffcc3c;
    }
</style>