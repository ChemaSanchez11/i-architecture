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

    public function move_section() {

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
                $order = ((int) $section->order) - 1;
            } else {
                $order = ((int) $section->order) + 1;
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

    public function new_section() {

        global $DB;

        require_once(__DIR__ . '/../core/Renderer.php');

        if (empty($this->params['target_section']) && empty($this->params['project'])) {
            $response = [
                'success' => false,
                'output' => 'Faltan parametros'
            ];
            $this->send_response($response, 400);
        }

        $project_id = $this->params['project'];
        $layout_type = $this->params['layout'];
        $time = time();

        $order_target_section = $DB->get_record('SELECT `order` FROM project_sections WHERE id = ?', [$this->params['target_section']])->order ?? 1;

        $custom_css = [];
        if (!empty($this->params['background'])) {
            $custom_css['background'] = $this->params['background'];
        }

        $custom_css = json_encode($custom_css);

        $project_section = null;
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

        $files = [];

        $DIR = __DIR__ . "/../assets/images/proyects/p-$project_id/";
        $DB_DIR = "proyects/p-$project_id/";

        foreach ($_FILES as $key => $value) {
            if(!empty($value['tmp_name'])) {

                // Extensión del archivo
                $ext = strtolower(pathinfo($value['name'], PATHINFO_EXTENSION));

                // Nombre único
                $uniqueName = uniqid("img_", true) . "." . $ext;

                $destination = $DIR . $uniqueName;
                $destination_db = $DB_DIR . $uniqueName;

                if (move_uploaded_file($value['tmp_name'], $destination)) {

                    // Ruta accesible para guardarla en BD
                    $files[$key] = [
                        'filename'   => $uniqueName,
                        'path'       => $destination_db,
                        'full_path'  => $destination
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

            if(!empty($this->params['style']) && $this->params['style'] === 'center') {
                $css['align-self'] = "center !important;";
            }

            $section_id = $project_section;
            $type = 'text';
            $content = $this->params['mn-text-left'];
            $css = json_encode($css);

            $project_section_items_1 = $DB->insert("INSERT INTO project_section_items 
                (section_id, `type`, content, media_url, settings, `order`, timecreated, timeupdated)
                VALUES 
                ($section_id, '$type', '$content', '', '$css', 1, $time, $time)
            ");

            $type = 'image';
            $media_url = $files['mn-image-right']['path'];

            $project_section_items_2 = $DB->insert("INSERT INTO project_section_items 
                (section_id, `type`, content, media_url, settings, `order`, timecreated, timeupdated)
                VALUES 
                ($section_id, '$type', '', '$media_url', '$css', 2, $time, $time)
            ");
        } else if ($this->params['layout'] === 'image_left_text_right') {

            if(!empty($this->params['style']) && $this->params['style'] === 'center') {
                $css['align-self'] = "center !important;";
            }

            $section_id = $project_section;
            $type = 'image';
            $media_url = $files['mn-image-left']['path'];
            $css = json_encode($css);

            $project_section_items_1 = $DB->insert("INSERT INTO project_section_items 
                (section_id, `type`, content, media_url, settings, `order`, timecreated, timeupdated)
                VALUES 
                ($section_id, '$type', '', '$media_url', '$css', 1, $time, $time)
            ");

            $type = 'text';
            $content = $this->params['mn-text-right'];
            $project_section_items_2 = $DB->insert("INSERT INTO project_section_items 
                (section_id, `type`, content, media_url, settings, `order`, timecreated, timeupdated)
                VALUES 
                ($section_id, '$type', '$content', '', '$css', 2, $time, $time)
            ");
        } else if ($this->params['layout'] === 'text_left_video_right') {

            if(!empty($this->params['style']) && $this->params['style'] === 'center') {
                $css['align-self'] = "center !important;";
            }

            $section_id = $project_section;
            $type = 'text';
            $content = $this->params['mn-text-left'];
            $css = json_encode($css);

            $project_section_items_1 = $DB->insert("INSERT INTO project_section_items 
                (section_id, `type`, content, media_url, settings, `order`, timecreated, timeupdated)
                VALUES 
                ($section_id, '$type', '$content', '', '$css', 1, $time, $time)
            ");

            $type = 'video';
            $media_url = $files['mn-video-right']['path'];

            $project_section_items_2 = $DB->insert("INSERT INTO project_section_items 
                (section_id, `type`, content, media_url, settings, `order`, timecreated, timeupdated)
                VALUES 
                ($section_id, '$type', '', '$media_url', '$css', 2, $time, $time)
            ");
        } else if ($this->params['layout'] === 'video_left_text_right') {

            if(!empty($this->params['style']) && $this->params['style'] === 'center') {
                $css['align-self'] = "center !important;";
            }

            $section_id = $project_section;
            $type = 'video';
            $media_url = $files['mn-video-left']['path'];
            $css = json_encode($css);

            $project_section_items_1 = $DB->insert("INSERT INTO project_section_items 
                (section_id, `type`, content, media_url, settings, `order`, timecreated, timeupdated)
                VALUES 
                ($section_id, '$type', '', '$media_url', '$css', 1, $time, $time)
            ");

            $type = 'text';
            $content = $this->params['mn-text-right'];

            $project_section_items_2 = $DB->insert("INSERT INTO project_section_items 
                (section_id, `type`, content, media_url, settings, `order`, timecreated, timeupdated)
                VALUES 
                ($section_id, '$type', '$content', '', '$css', 2, $time, $time)
            ");

        } else if ($this->params['layout'] === 'two_images_left_large_right_small') {

            if(!empty($this->params['style']) && $this->params['style'] === 'center') {
                $css['align-self'] = "center !important;";
            }

            $section_id = $project_section;
            $type = 'image';
            $media_url = $files['mn-image-left']['path'];
            $css = json_encode($css);

            $project_section_items_1 = $DB->insert("INSERT INTO project_section_items 
                (section_id, `type`, content, media_url, settings, `order`, timecreated, timeupdated)
                VALUES 
                ($section_id, '$type', '', '$media_url', '$css', 1, $time, $time)
            ");

            $media_url = $files['mn-image-right']['path'];

            $project_section_items_2 = $DB->insert("INSERT INTO project_section_items 
                (section_id, `type`, content, media_url, settings, `order`, timecreated, timeupdated)
                VALUES 
                ($section_id, '$type', '', '$media_url', '$css', 2, $time, $time)
            ");
        } else if ($this->params['layout'] === 'one_image') {

            if(!empty($this->params['style']) && $this->params['style'] === 'full-width') {
                $css['width'] = "100% !important;";
            }

            $section_id = $project_section;
            $type = 'image';
            $media_url = $files['mn-image-left']['path'];
            $css = json_encode($css);

            $project_section_items_1 = $DB->insert("INSERT INTO project_section_items 
                (section_id, `type`, content, media_url, settings, `order`, timecreated, timeupdated)
                VALUES 
                ($section_id, '$type', '', '$media_url', '$css', 1, $time, $time)
            ");
        } else if ($this->params['layout'] === 'two_images') {

            if(!empty($this->params['style']) && $this->params['style'] === 'full-width') {
                $css['width'] = "100% !important;";
            } else if(!empty($this->params['style']) && $this->params['style'] === 'full-width-height') {
                $css['width'] = "100% !important;";
                $css['height'] = "100% !important;";
            }

            $section_id = $project_section;
            $type = 'image';
            $media_url = $files['mn-image-left']['path'];
            $css = json_encode($css);

            $project_section_items_1 = $DB->insert("INSERT INTO project_section_items 
                (section_id, `type`, content, media_url, settings, `order`, timecreated, timeupdated)
                VALUES 
                ($section_id, '$type', '', '$media_url', '$css', 1, $time, $time)
            ");

            $media_url = $files['mn-image-right']['path'];

            $project_section_items_2 = $DB->insert("INSERT INTO project_section_items 
                (section_id, `type`, content, media_url, settings, `order`, timecreated, timeupdated)
                VALUES 
                ($section_id, '$type', '', '$media_url', '$css', 2, $time, $time)
            ");
        }

        $response = [
            'success' => true,
        ];
        $this->send_response($response);
    }

    public function generate_section_demo() {

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
            if(!empty($value['tmp_name'])) {

                // Convertir la imagen a Base64 para que sea accesible desde HTML
                $image_base64 = '';
                if (!empty($value['tmp_name'])) {
                    $imgData = file_get_contents($value['tmp_name']);
                    $ext = strtolower(pathinfo($value['name'], PATHINFO_EXTENSION));

                    // Extensiones de imagen
                    $image_exts = ['jpg','jpeg','png','gif','webp','bmp','svg'];

                    // Extensiones de vídeo
                    $video_exts = ['mp4','webm','ogg'];

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
                $css .= 'margin-top: '.$margin_top.'rem !important;';
            } else {
                $css .= 'margin-top: '.$margin_top.' !important;';
            }

        }

        if (!empty($this->params['margin-bottom'])) {
            $margin_bottom = $this->params['margin-bottom'];
            if (is_numeric($margin_bottom)) {
                $css .= 'margin-bottom: '.$margin_bottom.'rem !important;';
            } else {
                $css .= 'margin-bottom: '.$margin_bottom.' !important;';
            }
        }

        if ($this->params['layout'] === 'text_left_image_right') {

            if(!empty($this->params['style']) && $this->params['style'] === 'center') {
                $css .= "align-self: center !important;";
            }

            $temp_data = [
                'id' => 'temp',
                's_css' => !empty($this->params['background']) ? ('background: '. $this->params['background'] . ' !important;') : '',
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
                        'media_url' => $files['mn-image-right']['base64']
                    ]
                ]
            ];
            $html = $renderer->render_template('sections/text_left_image_right', $temp_data);
        } else if ($this->params['layout'] === 'image_left_text_right') {

            if(!empty($this->params['style']) && $this->params['style'] === 'center') {
                $css .= "align-self: center !important;";
            }

            $temp_data = [
                'id' => 'temp',
                's_css' => !empty($this->params['background']) ? ('background: '. $this->params['background'] . ' !important;') : '',
                'items' => [
                    [
                        'type' => 'image',
                        'is_image' => true,
                        'css' => $css,
                        'media_url' => $files['mn-image-left']['base64']
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

            if(!empty($this->params['style']) && $this->params['style'] === 'center') {
                $css .= "align-self: center !important;";
            }

            $temp_data = [
                'id' => 'temp',
                's_css' => !empty($this->params['background']) ? ('background: '. $this->params['background'] . ' !important;') : '',
                'items' => [
                    [
                        'type' => 'image',
                        'is_image' => true,
                        'css' => $css,
                        'media_url' => $files['mn-image-left']['base64']
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

            if(!empty($this->params['style']) && $this->params['style'] === 'center') {
                $css .= "align-self: center !important;";
            }

            $temp_data = [
                'id' => 'temp',
                's_css' => !empty($this->params['background']) ? ('background: '. $this->params['background'] . ' !important;') : '',
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
                        'media_url' => $files['mn-video-right']['base64']
                    ],
                ]
            ];
            $html = $renderer->render_template('sections/text_left_video_right', $temp_data);
        } else if ($this->params['layout'] === 'video_left_text_right') {

            if(!empty($this->params['style']) && $this->params['style'] === 'center') {
                $css .= "align-self: center !important;";
            }

            $temp_data = [
                'id' => 'temp',
                's_css' => !empty($this->params['background']) ? ('background: '. $this->params['background'] . ' !important;') : '',
                'items' => [
                    [
                        'type' => 'video',
                        'is_video' => true,
                        'css' => $css,
                        'media_url' => $files['mn-video-left']['base64']
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

            if(!empty($this->params['style']) && $this->params['style'] === 'center') {
                $css .= "align-self: center !important;";
            }

            $temp_data = [
                'id' => 'temp',
                's_css' => !empty($this->params['background']) ? ('background: '. $this->params['background'] . ' !important;') : '',
                'items' => [
                    [
                        'type' => 'image',
                        'is_image_left' => true,
                        'media_url' => $files['mn-image-left']['base64']
                    ],
                    [
                        'type' => 'image',
                        'is_image_right' => true,
                        'css' => $css,
                        'media_url' => $files['mn-image-right']['base64']
                    ]
                ]
            ];

            $html = $renderer->render_template('sections/two_images_left_large_right_small', $temp_data);
        } else if ($this->params['layout'] === 'one_image') {

            if(!empty($this->params['style']) && $this->params['style'] === 'full-width') {
                $css .= "width: 100% !important;";
            }

            $temp_data = [
                'id' => 'temp',
                's_css' => !empty($this->params['background']) ? ('background: '. $this->params['background'] . ' !important;') : '',
                'items' => [
                    [
                        'type' => 'image',
                        'is_image' => true,
                        'css' => $css,
                        'media_url' => $files['mn-image-left']['base64']
                    ]
                ]
            ];

            $html = $renderer->render_template('sections/one_image', $temp_data);
        } else if ($this->params['layout'] === 'two_images') {

            if(!empty($this->params['style']) && $this->params['style'] === 'full-width') {
                $css .= "width: 100% !important;";
            } else if(!empty($this->params['style']) && $this->params['style'] === 'full-width-height') {
                $css .= "width: 100% !important; height: 100% !important";
            }

            $temp_data = [
                'id' => 'temp',
                's_css' => !empty($this->params['background']) ? ('background: '. $this->params['background'] . ' !important;') : '',
                'items' => [
                    [
                        'type' => 'image',
                        'is_image_left' => true,
                        'css' => $css,
                        'media_url' => $files['mn-image-left']['base64']
                    ],
                    [
                        'type' => 'image',
                        'is_image_right' => true,
                        'css' => $css,
                        'media_url' => $files['mn-image-right']['base64']
                    ]
                ]
            ];

            $html = $renderer->render_template('sections/two_images', $temp_data);
        }

        $response = [
            'success' => true,
            'output' => $html
        ];
        $this->send_response($response);
    }

    public function delete_section() {
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