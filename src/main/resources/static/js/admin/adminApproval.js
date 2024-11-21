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
    const themeHtml = store.themes && store.themes.length > 0
    ? store.themes.join(", ")
    : "테마 정보가 없습니다.";

    const mainImageHtml = store.mainImage1
    ? `<img src="/images/store/${store.mainImage1}" alt="가게 대표 사진">`
    : `<div id="storeImages" class="map-container" style="margin-bottom: 50px;">입력된 가게 사진이 없습니다.</div>`;

    const menuImageHtml = store.menuImage
    ? `<img src="/images/store/${store.menuImage}" alt="대표 메뉴 사진">`
    : `<div id="storeImages" class="map-container">입력된 대표 메뉴 사진이 없습니다.</div>`;

    const approvalDOM = `
			<div class="container">
				<h1 style="margin-bottom: 50px;">${store.storeName}</h1>
				
				<label for="ceoName">대표자 이름</label>
				<span id="ceoName">${store.ceoName}</span>
				
				<label for="phone">연락처</label>
				<span id="phone">${store.phoneNumber}</span>

				<label for="tel">전화번호</label>
				<span id="tel">${store.tel}</span>

        <div class="underline"></div>
				
				<label for="address">가게 주소</label>
        <span id="address">${store.address}, ${store.detailAddress}</span>

				<label for="region">지역</label>
				<span id="region">${store.local}</span>
				
				<label for="industry">업종</label>
				<span id="industry">${store.industry}</span>

				<label for="theme">테마</label>
				<span id="theme">${themeHtml}</span>

        <div class="underline"></div>
				
				<label for="openTime">영업 시간</label>
				<span id="openTime">${store.openTime}</span>

				<label for="storeDescription">가게 설명</label>
				<p id="storeDescription" style="word-wrap: break-word; margin-bottom: 50px">${store.storeDescription}</p>

				<label for="storeImages" style="text-align: center;">가게 대표 사진</label>
				<div style="display: flex; justify-content: center; margin-bottom: 50px;">
					${mainImageHtml}
				</div>

				<label for="menuPhotos" style="text-align: center;">대표 메뉴 사진</label>
				<div style="display: flex; justify-content: center; margin-bottom: 50px;">
          ${menuImageHtml}
				</div>

        <div style="display: flex; gap: 80px;">
          <button class="btn btn-submit" data-id="${store.id}">등록</button>
          <button class="btn btn-reject" data-id="${store.id}">반려</button>
        </div>
			</div>
		`;

    $('#approval-content').html(approvalDOM);
  }

  // 게시글 승인 버튼 클릭
  $('#approval-content').on('click', '.btn-submit', function() {
    const storeId = $(this).data('id');
    enrollStore(storeId);
  });

  function enrollStore(storeId) {
    $.ajax({
      url: `/admin/approval/${storeId}/enroll`,
      type: 'POST',
      success: (result) => {
        closePopup();
        $(`.approval-status[data-id="${storeId}"]`).val(result).text(result).css('color', '#79f');
      },
      error: (e) => {
        alert(e.responseText);
        closePopup();
      },
    });
  }

  // 게시글 반려 버튼 클릭
  $('#approval-content').on('click', '.btn-reject', function() {
    const storeId = $(this).data('id');
    withdrawStore(storeId);
  });

  function withdrawStore(storeId) {
    $.ajax({
      url: `/admin/approval/${storeId}/withdraw`,
      type: 'POST',
      success: (result) => {
        closePopup();
        $(`.approval-status[data-id="${storeId}"]`).val(result).text(result).css('color', '#f66');
      },
      error: (e) => {
        alert(e.responseText);
        closePopup();
      },
    });
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
