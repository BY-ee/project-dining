$(() => {
    // 공지글 게시 상태에 따라 글자색 변경
    const statusColor = {
        'active': '#79f',
        'inactive': '#f66'
    }

    $('.notice-status').each(function() {
        const status = $(this).data('status');
        const color = statusColor[status];
        if (color) {
            $(this).css({
                'color': color
            });
        }
    });

    // 공지 작성 버튼 클릭하면 실행
    $('#write-notice-btn').on('click', () => {
        const title = $('#title').val();
        const content = $('#content').val();
        const noticeImageInput = $('#notice-image')[0].files[0]; // 파일 객체
    
        // 유효성 검증
        if (!title || !content) {
            alert('모든 항목을 입력하세요.');
            return;
        }
    
        // FormData 객체 생성 및 데이터 추가
        const formData = new FormData();
        formData.append("title", title);
        formData.append("content", content);
        if (noticeImageInput) {
            formData.append("imagePath", noticeImageInput);
        }
    
        // 공지글 작성
        $.ajax({
            url: '/admin/notice/write',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: () => {
                alert('공지를 작성하였습니다.');
                location.href = '/admin/notice';
            },
            error: (e) => {
                alert(`공지 작성 실패: ${e.responseText || '알 수 없는 오류'}`);
            }
        });
    });

    // 공지 수정 버튼 클릭하면 실행
    $('#edit-notice-btn').on('click', () => {
        const title = $('#title').val();
        const content = $('#content').val();
        const noticeImageInput = $('#notice-image')[0].files[0]; // 파일 객체

        // 유효성 검증
        if (!title || !content) {
            alert('모든 항목을 입력하세요.');
            return;
        }
    
        // FormData 객체 생성 및 데이터 추가
        const formData = new FormData();
        formData.append("title", title);
        formData.append("content", content);
        if (noticeImageInput) {
            formData.append("imagePath", noticeImageInput);
        }
    
        // 공지글 작성
        const path = window.location.pathname;
        const pathParts = path.split('/');
        const id = pathParts[3];

        $.ajax({
            url: `/admin/notice/${id}/edit`,
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: () => {
                alert('공지가 수정되었습니다.');
                location.href = '/admin/notice';
            },
            error: (e) => {
                alert(`공지 수정 실패: ${e.responseText || '알 수 없는 오류'}`);
            }
        });
    });

    // 공지 게시중단 버튼 클릭
    $('.inactive-notice').on('click', function(e) {
        e.preventDefault();
        const noticeId = $(this).data('id');
        $.ajax({
            url: `/admin/notice/${noticeId}/inactivate`,
            type: 'POST',
            success: () => {
                location.href = '/admin/notice';
            },
            error: (e) => {
                alert(`공지 게시중단 실패: ${e.responseText || '알 수 없는 오류'}`);
            }
        });
    });

    // 공지 재게시 버튼 클릭
    $('.reactive-notice').on('click', function(e) {
        e.preventDefault();
        const noticeId = $(this).data('id');
        $.ajax({
            url: `/admin/notice/${noticeId}/reactivate`,
            type: 'POST',
            success: () => {
                location.href = '/admin/notice';
            },
            error: (e) => {
                alert(`공지 재게시 실패: ${e.responseText || '알 수 없는 오류'}`);
            }
        });
    });

    // 파일 업로드 이벤트
    $('#notice-image').on('change', () => {
        const $noticeImageInput = $('#notice-image');
        const $fileNameDisplay = $('#file-name');
        
        // 선택된 파일의 이름을 표시
        if ($noticeImageInput.get(0).files.length > 0) {
            const fileName = $noticeImageInput.get(0).files[0].name;
            const validExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp']; // 허용하는 확장자 목록
            const fileExtension = fileName.split('.').pop().toLowerCase();
        
            // 파일 확장자가 유효한지 검사
            if (validExtensions.includes(fileExtension)) {
                $fileNameDisplay.text(fileName); // 파일 이름 표시
            } else {
                alert('사진 파일을 선택해 주세요.');
                $fileNameDisplay.text('선택된 파일이 없습니다.');
                $noticeImageInput.val(''); // 파일 입력 필드 초기화
            }
        } else {
            $fileNameDisplay.text('선택된 파일이 없습니다.');
        }
    });
});