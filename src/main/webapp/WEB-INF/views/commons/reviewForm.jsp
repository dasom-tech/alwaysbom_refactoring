<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!-- modal dialog (리뷰 쓰기 창) -->
<div class="modal fade " id="writingReview" tabindex="-1" aria-labelledby="writingReviewLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered ">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="writingReviewLabel">리뷰 쓰기</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- 리뷰 제목-->
                <div class="mb-3">
                    <label for="review-title" class="col-form-label">리뷰 제목</label>
                    <input type="text" class="form-control" id="review-title">
                </div>
                <!-- 사진 첨부 -->
                <div class="mb-3">
                    <label for="review-file" class="col-form-label">사진 첨부</label>
                    <input type="file" class="form-control text-secondary" id="review-file" aria-describedby="inputGroupFileAddon04" aria-label="Upload">
                </div>
                <!-- 리뷰 내용 -->
                <div class="mb-3">
                    <label for="review-content" class="col-form-label">내용</label>
                    <textarea class="form-control" id="review-content" rows="5"></textarea>
                </div>
                <!-- 별점 선택하기 -->
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
                            <input type="radio" class="btn-check" name="starPoint" value="5" autocomplete="off" checked>
                            <i class="fas fa-star"></i>
                        </label>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button id="addReviewBtn" type="button" class="btn btn-dark fs-19"
                        onclick="addReview()" data-bs-dismiss="modal">리뷰 등록하기</button>
                <button type="button" class="btn btn-secondary fs-19" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>
<style>
    .btn-radio {
        cursor: pointer;
    }

    .btn-radio:hover {
        color: #ffcc3c;
    }
</style>
<script class="inner-script">
    <!-- 별 클릭시 1~5 체크 -->
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

    function showReviewModal(btn, category, itemIdx, oitemIdx) {
        if (btn.id.length === 0) {
            throw new TypeError("버튼의 id가 존재하지 않습니다");
        } else if (document.querySelectorAll("#" + btn.id).length > 1) {
            throw new TypeError("버튼의 id가 유일하지 않습니다");
        }

        const $reviewModal = document.querySelector("#writingReview");

        $reviewModal.querySelector("#review-title").value = "";
        $reviewModal.querySelector("#review-file").value = "";
        $reviewModal.querySelector("#review-content").value = "";


        $reviewModal.dataset.category = category;
        $reviewModal.dataset.itemIdx = itemIdx;
        $reviewModal.dataset.oitemIdx = oitemIdx;
        $reviewModal.dataset.target = btn.id;
        new bootstrap.Modal($reviewModal).show();
    }

    /* 리뷰 등록하기 버튼 클릭 */
    function addReview() {
        const $reviewModal = document.querySelector("#writingReview");
        const target = document.querySelector("#" + $reviewModal.dataset.target);

        const category = $reviewModal.dataset.category;
        const itemIdx = $reviewModal.dataset.itemIdx;
        const oitemIdx = $reviewModal.dataset.oitemIdx;

        const star = document.querySelector("[name=starPoint]:checked").value;
        const name = document.querySelector("#review-title").value;
        const $image = document.querySelector("#review-file");

        const formData = new FormData();
        formData.append('name', name);
        if ($image.files[0]) {
            formData.append('imageFile', $image.files[0]);
        }
        formData.append('content', document.querySelector("#review-content").value);
        formData.append('star', star);

        let url;
        switch (category) {
            case "정기구독": {
                url = "/subs/" + itemIdx + "/reviews";
                formData.append("oitemIdx", oitemIdx);
                formData.append("subsIdx", itemIdx);
                break;
            }
            case "꽃다발": {
                url = "/flower/" + itemIdx + "/reviews";
                formData.append("oitemIdx", oitemIdx);
                formData.append("flowerIdx", itemIdx);
                break;
            }
            case "소품샵": {
                url = "/product/" + itemIdx + "/reviews";
                formData.append("oitemIdx", oitemIdx);
                formData.append("productIdx", itemIdx);
                break;
            }
            case "클래스": {
                url = "/fclass/api/classList/" + itemIdx + "/reviews";
                formData.append("oclassIdx", oitemIdx);
                formData.append("fclassIdx", itemIdx);
                break;
            }
        }

        const options = {
            method: 'post',
            body: formData
        };

        fetch(url, options).then(response => {
            response.json().then(result => {
                console.log(result);
                target.remove();
                alert("리뷰가 등록되었습니다");
            });
        });
    }
</script>