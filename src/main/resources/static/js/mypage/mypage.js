   
/*// 팝업 열기
     function openPopup(storeId) {
         const popup = document.getElementById(`popup-${storeId}`);
         if (popup) {
             popup.style.display = 'block'; // 팝업 표시
         } else {
             console.error(`Popup with ID popup-${storeId} not found`);
         }
     }
 
  // 팝업 닫기
     function closePopup(storeId) {
         const popup = document.getElementById(`popup-${storeId}`);
         if (popup) {
             popup.style.display = 'none'; // 팝업 숨기기
         } else {
             console.error(`Popup with ID popup-${storeId} not found`);
         }
    }*/
	$(document).ready(function() {
        // 팝업 열기
        $(".open-popup").on("click", function() {
        	const storeId = $(this).data("id");
            const popup = $(`#popup-`+storeId);
            popup.fadeIn(); // 팝업 열기
        });

        // 팝업 닫기
        $(".close-popup").on("click", function() {
            $(this).closest(".popup").fadeOut(); // 클릭된 닫기 버튼의 부모 팝업 닫기
        });
    }); 