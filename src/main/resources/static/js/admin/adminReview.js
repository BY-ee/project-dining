$(() => {
    // 임시 데이터 (db 연동 시 함수로 데이터를 가져옴)
    const review = `
    <p style="margin-bottom: 10px">
        In my last blog I discussed the need for referencing in articles submitted to the journal.
        One of the reasons for referencing that I mentioned was that it gives credibility to your work.
        The process of reviewing also lends credibility because, by the time a paper is published,
        it has been through a rigorous screening (review) process.
        The method of reviewing papers is one of the reasons that it can take quite some time before a paper is finally published.
    </p>

    <p style="margin-bottom: 10px">
        Over the next few blogs, I will explain the review process of the IAFOR Journal of Education and also outline
        what is included in the review form. This should be of assistance for those of you submitting papers
        and also for anyone who hopes to become a reviewer. This week concentrates on the start of the process.
        A flowchart of the full review process can be found at https://iafor.org/journal/iafor-journal-of-education/publication-process-flowchart/.
    </p>
    `;

    // 리뷰관리의 리뷰 클릭 시 팝업창 띄우기
    $('.review-link').each((index, link) => {
        $(link).on('click', (e) => {
            e.preventDefault();
            $('#review-content').html(review);
            $('#popup-overlay').css('display', 'flex');
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