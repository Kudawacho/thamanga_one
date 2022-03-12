document.querySelector(".search i").onclick = function() {
    this.style.display = "none";
    this.parentElement.querySelector("input").style.display = "block";
    this.parentElement.querySelector("input").focus();
};
document.querySelector(".search input").onkeyup = function(event) {
    if (event.keyCode === 13 && this.value.length > 0) {
        window.location.href = encodeURI("index.php?page=search&query=" + this.value);
    }
};
if (document.querySelector(".product-img-small")) {
    let imgs = document.querySelectorAll(".product-img-small");
    imgs.forEach(function(img) {
        img.onclick = function() {
            document.querySelector(".product-img-large").src = this.src;
            imgs.forEach(i => i.classList.remove("selected"));
            this.classList.add("selected");
        };
    });
}
if (document.querySelector(".sortby")) {
    document.querySelector(".sortby select").onchange = function() {
        window.location.href = "index.php?page=products&sort=" + this.value;
    };
}
document.querySelector(".responsive-toggle").onclick = function(event) {
    event.preventDefault();
    let nav_display = document.querySelector("header nav").style.display;
    document.querySelector("header nav").style.display = nav_display == "block" ? "none" : "block";
};
