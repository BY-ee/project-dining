function openTab(event, tabId) {
    const $tabContents = $(".tab-content");
    const $tabButtons = $(".tab-button");

    $tabContents.removeClass("active");
    $tabButtons.removeClass("active");

    $(`#${tabId}`).addClass("active");
    $(event.currentTarget).addClass("active");
}
