function toggleAnswer(button) {
    const $button = $(button); // jQuery 객체로 변환
    const $answer = $button.next(); // 다음 형제 요소 선택
    if ($answer.length) {
        $answer.toggle(); // 표시/숨김 토글
    } else {
        console.error("No next element found!");
    }
}

function showTab(tabId, event) {
    // 모든 탭 콘텐츠 숨기기
    $(".tab-content").removeClass("active");

    // 선택한 탭 콘텐츠만 표시
    $(`#${tabId}`).addClass("active");

    // 모든 탭 버튼의 활성화 상태 초기화
    $(".tab-button").removeClass("active");

    // 현재 선택된 탭 버튼에 활성화 상태 추가
    if (event) {
        $(event.currentTarget).addClass("active");
    }
}

// 페이지가 로드될 때 초기화
$(document).ready(function () {
    showTab('login', null); // 초기 로드 시 '로그인/회원가입' 탭 표시
    $(".tab-button").first().addClass("active"); // 첫 번째 탭 활성화
});