document.addEventListener("DOMContentLoaded", function() {
    const searchBtn = document.getElementById("searchBtn");
    if (searchBtn) {
        searchBtn.style.display = "block";
        searchBtn.onclick = function() {
			console.log("Filter criteria:", {
			                industry: selectedIndustry,
			                subCategory: selectedSubCategory,
			                themes: selectedTheme
			            });
			filterByCategory(selectedIndustry, selectedSubCategory, selectedTheme);
			
			toggleCategoryPopup();
		}
    } else {
        console.error("Search button not found in DOM");
    }
});

let selectedIndustry = "";
let selectedSubCategory = "";
let selectedTheme = [];  // 배열로 초기화하여 여러 선택 가능

// 카테고리 팝업 표시/숨기기
function toggleCategoryPopup() {
    const categoryPopup = document.getElementById("categoryPopup");
    categoryPopup.style.display = categoryPopup.style.display === "none" ? "block" : "none";
}


// 업종 선택
function selectIndustry(industry) {
    selectedIndustry = industry;
    selectedSubCategory = "";
    selectedTheme = []; // 테마 초기화하여 중복 방지

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
    selectedSubCategory = subCategory;
    document.getElementById("themeStep").style.display = "block";
}

// 테마 선택
function selectTheme(theme) {
    const themeIndex = selectedTheme.indexOf(theme);
    if (themeIndex === -1) {
        selectedTheme.push(theme);
    } else {
        selectedTheme.splice(themeIndex, 1);
    }
    console.log("Selected themes:", selectedTheme); // 선택된 테마 확인
}

// 검색 버튼 클릭
function searchStores() {
    console.log("Search button clicked");
    alert(`검색: 업종 - ${selectedIndustry}, 세부 항목 - ${selectedSubCategory}, 테마 - ${selectedTheme.join(", ")}`);
    // 검색 결과 표시 로직 추가 가능
}


	// 가게 상세 페이지로 이동
    function goToStoreDetail(storeId) {	        
        var url = '/storeDetail?store_ID=' + storeId;
        if (userId && userId.trim() !== "") {  
            url += '&user_ID=' + userId;
        }
        window.location.href = url;  
    }
    
	// 필터링 통합 기능 구현
	function storeFiltering(){
		$.ajax({
		      url: "/storeFiltering",
		      type: "GET",
		      data: {
		          ...filterOptions, // 필터링 조건 (location, industry, theme)
		      },
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
	
	// 정렬 기능 구현
	function orderByCriteria(orderOptions){
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	//   function filterByLocation(locationCode, locationName) {
	//        console.log("Selected location:", locationName); // 로그 추가
	//        document.getElementById("location-btn").innerText = locationName;
	//
	//        $.ajax({
	//            url: "/storesByLocation",
	//            type: "GET",
	//            data: { location: locationCode === "ALL" ? "" : locationCode },
	//            success: function(stores) {
	//
	//                let html = '';
	//                stores.forEach(function(store) {
	//                    html += '<div class="store-item-box" onclick="goToStoreDetail(' + store.id + ')">' +
	//                                '<div class="store-item">' +
	//                                    '<img src="/images/store/' + store.mainImage1 + '" alt="' + store.storeName + ' 이미지">' +
	//                                '</div>' +
	//                                '<div class="store-name">' + store.storeName + '</div>' +
	//                            '</div>';
	//                });
	//                $("#store-list-container").html(html);
	//            },
	//            error: function() {
	//                alert("가게 목록을 불러오는 중 문제가 발생했습니다.");
	//            }
	//        });
	//    }
	//	