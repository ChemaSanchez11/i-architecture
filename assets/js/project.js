$(document).ready(function () {

    const video = document.getElementById("video-bg");
    const text  = document.getElementById("gif-text");
    const $el   = $('#gif-text');

    /* =========================
       DETECCIÓN DE COLOR
    ========================= */

    const canvas = document.createElement("canvas");
    const ctx = canvas.getContext("2d");

    let colorInterval = null;

    function updateTextColor() {
        if (!video.videoWidth || !video.videoHeight) return;

        canvas.width  = video.videoWidth;
        canvas.height = video.videoHeight;

        ctx.drawImage(video, 0, 0, canvas.width, canvas.height);

        const pixel = ctx.getImageData(50, canvas.height - 50, 1, 1).data;
        const [r, g, b] = pixel;

        const brightness = (r * 0.299 + g * 0.587 + b * 0.114);

        text.style.color = brightness > 145 ? "#3F2212" : "#FFFFFF";
    }

    function startColorDetection() {
        if (colorInterval) clearInterval(colorInterval);
        colorInterval = setInterval(updateTextColor, 100);
    }

    video.addEventListener('loadeddata', startColorDetection);
    video.addEventListener('play', startColorDetection);

    // Arranque inicial
    startColorDetection();
});