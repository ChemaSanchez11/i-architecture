<?php

use core\Renderer;
use JetBrains\PhpStorm\NoReturn;

class ApiController
{

    protected array $params;

    public function __construct($params = [])
    {
        $this->params = $params;
    }

    #[NoReturn] public function handle_request($service): void
    {

        if ($service && method_exists($this, $service)) {
            $this->$service();
        } else {
            $this->send_response([
                'success' => false,
                'message' => 'Servicio no encontrado'
            ], 404);
        }
        exit();
    }

    public function new_project()
    {

        global $DB;

        if (empty($this->params['name'])) {
            $response = [
                'success' => false,
                'output' => 'Faltan parametros'
            ];
            $this->send_response($response, 400);
        }

        $name = $this->params['name'] ?? 'temp';

        $response = [
            'success' => false
        ];

        if (!empty($_FILES)) {

            $DIR = __DIR__ . "/../assets/images/proyects/";
            $DB_DIR = "proyects/";

            if (!is_dir($DIR)) {
                mkdir($DIR, 0777, true);
            }

            // Obtener el archivo (primer input)
            $file = reset($_FILES);

            // Extensión original
            $extension = pathinfo($file['name'], PATHINFO_EXTENSION);

            // MIME type reportado por el navegador
            $mimeType = $file['type'];

            $type = 'image';
            if (str_starts_with($mimeType, 'video/')) {
                $type = 'video';
            }

            // Nombre final
            $newName = uniqid('p-',) . ".$extension";

            // Ruta destino
            $targetPath = $DIR . $newName;

            $time = time();

            // Mover archivo
            if (move_uploaded_file($file['tmp_name'], $targetPath)) {
                // Guardar ruta en BD si hace falta
                $dbPath = $DB_DIR . $newName;

                $DB->insert("INSERT INTO proyects 
                    (`name`, source, source_type, timecreated, timeupdated)
                    VALUES 
                    ('$name', '$dbPath', '$type', $time, $time)
                ");

                $response = [
                    'success' => true
                ];
            }
        }

        $this->send_response($response);
    }

    public function update_project()
    {

        global $DB;

        if (empty($this->params['id'])) {
            $response = [
                'success' => false,
                'output' => 'Faltan parametros'
            ];
            $this->send_response($response, 400);
        }

        $id = $this->params['id'];
        $cover_id = $this->params['cover_id'] ?? null;
        $name = $this->params['name'] ?? 'temp';

        $response = [
            'success' => false
        ];

        if (!empty($_FILES)) {

            $DIR = __DIR__ . "/../assets/images/proyects/";
            $DB_DIR = "proyects/";

            if (!is_dir($DIR)) {
                mkdir($DIR, 0777, true);
            }

            // Obtener el archivo (primer input)
            $file = reset($_FILES);

            // Extensión original
            $extension = pathinfo($file['name'], PATHINFO_EXTENSION);

            // MIME type reportado por el navegador
            $mimeType = $file['type'];

            $type = 'image';
            if (str_starts_with($mimeType, 'video/')) {
                $type = 'video';
            }

            // Nombre final
            $newName = "proyect-$id.$extension";

            // Ruta destino
            $targetPath = $DIR . $newName;

            $time = time();

            // Mover archivo
            if (move_uploaded_file($file['tmp_name'], $targetPath)) {
                // Guardar ruta en BD si hace falta
                $dbPath = $DB_DIR . $newName;

                if (!empty($cover_id)) {
                    $DB->execute('UPDATE `proyects` SET `name` = ?, `source` = ?, source_type = ?, cover_project_id = ?, timeupdated = ? WHERE `id` = ?', [$name, $dbPath, $type, $cover_id, $time, $id]);
                } else {
                    $DB->execute('UPDATE `proyects` SET `name` = ?, `source` = ?, source_type = ?, timeupdated = ? WHERE `id` = ?', [$name, $dbPath, $type, $time, $id]);
                }

                $response = [
                    'success' => true
                ];
            }
        } else {
            $time = time();

            if (!empty($cover_id)) {
                $DB->execute('UPDATE `proyects` SET `name` = ?, cover_project_id = ?, timeupdated = ? WHERE `id` = ?', [$name, $cover_id, $time, $id]);
            } else {
                $DB->execute('UPDATE `proyects` SET `name` = ?, timeupdated = ? WHERE `id` = ?', [$name, $time, $id]);
            }

            $response = [
                'success' => true
            ];
        }

        $this->send_response($response);
    }

    public function edit_project()
    {

        global $DB;

        if (empty($this->params['id'])) {
            $response = [
                'success' => false,
                'output' => 'Faltan parametros'
            ];
            $this->send_response($response, 400);
        }

        $id = $this->params['id'];
        $name = $this->params['name'] ?? '';

        if (!empty($_FILES)) {

            $DIR = __DIR__ . "/../assets/images/proyects/p-$id/";
            $DB_DIR = "proyects/p-$id/";

            if (!is_dir($DIR)) {
                mkdir($DIR, 0777, true);
            }

            // Obtener el archivo (primer input)
            $file = reset($_FILES);

            // Extensión original
            $extension = pathinfo($file['name'], PATHINFO_EXTENSION);

            // Nombre final
            $newName = "header.$extension";

            // Ruta destino
            $targetPath = $DIR . $newName;

            // Mover archivo
            if (move_uploaded_file($file['tmp_name'], $targetPath)) {
                // Guardar ruta en BD si hace falta
                $dbPath = $DB_DIR . $newName;

                $DB->execute('UPDATE `proyects` SET `header_source` = ? WHERE `id` = ?', [$dbPath, $id]);

                $response = [
                    'success' => true
                ];
            } else {
                $response = [
                    'success' => false
                ];
            }
        }

        if (!empty($name)) {
            $DB->execute('UPDATE `proyects` SET `name` = ? WHERE `id` = ?', [$name, $id]);

            $response = [
                'success' => true
            ];
        }
        $this->send_response($response);
    }

    public function update_about()
    {

        global $DB;

        if (empty($_FILES)) {
            $response = [
                'success' => false,
                'output' => 'Faltan parametros'
            ];
            $this->send_response($response, 400);
        }

        $response = [
            'success' => false
        ];

        if (!empty($_FILES)) {

            $DIR = __DIR__ . "/../assets/images/";

            if (!is_dir($DIR)) {
                mkdir($DIR, 0777, true);
            }

            // Obtener el archivo (primer input)
            $file = reset($_FILES);

            // Extensión original
            $extension = pathinfo($file['name'], PATHINFO_EXTENSION);

            // MIME type reportado por el navegador
            $mimeType = $file['type'];

            $type = 'image';
            if (str_starts_with($mimeType, 'video/')) {
                $type = 'video';
            }

            // Nombre final
            $newName = "about.png";

            // Ruta destino
            $targetPath = $DIR . $newName;

            $time = time();

            // Mover archivo
            if (move_uploaded_file($file['tmp_name'], $targetPath)) {
                $DB->execute('UPDATE `config` SET `value` = ? WHERE `name` = "img_about"', [$newName]);

                $response = [
                    'success' => true
                ];
            }
        }

        $this->send_response($response);
    }

    public function move_section()
    {

        global $DB;

        require_once(__DIR__ . '/../core/Renderer.php');

        if (empty($this->params['data'])) {
            $response = [
                'success' => false,
                'output' => 'Faltan parametros'
            ];
            $this->send_response($response, 400);
        }

        $data = json_decode($this->params['data'], true);

        foreach ($data as $key => $value) {

            $section = $DB->get_record('SELECT * FROM project_sections WHERE id = ?', [$value]);

            if ($key === 'up') {
                $order = ((int)$section->order) - 1;
            } else {
                $order = ((int)$section->order) + 1;
            }


            $DB->execute('UPDATE `project_sections` SET `order` = ? WHERE `id` = ?', [$order, $value]);
        }

        $renderer = new Renderer();

//        $html = $renderer->render_template('tbody-files', ['visible_files' => $files]);

        $response = [
            'success' => true,
        ];
        $this->send_response($response);
    }

    public function get_section()
    {

        global $DB;

        if (empty($this->params['id'])) {
            $response = [
                'success' => false,
                'output' => 'Faltan parametros'
            ];
            $this->send_response($response, 400);
        }

        $id = $this->params['id'];

        $project_section = $DB->get_record('SELECT
            * 
        FROM
            project_sections ps
        WHERE
            id = ?', [$id]);

        $items = $DB->get_records('SELECT
            * 
        FROM
            project_section_items psi
        WHERE
            psi.section_id = ?', [$id]);

        $project_section->items = $items;

        $custom_css = json_decode($project_section->custom_css ?? '', true);

        if (!empty($custom_css['background'])) {
            $project_section->background = $custom_css['background'];
        }

        $project_section->item_values = [];

        $items_raw = [];

        foreach ($items as $item) {
            $items_css = json_decode($item->settings ?? '', true);

            if ($item->type === 'image') {
                if (isset($items_raw['image1'])) {
                    $items_raw['image2'] = $item->media_url;
                } else {
                    $items_raw['image1'] = $item->media_url;
                }
            } else if ($item->type === 'video') {
                if (isset($items_raw['video1'])) {
                    $items_raw['video2'] = $item->media_url;
                } else {
                    $items_raw['video1'] = $item->media_url;
                }
            } else if ($item->type === 'text') {
                if (isset($items_raw['text1'])) {
                    $items_raw['text2'] = $item->content;
                } else {
                    $items_raw['text1'] = $item->content;
                }
            }

            if (
                (!empty($items_css['width']) && self::clean_css_value($items_css['width']) === "100%") &&
                (!empty($items_css['height']) && self::clean_css_value($items_css['height']) === "100%")
            ) {
                $project_section->item_values['select_style'] = 'full-width-height';
            } else if (!empty($items_css['width']) && self::clean_css_value($items_css['width']) === "100%") {
                $project_section->item_values['select_style'] = 'full-width';
            } else if (!empty($items_css['align-self']) && $items_css['align-self'] === "center !important;") {
                $project_section->item_values['select_style'] = 'center';
            } else if (
                (!empty($items_css['display']) && $items_css['display'] === "block") &&
                (!empty($items_css['margin-left']) && $items_css['margin-left'] === "auto")
            ) {
                $project_section->item_values['select_style'] = 'align-right';
            }

            if (!empty($items_css['margin-top'])) {
                $project_section->item_values['margin_top'] = self::clean_css_value($items_css['margin-top']);
            }

            if (!empty($items_css['margin-bottom'])) {
                $project_section->item_values['margin_bottom'] = self::clean_css_value($items_css['margin-bottom']);
            }
        }

        if ($project_section->layout_type === 'text_left_image_right') {
            if (!empty($items_raw['text1'])) {
                $project_section->text_left = $items_raw['text1'];
            }
            if (!empty($items_raw['image1'])) {
                $project_section->image_right = $items_raw['image1'];
            }
        } else if ($project_section->layout_type === 'image_left_text_right') {
            if (!empty($items_raw['text1'])) {
                $project_section->image_left = $items_raw['image1'];
            }
            if (!empty($items_raw['image1'])) {
                $project_section->text_right = $items_raw['text1'];
            }
        } else if ($project_section->layout_type === 'text_left_video_right') {
            if (!empty($items_raw['text1'])) {
                $project_section->text_left = $items_raw['text1'];
            }
            if (!empty($items_raw['video1'])) {
                $project_section->video_right = $items_raw['video1'];
            }
        } else if ($project_section->layout_type === 'video_left_text_right') {
            if (!empty($items_raw['text1'])) {
                $project_section->text_right = $items_raw['text1'];
            }
            if (!empty($items_raw['video1'])) {
                $project_section->video_left = $items_raw['video1'];
            }
        } else if ($project_section->layout_type === 'two_images_left_large_right_small') {
            if (!empty($items_raw['image1'])) {
                $project_section->image_left = $items_raw['image1'];
            }
            if (!empty($items_raw['image2'])) {
                $project_section->image_right = $items_raw['image2'];
            }
        } else if ($project_section->layout_type === 'one_image') {
            if (!empty($items_raw['image1'])) {
                $project_section->image_left = $items_raw['image1'];
            }
        } else if ($project_section->layout_type === 'two_images') {
            if (!empty($items_raw['image1'])) {
                $project_section->image_left = $items_raw['image1'];
            }
            if (!empty($items_raw['image2'])) {
                $project_section->image_right = $items_raw['image2'];
            }
        } else if ($project_section->layout_type === 'one_video') {
            if (!empty($items_raw['video1'])) {
                $project_section->video_left = $items_raw['video1'];
            }
        }

        $project_section->items_raw = $items_raw;

        $response = [
            'success' => true,
            'output' => $project_section
        ];
        $this->send_response($response);
    }

    function clean_css_value($value)
    {
        // Quitar ';'
        $value = rtrim($value, ';');

        // Quitar "!important"
        $value = str_ireplace('!important', '', $value);

        // Quitar espacios sobrantes
        $value = trim($value);

        return $value;
    }

    public function new_section()
    {

        global $DB;

        require_once(__DIR__ . '/../core/Renderer.php');

        if (empty($this->params['target_section']) && empty($this->params['project'])) {
            $response = [
                'success' => false,
                'output' => 'Faltan parametros'
            ];
            $this->send_response($response, 400);
        }

        $action_update = !empty($this->params['update_id']);

        $project_id = $this->params['project'];
        $layout_type = $this->params['layout'];
        $time = time();

        $order_target_section = $DB->get_record('SELECT `order` FROM project_sections WHERE id = ?', [$this->params['target_section']])->order ?? 0;

        $custom_css = [];
        if (!empty($this->params['background'])) {
            $custom_css['background'] = $this->params['background'];
        }

        $custom_css = json_encode($custom_css);

        $project_section = null;

        // Si no es actualizar
        if (!$action_update) {
            if ($this->params['position'] === 'top') {
                $newOrder = $order_target_section;
                $DB->execute('UPDATE project_sections SET `order` = `order` + 1 WHERE `order` >= ?', [$order_target_section]);
                $project_section = $DB->insert("INSERT INTO project_sections 
                    (project_id, `order`, layout_type, custom_css, custom_settings, timecreated, timeupdated)
                    VALUES 
                    ($project_id, $newOrder, '$layout_type', '$custom_css', '{}', $time, $time)
                ");
            } else {
                $newOrder = $order_target_section + 1;
                $DB->execute('UPDATE project_sections SET `order` = `order` + 1 WHERE `order` > ?', [$order_target_section]);
                $project_section = $DB->insert("INSERT INTO project_sections 
                    (project_id, `order`, layout_type, custom_css, custom_settings, timecreated, timeupdated)
                    VALUES 
                    ($project_id, $newOrder, '$layout_type', '$custom_css', '{}', $time, $time)
                ");
            }
        }

        $files = [];

        $DIR = __DIR__ . "/../assets/images/proyects/p-$project_id/";
        $DB_DIR = "proyects/p-$project_id/";

        if (!is_dir($DIR)) {
            mkdir($DIR, 0777, true);
        }

        foreach ($_FILES as $key => $value) {
            if (!empty($value['tmp_name'])) {

                // Extensión del archivo
                $ext = strtolower(pathinfo($value['name'], PATHINFO_EXTENSION));

                // Nombre único
                $uniqueName = uniqid("img_", true) . "." . $ext;

                $destination = $DIR . $uniqueName;
                $destination_db = $DB_DIR . $uniqueName;

                if (move_uploaded_file($value['tmp_name'], $destination)) {

                    // Ruta accesible para guardarla en BD
                    $files[$key] = [
                        'filename' => $uniqueName,
                        'path' => $destination_db,
                        'full_path' => $destination
                    ];

                }
            }
        }

        $css = [];


        if (!empty($this->params['margin-top'])) {
            $margin_top = $this->params['margin-top'];

            if (is_numeric($margin_top)) {
                $css['margin-top'] = $margin_top . "rem !important;";
            } else {
                $css['margin-top'] = $margin_top . " !important;";
            }
        }

        if (!empty($this->params['margin-bottom'])) {
            $margin_bottom = $this->params['margin-bottom'];
            if (is_numeric($margin_bottom)) {
                $css['margin-bottom'] = $margin_bottom . "rem !important;";
            } else {
                $css['margin-bottom'] = $margin_bottom . " !important;";
            }
        }

        if ($this->params['layout'] === 'text_left_image_right') {

            if (!empty($this->params['style']) && $this->params['style'] === 'center') {
                $css['align-self'] = "center !important;";
            }

            $section_id = $project_section;
            $type = 'text';
            $content = $this->params['mn-text-left'];
            $css = json_encode($css);

            if (!$action_update) {
                $project_section_items_1 = $DB->insert("INSERT INTO project_section_items 
                    (section_id, `type`, content, media_url, settings, `order`, timecreated, timeupdated)
                    VALUES 
                    ($section_id, '$type', '$content', '', '$css', 1, $time, $time)
                ");
            } else {
                $id = $DB->get_record("SELECT id FROM project_section_items WHERE section_id = ? AND type = 'text'", [$this->params['update_id']])->id;

                $project_section_items_1 = $DB->execute("
                    UPDATE project_section_items
                    SET 
                        `type`       = '$type',
                        content      = '$content',
                        media_url    = '',
                        settings     = '$css',
                        timeupdated  = $time
                    WHERE id = $id
                ");
            }

            $type = 'image';
            $media_url = $files['mn-image-right']['path'] ?? $this->params['hdn-image-right'];

            if (!$action_update) {
                $project_section_items_2 = $DB->insert("INSERT INTO project_section_items 
                    (section_id, `type`, content, media_url, settings, `order`, timecreated, timeupdated)
                    VALUES 
                    ($section_id, '$type', '', '$media_url', '$css', 2, $time, $time)
                ");
            } else {
                $id = $DB->get_record("SELECT id FROM project_section_items WHERE section_id = ? AND type = 'image'", [$this->params['update_id']])->id;

                $project_section_items_2 = $DB->execute("
                    UPDATE project_section_items
                    SET 
                        `type`       = '$type',
                        content      = '',
                        media_url    = '$media_url',
                        settings     = '$css',
                        timeupdated  = $time
                    WHERE id = $id
                ");
            }

        } else if ($this->params['layout'] === 'image_left_text_right') {

            if (!empty($this->params['style']) && $this->params['style'] === 'center') {
                $css['align-self'] = "center !important;";
            }

            $section_id = $project_section;
            $type = 'image';
            $media_url = $files['mn-image-left']['path'] ?? $this->params['hdn-image-left'];
            $css = json_encode($css);

            if (!$action_update) {
                $project_section_items_1 = $DB->insert("INSERT INTO project_section_items 
                    (section_id, `type`, content, media_url, settings, `order`, timecreated, timeupdated)
                    VALUES 
                    ($section_id, '$type', '', '$media_url', '$css', 1, $time, $time)
                ");
            } else {
                $id = $DB->get_record("SELECT id FROM project_section_items WHERE section_id = ? AND type = 'image'", [$this->params['update_id']])->id;

                $project_section_items_1 = $DB->execute("
                    UPDATE project_section_items
                    SET 
                        `type`       = '$type',
                        content      = '',
                        media_url    = '$media_url',
                        settings     = '$css',
                        timeupdated  = $time
                    WHERE id = $id
                ");
            }

            $type = 'text';
            $content = $this->params['mn-text-right'];

            if (!$action_update) {
                $project_section_items_2 = $DB->insert("INSERT INTO project_section_items 
                    (section_id, `type`, content, media_url, settings, `order`, timecreated, timeupdated)
                    VALUES 
                    ($section_id, '$type', '$content', '', '$css', 2, $time, $time)
                ");
            } else {
                $id = $DB->get_record("SELECT id FROM project_section_items WHERE section_id = ? AND type = 'text'", [$this->params['update_id']])->id;

                $project_section_items_2 = $DB->execute("
                    UPDATE project_section_items
                    SET 
                        `type`       = '$type',
                        content      = '$content',
                        media_url    = '',
                        settings     = '$css',
                        timeupdated  = $time
                    WHERE id = $id
                ");
            }

        } else if ($this->params['layout'] === 'text_left_video_right') {
            if (!empty($this->params['style']) && $this->params['style'] === 'center') {
                $css['align-self'] = "center !important;";
            }

            $section_id = $project_section;
            $type = 'text';
            $content = $this->params['mn-text-left'];
            $css = json_encode($css);

            if (!$action_update) {
                $project_section_items_1 = $DB->insert("INSERT INTO project_section_items 
                    (section_id, `type`, content, media_url, settings, `order`, timecreated, timeupdated)
                    VALUES 
                    ($section_id, '$type', '$content', '', '$css', 1, $time, $time)
                ");
            } else {
                $id = $DB->get_record("SELECT id FROM project_section_items WHERE section_id = ? AND type = 'text'", [$this->params['update_id']])->id;

                $project_section_items_1 = $DB->execute("
                    UPDATE project_section_items
                    SET 
                        `type`       = '$type',
                        content      = '$content',
                        media_url    = '',
                        settings     = '$css',
                        timeupdated  = $time
                    WHERE id = $id
                ");
            }

            $type = 'video';
            $media_url = $files['mn-video-right']['path'] ?? $this->params['hdn-video-right'];
            if (!$action_update) {
                $project_section_items_2 = $DB->insert("INSERT INTO project_section_items 
                    (section_id, `type`, content, media_url, settings, `order`, timecreated, timeupdated)
                    VALUES 
                    ($section_id, '$type', '', '$media_url', '$css', 2, $time, $time)
                ");
            } else {
                $id = $DB->get_record("SELECT id FROM project_section_items WHERE section_id = ? AND type = 'video'", [$this->params['update_id']])->id;

                $project_section_items_1 = $DB->execute("
                    UPDATE project_section_items
                    SET 
                        `type`       = '$type',
                        content      = '',
                        media_url    = '$media_url',
                        settings     = '$css',
                        timeupdated  = $time
                    WHERE id = $id
                ");
            }
        } else if ($this->params['layout'] === 'video_left_text_right') {
            if (!empty($this->params['style']) && $this->params['style'] === 'center') {
                $css['align-self'] = "center !important;";
            }

            $section_id = $project_section;
            $type = 'video';
            $media_url = $files['mn-video-left']['path'] ?? $this->params['hdn-video-left'];
            $css = json_encode($css);
            if (!$action_update) {
                $project_section_items_1 = $DB->insert("INSERT INTO project_section_items 
                (section_id, `type`, content, media_url, settings, `order`, timecreated, timeupdated)
                VALUES 
                ($section_id, '$type', '', '$media_url', '$css', 1, $time, $time)
            ");
            } else {
                $id = $DB->get_record("SELECT id FROM project_section_items WHERE section_id = ? AND type = 'video'", [$this->params['update_id']])->id;

                $project_section_items_1 = $DB->execute("
                    UPDATE project_section_items
                    SET 
                        `type`       = '$type',
                        content      = '',
                        media_url    = '$media_url',
                        settings     = '$css',
                        timeupdated  = $time
                    WHERE id = $id
                ");
            }

            $type = 'text';
            $content = $this->params['mn-text-right'];
            if (!$action_update) {
                $project_section_items_2 = $DB->insert("INSERT INTO project_section_items 
                    (section_id, `type`, content, media_url, settings, `order`, timecreated, timeupdated)
                    VALUES 
                    ($section_id, '$type', '$content', '', '$css', 2, $time, $time)
                ");
            } else {
                $id = $DB->get_record("SELECT id FROM project_section_items WHERE section_id = ? AND type = 'text'", [$this->params['update_id']])->id;

                $project_section_items_2 = $DB->execute("
                    UPDATE project_section_items
                    SET 
                        `type`       = '$type',
                        content      = '$content',
                        media_url    = '',
                        settings     = '$css',
                        timeupdated  = $time
                    WHERE id = $id
                ");
            }

        } else if ($this->params['layout'] === 'two_images_left_large_right_small') {

            if (!empty($this->params['style']) && $this->params['style'] === 'center') {
                $css['align-self'] = "center !important;";
            }

            $section_id = $project_section;
            $type = 'image';
            $media_url = $files['mn-image-left']['path'] ?? $this->params['hdn-image-left'];
            $css = json_encode($css);

            if (!$action_update) {
                $project_section_items_1 = $DB->insert("INSERT INTO project_section_items 
                    (section_id, `type`, content, media_url, settings, `order`, timecreated, timeupdated)
                    VALUES 
                    ($section_id, '$type', '', '$media_url', '$css', 1, $time, $time)
                ");
            } else {
                $id = $DB->get_record("SELECT id FROM project_section_items WHERE section_id = ? AND type = 'image' LIMIT 1", [$this->params['update_id']])->id;

                $project_section_items_1 = $DB->execute("
                    UPDATE project_section_items
                    SET 
                        `type`       = '$type',
                        content      = '',
                        media_url    = '$media_url',
                        settings     = '$css',
                        timeupdated  = $time
                    WHERE id = $id
                ");
            }

            $media_url = $files['mn-image-right']['path'] ?? $this->params['hdn-image-right'];

            if (!$action_update) {
                $project_section_items_2 = $DB->insert("INSERT INTO project_section_items 
                (section_id, `type`, content, media_url, settings, `order`, timecreated, timeupdated)
                VALUES 
                ($section_id, '$type', '', '$media_url', '$css', 2, $time, $time)
            ");
            } else {
                $id = $DB->get_record("SELECT id FROM project_section_items WHERE section_id = ? AND type = 'image' LIMIT 1,1", [$this->params['update_id']])->id;

                $project_section_items_2 = $DB->execute("
                    UPDATE project_section_items
                    SET 
                        `type`       = '$type',
                        content      = '',
                        media_url    = '$media_url',
                        settings     = '$css',
                        timeupdated  = $time
                    WHERE id = $id
                ");
            }
        } else if ($this->params['layout'] === 'one_image') {

            if (!empty($this->params['style']) && $this->params['style'] === 'full-width') {
                $css['width'] = "100% !important;";
            } else if (!empty($this->params['style']) && $this->params['style'] === 'align-right') {
                $css['display'] = 'block';
                $css['margin-left'] = 'auto !important;';
            }

            $section_id = $project_section;
            $type = 'image';
            $media_url = $files['mn-image-left']['path'] ?? $this->params['hdn-image-left'];
            $css = json_encode($css);

            if (!$action_update) {
                $project_section_items_1 = $DB->insert("INSERT INTO project_section_items 
                    (section_id, `type`, content, media_url, settings, `order`, timecreated, timeupdated)
                    VALUES 
                    ($section_id, '$type', '', '$media_url', '$css', 1, $time, $time)
                ");
            } else {
                $id = $DB->get_record("SELECT id FROM project_section_items WHERE section_id = ? AND type = 'image' LIMIT 1", [$this->params['update_id']])->id;

                $project_section_items_1 = $DB->execute("
                    UPDATE project_section_items
                    SET 
                        `type`       = '$type',
                        content      = '',
                        media_url    = '$media_url',
                        settings     = '$css',
                        timeupdated  = $time
                    WHERE id = $id
                ");
            }
        } else if ($this->params['layout'] === 'two_images') {

            if (!empty($this->params['style']) && $this->params['style'] === 'full-width') {
                $css['width'] = "100% !important;";
            } else if (!empty($this->params['style']) && $this->params['style'] === 'full-width-height') {
                $css['width'] = "100% !important;";
                $css['height'] = "100% !important;";
            }

            $section_id = $project_section;
            $type = 'image';
            $media_url = $files['mn-image-left']['path'] ?? $this->params['hdn-image-left'];
            $css = json_encode($css);

            if (!$action_update) {
                $project_section_items_1 = $DB->insert("INSERT INTO project_section_items 
                    (section_id, `type`, content, media_url, settings, `order`, timecreated, timeupdated)
                    VALUES 
                    ($section_id, '$type', '', '$media_url', '$css', 1, $time, $time)
                ");
            } else {
                $id = $DB->get_record("SELECT id FROM project_section_items WHERE section_id = ? AND type = 'image' LIMIT 1", [$this->params['update_id']])->id;

                $project_section_items_1 = $DB->execute("
                    UPDATE project_section_items
                    SET 
                        `type`       = '$type',
                        content      = '',
                        media_url    = '$media_url',
                        settings     = '$css',
                        timeupdated  = $time
                    WHERE id = $id
                ");
            }

            $media_url = $files['mn-image-right']['path'] ?? $this->params['hdn-image-right'];

            if (!$action_update) {
                $project_section_items_2 = $DB->insert("INSERT INTO project_section_items 
                    (section_id, `type`, content, media_url, settings, `order`, timecreated, timeupdated)
                    VALUES 
                    ($section_id, '$type', '', '$media_url', '$css', 2, $time, $time)
                ");
            } else {
                $id = $DB->get_record("SELECT id FROM project_section_items WHERE section_id = ? AND type = 'image' LIMIT 1,1", [$this->params['update_id']])->id;

                $project_section_items_2 = $DB->execute("
                    UPDATE project_section_items
                    SET 
                        `type`       = '$type',
                        content      = '',
                        media_url    = '$media_url',
                        settings     = '$css',
                        timeupdated  = $time
                    WHERE id = $id
                ");
            }
        } else if ($this->params['layout'] === 'one_video') {
            if (!empty($this->params['style']) && $this->params['style'] === 'full-width') {
                $css['width'] = "100% !important;";
            } else if (!empty($this->params['style']) && $this->params['style'] === 'full-width-height') {
                $css['width'] = "100% !important;";
                $css['height'] = "100% !important;";
            } else if (!empty($this->params['style']) && $this->params['style'] === 'center') {
                $css['margin-left'] = "auto !important;";
                $css['margin-right'] = "auto !important;";
            } else if (!empty($this->params['style']) && $this->params['style'] === 'align-right') {
                $css['margin-left'] = "auto !important;";
            }

            $section_id = $project_section;
            $type = 'video';
            $media_url = $files['mn-video-left']['path'] ?? $this->params['hdn-video-left'];
            $css = json_encode($css);
            if (!$action_update) {
                $project_section_items_1 = $DB->insert("INSERT INTO project_section_items 
                (section_id, `type`, content, media_url, settings, `order`, timecreated, timeupdated)
                VALUES 
                ($section_id, '$type', '', '$media_url', '$css', 1, $time, $time)
            ");
            } else {
                $id = $DB->get_record("SELECT id FROM project_section_items WHERE section_id = ? AND type = 'video'", [$this->params['update_id']])->id;

                $project_section_items_1 = $DB->execute("
                    UPDATE project_section_items
                    SET 
                        `type`       = '$type',
                        content      = '',
                        media_url    = '$media_url',
                        settings     = '$css',
                        timeupdated  = $time
                    WHERE id = $id
                ");
            }
        }

        $response = [
            'success' => true,
        ];
        $this->send_response($response);
    }

    public function generate_section_demo()
    {

        global $DB;

        require_once(__DIR__ . '/../core/Renderer.php');

        $renderer = new Renderer();

//        if (empty($this->params['data'])) {
//            $response = [
//                'success' => false,
//                'output' => 'Faltan parametros'
//            ];
//            $this->send_response($response, 400);
//        }

        $files = [];

        foreach ($_FILES as $key => $value) {
            if (!empty($value['tmp_name'])) {

                // Convertir la imagen a Base64 para que sea accesible desde HTML
                $image_base64 = '';
                if (!empty($value['tmp_name'])) {
                    $imgData = file_get_contents($value['tmp_name']);
                    $ext = strtolower(pathinfo($value['name'], PATHINFO_EXTENSION));

                    // Extensiones de imagen
                    $image_exts = ['jpg', 'jpeg', 'png', 'gif', 'webp', 'bmp', 'svg'];

                    // Extensiones de vídeo
                    $video_exts = ['mp4', 'webm', 'ogg'];

                    if (in_array($ext, $image_exts)) {
                        // Imagen
                        $image_base64 = 'data:image/' . $ext . ';base64,' . base64_encode($imgData);

                    } else if (in_array($ext, $video_exts)) {
                        // Vídeo
                        $image_base64 = 'data:video/' . $ext . ';base64,' . base64_encode($imgData);

                    } else {
                        // Otros tipos (opcional)
                        $image_base64 = 'data:application/octet-stream;base64,' . base64_encode($imgData);
                    }
                }

                $files[$key] = [
                    'full_path' => $value['full_path'],
                    'tmp_name' => $value['tmp_name'],
                    'base64' => $image_base64
                ];
            }
        }

        $html = $css = '';

        if (!empty($this->params['margin-top'])) {
            $margin_top = $this->params['margin-top'];

            if (is_numeric($margin_top)) {
                $css .= 'margin-top: ' . $margin_top . 'rem !important;';
            } else {
                $css .= 'margin-top: ' . $margin_top . ' !important;';
            }

        }

        if (!empty($this->params['margin-bottom'])) {
            $margin_bottom = $this->params['margin-bottom'];
            if (is_numeric($margin_bottom)) {
                $css .= 'margin-bottom: ' . $margin_bottom . 'rem !important;';
            } else {
                $css .= 'margin-bottom: ' . $margin_bottom . ' !important;';
            }
        }

        if ($this->params['layout'] === 'text_left_image_right') {

            if (!empty($this->params['style']) && $this->params['style'] === 'center') {
                $css .= "align-self: center !important;";
            }

            $temp_data = [
                'id' => 'temp',
                's_css' => !empty($this->params['background']) ? ('background: ' . $this->params['background'] . ' !important;') : '',
                'items' => [
                    [
                        'type' => 'text',
                        'is_text' => true,
                        'css' => $css,
                        'content' => $this->params['mn-text-left']
                    ],
                    [
                        'type' => 'image',
                        'is_image' => true,
                        'css' => $css,
                        'media_url' => $files['mn-image-right']['base64'] ?? $this->params['hdn-image-right']
                    ]
                ]
            ];
            $html = $renderer->render_template('sections/text_left_image_right', $temp_data);
        } else if ($this->params['layout'] === 'image_left_text_right') {

            if (!empty($this->params['style']) && $this->params['style'] === 'center') {
                $css .= "align-self: center !important;";
            }

            $temp_data = [
                'id' => 'temp',
                's_css' => !empty($this->params['background']) ? ('background: ' . $this->params['background'] . ' !important;') : '',
                'items' => [
                    [
                        'type' => 'image',
                        'is_image' => true,
                        'css' => $css,
                        'media_url' => $files['mn-image-left']['base64'] ?? $this->params['hdn-image-left']
                    ],
                    [
                        'type' => 'text',
                        'is_text' => true,
                        'css' => $css,
                        'content' => $this->params['mn-text-right']
                    ],
                ]
            ];
            $html = $renderer->render_template('sections/image_left_text_right', $temp_data);
        } else if ($this->params['layout'] === 'image_left_text_right') {

            if (!empty($this->params['style']) && $this->params['style'] === 'center') {
                $css .= "align-self: center !important;";
            }

            $temp_data = [
                'id' => 'temp',
                's_css' => !empty($this->params['background']) ? ('background: ' . $this->params['background'] . ' !important;') : '',
                'items' => [
                    [
                        'type' => 'image',
                        'is_image' => true,
                        'css' => $css,
                        'media_url' => $files['mn-image-left']['base64'] ?? $this->params['hdn-image-left']
                    ],
                    [
                        'type' => 'text',
                        'is_text' => true,
                        'css' => $css,
                        'content' => $this->params['mn-text-right']
                    ],
                ]
            ];
            $html = $renderer->render_template('sections/image_left_text_right', $temp_data);
        } else if ($this->params['layout'] === 'text_left_video_right') {

            if (!empty($this->params['style']) && $this->params['style'] === 'center') {
                $css .= "align-self: center !important;";
            }

            $temp_data = [
                'id' => 'temp',
                's_css' => !empty($this->params['background']) ? ('background: ' . $this->params['background'] . ' !important;') : '',
                'items' => [
                    [
                        'type' => 'text',
                        'is_text' => true,
                        'css' => $css,
                        'content' => $this->params['mn-text-left']
                    ],
                    [
                        'type' => 'video',
                        'is_video' => true,
                        'css' => $css,
                        'media_url' => $files['mn-video-right']['base64'] ?? $this->params['hdn-video-right']
                    ],
                ]
            ];
            $html = $renderer->render_template('sections/text_left_video_right', $temp_data);
        } else if ($this->params['layout'] === 'video_left_text_right') {

            if (!empty($this->params['style']) && $this->params['style'] === 'center') {
                $css .= "align-self: center !important;";
            }

            $temp_data = [
                'id' => 'temp',
                's_css' => !empty($this->params['background']) ? ('background: ' . $this->params['background'] . ' !important;') : '',
                'items' => [
                    [
                        'type' => 'video',
                        'is_video' => true,
                        'css' => $css,
                        'media_url' => $files['mn-video-left']['base64'] ?? $this->params['hdn-video-left']
                    ],
                    [
                        'type' => 'text',
                        'is_text' => true,
                        'css' => $css,
                        'content' => $this->params['mn-text-right']
                    ]
                ]
            ];
            $html = $renderer->render_template('sections/video_left_text_right', $temp_data);
        } else if ($this->params['layout'] === 'two_images_left_large_right_small') {

            if (!empty($this->params['style']) && $this->params['style'] === 'center') {
                $css .= "align-self: center !important;";
            }

            $temp_data = [
                'id' => 'temp',
                's_css' => !empty($this->params['background']) ? ('background: ' . $this->params['background'] . ' !important;') : '',
                'items' => [
                    [
                        'type' => 'image',
                        'is_image_left' => true,
                        'media_url' => $files['mn-image-left']['base64'] ?? $this->params['hdn-image-left']
                    ],
                    [
                        'type' => 'image',
                        'is_image_right' => true,
                        'css' => $css,
                        'media_url' => $files['mn-image-right']['base64'] ?? $this->params['hdn-image-right']
                    ]
                ]
            ];

            $html = $renderer->render_template('sections/two_images_left_large_right_small', $temp_data);
        } else if ($this->params['layout'] === 'one_image') {

            if (!empty($this->params['style']) && $this->params['style'] === 'full-width') {
                $css .= "width: 100% !important;";
            } else if (!empty($this->params['style']) && $this->params['style'] === 'align-right') {
                $css .= "display: block; margin-left: auto !important;";
            }

            $temp_data = [
                'id' => 'temp',
                's_css' => !empty($this->params['background']) ? ('background: ' . $this->params['background'] . ' !important;') : '',
                'items' => [
                    [
                        'type' => 'image',
                        'is_image' => true,
                        'css' => $css,
                        'media_url' => $files['mn-image-left']['base64'] ?? $this->params['hdn-image-left']
                    ]
                ]
            ];

            $html = $renderer->render_template('sections/one_image', $temp_data);
        } else if ($this->params['layout'] === 'two_images') {

            if (!empty($this->params['style']) && $this->params['style'] === 'full-width') {
                $css .= "width: 100% !important;";
            } else if (!empty($this->params['style']) && $this->params['style'] === 'full-width-height') {
                $css .= "width: 100% !important; height: 100% !important";
            }

            $temp_data = [
                'id' => 'temp',
                's_css' => !empty($this->params['background']) ? ('background: ' . $this->params['background'] . ' !important;') : '',
                'items' => [
                    [
                        'type' => 'image',
                        'is_image_left' => true,
                        'css' => $css,
                        'media_url' => $files['mn-image-left']['base64'] ?? $this->params['hdn-image-left']
                    ],
                    [
                        'type' => 'image',
                        'is_image_right' => true,
                        'css' => $css,
                        'media_url' => $files['mn-image-right']['base64'] ?? $this->params['hdn-image-right']
                    ]
                ]
            ];

            $html = $renderer->render_template('sections/two_images', $temp_data);
        } else if ($this->params['layout'] === 'one_video') {

            if (!empty($this->params['style']) && $this->params['style'] === 'full-width') {
                $css .= "width: 100% !important;";
            } else if (!empty($this->params['style']) && $this->params['style'] === 'align-right') {
                $css .= "display: block; margin-left: auto !important;";
            } else if (!empty($this->params['style']) && $this->params['style'] === 'center') {
                $css .= "margin-left: auto !important;";
                $css .= "margin-right: auto !important;";
            } else if (!empty($this->params['style']) && $this->params['style'] === 'align-right') {
                $css .= "margin-left: auto !important;";
            }

            $temp_data = [
                'id' => 'temp',
                's_css' => !empty($this->params['background']) ? ('background: ' . $this->params['background'] . ' !important;') : '',
                'items' => [
                    [
                        'type' => 'video',
                        'is_video' => true,
                        'css' => $css,
                        'media_url' => $files['mn-video-left']['base64'] ?? $this->params['hdn-video-left']
                    ]
                ]
            ];
            $html = $renderer->render_template('sections/one_video', $temp_data);
        }

        $response = [
            'success' => true,
            'output' => $html
        ];
        $this->send_response($response);
    }

    public function delete_section()
    {
        global $DB;

        if (empty($this->params['project'])) {
            $response = [
                'success' => false,
                'output' => 'Faltan parametros'
            ];
            $this->send_response($response, 400);
        }

        $project_id = $this->params['project'];

        $DB->execute('UPDATE project_sections SET `visible` = 0 WHERE `id` = ?', [$project_id]);

        $response = [
            'success' => true,
            'output' => $project_id,
        ];
        $this->send_response($response);
    }

    #[NoReturn] private function send_response($data, $status = 200): void
    {
        header('Content-Type: application/json');
        http_response_code($status);
        echo json_encode($data);
        exit();
    }

}