/**
 * Image carousel — minimal JS for senior approach
 * - Thumbnail click → update main image and active state
 * - Prev/Next arrows → cycle images
 * - No dependencies, progressive enhancement
 */
(function () {
  const mainImage = document.querySelector('.gallery__main-image');
  const thumbs = document.querySelectorAll('.gallery__thumb');
  const prevBtn = document.querySelector('.gallery__arrow--prev');
  const nextBtn = document.querySelector('.gallery__arrow--next');

  if (!mainImage || !thumbs.length) return;

  let currentIndex = parseInt(
    document.querySelector('.gallery__thumb--active')?.getAttribute('data-index') ?? '0',
    10
  );
  const total = thumbs.length;

  function setActive(index) {
    currentIndex = ((index % total) + total) % total;
    thumbs.forEach((thumb, i) => {
      const isActive = i === currentIndex;
      thumb.classList.toggle('gallery__thumb--active', isActive);
      thumb.setAttribute('aria-current', isActive ? 'true' : 'false');
    });
    const src = thumbs[currentIndex].querySelector('img')?.src;
    if (src) {
      mainImage.style.opacity = '0';
      mainImage.onload = () => { mainImage.style.opacity = '1'; };
      mainImage.src = src;
    }
  }

  thumbs.forEach((thumb, i) => {
    thumb.addEventListener('click', () => setActive(i));
  });
  prevBtn?.addEventListener('click', () => setActive(currentIndex - 1));
  nextBtn?.addEventListener('click', () => setActive(currentIndex + 1));
})();
