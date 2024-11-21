$(() => {
    // 유저 아이디 클릭 시 팝업창 띄우기
    $('.member-link').on('click', function(e) {
        e.preventDefault();
        const memberId = $(this).data('id');
        const review = $(this).data('review');
        getMember(memberId, review);
    });

    // 유저 데이터 가져오는 함수
    function getMember(memberId, review) {
        $.ajax({
            url: `/admin/members/${memberId}`,
            type: 'GET',
            success: (member) => {
                renderMemberPopup(member, review);
                openPopup();
            }
        });
    }

    // 유저 데이터를 팝업에 렌더링
    function renderMemberPopup(member, review) {
        const memberDOM = `
            <h2 style="margin-bottom: 20px;">${member.nickname}</h2>
                
            <section>
                <label for="id">Id</label>
                <p id="id">${member.id}</p>
                
                <label for="category">분류</label>
                <p id="category">${member.category}</p>
                
                <label for="registration-number">사업자 등록번호</label>
                <p id="registration-number">${member.registrationNumber}</p>
            </section>
        
            <section>
                <label for="member-id">계정</label>
                <p id="member-id">${member.memberId}</p>

                <label for="naver-id">네이버 계정</label>
                <p id="naver-id">${member.naverId}</p>

                <label for="google-id">구글 계정</label>
                <p id="google-id">${member.googleId}</p>
                
                <label for="kakao-id">카카오 계정</label>
                <p id="kakao-id">${member.kakaoId}</p>

                <label for="email">이메일</label>
                <p id="email">${member.email}</p>
            </section>
        
            <section>
                <label for="nickname">닉네임</label>
                <p id="nickname">${member.nickname}</p>

                <label for="introduction">자기소개</label>
                <p id="introduction">${member.introduction}</p>

                <label for="profile-image">프로필 사진</label>
                <img src="https://okky.kr/cat-footer.svg" alt="pfp" />
            </section>

            <section>
                <label for="created-at">가입일</label>
                <p id="created-at">
                    ${formatISODateIntl(member.createdAt)}
                </p>
            
                <label for="status">상태</label>
                <p id="status">${member.status}</p>

                <label for="inactive-date">차단일</label>
                <p id="inactive-date">
                    ${formatISODateIntl(member.inactiveDate)}
                </p>

                <label for="reactive-date">차단해제일</label>
                <p id="reactive-date">
                    ${formatISODateIntl(member.reactiveDate)}
                </p>

                <label for="deleted-date">탈퇴일</label>
                <p id="deleted-date">
                    ${formatISODateIntl(member.deletedDate)}
                </p>
            </section>
        `;

        if(review) {
            $('#review-content').html(memberDOM);
            $('.popup-content').css({
                'width': '1000px',
                'height': '80vh',
                'max-height': '80vh'
            });
        } else {
            $('#member-content').html(memberDOM);
        }
    }

    // 날짜 형식 변환 함수
    function formatISODateIntl(isoDate) {
        const date = new Date(isoDate);

        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');
        const hours = String(date.getHours()).padStart(2, '0');
        const minutes = String(date.getMinutes()).padStart(2, '0');
        const seconds = String(date.getSeconds()).padStart(2, '0');
    
        if (year <= 1970) {
            return '-';
        }

        return `${year}.${month}.${day} ${hours}:${minutes}:${seconds}`;
    }

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
        const banTime = parseInt($(`.member-ban-time[data-id="${memberId}"]`).val());
        console.log(banTime);
        $.ajax({
            url: `/admin/members/${memberId}/block`,
            data: { 'banTime': banTime },
            type: 'POST',
            success: (result) => {
                const $statusTd = $(`.member-status[data-id="${memberId}"]`);
                $statusTd.text(result).css({
                    'color': '#f66'
                });
            },
            error: (e) => {
                console.error(e.responseText);
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
                console.error(e.responseText);
            }
        });
    });
});

function openPopup() {
    $('#popup-overlay').css('display', 'flex');
}

function closePopup() {
    $('#popup-overlay').css('display', 'none');
}