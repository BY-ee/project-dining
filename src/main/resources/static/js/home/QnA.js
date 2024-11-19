function toggleAnswer($button) {
    const $answer = $button.next();
    $answer.toggle();
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

// 페이지가 로드될 때 '로그인/회원가입' 탭을 활성화
$(document).ready(function () {
    showTab('login', null); // 초기 로드 시 이벤트 객체 필요 없음
    $(".tab-button").first().addClass("active"); // 첫 번째 탭 버튼을 활성화
});
