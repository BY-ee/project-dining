$('.terms-item a').on('click', function (e) {
    e.preventDefault();

    const targetId = $(this).attr('href').substring(1);
    const $targetElement = $(`#${targetId}`);

    if ($targetElement.length) {
        // 원하는 위치로 스크롤 (여기서 위치 비율을 조정할 수 있음)
        $('html, body').animate(
            {
                scrollTop: $targetElement.offset().top - $(window).height() / 3,
            },
            500 // 스크롤 애니메이션 지속 시간 (ms)
        );
    }
});
