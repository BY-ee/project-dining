$(() => {
    // 임시 데이터 (db 연동 시 함수로 데이터를 가져옴)
    const intro = `
    <p style="margin: 5px 0">
        독특한 음색을 주 무기로 사용하는 가수로서 뇌쇄적이지만 한편으로는 유리알처럼 맑고 선명한 매력적인 음색을 소유하고 있다.
        블랙핑크의 팬이 아닌 사람조차 그녀의 목소리는 쉽게 구별할 수 있을 만큼 독보적이다.
        오죽하면 복면가왕에 출연 당시 패널들과 시청자들이 가면 쓴 게 무의미하다고 했을 정도.
        메인보컬로서 주로 찐득한 음색과 뛰어난 가창력으로 BLACKPINK에서 음악성의 중심을 단단히 잡아주는 역할을 한다.
        양산형 보컬과 흔히 메인보컬에게 요구하는 고음셔틀 등이 널리고 널린 레드오션 경쟁 속에 로제만의 이 독특함은
        리스너들이 그녀의 노래를 자꾸 찾게 만드는 매우 중독적인 무기가 된다.
    </p>

    <p style="margin: 5px 0">
        보통 음색으로 대결하는 가수는 성량이나 가창력이 뛰어나지 않은 게 다반사이지만 로제는 그 음색을 유지하면서 진성으로 큰 성량의 고음을 낸다.
        주로 중저음~중고음 구간에서 음색이 매우 농염하며 고음에서는 특히, 가성보단 진성 고음을 낼 때 비단뱀이 지나가는 듯한 섹시한 음색,
        끝처리에 독특하게 숨을 내뱉는 스타일과 함께 밀도 있는 단단한 성량을 자랑한다.
        현재까지 확인된 음역대는 최저음 1옥타브 도(C3)[47], 라이브에서 선보인 고음은 가성 3옥타브 솔#(G#5)[48],
        라이브 진성 고음은 3옥타브 파(F5)이며[49], 녹음에서는 믹스나인 테마곡 Just Dance 가이드 보컬에서의 진성 3옥타브 솔(G5)로 꽤나 넓은 음역대를 보여준다.
    </p>

    <p style="margin: 5px 0">
        로제의 기본적인 발성은 비성에 베이스를 두는데 여기에 독특한 창법과 수려한 기교를 가미하여 농염한 음색과 스타일을 만들어낸다.
        로제의 이 독창적인 그루브와 목소리는 테디가 작곡한 블랙핑크 곡들이나 팝송과 만나면 시너지가 좋은 편인데,
        이것은 로제의 보컬이 스탠다드한 기본기 탄탄한 발성보다 YG엔터테인먼트가 추구하는 스타일리쉬한 보컬이기 때문이다.
        하지만 이 창법은 단점과 장점이 명확하다. 단점은 창법으로 인한 호흡이 부족하여 따라오는 음정 불안이라고 말할 수 있다.
        때문에 로제는 간혹 라이브에서 고음역대를 시도하거나 맞지않는 장르와 만나면 음정이 불안해진다.
        또한 BLACKPINK 곡들의 춤 난이도가 전반적으로 어렵고 격함에도 불구하고 로제는 춤을 추면서도 꽤나 안정적으로 고음을 내며 라이브를 잘하지만
        춤추는 것과 더불어 창법 특성상 호흡 컨트롤이 벅차 다른 멤버보다 종종 음정이 불안하게 들리기도 한다.
        특이하게 로제는 이 단점을 수려한 기교로 장식하여 더 매력적으로 들리게 한다.
    </p>
    `;

    // 회원의 자기소개 확인 링크 클릭 시 팝업창 띄우기
    $('.intro-link').each((index, link) => {
        $(link).on('click', (e) => {
            e.preventDefault();
            $('#intro-content').html(intro);
            $('#popup-overlay').css('display', 'flex');
        });
    });

    // 회원의 상태에 따라 글자색 변경
    const statusColor = {
        'active': '#79f',
        'inactive': '#f66'
    }

    $('.member-status').each(function() {
        const status = $(this).data('status');
        const color = statusColor[status];
        if (color) {
            $(this).css({
                'color': color
            });
        }
    });

    // 회원 차단 버튼 클릭
    $('.block-btn').on('click', function() {
        const memberId = $(this).data('id');
        $.ajax({
            url: `/admin/members/${memberId}/block`,
            type: 'POST',
            success: (result) => {
                const $statusTd = $(`.member-status[data-id="${memberId}"]`);
                $statusTd.text(result).css({
                    'color': '#f66'
                });
            },
            error: (e) => {
                alert('Error occurred' + e.message);
            }
        });
    });

    // 회원 차단 해제 버튼 클릭
    $('.unblock-btn').on('click', function() {
        const memberId = $(this).data('id');
        $.ajax({
            url: `/admin/members/${memberId}/unblock`,
            type: 'POST',
            success: (result) => {
                const $statusTd = $(`.member-status[data-id="${memberId}"]`);
                $statusTd.text(result).css({
                    'color': '#79f'
                });
            },
            error: (e) => {
                alert('Error occurred' + e.message);
            }
        });
    });
});

// 회원의 자기소개 가져오는 함수
function getIntroduction() {
    $.ajax({
        url: ``,
        type: 'GET',
        success: (introduction) => {
            
        }
    });
}

function closePopup() {
    $('#popup-overlay').css('display', 'none');
}