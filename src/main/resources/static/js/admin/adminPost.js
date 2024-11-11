$(() => {
    // 임시 데이터 (db 연동 시 함수로 데이터를 가져옴)
    const menu = `
    <div style="display: flex; margin: 20px 0;">
        <img src="https://www.hsd.co.kr/images/b962162cb6074df090418f0f5c63b9b220241031041026.jpg" 
        style="width: 200px; margin-right: 10px; align-self: center;" alt="img" />
        <div>
            <h3 style="margin-bottom: 10px;">오모가리 김치제육덮밥</h4>
            <span>500일 저온 숙성된 오모가리 김치 특유의 묵은지 감칠맛과 매콤 달콤한 제육이 만나 깊고 풍성한 맛을 자랑하는 한솥만의 특별한 '오모가리 김치제육덮밥'</span>
        </div>
    </div>

    <hr />

    <div style="display: flex; margin: 20px 0;">
        <img src="https://www.hsd.co.kr/images/307601a3e71440d391e79a1d88fe634a20240930040239.jpg" 
        style="width: 200px; margin-right: 10px; align-self: center;" alt="img" />
        <div>
            <h3 style="margin-bottom: 10px;">한우 함박스테이크& 청양 토네이도 소세지</h3>
            <span>한우 농가 상생 메뉴로 육즙 가득한 한우 함박스테이크와 풍미 깊은 데미그라스 소스, 매콤한 청양 토네이도 소세지와 해시 포테이토 스틱, 고구마 샐러드 등 푸짐한 사이드 메뉴로 구성된 '한우 함박스테이크& 청양 토네이도 소세지'</span>
        </div>
    </div>

    <hr />

    <div style="display: flex; margin: 20px 0;">
        <img src="https://www.hsd.co.kr/images/b52880638a704456b8c1e77093f97bb920240930041058.jpg" 
        style="width: 200px; margin-right: 10px; align-self: center;" alt="img" />
        <div>
            <h3 style="margin-bottom: 10px;">제주녹차 미니꿀호떡</h3>
            <span>제주산 녹차로 은은한 향과 깊은 맛을 더하고, 쫄깃한 식감에 견과류와 꿀이 어우러져 고소하고 달콤한 '제주녹차 미니꿀호떡'</span>
        </div>
    </div>

    <hr />
    `;

    // 게시글에서 메뉴 확인 클릭 시 팝업창 띄우기
    $('.menu-link').each((index, link) => {
        $(link).on('click', (e) => {
            e.preventDefault();
            $('#menu-content').html(menu);
            $('#popup-overlay').css('display', 'flex');
        });
    });
});

// 메뉴 가져오는 함수
function getMenu() {
    $.ajax({
        url: ``,
        type: 'GET',
        success: (menu) => {
            
        }
    });
}

function closePopup() {
    $('#popup-overlay').css('display', 'none');
}