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
    document.querySelectorAll(".industry-btn").forEach(btn => btn.classList.remove("active"));
    document.querySelector(`button[data-industry="${industry}"]`).classList.add("active");

    // 세부 항목과 테마 선택 UI 초기화
    document.getElementById("selectedIndustryOptions").style.display = "none";
    document.getElementById("themeStep").style.display = "none";

    // 세부 항목 옵션 표시
    showSubCategoryOptions(industry);
}

// 선택한 업종에 따른 세부 항목 표시
function showSubCategoryOptions(industry) {
    const selectedIndustryOptions = document.getElementById("selectedIndustryOptions");
    selectedIndustryOptions.style.display = "block";
    selectedIndustryOptions.innerHTML = `<h3>${industry} 선택</h3>`; // 제목 표시

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
        const button = document.createElement("button");
		button.type = "button"; // 기본 제출 동작 방지
        button.textContent = option;
        button.classList.add("subcategory-btn");
        button.setAttribute("data-subcategory", option);
		button.id = `subcategory-${option}`; // 고유 id 추가
		button.name = "subcategory"; // name 추가
        button.onclick = () => selectSubCategory(option);
        selectedIndustryOptions.appendChild(button);
    });
}

// 세부 항목 선택
function selectSubCategory(subCategory) {
    selectedSubCategory = subCategory;
    
    // 콘솔에 선택된 세부 항목 로그 출력
    console.log("선택된 세부 항목:", selectedSubCategory);

    // 버튼 스타일 업데이트
    document.querySelectorAll(".subcategory-btn").forEach(btn => btn.classList.remove("active"));
    const selectedButton = document.querySelector(`button[data-subcategory="${subCategory}"]`);
    if (selectedButton) {
        selectedButton.classList.add("active");
    }

    document.getElementById("themeStep").style.display = "block"; // 테마 선택 UI 표시
}

// 테마 선택
function selectTheme(theme) {
    const themeIndex = selectedThemes.indexOf(theme);
    if (themeIndex === -1) {
        selectedThemes.push(theme);
        document.querySelector(`button[data-theme="${theme}"]`).classList.add("active");
    } else {
        selectedThemes.splice(themeIndex, 1);
        document.querySelector(`button[data-theme="${theme}"]`).classList.remove("active");
    }
    
    // 콘솔에 선택된 테마 목록 로그 출력
    console.log("선택된 테마:", selectedThemes);
}

// 데이터 폼에 추가
function prepareFormData() {
    document.getElementById("hiddenIndustry").value = selectedIndustry || "";
    document.getElementById("hiddenSubCategory").value = selectedSubCategory || "";
    document.getElementById("hiddenThemes").value = selectedThemes.join(",") || "";
    
    // 폼 제출 전 콘솔에 선택된 값 출력
    console.log("폼 데이터 준비:");
    console.log("업종:", selectedIndustry);
    console.log("세부 항목:", selectedSubCategory);
    console.log("테마:", selectedThemes.join(","));
}
