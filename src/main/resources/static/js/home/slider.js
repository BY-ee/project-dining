function moveToSlide(slideIndex) {
    const slidesContainer = document.querySelector('.slider-container');
    slidesContainer.style.transform = `translateX(-${slideIndex * 100}%)`;

    // 모든 버튼의 'active' 클래스를 제거하고 현재 선택된 버튼에 추가
    const buttons = document.querySelectorAll('.slide-buttons button');
    buttons.forEach(button => button.classList.remove('active'));
    buttons[slideIndex].classList.add('active');
}	