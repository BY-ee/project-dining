document.addEventListener("DOMContentLoaded", function() {
	const searchBtn = document.getElementById("searchBtn");
	if (searchBtn) {
			searchBtn.style.display = "block";
			searchBtn.onclick = function() {
		console.log("Filter criteria:", {
										industry: selectedIndustry,
										subCategory: selectedSubCategory,
										themes: selectedThemes
								});
		filterByCategory(selectedIndustry, selectedSubCategory, selectedThemes);
		
		toggleCategoryPopup();
	}
	} else {
			console.error("Search button not found in DOM");
	}
});

let selectedIndustry = "";
let selectedSubCategory = "";
let selectedThemes = [];
let selectedOrder = "";



// 카테고리 팝업 표시/숨기기
function toggleCategoryPopup() {
	const categoryPopup = document.getElementById("categoryPopup");
	categoryPopup.style.display = categoryPopup.style.display === "none" ? "block" : "none";
}


// 업종 선택
function selectIndustry(industry) {
	selectedIndustry = industry;
	selectedSubCategory = "";
	selectedThemes = []; // 테마 초기화하여 중복 방지

	// 세부 항목과 테마 선택 초기화
	document.getElementById("selectedIndustryOptions").style.display = "none";
	document.getElementById("themeStep").style.display = "none";

	showSubCategoryOptions(industry);
}

// 선택한 업종에 따른 세부 항목 표시
function showSubCategoryOptions(industry) {
	const selectedIndustryOptions = document.getElementById("selectedIndustryOptions");
	selectedIndustryOptions.style.display = "block";
	selectedIndustryOptions.innerHTML = `<h3>${industry} 선택</h3>`;

	let options = [];
	if (industry === "음식점") {
			options = ["한식", "일식", "중식", "양식"];
	} else if (industry === "카페") {
			options = ["핸드드립", "셀프 로스팅", "빵 맛집"];
	} else if (industry === "술집") {
			options = ["포차", "세계맥주", "와인바", "펍", "바"];
	}

	options.forEach(option => {
			const button = document.createElement("button");
			button.textContent = option;
			button.classList.add("category-step-btn");
			button.onclick = () => selectSubCategory(option);
			selectedIndustryOptions.appendChild(button);
	});
}

// 세부 항목 선택
function selectSubCategory(subCategory) {
	if (event) event.preventDefault(); // 기본 동작 방지

	selectedSubCategory = subCategory;
	document.getElementById("themeStep").style.display = "block";
	
}

// 테마 선택
function selectTheme(theme) {
	if (event) event.preventDefault(); // 기본 동작 방지

	const themeIndex = selectedThemes.indexOf(theme);
	if (themeIndex === -1) {
			selectedThemes.push(theme);
	} else {
			selectedThemes.splice(themeIndex, 1);
	}
	console.log("Selected themes:", selectedThemes); // 선택된 테마 확인
}

// 선택된 데이터를 반환하는 함수 추가
function getSelectedThemes() {
    return {
        industry: selectedIndustry,
        subCategory: selectedSubCategory,
        themes: selectedThemes
    };
}

function getSelectedThemeString() {
    const { industry, subCategory, themes } = getSelectedThemes();

    // 업종, 세부 항목, 테마를 하나의 문자열로 조합
    const themeString = [
        industry || "미선택",             // 업종
        subCategory || "미선택",          // 세부 항목
        themes.join(", ") || "미선택"     // 테마 배열을 문자열로 조합 (콤마로 구분)
    ].join(" > ");                        // '>' 구분자로 조합

    console.log("Combined Theme String:", themeString);
    return themeString;
}