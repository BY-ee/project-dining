$(() => {
    // 리뷰관리의 리뷰 클릭 시 팝업창 띄우기
    $('.review-link').each((index, link) => {
        $(link).on('click', (e) => {
            e.preventDefault();
            const reviewId = $(link).data('id');
            selectDetailReview(reviewId);
        });
    });

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

// 상세리뷰 데이터를 가져와서 페이지에 데이터 추가
function selectDetailReview(reviewId) {
    $.ajax({
        url: `/admin/reviews/detail-with-member/${reviewId}`,
        type: 'GET',
        success: (review) => {
            $('.popup-title').text(review.nickname);
            $('#review-content').html(review.content);
            $('#popup-overlay').css('display', 'flex');
        },
        error: (e) => {
            console.error(e.responseText);
        }
    });
}

function closePopup() {
    $('#popup-overlay').css('display', 'none');
}