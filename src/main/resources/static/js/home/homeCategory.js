$(document).ready(function () {
	const $searchBtn = $("#searchBtn");
	if ($searchBtn.length) {
			$searchBtn.show().on("click", function () {
					console.log("Filter criteria:", {
							industry: selectedIndustry,
							subCategory: selectedSubCategory,
							themes: selectedTheme,
					});
					filterByCategory(selectedIndustry, selectedSubCategory, selectedTheme);
					toggleCategoryPopup();
			});
	} else {
			console.error("Search button not found in DOM");
	}
});

let selectedIndustry = "";
let selectedSubCategory = "";
let selectedTheme = []; // 배열로 초기화하여 여러 선택 가능

// 카테고리 팝업 표시/숨기기
function toggleCategoryPopup() {
	const $categoryPopup = $("#categoryPopup");
	$categoryPopup.toggle();
}

// 업종 선택
function selectIndustry(industry) {
	selectedIndustry = industry;
	selectedSubCategory = "";
	selectedTheme = []; // 테마 초기화하여 중복 방지

	// 세부 항목과 테마 선택 초기화
	$("#selectedIndustryOptions").hide();
	$("#themeStep").hide();

	showSubCategoryOptions(industry);
}

// 선택한 업종에 따른 세부 항목 표시
function showSubCategoryOptions(industry) {
	const $selectedIndustryOptions = $("#selectedIndustryOptions");
	$selectedIndustryOptions.show().html(`<h3>${industry} 선택</h3>`);

	let options = [];
	if (industry === "음식점") {
			options = ["한식", "일식", "중식", "양식"];
	} else if (industry === "카페") {
			options = ["핸드드립", "셀프 로스팅", "빵 맛집"];
	} else if (industry === "술집") {
			options = ["포차", "세계맥주", "와인바", "펍", "바"];
	}

	options.forEach(option => {
			const $button = $("<button>")
					.text(option)
					.addClass("category-step-btn")
					.on("click", function () {
							selectSubCategory(option);
					});
			$selectedIndustryOptions.append($button);
	});
}

// 세부 항목 선택
function selectSubCategory(subCategory) {
	selectedSubCategory = subCategory;
	$("#themeStep").show();
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
	const url = `/storeDetail?store_ID=${encodeURIComponent(storeId)}`;
	window.location.href = url;
}

// 필터링 통합 기능 구현
function storeFiltering() {
	$.ajax({
			url: "/storeFiltering",
			type: "GET",
			data: {
					location: "defaultLocation",
					industry: selectedIndustry,
					themes: selectedTheme,
			},
			success: function (stores) {
					let html = "";
					stores.forEach(function (store) {
							html += `
									<div class="store-item-box" onclick="goToStoreDetail(${store.id})">
											<div class="store-item">
													<img src="/images/store/${store.mainImage1}" alt="${store.storeName} 이미지">
											</div>
											<div class="store-name">${store.storeName}</div>
									</div>`;
					});
					$("#store-list-container").html(html);
			},
			error: function () {
					alert("가게 목록을 불러오는 중 문제가 발생했습니다.");
			},
	});
}


// $(document).on("click", ".store-item-box", function () {
// 	const storeId = $(this).data("store-id");
// 	goToStoreDetail(storeId);
// });

	
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