$(() => {
    // 공지 작성 버튼 클릭하면 실행
    $('#write-notice-btn').on('click', () => {
        const category = $('#category').val();
        const title = $('#title').val();
        const content = $('#content').val();

        // 유효성 검증
        if (!category || !title || !content) {
            alert('모든 항목을 입력하세요.');
            return;
        }
        
        const notice = {
            category: category,
            title: title,
            content: content
        };

        // 공지글 작성
        $.ajax({
            url: '/admin/notice/write',
            type: 'POST',
            data: JSON.stringify(notice),
            contentType: 'application/json',
            success: () => {
                alert('공지를 작성하였습니다.');
                location.href = '/admin/notice';
            },
            error: (error) => {
                alert(`공지 작성 실패: ${error.responseJSON?.message || '알 수 없는 오류'}`);
            }
        });
    });
});

function showFileName() {
    const fileInput = document.getElementById('file-upload');
    const fileNameDisplay = document.getElementById('file-name');
    
    // 선택된 파일의 이름을 표시
    if (fileInput.files.length > 0) {
        fileNameDisplay.textContent = fileInput.files[0].name;
    } else {
        fileNameDisplay.textContent = '선택된 파일이 없습니다.';
    }
}