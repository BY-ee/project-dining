<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="_csrf" content="${_csrf.token}" />
    <!-- CSRF 토큰 -->
    <meta name="_csrf_header" content="${_csrf.headerName}" />
    <!-- CSRF 헤더 -->

    <title></title>
    <link rel="stylesheet" href="/css/admin/admin.css" />
    <link rel="stylesheet" href="/css/admin/adminPopup.css" />

    <script src="https://code.jquery.com/jquery-latest.js"></script>

    <!-- CSRF 토큰을 form 태그와 ajax 요청에 자동 삽입 -->
    <script>
      $(() => {
        const csrfToken = $('meta[name="_csrf"]').attr('content');
        const csrfHeader = $('meta[name="_csrf_header"]').attr('content');

        // 모든 form 태그에 CSRF 토큰 추가
        $('form').each(function () {
          $('<input>', {
            type: 'hidden',
            name: '_csrf',
            value: csrfToken,
          }).appendTo($(this));
        });

        // 모든 ajax 요청에 CSRF 토큰 추가
        $.ajaxSetup({
          beforeSend: function (xhr, settings) {
            xhr.setRequestHeader(csrfHeader, csrfToken);
          },
        });
      });
    </script>
  </head>
  <body>
    <!-- Header -->
    <header class="header">
      <div class="logo">
        <img src="https://static.cdn.okky.kr/okky-web/public/cat-footer.svg" onclick="location.href=location.origin" style="cursor: pointer" alt="Logo" />
        관리자 페이지
      </div>
      <nav class="nav-links">
        <a href="/admin/members">회원관리</a>
        <a href="/admin/stores">가게 관리</a>
        <a href="/admin/reviews">리뷰 관리</a>
        <a href="/admin/approval">가게 승인</a>
        <a href="/admin/notice">공지사항 관리</a>
        <a href="/admin/events">이벤트 관리</a>
        <a href="/admin/points">포인트 관리</a>
      </nav>
      <div>?</div>
    </header>
  </body>
</html>
