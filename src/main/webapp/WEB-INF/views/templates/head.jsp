<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <!-- 한글 인코딩 -->

<!-- head 태그 템플릿 -->
<head>
    <!-- meta -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- title -->
    <title>Dining Recommendation</title>

    <!-- css -->
    <link rel="stylesheet" href="/css/templates/common.css"> <!-- 공통 css -->
    <link rel="stylesheet" href="/css/templates/header.css"> <!-- header css -->
    <link rel="stylesheet" href="/css/templates/footer.css"> <!-- footer css -->

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