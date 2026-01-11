$(function () {
    const startTime = Date.now();

    let cropper = null;
    let editCropper = null; // <-- AÑADIR ESTA LÍNEA
    let croppedBlob = null;
    let msnry = null;
    let editingItem = null;

    // Overlay de carga para demo
    const $loadingOverlay = $('<div id="loading-demo" style="position:fixed; inset:0; background:rgba(0,0,0,0.5); color:#fff; display:flex; align-items:center; justify-content:center; font-size:24px; z-index:9999; display:none;">Generando demo...</div>');
    $('body').append($loadingOverlay);

    // Abrir modal de edición
    $(document).on('click', '.edit-project', function () {
        editingItem = $(this).closest('.grid-item');
        const imgSrc = editingItem.find('img').attr('src');
        const name = editingItem.find('.overlay-text').text();

        $('#edit-project-name').val(name);
        $('#edit-crop-image').attr('src', imgSrc).show();
        $('#edit-crop-height').text($('#edit-crop-image').height());
        $('#edit-input-image').val('');
        $('#modal-edit').fadeIn(200);

        if (editCropper) editCropper.destroy();

        editCropper = new Cropper(document.getElementById('edit-crop-image'), {
            viewMode: 1,
            dragMode: 'move',
            autoCropArea: 1,
            responsive: true,
            movable: true,
            zoomable: true,
            rotatable: false,
            scalable: false,
            aspectRatio: NaN,
            crop(event) {
                $('#edit-crop-height').text(Math.round(event.detail.height));
            }
        });
    });

    // Cambiar imagen dentro del modal de edición
    $('#edit-input-image').on('change', function (e) {
        const file = e.target.files[0];
        if (!file) return;

        const reader = new FileReader();
        reader.onload = function () {
            const img = document.getElementById('edit-crop-image');
            img.src = reader.result;
            img.style.display = 'block';

            if (editCropper) editCropper.destroy();
            editCropper = new Cropper(img, {
                viewMode: 1,
                dragMode: 'move',
                autoCropArea: 1,
                responsive: true,
                movable: true,
                zoomable: true,
                rotatable: false,
                scalable: false,
                aspectRatio: NaN,
                crop(event) {
                    $('#edit-crop-height').text(Math.round(event.detail.height));
                }
            });
        };
        reader.readAsDataURL(file);
    });

    // Demo: reemplazar imagen en el grid
    $('#edit-demo').on('click', function () {
        if (!editCropper || !editingItem) return;

        $('#modal-edit').fadeOut(200);
        $loadingOverlay.fadeIn(200);

        setTimeout(() => {
            const canvas = editCropper.getCroppedCanvas({ imageSmoothingQuality: 'high' });
            const dataURL = canvas.toDataURL('image/png');
            const projectName = $('#edit-project-name').val().trim() || '(Demo)';

            editingItem.find('img').attr('src', dataURL);
            editingItem.find('.overlay-text').text(projectName);

            // Recalcular Masonry
            if (typeof msnry !== 'undefined') {
                editingItem.find('img')[0].onload = () => msnry.layout();
            }

            $loadingOverlay.fadeOut(200);

            // Reset cropper y modal
            editCropper.destroy();
            editCropper = null;
            $('#edit-crop-image').hide();
            $('#edit-project-name').val('');
            $('#edit-input-image').val('');
            $('#edit-crop-height').text('0');
            editingItem = null;
        }, 100);
    });

    // Guardar cambios al backend
    $('#edit-save').on('click', function () {
        if (!editCropper || !editingItem) return;

        const projectName = $('#edit-project-name').val().trim();
        if (!projectName) {
            alert('Introduce un nombre para el proyecto');
            return;
        }

        const canvas = editCropper.getCroppedCanvas({ imageSmoothingQuality: 'high' });

        canvas.toBlob(blob => {
            const formData = new FormData();
            formData.append('image', blob, 'project.png');
            formData.append('name', projectName);
            formData.append('id', editingItem.data('id')); // id del proyecto para backend

            $.ajax({
                url: '/i-architecture/api/update_project',
                method: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function () {
                    // Actualizar imagen y nombre sin recargar
                    editingItem.find('img').attr('src', URL.createObjectURL(blob));
                    editingItem.find('.overlay-text').text(projectName);
                    if (typeof msnry !== 'undefined') msnry.layout();

                    // Reset cropper y cerrar modal
                    editCropper.destroy();
                    editCropper = null;
                    $('#edit-crop-image').hide();
                    $('#edit-project-name').val('');
                    $('#edit-input-image').val('');
                    $('#edit-crop-height').text('0');
                    editingItem = null;
                    $('#modal-edit').fadeOut(200);
                },
                error: function () {
                    alert('Error al actualizar el proyecto');
                }
            });
        });
    });

    // Cerrar modal edición
    $('#edit-close').on('click', function () {
        if (editCropper) editCropper.destroy();
        editCropper = null;
        $('#edit-crop-image').hide();
        $('#edit-project-name').val('');
        $('#edit-input-image').val('');
        $('#edit-crop-height').text('0');
        editingItem = null;
        $('#modal-edit').fadeOut(200);
    });

    // Abrir modal
    $('#new').on('click', function () {
        $('#modal-crop').fadeIn(200);
    });

    // Cerrar modal
    $('#close-crop').on('click', function () {
        if (cropper) cropper.destroy();
        cropper = null;
        $('#crop-image').hide();
        $('#modal-crop').fadeOut(200);
        $('#crop-height').text('0');
        $('#input-image').val('');
        $('#project-name').val('');
    });

    // Cargar imagen y crear cropper
    $('#input-image').on('change', function (e) {
        const file = e.target.files[0];
        if (!file) return;

        const reader = new FileReader();
        reader.onload = function () {
            const img = document.getElementById('crop-image');
            img.src = reader.result;
            img.style.display = 'block';

            if (cropper) cropper.destroy();

            cropper = new Cropper(img, {
                viewMode: 1,
                dragMode: 'move',
                autoCropArea: 1,
                responsive: true,
                movable: true,
                zoomable: true,
                rotatable: false,
                scalable: false,
                aspectRatio: NaN,
                crop(event) {
                    const height = Math.round(event.detail.height);
                    document.getElementById('crop-height').textContent = height;
                }
            });
        };
        reader.readAsDataURL(file);
    });

    // === Botón DEMO ===
    $('#demo-crop').on('click', function () {
        if (!cropper) return;

        const projectName = $('#project-name').val().trim() || '(Demo)';

        $('#modal-crop').fadeOut(200);
        $loadingOverlay.fadeIn(200);

        setTimeout(() => {
            const canvas = cropper.getCroppedCanvas({ imageSmoothingQuality: 'high' });
            const dataURL = canvas.toDataURL('image/png');

            const item = document.createElement('div');
            item.className = 'grid-item';
            item.innerHTML = `
                <img src="${dataURL}" style="width:100%; display:block;">
                <a href="#" class="overlay-text">${projectName}</a>
            `;

            const grid = document.querySelector('.grid-proyects');
            grid.appendChild(item);

            // Esperar a que la imagen se cargue antes de refrescar Masonry
            const img = item.querySelector('img');
            img.onload = function () {
                if (msnry) {
                    msnry.appended(item);
                    msnry.layout();
                }
            };

            $loadingOverlay.fadeOut(200);

            // Reset cropper
            // cropper.destroy();
            // cropper = null;
            // $('#crop-image').hide();
            // $('#project-name').val('');
            // $('#input-image').val('');
            // $('#crop-height').text('0');
        }, 100);
    });

    // Guardar recorte y enviar
    $('#save-crop').on('click', function () {
        if (!cropper) return;

        const projectName = $('#project-name').val().trim();
        if (!projectName) {
            alert('Introduce un nombre para el proyecto');
            return;
        }

        const canvas = cropper.getCroppedCanvas({ imageSmoothingQuality: 'high' });

        canvas.toBlob(blob => {
            croppedBlob = blob;

            const formData = new FormData();
            formData.append('image', blob, 'project.png');
            formData.append('name', projectName);

            $.ajax({
                url: '/i-architecture/api/new_project',
                method: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function () {
                    location.reload();
                },
                error: function () {
                    alert('Error al guardar el proyecto');
                }
            });
        });
    });

    // Inicializar Masonry después de cargar la ventana
    $(window).on('load', function () {
        const elapsed = Date.now() - startTime;
        const remaining = Math.max(1 - elapsed, 0);

        setTimeout(() => {
            $('#video-container-loading').fadeOut(500);
            $('main#page').fadeIn(100);

            setTimeout(() => {
                if (typeof Masonry != 'undefined') {
                    msnry = new Masonry('.grid-proyects', {
                        itemSelector: '.grid-item',
                        columnWidth: '.grid-sizer',
                        percentPosition: true,
                        gutter: 0
                    });

                    // Recalcular después de que los vídeos carguen
                    const videos = document.querySelectorAll(".grid-proyects video");
                    videos.forEach(video => {
                        video.addEventListener("loadedmetadata", () => {
                            msnry.layout();
                        });
                    });

                    // Recalcular después de que las imágenes iniciales carguen
                    const imgs = document.querySelectorAll(".grid-proyects img");
                    imgs.forEach(img => {
                        img.onload = function () {
                            msnry.layout();
                        };
                    });
                }
            }, 310);
        }, remaining);
    });
});