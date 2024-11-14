$(() => {
    // 이벤트글 게시 상태에 따라 글자색 변경
    const statusColor = {
        'active': '#79f',
        'inactive': '#f66'
    }

    $('.event-status').each(function() {
        const status = $(this).data('status');
        const color = statusColor[status];
        if (color) {
            $(this).css({
                'color': color
            });
        }
    });

    // 이벤트 작성 버튼 클릭하면 실행
    $('#write-event-btn').on('click', () => {
        const category = $('#category').val();
        const title = $('#title').val();
        const content = $('#content').val();
        const startDate = new Date($('#start-date').val()).toISOString().slice(0, -1);
        const endDate = new Date($('#end-date').val()).toISOString().slice(0, -1);
        const eventImageInput = $('#event-image')[0].files[0];
        console.dir(startDate);
        console.dir(endDate);
    
        // 유효성 검증
        if (!category || !title || !content || !startDate || !endDate) {
            alert('모든 항목을 입력하세요.');
            return;
        }
    
        // FormData 객체 생성 및 데이터 추가
        const formData = new FormData();
        formData.append("category", category);
        formData.append("title", title);
        formData.append("content", content);
        formData.append("startDate", startDate);
        formData.append("endDate", endDate);
        if (eventImageInput) {
            formData.append("imagePath", eventImageInput);
        }
    
        // 이벤트글 작성
        $.ajax({
            url: '/admin/events/write',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: () => {
                alert('이벤트 글을 작성하였습니다.');
                location.href = '/admin/events';
            },
            error: (e) => {
                alert(`글 작성 실패: ${e.responseText || '알 수 없는 오류'}`);
            }
        });
    });

    // 이벤트 수정 버튼 클릭하면 실행
    $('#edit-event-btn').on('click', () => {
        const category = $('#category').val();
        const title = $('#title').val();
        const content = $('#content').val();
        const startDate = new Date($('#start-date').val()).toISOString();
        const endDate = new Date($('#end-date').val()).toISOString();
        const eventImageInput = $('#event-image')[0].files[0];
    
        // 유효성 검증
        if (!category || !title || !content || !startDate || !endDate) {
            alert('모든 항목을 입력하세요.');
            return;
        }
    
        // FormData 객체 생성 및 데이터 추가
        const formData = new FormData();
        formData.append("category", category);
        formData.append("title", title);
        formData.append("content", content);
        formData.append("startDate", startDate);
        formData.append("endDate", endDate);
        if (eventImageInput) {
            formData.append("imagePath", eventImageInput);
        }
    
        // 이벤트글 작성
        const path = window.location.pathname;
        const pathParts = path.split('/');
        const eventId = pathParts[3];

        $.ajax({
            url: `/admin/events/${eventId}/edit`,
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: () => {
                alert('글이 수정되었습니다.');
                location.href = '/admin/events';
            },
            error: (e) => {
                alert(`글 수정 실패: ${e.responseText || '알 수 없는 오류'}`);
            }
        });
    });

    // 이벤트글 게시중단 버튼 클릭
    $('.inactive-event').on('click', function(e) {
        e.preventDefault();
        const eventId = $(this).data('eventId');
        $.ajax({
            url: `/admin/events/${eventId}/inactivate`,
            type: 'POST',
            success: () => {
                location.href = '/admin/events';
            },
            error: (e) => {
                alert(`글 게시중단 실패: ${e.responseText || '알 수 없는 오류'}`);
            }
        });
    });

    // 이벤트글 재게시 버튼 클릭
    $('.reactive-event').on('click', function(e) {
        e.preventDefault();
        const eventId = $(this).data('eventId');
        $.ajax({
            url: `/admin/events/${eventId}/reactivate`,
            type: 'POST',
            success: () => {
                location.href = '/admin/events';
            },
            error: (e) => {
                alert(`글 재게시 실패: ${e.responseText || '알 수 없는 오류'}`);
            }
        });
    });

    // 파일 업로드 이벤트
    $('#event-image').on('change', () => {
        const $eventImageInput = $('#event-image');
        const $fileNameDisplay = $('#file-name');
        
        // 선택된 파일의 이름을 표시
        if ($eventImageInput.get(0).files.length > 0) {
            const fileName = $eventImageInput.get(0).files[0].name;
            const validExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp']; // 허용하는 확장자 목록
            const fileExtension = fileName.split('.').pop().toLowerCase();
        
            // 파일 확장자가 유효한지 검사
            if (validExtensions.includes(fileExtension)) {
                $fileNameDisplay.text(fileName); // 파일 이름 표시
            } else {
                alert('사진 파일을 선택해 주세요.');
                $fileNameDisplay.text('선택된 파일이 없습니다.');
                $eventImageInput.val(''); // 파일 입력 필드 초기화
            }
        } else {
            $fileNameDisplay.text('선택된 파일이 없습니다.');
        }
    });
});