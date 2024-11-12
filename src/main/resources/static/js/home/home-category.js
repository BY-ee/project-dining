let selectedIndustry = "";
let selectedSubCategory = "";
let selectedTheme = "";

// 카테고리 팝업 표시/숨기기
function toggleCategoryPopup() {
    const categoryPopup = document.getElementById("categoryPopup");
    categoryPopup.style.display = categoryPopup.style.display === "none" ? "block" : "none";
}


// 업종 선택
function selectIndustry(industry) {
    selectedIndustry = industry;
    selectedSubCategory = ""; // 세부 항목 초기화
    selectedTheme = ""; // 테마 초기화

    // 세부 항목과 테마 선택 초기화
    document.getElementById("selectedIndustryOptions").style.display = "none";
    document.getElementById("themeStep").style.display = "none";
    document.getElementById("searchBtn").style.display = "none";

    // 선택한 업종에 따른 세부 항목 표시
    showSubCategoryOptions(industry);
}

// 선택한 업종에 따른 세부 항목 표시
function showSubCategoryOptions(industry) {
    const selectedIndustryOptions = document.getElementById("selectedIndustryOptions");
    selectedIndustryOptions.style.display = "block";
    selectedIndustryOptions.innerHTML = `<h3>${industry} 선택</h3>`; // 새로운 업종에 맞는 타이틀 설정

    // 업종에 따른 세부 항목 설정
    let options = [];
    if (industry === "음식점") {
        options = ["한식", "일식", "중식", "양식"];
    } else if (industry === "카페") {
        options = ["핸드드립", "셀프 로스팅", "빵 맛집"];
    } else if (industry === "술집") {
        options = ["포차", "세계맥주", "와인바", "펍"];
    }

    // 세부 항목 버튼 추가
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
    selectedSubCategory = subCategory;

    // 테마 선택 단계 표시
    document.getElementById("themeStep").style.display = "block";
}

// 테마 선택
function selectTheme(theme) {
    selectedTheme = theme;

    // 검색 버튼 표시
    document.getElementById("searchBtn").style.display = "block";
}

// 검색 버튼 클릭
function searchStores() {
    alert(`검색: 업종 - ${selectedIndustry}, 세부 항목 - ${selectedSubCategory}, 테마 - ${selectedTheme}`);
    // 검색 결과 표시 로직 추가 가능
}



	var userId = "${sessionScope.user_ID != null ? sessionScope.user_ID : ''}";

    function goToStoreDetail(storeId) {	        
        var url = '/storeDetail?store_ID=' + storeId;
        if (userId && userId.trim() !== "") {  
            url += '&user_ID=' + userId;
        }
        window.location.href = url;  
    }
    
    function filterByLocation(locationCode, locationName) {
        console.log("Selected location:", locationName); // 로그 추가
        document.getElementById("location-btn").innerText = locationName;

        $.ajax({
            url: "/storesByLocation",
            type: "GET",
            data: { location: locationCode === "ALL" ? "" : locationCode },
            success: function(stores) {

                let html = '';
                stores.forEach(function(store) {
                    html += '<div class="store-item-box" onclick="goToStoreDetail(' + store.id + ')">' +
                                '<div class="store-item">' +
                                    '<img src="/images/store/' + store.mainImage1 + '" alt="' + store.storeName + ' 이미지">' +
                                '</div>' +
                                '<div class="store-name">' + store.storeName + '</div>' +
                            '</div>';
                });
                $("#store-list-container").html(html);
            },
            error: function() {
                alert("가게 목록을 불러오는 중 문제가 발생했습니다.");
            }
        });
    }
	
	
	
	/* 정렬 기능 구현*/