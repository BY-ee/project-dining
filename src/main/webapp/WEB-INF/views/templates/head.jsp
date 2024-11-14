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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" defer></script>
    <script src="/js/home/slider.js" defer></script>
    <script src="/js/home/userdropdown.js" defer></script>
    <script src="js/home/home-category.js" defer></script>
    <script type="text/javascript">
        var userId = "${sessionScope.user_ID != null ? sessionScope.user_ID : ''}";
	</script>
</head>