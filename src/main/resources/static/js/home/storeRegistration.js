// 전역 변수 선언
let selectedIndustry = ""; // 선택된 업종
let selectedSubCategory = ""; // 선택된 세부 항목
let selectedThemes = []; // 선택된 테마 목록

// 업종 선택
function selectIndustry(industry) {
    selectedIndustry = industry;
    selectedSubCategory = ""; // 세부 항목 초기화
    selectedThemes = []; // 테마 초기화하여 중복 방지

    // 콘솔에 선택된 업종 로그 출력
    console.log("선택된 업종:", selectedIndustry);

    // 버튼 스타일 업데이트
    $(".industry-btn").removeClass("active");
    $(`button[data-industry="${industry}"]`).addClass("active");

    // 세부 항목과 테마 선택 UI 초기화
    $("#selectedIndustryOptions").hide();
    $("#themeStep").hide();

    // 세부 항목 옵션 표시
    showSubCategoryOptions(industry);
}


// 선택한 업종에 따른 세부 항목 표시
function showSubCategoryOptions(industry) {
    const $selectedIndustryOptions = $("#selectedIndustryOptions");
    $selectedIndustryOptions.show(); // display: block
    $selectedIndustryOptions.html(`<h3>${industry} 선택</h3>`); // 제목 표시

    let options = [];
    if (industry === "음식점") {
        options = ["한식", "일식", "중식", "양식"];
    } else if (industry === "카페") {
        options = ["핸드드립", "셀프 로스팅", "빵 맛집"];
    } else if (industry === "술집") {
        options = ["포차", "세계맥주", "와인바", "펍", "바"];
    }

    // 세부 항목 버튼 생성
    options.forEach(option => {
        const $button = $("<button>")
            .attr({
                type: "button",               // 기본 제출 동작 방지
                "data-subcategory": option,   // data 속성 설정
                id: `subcategory-${option}`,  // 고유 id 추가
                name: "subcategory"           // name 속성 추가
            })
            .addClass("subcategory-btn")      // 클래스 추가
            .text(option)                     // 버튼 텍스트 설정
            .on("click", () => selectSubCategory(option)); // 클릭 이벤트 추가

        $selectedIndustryOptions.append($button); // 버튼 추가
    });
}


// 세부 항목 선택
function selectSubCategory(subCategory) {
    selectedSubCategory = subCategory;

    // 콘솔에 선택된 세부 항목 로그 출력
    console.log("선택된 세부 항목:", selectedSubCategory);

    // 버튼 스타일 업데이트
    $(".subcategory-btn").removeClass("active"); // 모든 버튼에서 "active" 클래스 제거
    $(`button[data-subcategory="${subCategory}"]`).addClass("active"); // 선택된 버튼에 "active" 클래스 추가

    // 테마 선택 UI 표시
    $("#themeStep").show(); // display: block
}


// 테마 선택
function selectTheme(theme) {
    const themeIndex = selectedThemes.indexOf(theme);
    
    if (themeIndex === -1) {
        selectedThemes.push(theme); // 테마 추가
        $(`button[data-theme="${theme}"]`).addClass("active"); // 버튼 활성화
    } else {
        selectedThemes.splice(themeIndex, 1); // 테마 제거
        $(`button[data-theme="${theme}"]`).removeClass("active"); // 버튼 비활성화
    }
    
    // 콘솔에 선택된 테마 목록 로그 출력
    console.log("선택된 테마:", selectedThemes);
}


// 데이터 폼에 추가
function prepareFormData() {
    $("#hiddenIndustry").val(selectedIndustry || ""); // 업종 값 설정
    $("#hiddenSubCategory").val(selectedSubCategory || ""); // 세부 항목 값 설정
    $("#hiddenThemes").val(selectedThemes.join(",") || ""); // 테마 값 설정

    // 폼 제출 전 콘솔에 선택된 값 출력
    console.log("폼 데이터 준비:");
    console.log("업종:", selectedIndustry);
    console.log("세부 항목:", selectedSubCategory);
    console.log("테마:", selectedThemes.join(","));
}

// 유효성 검사
$('.submit-btn').on('click', function() {
    let isSubmit = true;
    $('#location-message').text('');
    $('#storeName-message').text('');
    $('#ceoName-message').text('');
    $('#tel-message').text('');
    $('#address-message').text('');
    $('#openTime-message').text('');
    $('#storeDescription-message').text('');    

    if($('#location').val() == '') {
        $('#location-message').text('지역을 선택하세요.');
        $('#location').focus();
        return false;
    }

    if($('#storeName').val() == '') {
        $('#storeName-message').text('가게 이름을 입력하세요.');
        $('#storeName').focus();
        return false;
    }

    if($('#ceoName').val() == '') {
        $('#ceoName-message').text('대표자 이름을 입력하세요.');
        $('#ceoName').focus();
        return false;
    }

    if($('#tel').val() == '') {
        $('#tel-message').text('연락처를 입력하세요.');
        $('#tel').focus();
        return false;
    }

    if($('#address').val() == '') {
        $('#address-message').text('가게 주소를 입력하세요.');
        $('#address').focus();
        return false;
    }

    if($('#detailAddress').val() == '') {
        $('#address-message').text('가게 상세 주소를 입력하세요.');
        $('#detailAddress').focus();
        return false;
    }

    if($('#openTime').val() == '') {
        $('#openTime-message').text('영업 시간을 입력하세요.');
        $('#openTime').focus();
        return false;
    }

    if($('#storeDescription').val().length < 10) {
        $('#storeDescription-message').text('가게 설명을 10자 이상 입력하세요.');
        $('#storeDescription').focus();
        return false;
    }

    if($('#storeDescription').val().length > 500) {
        $('#storeDescription-message').text('가게 설명을 500자 이상으로 입력할 수 없습니다.');
        $('#storeDescription').focus();
        return false;
    }

    if(!$('.consent').prop('checked')) {
        alert('정보 수집 및 이용 동의는 필수 항목입니다.');
        $('.consent').focus();
        return false;
    }
});

$('.char-count').text($('#storeDescription').val().length);

// 입력 이벤트 처리
$('#storeDescription').on('input', function () {
    let input = $(this).val();

    if (input.length >= 500) {
        $('#storeDescription-message').text('최대 글자수에 도달했습니다.');
        $(this).val(input);
    } else {
        $('#storeDescription-message').text(''); // 메시지 제거
    }

    // 현재 글자 수 업데이트
    $('.char-count').text($(this).val().length);
});