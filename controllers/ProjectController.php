<?php

require_once __DIR__ . '/../core/Renderer.php';

use core\Renderer;

class ProjectController
{
    public function index()
    {
        global $CFG, $DB;

        // Recoger ID
        $id = $_GET['id'] ?? null;
        if (!$id) {
            die("ID de proyecto no proporcionado");
        }

        // 1️⃣ Obtener proyecto
        $project = (array) $DB->get_record("SELECT * FROM proyects WHERE id = ?", [$id]);

        if (!$project) {
            die("Proyecto no encontrado");
        }

        $renderer = new Renderer();
        $renderer->set_title($project['name'] ?? 'Proyecto');
        $renderer->add_styles(['project.css']);
        $renderer->add_scripts(['project.js']);

        // Render HEAD + NAV
        $renderer->render_head();
        $renderer->render_nav_transparent([
            'routes' => array_values($CFG->routes),
        ]);

        // 2️⃣ Obtener secciones del proyecto
        $sections = $DB->get_records("
            SELECT * FROM project_sections 
            WHERE project_id = ? AND visible = 1
            ORDER BY `order` ASC
        ", [$id]);

        // 3️⃣ Obtener items de cada sección
        foreach ($sections as &$section) {
            $section->{"is_" . $section->layout_type} = true;

            $section->s_css = '';
            if (!empty($section->custom_css)) {
                $section->custom_css = json_decode($section->custom_css);

                foreach ($section->custom_css as $key => $value) {
                    $section->s_css .= "$key: $value;";
                }

            }

            $items = $DB->get_records("
                SELECT * FROM project_section_items
                WHERE section_id = ?
                ORDER BY `order` ASC
            ", [$section->id]);

            foreach ($items as &$item) {
                $item->{"is_" . $item->type} = true;

                // Asignar izquierda/derecha manual según orden o configuración
                if ($item->order == 1) $item->is_image_left = true;
                if ($item->order == 2) $item->is_image_right = true;

                $item->css = null;
                if (!empty($item->settings)) {
                    $item->settings_json = json_decode($item->settings);
                    foreach ($item->settings_json as $key => $setting) {
                        $item->css .= "$key: $setting;";
                    }
                }
            }


            $section->items = $items;
        }

        // 4️⃣ Preparar datos para Mustache
        $context = [
            'project'  => $project,
            'sections' => $sections,
        ];

        // 5️⃣ Renderizar plantilla Mustache
        $renderer->render_html('project', $context);

        echo('<pre>');
        echo json_encode([
            'project' => $project,
            'sections' => $sections,
        ], JSON_PRETTY_PRINT);
        echo('</pre>');
    }
}
