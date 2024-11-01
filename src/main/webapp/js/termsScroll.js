document.querySelectorAll('.terms-item a').forEach(anchor => {
    anchor.addEventListener('click', function(e) {
        e.preventDefault();
        const targetId = this.getAttribute('href').substring(1);
        const targetElement = document.getElementById(targetId);

        // 원하는 위치 조정 (여기서 위치 비율을 조정할 수 있음)
        window.scrollTo({
            top: targetElement.offsetTop - window.innerHeight / 3, // 화면의 1/3 높이로 조정
            behavior: 'smooth'
        });
    });
});