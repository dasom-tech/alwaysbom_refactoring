<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<title>새늘봄 회원 가입</title>
    <%@ include file="../main/import.jspf"%>
    <link rel="stylesheet" href="static/css/member/joinStyle.css">
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
</head>
<body>
<%@ include file="../main/header.jspf" %>
<div id="container" class="mx-auto">
    <aside class="member join" id="join_us_select">
        <div class="member_wrap">
            <div class="member_content new_2nd">
                <h5 class="title">새늘봄 회원 가입</h5>
                <nav class="join_us_2nd">
                    <p class="blind">새늘봄 멤버쉽 회원가입을 할 수 있습니다.</p>
                    <p class="let_join">
                        바로 사용할 수 있는 <b>1,000P</b>
                        를 드려요!
                    </p>
                    <p class="let_join">이 사이트는 포트폴리오 용 사이트입니다.<br>
                        테스트용으로 이용하실분만 가입하시고 민감한 개인정보는 입력하지 마시길 바랍니다</p>
                    <div class="d-flex justify-content-center">
                        <a href="/member_join" class="link email border-dark rounded-3 p-2 col-12 text-center text-decoration-none">
                            이메일 회원가입
                        </a>
                    </div>
                    <p class="sns">

                                              SNS 간편 회원가입

                      <span class="blind">SNS 계정으로 간편하게 새늘봄에 가입이 가능합니다.</span>
                    </p>
                    <form action="/member_join">
                    <div class="d-flex justify-content-center">
                    <a href="javascript:kakaoLogin();" class="link kakao border-warning rounded-3 p-2 col-12 text-center text-decoration-none">
                        카카오로 가입하기
                    </a>
                    </div>
                    </form>
                </nav>
            </div>
        </div>
    </aside>
</div>
<%@ include file="../main/footer.jspf"%>
<script>
    Kakao.init("a7ed8ce3bc2337bb4281fa9fc4d51ddd");
    Kakao.isInitialized();

    function kakaoLogin() {
        Kakao.Auth.login({
            scope:'profile, account_email, gender, birthday',
            success: function (authObj) {
                window.Kakao.API.request({
                    url:'/v2/user/me',
                    success: res => {
                        const kakao_account = res.kakao_account;
                        console.log(kakao_account);

                        var kakao_id = kakao_account.email;
                        var kakao_name = kakao_account.profile.nickname;
                        var kakao_gender = kakao_account.gender;

                        location.href="/member_join?kakao_id=" + kakao_id + "&kakao_name=" + kakao_name +"&kakao_gender=" + kakao_gender;
                    }
                });
            }
        });
    }
</script>
</body>
</html>
