$(() => {
  // 등록 현황 별 필터링
  $('.tab-select').on('change', function () {
    const status = $(this).val();
    const url = `/admin/approval?enrollStatus=${encodeURIComponent(status)}`;

    location.href = url;
  });

  // 가게 이름 클릭 시 팝업창 띄우기
  $('.approval-link').off('click');
  $('.approval-link').on('click', function (e) {
    e.preventDefault();
    const storeId = $(this).data('id');
    getStoreForm(storeId);
  });

  // 가게 승인 폼 가져오는 함수
  function getStoreForm(storeId) {
    $.ajax({
      url: `/admin/approval/${storeId}`,
      type: 'GET',
      success: (store) => {
        renderStorePopup(store);
        openPopup();
      },
    });
  }

  function renderStorePopup(store) {
    const approvalDOM = `
			<div class="container">
				<h1 style="margin-bottom: 50px;">${store.storeName}</h1>
				
				<label for="ceoName">대표자 이름</label>
				<span id="ceoName">${store.ceoName}</span>
				
				<label for="phone">연락처</label>
				<span id="phone">${store.phoneNumber}</span>

				<label for="tel">전화번호</label>
				<span class="underline" id="tel">${store.tel}</span>
				
				<label for="address">가게 주소</label>
        <span id="address">${store.address}, ${store.detailAddress}</span>

				<label for="region">지역</label>
				<span id="region">${store.local}</span>
				
				<label for="industry">업종</label>
				<span id="industry">${store.industry}</span>

				<label for="theme">테마</label>
				<span class="underline" id="theme">${store.theme}</span>
				
				<label for="openTime">영업 시간</label>
				<span id="openTime">${store.openTime}</span>

				<label for="storeDescription">가게 설명</label>
				<p id="storeDescription">${store.storeDescription}</p>

				<label for="storeImages">가게 대표 사진</label>
				<div style="display: flex; justify-content: center; margin-bottom: 20px;">
					<img src="/images/store/${store.mainImage1}">
					<img src="/images/store/${store.mainImage2}">
				</div>

				<label for="menuPhotos">대표 메뉴 사진</label>
				<div style="display: flex; justify-content: center; margin-bottom: 50px;">
				</div>
				
					
				<div style="display: flex; gap: 80px;">
					<button class="btn btn-submit">등록</button>
					<button class="btn btn-reject">반려</button>
				</div>
			</div>
		`;

    $('#approval-content').html(approvalDOM);
  }

  // 가게 신청 현황에 따라 글자색 변경
  const statusColor = {
    wait: '#f66',
    enrolled: '#79f',
    withdrawal: '#f66',
  };

  $('.approval-status').each(function () {
    const status = $(this).data('status');
    const color = statusColor[status];
    if (color) {
      $(this).css({
        color: color,
      });
    }
  });
});

function openPopup() {
  $('#popup-overlay').css('display', 'flex');
}

function closePopup() {
  $('#popup-overlay').css('display', 'none');
}
