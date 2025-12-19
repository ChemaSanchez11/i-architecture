$(document).ready(function () {

    const video = document.getElementById("video-bg");
    const text  = document.getElementById("gif-text");
    const $el   = $('#gif-text');

    /* =========================
       DOBLE CLICK → CAMBIAR VÍDEO
    ========================= */

    $('#container-gif-home').on('dblclick', function (e) {
        if ($(e.target).closest('#gif-text').length) return;
        $('#video-input').trigger('click');
    });

    /* =========================
       CARGAR NUEVO VÍDEO
    ========================= */

    $('#video-input').on('change', async function () {
        const file = this.files[0];
        if (!file) return;

        const id = $el.data('id');

        const formData = new FormData();
        formData.append('id', id);
        formData.append('file', file);

        const response = await fetch('/i-architecture/api/edit_project', {
            method: 'POST',
            body: formData
        });

        const url = URL.createObjectURL(file);

        $('#video-bg source').attr('src', url);
        video.load();
        video.play();
    });

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

    /* =========================
       EDICIÓN DEL TEXTO
    ========================= */

    $el.on('dblclick', function () {
        $(this).attr('contenteditable', 'true').focus();
    });

    // ENTER → guardar
    $el.on('keydown', async function (e) {
        if (e.key === 'Enter') {
            e.preventDefault(); // evita salto de línea

            const id = $(this).data('id');
            const text = $(this).text().trim();

            const formData = new FormData();
            formData.append('id', id);
            formData.append('name', text);

            const response = await fetch('/i-architecture/api/edit_project', {
                method: 'POST',
                body: formData
            });

            // desactivar edición
            $(this).removeAttr('contenteditable').blur();
        }
    });

    let currentSection = null;

    // Abrir menú con clic derecho
    $(document).on("contextmenu", "section[data-section]", function (e) {
        e.preventDefault(); // Evitar menú del navegador

        currentSection = $(this); // Guardamos la sección clicada

        $("#customMenu")
            .finish()
            .toggle(100)
            .css({
                top: e.pageY + "px",
                left: e.pageX + "px"
            });

    });

    // Ocultar menú al hacer click fuera
    $(document).on("mousedown", function (e) {
        if (!$(e.target).closest("#customMenu").length) {
            $("#customMenu").hide(100);
        }
    });

    // Acción Editar
    $("#menu-edit").on("click", async function () {
        if (currentSection) {
            $("#new-section-dialog").modal('show');

            $('#create-new-section').text('Editar sección');
            $('#create-new-section').data('section', currentSection.data("section"));

            try {
                const formData = new FormData();
                formData.append('id', currentSection.data("section"));

                const response = await fetch('/i-architecture/api/get_section', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) {
                    throw new Error(`Error HTTP: ${response.status}`);
                }

                const result = await response.json();

                let data = result.output;

                if (data.layout_type === 'text_left_image_right') {
                    $('#mn-text-left').val(data.text_left);
                    $('#hdn-image-right').val(data.image_right);
                } else if (data.layout_type === 'image_left_text_right') {
                    $('#hdn-image-left').val(data.image_left);
                    $('#mn-text-right').val(data.text_right);
                } else if (data.layout_type === 'text_left_video_right') {
                    $('#mn-text-left').val(data.text_left);
                    $('#hdn-video-right').val(data.video_right);
                } else if (data.layout_type === 'video_left_text_right') {
                    $('#mn-text-right').val(data.text_right);
                    $('#hdn-video-left').val(data.video_left);
                } else if (data.layout_type === 'two_images_left_large_right_small') {
                    $('#hdn-image-left').val(data.image_left);
                    $('#hdn-image-right').val(data.image_right);
                } else if (data.layout_type === 'one_image') {
                    $('#hdn-image-left').val(data.image_left);
                } else if (data.layout_type === 'two_images') {
                    $('#hdn-image-left').val(data.image_left);
                    $('#hdn-image-right').val(data.image_right);
                } else if (data.layout_type === 'one_video') {
                    $('#hdn-video-left').val(data.video_left);
                }

                $('#new-section-layout').val(data.layout_type).trigger('change');

                if (data?.background ?? false) {
                    $('#create_background').val(data.background);
                }

                // Estilo elementos
                if (data?.item_values?.select_style ?? false) {
                    $("#new-section-dialog select[name='style']").val(data.item_values.select_style);
                    // $('').val(data.background);
                }

                // Margin TOP
                if (data?.item_values?.margin_top ?? false) {
                    $("#new-section-dialog input[name='margin-top']").val(data.item_values.margin_top);
                    // $('').val(data.background);
                }

                // Margin BOTTOM
                if (data?.item_values?.margin_bottom ?? false) {
                    $("#new-section-dialog input[name='margin-bottom']").val(data.item_values.margin_bottom);
                    // $('').val(data.background);
                }

            } catch (err) {
                console.error('Error:', err);
            }
        }
        $("#customMenu").hide();
    });

    // Acción Eliminar
    $("#menu-delete").on("click", async function () {
        if (currentSection) {
            const formData = new FormData();
            formData.append('project', currentSection.data("section"));

            try {
                const response = await fetch('/i-architecture/api/delete_section', {
                    method: 'POST',
                    body: formData
                });

                if (!response.ok) {
                    throw new Error(`Error HTTP: ${response.status}`);
                }

                const result = await response.json();

                if (result?.success) {
                    currentSection.remove();
                }

            } catch (err) {
                console.error('Error:', err);
            }
        }
        $("#customMenu").hide();
    });

    const CONTAINER_IMAGE_LEFT = '#container-mn-image-left';
    const CONTAINER_IMAGE_RIGHT = '#container-mn-image-right';
    const CONTAINER_VIDEO_LEFT = '#container-mn-video-left';
    const CONTAINER_VIDEO_RIGHT = '#container-mn-video-right';
    const CONTAINER_TEXT_LEFT = '#container-mn-text-left';
    const CONTAINER_TEXT_RIGHT = '#container-mn-text-right';
    const MENU_SELECTOR = '#section-menu';
    const SECTION_SELECTOR = '.section';

    let insertPosition = null; // "top" o "bottom"
    let insertSectionId = null; // section

// botoncitos
    $("#cancel-dialog").on("click", function () {
        $("#new-section-dialog").dialog("close");
    });

    $("#create-section-dialog").on("click", function () {

        const formData = Object.fromEntries(
            new FormData(document.getElementById("new-section-form")).entries()
        );

        formData.marginTop = parseFloat(formData.marginTop);
        formData.marginBottom = parseFloat(formData.marginBottom);

        console.log(formData);

        $("#new-section-dialog").dialog("close");
    });

    // Cambiar layout modal
    $('#new-section-layout').on('change', function () {
        let layout = $(this).val();
        $('.container-mn-layout').hide();

        $('#demo-new-section').removeAttr('disabled');

        switch (layout) {
            case "text_left_image_right":
                $(CONTAINER_TEXT_LEFT).show();
                $(CONTAINER_IMAGE_RIGHT).show();
                break;
            case "image_left_text_right":
                $(CONTAINER_TEXT_RIGHT).show();
                $(CONTAINER_IMAGE_LEFT).show();
                break;
            case "text_left_video_right":
                $(CONTAINER_TEXT_LEFT).show();
                $(CONTAINER_VIDEO_RIGHT).show();
                break;
            case "video_left_text_right":
                $(CONTAINER_VIDEO_LEFT).show();
                $(CONTAINER_TEXT_RIGHT).show();
                break;
            case "two_images_left_large_right_small":
                $(CONTAINER_IMAGE_LEFT).show();
                $(CONTAINER_IMAGE_RIGHT).show();
                break;
            case "one_image":
                $(CONTAINER_IMAGE_LEFT).show();
                break;
            case "two_images":
                $(CONTAINER_IMAGE_LEFT).show();
                $(CONTAINER_IMAGE_RIGHT).show();
                break;
            case "one_video":
                $(CONTAINER_VIDEO_LEFT).show();
                break;
            default:
                console.log("Lo lamentamos, por el momento no disponemos de " + layout + ".");
        }
    });

    $('#demo-new-section').click(async function () {
        const $form = document.getElementById('new-section-form');
        const formData = new FormData($form);

        // Opcional: mostrar todos los valores en consola
        for (let [key, value] of formData.entries()) {
            console.log(key, value);
        }

        try {
            const response = await fetch('/i-architecture/api/generate_section_demo', {
                method: 'POST',
                body: formData
            });

            if (!response.ok) {
                throw new Error(`Error HTTP: ${response.status}`);
            }

            const result = await response.json();
            console.log(result.output);

            $('#demo_html').html(result.output);

            // Aquí puedes hacer algo con la respuesta, por ejemplo mostrar un preview
            // alert('Demo generada correctamente');

        } catch (err) {
            console.error('Error enviando demo:', err);
        }
    });

    $('#create-new-section').click(async function () {

        const $form = document.getElementById('new-section-form');
        const formData = new FormData($form);

        formData.append('project', $('#gif-text').data('id'));
        formData.append('position', insertPosition);
        formData.append('target_section', insertSectionId);

        let updateId = $('#create-new-section').data('section');
        if(updateId) {
            formData.append('update_id', updateId);
        }

        try {
            const response = await fetch('/i-architecture/api/new_section', {
                method: 'POST',
                body: formData
            });

            if (!response.ok) {
                throw new Error(`Error HTTP: ${response.status}`);
            }

            $('#new-section-form')[0].reset();

            // location.reload();

        } catch (err) {
            console.error('Error enviando demo:', err);
        }
    });

    // Config
    const HIDE_DELAY = 120; // ms cuando te vas al vacío
    const MENU_RIGHT = 20; // px desde la derecha

    let sections = []; // [{el, top, bottom, height, id}]
    let current = null; // DOM section actual
    let rafPending = false;
    let lastPointerY = null;
    let hideTimeout = null;

    const $menu = $(MENU_SELECTOR);

    const menuEl = $menu[0];

    function collectSections() {
        sections = [];
        $(SECTION_SELECTOR).each(function () {
            const el = this;
            const rect = el.getBoundingClientRect();
            // top/bottom relative to viewport (we'll use rect during positioning)
            sections.push({
                el,
                // no need to store top/bottom permanently; we'll compute live when needed
                id: $(el).data('section') || null
            });
        });
    }

    // reevaluar en scroll/resize/DOM changes
    function scheduleRecalc() {
        // slight debounce
        clearTimeout(scheduleRecalc._t);
        scheduleRecalc._t = setTimeout(collectSections, 80);
    }

    // Determina qué sección contiene el punto (clientY) o está más cerca
    function findSectionByY(clientY) {
        // clientY = coordenada relativa al viewport
        let found = null;
        for (let i = 0; i < sections.length; i++) {
            const el = sections[i].el;
            const r = el.getBoundingClientRect();
            if (clientY >= r.top && clientY <= r.bottom) {
                found = el;
                break;
            }
        }
        // si no hay sección que contenga, busca la más cercana verticalmente (por si estás en gaps)
        if (!found) {
            let minDist = Infinity;
            for (let i = 0; i < sections.length; i++) {
                const el = sections[i].el;
                const r = el.getBoundingClientRect();
                let dist = 0;
                if (clientY < r.top) dist = r.top - clientY;
                else dist = clientY - r.bottom;
                if (dist < minDist) {
                    minDist = dist;
                    found = el;
                }
            }
        }
        return found;
    }

    function showMenuForSection(sectionEl) {
        if (!sectionEl) {
            hideMenu();
            return;
        }

        if (current !== sectionEl) {
            // cambio de sección: update clases
            $('.section').removeClass('section-active');
            $(sectionEl).addClass('section-active');
            current = sectionEl;

            // guardar id en menu
            const sid = $(sectionEl).data('section') || $(sectionEl).index(SECTION_SELECTOR);
            $menu.data('section-target', sid);
        }

        // ---- Ocultar botones si es primera o última ----
        const $sections = $(SECTION_SELECTOR);
        const isFirst = sectionEl === $sections.first()[0];
        const isLast  = sectionEl === $sections.last()[0];

        $("#move-up").toggle(!isFirst);
        $("#move-down").toggle(!isLast);
        // -------------------------------------------------

        // posicionar menú: fixed + top viewport
        const rect = sectionEl.getBoundingClientRect();
        const topInViewport = Math.max(8, rect.top + 10);

        $menu.css({
            top: Math.round(topInViewport) + 'px',
            right: MENU_RIGHT + 'px'
        });

        $menu.stop(true, true).fadeIn(150);

        if (hideTimeout) {
            clearTimeout(hideTimeout);
            hideTimeout = null;
        }
    }

    function hideMenu() {
        $menu.stop(true, true).fadeOut(120);
        $('.section').removeClass('section-active');
        current = null;
    }

    // Handler llamado por raf
    function handlePointer() {
        rafPending = false;
        if (lastPointerY == null) return;

        const clientY = lastPointerY;
        const section = findSectionByY(clientY);

        // si puntero está encima del propio menú, no hacer hide o cambio
        // obtener bounding rect del menu y comprobar
        const menuRect = menuEl.getBoundingClientRect();
        if (menuRect.width > 0 && clientY >= menuRect.top && clientY <= menuRect.bottom) {
            // si estamos sobre el menú, mantener lo que había
            return;
        }

        if (section) {
            showMenuForSection(section);
        } else {
            // si no hay sección cercana: programar ocultado leve
            if (!hideTimeout) {
                hideTimeout = setTimeout(() => {
                    // solo ocultar si puntero no está sobre el menu
                    if (!$menu.is(':hover')) hideMenu();
                    hideTimeout = null;
                }, HIDE_DELAY);
            }
        }
    }

    function onPointerMove(e) {
        // usar clientY (viewport)
        lastPointerY = (e.touches ? e.touches[0].clientY : e.clientY);
        if (!rafPending) {
            rafPending = true;
            requestAnimationFrame(handlePointer);
        }
    }

    // recalc en scroll/resize
    window.addEventListener('scroll', scheduleRecalc, { passive: true });
    window.addEventListener('resize', scheduleRecalc);

    // init
    $(function () {
        collectSections();

        // Si las secciones cambian dinámicamente, observar el contenedor de secciones
        const container = document.querySelector('body'); // puedes usar un contenedor más específico
        if (container && window.MutationObserver) {
            const mo = new MutationObserver(scheduleRecalc);
            mo.observe(container, { childList: true, subtree: true, attributes: true, characterData: false });
        }

        // pointermove para mouse y touchmove
        document.addEventListener('mousemove', onPointerMove, { passive: true });
        document.addEventListener('touchmove', onPointerMove, { passive: true });

        // Si el ratón sale de la ventana, ocultar
        document.addEventListener('mouseout', function (e) {
            if (!e.relatedTarget && !e.toElement) {
                hideMenu();
            }
        });

        // Mantener visible cuando el puntero está sobre el menú
        $menu.on('mouseenter pointerenter', function () {
            if (hideTimeout) {
                clearTimeout(hideTimeout);
                hideTimeout = null;
            }
        });
        $menu.on('mouseleave pointerleave', function () {
            // al salir del menu, forzamos recalcular con la última posición conocida
            if (lastPointerY != null) {
                if (!rafPending) {
                    rafPending = true;
                    requestAnimationFrame(handlePointer);
                }
            } else {
                hideMenu();
            }
        });

        // acciones del menú (ejemplo: crear arriba/abajo)
        $('#create-top').on('click', function () {
            const target = $menu.data('section-target');

            insertPosition = "top";
            insertSectionId = target;
        });

        showOrHideFirstSectionBtn();

        function showOrHideFirstSectionBtn() {
            if (sections.length === 0) {
                // No hay secciones → mostrar botón para crear la primera
                $("#menu-no-sections").show();
            } else {
                $("#menu-no-sections").hide();
            }
        }


        $(document).on("hidden.bs.modal", "#new-section-dialog", function (e) {
            $('#new-section-form')[0].reset();

            $('#create-new-section').text('Crear sección');
            $('#create-new-section').removeData('section');

            $('#demo_html').html('');
            showOrHideFirstSectionBtn();
        });

        $("#menu-no-sections").on("click", function () {
            insertPosition = "bottom";  // o null, la API decidirá
            insertSectionId = null;     // porque no hay sección target
            $("#menu-no-sections").hide();
        });

        $('#create-bottom').on('click', function () {
            const target = $menu.data('section-target');

            insertPosition = "bottom";
            insertSectionId = target;
        });

        $('#move-up').on('click', async function () {
            if (!current) return;
            const $cur = $(current);
            const $prev = $cur.prev('.section');

            let obj = {
                'up': $cur.data('section'),
                'down': $prev.data('section')
            }

            let formData = new FormData();
            formData.append("data", JSON.stringify(obj));


            if ($prev.length) {

                let input = '/i-architecture/api/move_section';
                const response = await fetch(input, {
                    method: "POST",
                    body: formData
                });

                console.log(response);

                $cur.insertBefore($prev);
                scheduleRecalc();
            }
        });

        $('#move-down').on('click', function () {
            if (!current) return;
            const $cur = $(current);
            const $next = $cur.next('.section');
            if ($next.length) {
                $cur.insertAfter($next);
                scheduleRecalc();
            }
        });
    });

});