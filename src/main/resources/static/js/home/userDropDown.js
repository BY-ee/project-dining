// 팝업 클릭 시 메뉴가 보이도록 설정
$(".menu-btn").on("click", function (event) {
  event.stopPropagation();
  const $popup = $(".user-popup");
  $popup.css("display", $popup.css("display") === "block" ? "none" : "block");
});

// 팝업 외부를 클릭 시 팝업 닫기
$(document).on("click", function (event) {
  const $popup = $(".user-popup");
  if (!$popup.closest(".user-popup-container").is(event.target) && $popup.css("display") === "block") {
      $popup.css("display", "none");
  }
});
