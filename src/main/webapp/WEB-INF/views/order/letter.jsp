<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>새늘봄 - checkout</title>
    <link rel="stylesheet" href="/static/css/order/orderstyle.css">
    <%@ include file="../main/import.jspf"%>
    <script>
        function printLetter($letter, index) {
            const letter = $letter.value;
            document.querySelector("#preview[data-preview-index='" + index + "']").innerText = letter;
            document.querySelector("#letter_press_cnt_[data-preview-index='" + index + "']").innerHTML = letter.length;
        }

        //메세지 체크박스 선택 안했는데 메세지 비어있을때!
        function checkForm() {
            //flower_letter form을 전부 선택해준다. (배열로)
            const $forms = document.querySelectorAll(".flower_letter");

            <%--if (${member.id == null}) {--%>
            <%--    alert("로그인이 필요합니다.");--%>
            <%--}--%>
            
            //선택한 폼들을 하나씩 돌려주면서...
            for (const $form of $forms) {
                // 돌려주면서 폼 안에서 message, check 를 선택해준다.
                const $message = $form.querySelector("#message");
                const check = $form.querySelector("#letter_none").checked;

                //편지 1개 -> 안의 폼 안에 값들 (message, check)를 하나씩 비교하면서 if 조건 비교 후 reture or submit 해준다.
                if ($message.value === "" && !check) {
                    alert("메세지를 입력해주세요.\n메세지 없이 카드만 받고싶으시면 선택해주세요.");
                    $message.focus();
                    return false;
                }
            }
            submitForm();
        }

        //편지값 전송
        function submitForm() {

            //class="flower_letter"의 폼을 전부 선택.
            let letters = document.querySelectorAll(".flower_letter");
            let datas = [];
            for (let letter of letters) {
                let data = {
                    idx : letter.list_idx.value,
                    name : letter.product_name.value,
                    content : letter.letter_content.value
                };
                //생성된 데이터 배열안에 넣어주기.
                datas.push(data);
            }

            //폼 동적으로 만들기
            let form = document.createElement("form")
            form.action = "/oitem/checkOut";
            form.method = "post";
            let data = document.createElement("input");
            data.name = "data";
            data.type = "text";
            //위에서 만든 데이터 배열을 Json 타입 문자열로 변환 -> input value로 설정해준다.
            data.value = JSON.stringify(datas);
            //만들어둔 form에 input 넣어준다.
            form.appendChild(data);
            document.body.appendChild(form);
            form.submit();
        }

        function letterNone(event, btn) {

             let message = document.querySelector("#message");

            if(event.target.checked) {
                btn.form.querySelector('#letter_input_form').style.display = 'none';
                message.value = 'null';
            } else {
                btn.form.querySelector('#letter_input_form').style.display = 'block';
                message.value = '';
            }
        }

    </script>
</head>
<body>
<%@ include file="../main/header.jspf" %>
    <div id="container" class="mx-auto">
        <!-- 헤더 -->
        <div class="checkout_wrap">
            <div class="navi" tabindex="-1">
                <ul class="process">
                    <div class="step current"><span class="order"><b>1</b><span class="desc">편지 추가</span></span></div>
                    <div class="step"><span class="order"><b>2</b><span class="desc">주소 입력</span></span></div>
                    <div class="step"><span class="order"><b>3</b><span class="desc">결제</span></span></div>
                </ul>
            </div>
            <!-- 편지 폼 -->
            <div class="checkout_letter_add">
                <div class="head">
                    <div class="float-start">
                        <h4 class="tit">메시지카드</h4>
                    </div><br>
                    <c:forEach var="oitem" items="${oitemList}" varStatus="status">
                        <c:if test="${oitem.hasLetter eq false}">
                    <div class="float-xl-none py-5 px-3">
                        <p> 메세지 카드를 옵션을 선택하지 않았습니다.</p>
                        <p> 메세지 카드를 원하지 않으시면<i class="text-warning px-2">다음 버튼</i>을 눌러 결제를 진행해주세요.</p>
                        <p> 메세지 카드를 선택하고 싶으시면<i class="text-warning px-2">이전 페이지<i>를 눌러 카드 선택 옵션을 추가해주세요.</p>
                    </div>
                        </c:if>
                    </c:forEach>
                </div>


                <!-- letter 옵션 추가시, 그 개수만큼 생성해준다. -->
                <c:forEach var="oitem" items="${oitemList}" varStatus="status">
                <c:if test="${oitem.hasLetter eq true}">
                    <form class="flower_letter" name="letter_form" onSubmit="return CheckForm(this)">
                    <div id="letterbox-wrapper">
                         <input type="hidden" name="list_idx" value="${status.index}">
                        <div id="letter_product" class="letterbox">
                            <div class="letter">
                                <div class="select_letter">
                                    <input type="text" class="select_letter_select_tag" name="product_name"
                                           readonly value="${oitem.name}">
                                </div>
                                <div class="role_select_checked">
                                    <div class="col-12">
                                        <div class="form-check">
                                            <label class="form-check-label">
                                                <input class="form-check-input" type="checkbox" id="letter_none" name="letter_none"
                                                       value="letterNone" onclick="letterNone(event, this)" data-index="${status.index}"/>
                                                메세지 없이 카드만 받을게요
                                            </label>
                                        </div>
                                    </div>
                                </div>

                                <!-- 편지 내용 -->
                                <div class="input_letter_wrap write" id="letter_input_form">
                                    <div class="input_letter">
                                        <textarea id="message" name="letter_content" class="letter_press" rows="8" maxlength="120"
                                                          wrap="hard" placeholder="여기에 입력하세요 :-)" data-letter="" onkeyup="printLetter(this, ${status.index})"></textarea>
                                            <span class="limmit">
                                                <b data-preview-index="${status.index}" class="count" id="letter_press_cnt_">0</b> / 120
                                            </span>
                                            <span class="noti">*이모티콘은 편지 내용에 포함되지 않습니다.</span>
                                            <span class="noti">* 편지 내용을 이곳에 직접 입력해주세요.</span>
                                            <span class="noti">* 붙여넣기 시용시 편지가 입력 되지 않습니다.</span>
                                    </div>
                                    <div class="preview_letter">
                                        <div data-preview-index="${status.index}" id="preview" class="text" readonly></div>
                                        <span class="noti">* 실제 편지지 모습입니다. 최대 8줄까지만 인쇄됩니다.</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    </form>
                    </c:if>
                    </c:forEach>
                        </div>
                    </div>
                <!-- 버튼 -->
                <div class="float-end">
                    <button type="button" class="btn btn-outline-secondary btn-lg"
                            onclick="history.back()">이전 화면으로</button>
                    <!-- 여기서 받은 데이터를 submitForm() -->
                    <button type="button" class="btn btn btn-secondary btn-lg" onclick="checkForm()">다음 단계로</button>
                </div>
                <br>
            </div>
<%@ include file="../main/footer.jspf"%>
</body>
</html>
