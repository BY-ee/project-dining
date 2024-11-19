<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <!-- 한글 인코딩 -->

<!-- meta -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- title -->
<title>Dining Recommendation</title>

<!-- css -->
<link rel="stylesheet" href="/css/templates/common.css"> <!-- 공통 css -->
<link rel="stylesheet" href="/css/templates/header.css"> <!-- header css -->
<link rel="stylesheet" href="/css/templates/footer.css"> <!-- footer css -->
<link rel="stylesheet" href="/css/community/community.css">
<link rel="stylesheet" href="/css/community/chat.css">
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css"> <!-- jQuery UI CSS -->

<!-- script -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- jQuery -->
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script> <!-- jQuery UI -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client/dist/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>


<script src="/js/home/slider.js"></script> <!-- 슬라이더 -->
<script type="text/javascript"> var userId = "${sessionScope.user_ID != null ? sessionScope.user_ID : ''}"; </script>
<script src="/js/community/chat.js"></script>
<script src="/js/community/community.js"></script> <!-- 페이지 전용 JS -->
<script src="/js/home/userdropdown.js"></script> <!-- 페이지 전용 JS -->





    <!-- script -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/js/home/userDropDown.js" defer></script>
    <script type="text/javascript">
        var userId = "${sessionMember.memberId}";
	</script>
    <script>
        // Spring Security가 제공하는 CSRF 토큰을 각 form 태그에 자동으로 삽입
        $(document).on('submit', 'form', function () {
            const csrfToken = $('meta[name="_csrf"]').attr('content');

            $(this).append(
                $('<input>', {
                    type: 'hidden',
                    name: '_csrf',
                    value: csrfToken
                })
            );
        });
    </script>
</head>
