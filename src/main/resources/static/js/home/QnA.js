function toggleAnswer(button) {
    const answer = button.nextElementSibling;
    answer.style.display = answer.style.display === 'block' ? 'none' : 'block';
}

function showTab(tabId, event) {
    // 모든 탭 콘텐츠 숨기기
    const contents = document.querySelectorAll('.tab-content');
    contents.forEach(content => content.classList.remove('active'));

    // 선택한 탭 콘텐츠만 표시
    document.getElementById(tabId).classList.add('active');

    // 모든 탭 버튼의 활성화 상태 초기화
    const buttons = document.querySelectorAll('.tab-button');
    buttons.forEach(button => button.classList.remove('active'));

    // 현재 선택된 탭 버튼에 활성화 상태 추가
    if (event) {
        event.currentTarget.classList.add('active');
    }
}

// 페이지가 로드될 때 '로그인/회원가입' 탭을 활성화
window.onload = function() {
    showTab('login', null); // 초기 로드 시 이벤트 객체 필요 없음
    document.querySelector(".tab-button").classList.add('active'); // 첫 번째 탭 버튼을 활성화
};