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
            error: (e) => {
                alert(`공지 작성 실패: ${e.responseText || '알 수 없는 오류'}`);
            }
        });
    });

    // 파일 업로드 이벤트
    $('#file-upload').on('change', () => {
        const $fileInput = $('#file-upload');
        const $fileNameDisplay = $('#file-name');
        
        // 선택된 파일의 이름을 표시
        if ($fileInput.get(0).files.length > 0) {
            const fileName = $fileInput.get(0).files[0].name;
            const validExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp']; // 허용하는 확장자 목록
            const fileExtension = fileName.split('.').pop().toLowerCase();
        
            // 파일 확장자가 유효한지 검사
            if (validExtensions.includes(fileExtension)) {
                $fileNameDisplay.text(fileName); // 파일 이름 표시
            } else {
                alert('사진 파일을 선택해 주세요.');
                $fileNameDisplay.text('선택된 파일이 없습니다.');
                $fileInput.val(''); // 파일 입력 필드 초기화
            }
        } else {
            $fileNameDisplay.text('선택된 파일이 없습니다.');
        }
    });
});