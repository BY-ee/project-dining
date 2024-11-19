// DOMContentLoaded 이후 실행
document.addEventListener("DOMContentLoaded", function() {
  // 메뉴 버튼 클릭 이벤트
  const menuBtn = document.querySelector(".menu-btn");
  if (menuBtn) {
    menuBtn.addEventListener("click", function(event) {
      event.stopPropagation(); // 클릭 이벤트 전파 방지
      const popup = document.querySelector(".user-popup");
      if (popup) {
        popup.style.display = popup.style.display === "block" ? "none" : "block";
      }
    });
  }

  // 팝업 외부 클릭 시 닫기
  document.addEventListener("click", function(event) {
    const popup = document.querySelector(".user-popup");
    if (popup && !event.target.closest('.user-popup-container')) {
      popup.style.display = "none";
    }
  });
});