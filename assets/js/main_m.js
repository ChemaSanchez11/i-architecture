$(function () {
    const startTime = Date.now();

    let cropper = null;
    let editCropper = null; // <-- AÑADIR ESTA LÍNEA
    let croppedBlob = null;
    let msnry = window.msnry || null;
    let editingItem = null;
    let editFileMemory = null;

    // Overlay de carga para demo
    const $loadingOverlay = $('<div id="loading-demo" style="position:fixed; inset:0; background:rgba(0,0,0,0.5); color:#fff; display:flex; align-items:center; justify-content:center; font-size:24px; z-index:9999; display:none;">Generando demo...</div>');
    $('body').append($loadingOverlay);

    const $input = $('#edit-cover-project');
    const $dropdown = $('#custom-select-dropdown');

    function showDropdown(filtered) {
        $dropdown.empty();
        filtered.forEach(p => {
            $dropdown.append(`<div data-id="${p.id}">${p.name}</div>`);
        });
        $dropdown.show();
    }

// Al escribir
    $input.on('input', function() {
        const val = $(this).val().toLowerCase();
        const filtered = window.projects_list.filter(p => p.name.toLowerCase().includes(val));
        showDropdown(filtered);
    });

// Al hacer foco, mostrar todos
    $input.on('focus', function() {
        showDropdown(window.projects_list);
    });

// Seleccionar opción
    $dropdown.on('click', 'div', function() {
        const name = $(this).text();
        const id = $(this).data('id');
        $input.val(name);
        $input.data('id', id); // Guardar id asociado
        $dropdown.hide();
    });

// Cerrar dropdown si clic fuera
    $(document).on('click', function(e) {
        if (!$(e.target).closest('.custom-select-wrapper').length) {
            $dropdown.hide();
        }
    });


    /* =========================
   EDITAR PROYECTO
========================== */

    $(document).on('click', '.edit-project', function () {
        editingItem = $(this).closest('.grid-item');

        const img = editingItem.find('img');
        const video = editingItem.find('video');
        const name = editingItem.find('.overlay-text').text().trim();

        $('#edit-project-name').val(name);
        $('#edit-input-image').val('');
        $('#edit-crop-height').text('0');

        if (editCropper) {
            editCropper.destroy();
            editCropper = null;
        }

        // === IMAGEN ===
        if (img.length) {
            $('#edit-video').hide();

            const imgEl = document.getElementById('edit-crop-image');
            imgEl.src = img.attr('src');
            imgEl.style.display = 'block';

            editCropper = new Cropper(imgEl, {
                viewMode: 1,
                dragMode: 'move',
                autoCropArea: 1,
                zoomable: true,
                aspectRatio: NaN,
                crop(e) {
                    $('#edit-crop-height').text(Math.round(e.detail.height));
                }
            });
        }

        // === VÍDEO ===
        if (video.length) {
            $('#edit-crop-image').hide();
            $('#edit-crop-height').text('—');

            const videoEl = document.getElementById('edit-video');
            videoEl.src = video.find('source').attr('src') || video.attr('src');
            videoEl.style.display = 'block';
        }

        $('#modal-edit').fadeIn(200);
    });


    /* =========================
       CAMBIAR ARCHIVO EN EDICIÓN
    ========================== */

    $('#edit-input-image').on('change', function (e) {
        const file = e.target.files[0];
        if (!file) return;

        editFileMemory = null;
        editFileMemory = file;

        const isImage = file.type.startsWith('image/');
        const isVideo = file.type.startsWith('video/');

        if (editCropper) {
            editCropper.destroy();
            editCropper = null;
        }

        const reader = new FileReader();
        reader.onload = function () {

            if (isImage) {
                $('#edit-video').hide();

                const img = document.getElementById('edit-crop-image');
                img.src = reader.result;
                img.style.display = 'block';

                editCropper = new Cropper(img, {
                    viewMode: 1,
                    dragMode: 'move',
                    autoCropArea: 1,
                    zoomable: true,
                    aspectRatio: NaN,
                    crop(e) {
                        $('#edit-crop-height').text(Math.round(e.detail.height));
                    }
                });
            }

            if (isVideo) {
                $('#edit-crop-image').hide();
                $('#edit-crop-height').text('—');

                const video = document.getElementById('edit-video');
                video.src = reader.result;
                video.style.display = 'block';
            }
        };

        reader.readAsDataURL(file);
    });


    /* =========================
       DEMO EDICIÓN
    ========================== */

    $('#edit-demo').on('click', function () {
        if (!editingItem) return;

        const projectName = $('#edit-project-name').val().trim() || '(Demo)';

        // === IMAGEN ===
        if (editCropper) {
            const canvas = editCropper.getCroppedCanvas();
            let img = editingItem.find('img');

            if (!img.length) {
                img = $('<img style="width:100%;">').prependTo(editingItem);
            }

            img.attr('src', canvas.toDataURL('image/png'));
            editingItem.find('video').hide();

        } else {
            // === VÍDEO ===
            const file = $('#edit-input-image')[0].files[0];
            if (file && file.type.startsWith('video/')) {
                let video = editingItem.find('video');
                if (!video.length) {
                    video = $(`
                    <video controls style="width:100%;">
                        <source>
                    </video>
                `).prependTo(editingItem);
                }

                video.show();
                video.find('source').attr('src', URL.createObjectURL(file)).attr('type', file.type);
                video[0].load();
                editingItem.find('img').hide();
            }
        }

        editingItem.find('.overlay-text').text(projectName);

        // Recalcular Masonry solo para este item
        if (msnry) msnry.layout();

        $('#modal-edit').fadeOut(200);
    });


    /* =========================
       GUARDAR EDICIÓN BACKEND
    ========================== */

    $('#edit-save').on('click', function () {
        if (!editingItem) return;

        const projectName = $('#edit-project-name').val().trim();
        if (!projectName) return alert('Introduce un nombre');

        const formData = new FormData();
        formData.append('id', editingItem.data('id'));
        formData.append('name', projectName);

        const coverId = $('#edit-cover-project').data('id') || null;
        console.log(coverId);
        if (coverId) formData.append('cover_id', coverId);

        // === IMAGEN ===
        if (editCropper) {
            editCropper.getCroppedCanvas().toBlob(blob => {
                formData.append('file', blob, 'project.png');
                sendEdit(formData);
            });
            return; // importante: salir, ya se envía en el callback
        }

        // === VÍDEO ===
        if (editFileMemory && editFileMemory.type.startsWith('video/')) {
            formData.append('file', editFileMemory);
        }

        sendEdit(formData);

        editFileMemory = null;
    });


    function sendEdit(formData) {
        $.ajax({
            url: window.base_url + 'api/update_project',
            method: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success(response) {
                location.reload();
            },
            error() {
                alert('Error al actualizar');
            }
        });
    }



    /* =========================
       CERRAR MODAL EDICIÓN
    ========================== */

    $('#edit-close').on('click', function () {
        if (editCropper) editCropper.destroy();
        editCropper = null;
        editFileMemory = null;

        $('#edit-crop-image, #edit-video').hide();
        $('#edit-project-name').val('');
        $('#edit-input-image').val('');
        $('#edit-crop-height').text('0');
        editingItem = null;

        $('#modal-edit').fadeOut(200);
    });

    /* =========================
       NUEVO PROYECTO
    ========================== */

    $('#new').on('click', () => $('#modal-crop').fadeIn(200));

    $('#close-crop').on('click', resetNewModal);

    $('#input-image').on('change', function (e) {
        const file = e.target.files[0];
        if (!file) return;

        const isImage = file.type.startsWith('image/');
        const isVideo = file.type.startsWith('video/');

        if (cropper) {
            cropper.destroy();
            cropper = null;
        }

        const reader = new FileReader();
        reader.onload = function () {
            if (isImage) {
                $('#crop-video').hide();
                const img = document.getElementById('crop-image');
                img.src = reader.result;
                img.style.display = 'block';

                cropper = new Cropper(img, {
                    viewMode: 1,
                    dragMode: 'move',
                    autoCropArea: 1,
                    zoomable: true,
                    aspectRatio: NaN,
                    crop(e) {
                        $('#crop-height').text(Math.round(e.detail.height));
                    }
                });

            } else if (isVideo) {
                $('#crop-image').hide();
                $('#crop-height').text('—');
                const video = document.getElementById('crop-video');
                video.src = reader.result;
                video.style.display = 'block';
            }
        };
        reader.readAsDataURL(file);
    });

    $('#demo-crop').on('click', function () {
        const file = $('#input-image')[0].files[0];
        if (!file) return;

        const isImage = file.type.startsWith('image/');
        const isVideo = file.type.startsWith('video/');
        const projectName = $('#project-name').val().trim() || '(Demo)';

        $('#modal-crop').fadeOut(200);
        $loadingOverlay.fadeIn(200);

        setTimeout(() => {
            let mediaHTML = '';

            if (isImage && cropper) {
                const canvas = cropper.getCroppedCanvas({ imageSmoothingQuality: 'high' });
                mediaHTML = `<img src="${canvas.toDataURL('image/png')}" style="width:100%;">`;
            }

            if (isVideo) {
                const url = URL.createObjectURL(file);
                mediaHTML = `
                    <video controls style="width:100%;">
                        <source src="${url}" type="${file.type}">
                    </video>`;
            }

            const item = document.createElement('div');
            item.className = 'grid-item';
            item.innerHTML = `
                ${mediaHTML}
                <a href="#" class="overlay-text">${projectName}</a>
            `;

            document.querySelector('.grid-proyects').appendChild(item);

            if (msnry) {
                msnry.appended(item);
                msnry.layout();
            }

            $loadingOverlay.fadeOut(200);
        }, 100);
    });

    $('#save-crop').on('click', function () {
        const file = $('#input-image')[0].files[0];
        if (!file) return;

        const projectName = $('#project-name').val().trim();
        if (!projectName) return alert('Introduce un nombre');

        const isImage = file.type.startsWith('image/');
        const isVideo = file.type.startsWith('video/');

        const formData = new FormData();
        formData.append('name', projectName);

        if (isImage && cropper) {
            cropper.getCroppedCanvas().toBlob(blob => {
                formData.append('file', blob, 'project.png');
                sendNew(formData);
            });
        }

        if (isVideo) {
            formData.append('file', file);
            sendNew(formData);
        }
    });

    function sendNew(formData) {
        $.ajax({
            url: window.base_url + 'api/new_project',
            method: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: () => console.log("ERROR"),
            error: () => alert('Error al guardar')
        });
    }

    function resetNewModal() {
        if (cropper) cropper.destroy();
        cropper = null;
        $('#crop-image, #crop-video').hide();
        $('#project-name').val('');
        $('#input-image').val('');
        $('#crop-height').text('0');
        $('#modal-crop').fadeOut(200);
    }
});