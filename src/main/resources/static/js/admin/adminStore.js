$(() => {
  // 가게 이름 클릭 시 팝업창 띄우기
  $('.store-link').on('click', function (e) {
    e.preventDefault();
    const storeId = $(this).data('id');
    getLikeCount(storeId);
  });

  // 찜 수를 가져오는 함수
  function getLikeCount(storeId) {
    $.ajax({
      url: `/admin/stores/${storeId}/like`,
      type: 'GET',
      success: (likeCount) => {
        getStore(storeId, likeCount);
      },
    });
  }

  // 가게 데이터 가져오는 함수
  function getStore(storeId, likeCount) {
    $.ajax({
      url: `/admin/stores/${storeId}`,
      type: 'GET',
      success: (store) => {
        renderStorePopup(store, likeCount);
        openPopup();
      },
    });
  }

  // 가게 데이터를 팝업에 렌더링
  function renderStorePopup(store, likeCount) {
    const storeDOM = `
      <div class="container">
          <div class="store-header">
              <h2>${store.storeName} </h2>
              <p id="likeButton" class="like-button">❤️ 찜 <span id="likeCount">${likeCount}</p></button>
          </div>

          <!-- 메인 사진 섹션 -->
          <div class="section main-photo">
              <!-- <div class="section-title">가게 메인 사진</div> -->
              <div class="slider-container"> <!-- 슬라이더 컨테이너 추가 -->
                  <div class="slider" id="slider">
                      <div class="slide"><img src="/images/store/${store.mainImage1}" alt="Main Image 1"></div>
                      <div class="slide"><img src="/images/store/${store.mainImage2}" alt="Main Image 2"></div>
                  </div>
              </div>
              <div class="slider-nav">
                  <button aria-label="이전 슬라이드" onclick="moveToMainPhotoSlide(currentSlideIndex - 1)"></button>
                  <button aria-label="다음 슬라이드" onclick="moveToMainPhotoSlide(currentSlideIndex + 1)"></button>
              </div>
              <!-- <div class="store-info">
                  <strong>가게주소:</strong> ${store.address}<br>
                  <strong>상세주소:</strong> ${store.detailAddress}<br>
                  <strong>전화번호:</strong> ${store.tel}<br>
                  <strong>영업시간:</strong> ${store.openTime}<br>
                  <strong>가게설명:</strong> ${store.storeDescription}<br>
              </div> -->
              <div class="store-info">
                  <p><strong>🏠 주소:</strong> ${store.address}, ${store.detailAddress}</p>
                  <div class="store-info-row">
                      <p><strong>📞 Tel:</strong> ${store.tel}</p>
                      <p><strong>⏰ 영업시간:</strong> ${store.openTime}</p>
                  </div>
                  <p><strong>${store.storeDescription}</strong></p>
              </div>
          </div>

          <!-- 대표 메뉴 섹션 -->
          <div class="section menu-price-section">
              <div class="section-title">대표 메뉴</div>
              <c:forEach var="menu" items="{menuList}">
                  <div class="menu-card">
                      <img src="/images/store/${store.menuImage}">
                      <div class="menu-info">
                          <p class="menu-name">${store.menuName}</p>
                          <p class="menu-description">${store.menuDescription}</p>
                          <p class="menu-price">${store.menuPrice}원</p>
                      </div>
                  </div>
              </c:forEach>
          </div>

          <!-- 메뉴 음식 사진 슬라이더 섹션 -->
          <div class="section menu-photo-container">
              <div class="section-title">메뉴 사진 모음</div>
              <div class="menu-slider">
                  <c:forEach var="menu" items="{menuList}">
                      <div class="menu-slide"><img src="/images/store/${store.menuImage}"></div>
                  </c:forEach>
              </div>
              <div class="menu-slider-nav">
                  <button class="prev-button" aria-label="이전 슬라이드">&#10094;</button>
                  <button class="next-button" aria-label="다음 슬라이드">&#10095;</button>
              </div>
          </div>

          <!-- 리뷰 목록 섹션 -->
          <jsp:include page="reviews.jsp" />
      </div>
    `;

    $('#store-content').html(storeDOM);
  }

  // 가게 게시 상태에 따라 글자색 변경
  const statusColor = {
    active: '#79f',
    inactive: '#f66',
  };

  $('.store-status').each(function () {
    const status = $(this).data('status');
    const color = statusColor[status];
    if (color) {
      $(this).css({
        color: color,
      });
    }
  });

  // 게시글의 게시중단 버튼 클릭
  $('.inactivate-btn').on('click', function () {
    const storeId = $(this).data('id');
    $.ajax({
      url: `/admin/stores/${storeId}/inactivate`,
      type: 'POST',
      success: (result) => {
        const $statusTd = $(`.store-status[data-id="${storeId}"]`);
        $statusTd.text(result).css({
          color: '#f66',
        });
      },
      error: (e) => {
        console.error(e.responseText);
      },
    });
  });

  // 게시글의 재게시 버튼 클릭
  $('.reactivate-btn').on('click', function () {
    const storeId = $(this).data('id');
    $.ajax({
      url: `/admin/stores/${storeId}/reactivate`,
      type: 'POST',
      success: (result) => {
        const $statusTd = $(`.store-status[data-id="${storeId}"]`);
        $statusTd.text(result).css({
          color: '#79f',
        });
      },
      error: (e) => {
        console.error(e.responseText);
      },
    });
  });
});

function openPopup() {
  $('#popup-overlay').css('display', 'flex');
}

function closePopup() {
  $('#popup-overlay').css('display', 'none');
}
