document.getElementById("signup").addEventListener("click", function() {
    document.querySelector(".pinkbox").style.transform = "translateX(80%)";
    document.querySelector(".signin").classList.add("nodisplay");
    document.querySelector(".signup").classList.remove("nodisplay");
});

document.getElementById("signin").addEventListener("click", function() {
    document.querySelector(".pinkbox").style.transform = "translateX(0%)";
    document.querySelector(".signup").classList.add("nodisplay");
    document.querySelector(".signin").classList.remove("nodisplay");
});