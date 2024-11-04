// 파일 개수 제한 및 파일 이름 가로 표시 함수
function handleFileInput(event, maxFiles, namesElementId) {
    const input = event.target;
    const namesElement = document.getElementById(namesElementId);

    // 선택된 파일이 maxFiles를 초과하면 경고 메시지와 함께 초기화
    if (input.files.length > maxFiles) {
        alert(`최대 ${maxFiles}개의 파일만 업로드할 수 있습니다.`);
        input.value = ""; // 선택된 파일 초기화
        namesElement.textContent = ""; // 파일 이름 초기화
        return;
    }

    // 선택된 파일 이름들을 가로로 표시
    const fileNames = Array.from(input.files).map(file => file.name).join(", ");
    namesElement.textContent = `${fileNames} (${input.files.length}개 파일)`;
}

// 각각의 파일 입력 필드에 개수 제한 및 파일 이름 표시 적용
document.getElementById('menuPhotos').addEventListener('change', function(event) {
    handleFileInput(event, 4, 'menuPhotosNames'); // menuPhotos는 최대 4개로 제한
});

document.getElementById('storePhotos').addEventListener('change', function(event) {
    handleFileInput(event, 2, 'storePhotosNames'); // storePhotos는 최대 2개로 제한
});