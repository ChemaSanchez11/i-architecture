$(function () {
    const startTime = Date.now();

    $(window).on('load', function () {
        const elapsed = Date.now() - startTime;
        const remaining = Math.max(3800 - elapsed, 0);

        setTimeout(() => {
            $('#video-container-loading').fadeOut(500);
            $('main#page').fadeIn(100);

            setTimeout(() => {
                const msnry = new Masonry('.grid', {
                    itemSelector: '.grid-item',
                    columnWidth: '.grid-sizer', // usa grid-sizer como referencia
                    percentPosition: true,
                    gutter: 0
                });

                // Recalcular después de que los vídeos carguen
                const videos = document.querySelectorAll(".grid video");
                videos.forEach(video => {
                    video.addEventListener("loadedmetadata", () => {
                        msnry.layout();
                    });
                });
            }, 310);
        }, remaining);
    });
});
