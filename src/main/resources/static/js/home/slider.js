function moveToSlide(slideIndex) {
    const $slidesContainer = $('.slider-container');
    const $buttons = $('.slide-buttons button');

    // 슬라이드 이동
    $slidesContainer.css('transform', `translateX(-${slideIndex * 100}%)`);
    
    // 모든 버튼의 'active' 클래스를 제거하고 현재 선택된 버튼에 추가
    $buttons.removeClass('active');
    $buttons.eq(slideIndex).addClass('active');
}
