$(function () {
    const startTime = Date.now();

    $(window).on('load', function () {
        const elapsed = Date.now() - startTime;
        // const remaining = Math.max(3800 - elapsed, 0);
        const remaining = Math.max(0 - elapsed, 0);

        setTimeout(() => {
            $('#video-container-loading').fadeOut(500, function () {
                $('main#page').fadeIn(300);
            });
        }, remaining);
    });
});
