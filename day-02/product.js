/**
 * PDP (Product Detail Page) – minimal JS
 * - Thumbnail click updates main image and active state
 * - Form submit prevented for demo (could send to cart API)
 */
(function () {
  const mainImg = document.getElementById("pdp-main-img");
  const thumbs = document.querySelectorAll(".pdp__thumb");
  const form = document.getElementById("pdp-form");

  const mainImages = [
    "./assets/images/Rectangle 2.png",
    "./assets/images/Rectangle 2 (1).png",
    "./assets/images/Rectangle 2 (2).png",
    "./assets/images/Rectangle 2 (3).png",
  ];

  thumbs.forEach(function (thumb, index) {
    thumb.addEventListener("click", function () {
      const src = mainImages[index] || mainImages[0];
      if (mainImg && src) {
        mainImg.src = src;
        mainImg.alt = thumb.getAttribute("aria-label") || "Product view " + (index + 1);
      }
      thumbs.forEach(function (t) {
        t.classList.remove("pdp__thumb--active");
        t.removeAttribute("aria-current");
      });
      thumb.classList.add("pdp__thumb--active");
      thumb.setAttribute("aria-current", "true");
    });
  });

  if (form) {
    form.addEventListener("submit", function (e) {
      e.preventDefault();
      const size = form.querySelector('input[name="size"]:checked');
      const sizeValue = size ? size.value : "";
      if (sizeValue) {
        console.log("Add to bag: size " + sizeValue);
        // In a real app: dispatch event or call API, then show confirmation
      }
    });
  }
})();
