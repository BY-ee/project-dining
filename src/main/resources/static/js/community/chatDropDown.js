$(document).ready(function () {
    // 필터 값 저장 객체
    const filters = {
        location: "",
        industry: "",
        subCategory: "",
        theme: []
    };

    // 업종별 세부 업종 매핑
    const subCategoryOptions = {
        "음식점": ["한식", "일식", "중식", "양식"],
        "카페": ["핸드드립", "셀프 로스팅", "빵 맛집"],
        "술집": ["포차", "세계맥주", "와인바", "펍"]
    };

    // === 드롭다운 메뉴 토글 ===
    $("#location-chat-btn").click(function (event) {
        event.stopPropagation();
        $("#location-chat-menu").toggle();
    });

    $("#industry-chat-btn").click(function (event) {
        event.stopPropagation();
        $("#industry-chat-menu").toggle();
    });

    $("#subCategory-chat-btn").click(function (event) {
        event.stopPropagation();
        $("#subCategory-chat-menu").toggle();
    });

    $("#theme-chat-btn").click(function (event) {
        event.stopPropagation();
        $("#theme-chat-menu").toggle();
    });

    $(document).click(function () {
        $(".location-chat-menu").hide();
    });

    // === 필터링 이벤트 ===
    window.filterByLocation = function (locationCode, locationName) {
        filters.location = locationName;
        $("#location-chat-btn").text(locationName);
        applyFilters();
    };

    window.filterByIndustry = function (value, displayName) {
        // 업종 선택 시 세부 업종 초기화
        filters.industry = value;
        filters.subCategory = ""; // 세부 업종 초기화
        $("#industry-chat-btn").text(displayName);
        $("#subCategory-chat-btn").text("세부 업종 선택");

        // 업종 선택 시 세부 업종 드롭다운 업데이트
        const subCategoryMenu = $("#subCategory-chat-menu");
        subCategoryMenu.empty();
        subCategoryMenu.append(`<a href="#" onclick="filterBySubCategory('', '전체')">전체</a>`);

        if (subCategoryOptions[value]) {
            subCategoryOptions[value].forEach(option => {
                subCategoryMenu.append(
                    `<a href="#" onclick="filterBySubCategory('${option}', '${option}')">${option}</a>`
                );
            });
        }

        applyFilters(); // 필터 적용
    };

    window.filterBySubCategory = function (value, displayName) {
        filters.subCategory = value;
        $("#subCategory-chat-btn").text(displayName);
        applyFilters();
    };

    window.filterByTheme = function (value, displayName) {
        const themeIndex = filters.theme.indexOf(value);

        if (themeIndex === -1 && value) {
            filters.theme.push(value); // 테마 추가
        } else if (themeIndex !== -1) {
            filters.theme.splice(themeIndex, 1); // 테마 제거
        }

        $("#theme-chat-btn").text(displayName);
        applyFilters();
    };

    // === 필터 적용 함수 ===
    function applyFilters() {
        $(".chat-details-container").slideUp(100);

        $(".chat-item").each(function () {
            const chatLocation = $(this).find(".chat-location").text();
            const chatThemeString = $(this).data("theme");

            const chatThemes = chatThemeString
                .replace(/>/g, ",")
                .split(/[,]\s*/)
                .map(item => item.trim());

            const matchLocation =
                !filters.location || filters.location === "전체" || chatLocation === filters.location;
            const matchIndustry =
                !filters.industry || chatThemes.includes(filters.industry);
            const matchSubCategory =
                !filters.subCategory || chatThemes.includes(filters.subCategory);
            const matchThemes =
                !filters.theme.length || filters.theme.some(theme => chatThemes.includes(theme));

            if (matchLocation && matchIndustry && matchSubCategory && matchThemes) {
                $(this).show();
            } else {
                $(this).hide();
            }
        });
    }

    $("#search-btn").click(function () {
        applyFilters();
    });
});