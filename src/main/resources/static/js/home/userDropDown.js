//팝업 클릭시 메뉴가 보이도록 설정
document.querySelector(".menu-btn").addEventListener("click", function(event) {
  event.stopPropagation();
  const popup = document.querySelector(".user-popup");
  popup.style.display = popup.style.display === "block" ? "none" : "block";
});

// 팝업 외부를 클릭 시 팝업 닫기
document.addEventListener("click", function(event) {
  const popup = document.querySelector(".user-popup");
  if (!event.target.closest('.user-popup-container') && popup.style.display === "block") {
    popup.style.display = "none";
  }
});