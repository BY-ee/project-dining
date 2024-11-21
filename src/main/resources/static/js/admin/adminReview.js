$(() => {
    // 리뷰관리의 리뷰 클릭 시 팝업창 띄우기
    $('.review-link').each((index, link) => {
        $(link).on('click', (e) => {
            e.preventDefault();
            const content = $(link).data('content');
            const image = $(link).data('image');
            const storeName = $(link).data('store-name');
            const nickname = $(link).data('nickname');
            renderReviewPopup(content, image, storeName, nickname);
            openPopup();
        });
    });

    // // 상세리뷰 데이터를 가져와서 페이지에 데이터 추가
    // function selectDetailReview(nickname, storeName) {
    //     $.ajax({
    //         url: `/admin/reviews/detail`,
    //         type: 'GET',
    //         data: {
    //             nickname: nickname,
    //             storeName: storeName
    //         },
    //         success: (review) => {
    //             renderReviewPopup(review)
    //             openPopup();
    //         },
    //         error: (e) => {
    //             console.error(e.responseText);
    //         }
    //     });
    // }

    // 리뷰 데이터를 팝업에 렌더링
    function renderReviewPopup(content, image, storeName, nickname) {
        const imageLinks = image.split(',');
        const imageDOM = imageLinks.map(link => `<img src="/images/${link.trim()}" style="margin: 20px auto; width: 200px;" alt="Review Image" />`).join('');

        const reviewDOM = `
            <div class="container">
                <h2>${storeName}</h2>
                <h4 style="text-align: right; margin-right: 60px;">작성자: ${nickname}</h4>
                <div style="display: flex; flex-direction: column;">
                    ${imageDOM}
                </div>
                <span style="word-wrap: break-word;">${content}</span>
            </div>
        `;

        $('#review-content').html(reviewDOM);
        $('.popup-content').css({
            'width': '600px',
            'height': 'auto',
            'min-height': '400px',
            'max-height': '800px'
        });
    }


    // 리뷰 게시 상태에 따라 글자색 변경
    const statusColor = {
        'active': '#79f',
        'inactive': '#f66'
    }

    $('.review-status').each(function() {
        const status = $(this).data('status');
        const color = statusColor[status];
        if (color) {
            $(this).css({
                'color': color
            });
        }
    });

    // 리뷰의 게시중단 버튼 클릭
    $('.inactivate-btn').on('click', function() {
        const reviewId = $(this).data('id');
        $.ajax({
            url: `/admin/reviews/${reviewId}/inactivate`,
            type: 'POST',
            success: (result) => {
                const $statusTd = $(`.review-status[data-id="${reviewId}"]`);
                $statusTd.text(result).css({
                    'color': '#f66'
                });
            },
            error: (e) => {
                console.error(e.responseText);
            }
        });
    });

    // 리뷰의 재게시 버튼 클릭
    $('.reactivate-btn').on('click', function() {
        const reviewId = $(this).data('id');
        $.ajax({
            url: `/admin/reviews/${reviewId}/reactivate`,
            type: 'POST',
            success: (result) => {
                const $statusTd = $(`.review-status[data-id="${reviewId}"]`);
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