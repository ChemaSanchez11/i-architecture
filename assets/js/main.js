document.addEventListener('DOMContentLoaded', function () {

    const grid = document.querySelector('.grid-proyects');

    // ⛔ Si no existe Masonry o el contenedor, salimos
    if (typeof Masonry === 'undefined' || !grid) {
        console.warn('Masonry no está disponible o .grid-proyects no existe');
        return;
    }

    /* =========================
       Masonry INIT
    ========================== */
    window.msnry = new Masonry(grid, {
        itemSelector: '.grid-item',
        columnWidth: '.grid-sizer',
        percentPosition: true,
        gutter: 0,
        transitionDuration: '0.25s'
    });

    /* =========================
       Loader
    ========================== */
    setTimeout(() => {
        window.msnry.layout();
    }, 3000);

    /* =========================
       Lazy loading ordenado
    ========================== */
    const lazyItems = Array.from(document.querySelectorAll('.lazy-media'));
    let currentIndex = 0;
    const batchSize = window.innerWidth < 768 ? 12 : 5;

    function loadNextBatch() {
        const batch = lazyItems.slice(currentIndex, currentIndex + batchSize);
        let loadedCount = 0;

        if (batch.length === 0) return;

        batch.forEach(el => {

            const markLoaded = () => {
                loadedCount++;
                if (loadedCount === batch.length) {
                    window.msnry.layout();
                    currentIndex += batchSize;
                    setTimeout(loadNextBatch, 100);
                }
            };

            if (el.tagName === 'IMG' && !el.src) {
                el.src = el.dataset.src;
                el.onload = markLoaded;
                el.onerror = markLoaded;
            } else if (el.tagName === 'VIDEO') {
                const source = el.querySelector('source');
                if (!source.src) {
                    source.src = source.dataset.src;
                    el.load();
                }
                el.pause();
                el.addEventListener('loadedmetadata', markLoaded, { once: true });
                el.addEventListener('error', markLoaded, { once: true });
            } else {
                markLoaded();
            }
        });
    }

    /* =========================
       Lazy scroll vídeos
    ========================== */
    const observer = new IntersectionObserver(entries => {
        entries.forEach(entry => {
            const el = entry.target;
            if (el.tagName !== 'VIDEO') return;

            if (entry.isIntersecting) el.play().catch(() => {});
            else el.pause();
        });
    }, { rootMargin: '240px', threshold: 0.01 });

    document.querySelectorAll('.grid-proyects video')
        .forEach(v => observer.observe(v));

    /* =========================
       Start
    ========================== */
    loadNextBatch();

    window.addEventListener('resize', () => {
        window.msnry.layout();
    });

});