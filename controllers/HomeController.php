<?php

require_once __DIR__ . '/../core/Renderer.php';

use core\Renderer;

class HomeController
{
    public function index()
    {
        global $CFG, $DB;

        // Crear una instancia de la clase Renderer
        $renderer = new Renderer();

        // Establecer el título de la página
        $renderer->set_title('Inicio');

        // Agregar archivos de estilo
        $renderer->add_styles(['home.css']);

        $renderer->add_scripts(['main.js']);

        $is_manager = false;
        // Agregar archivos de script con parámetros adicionales
        if (!empty($_SESSION['user_id']) && !empty($_SESSION['role']) && $_SESSION['role'] === 'manager') {
            $is_manager = true;
            $renderer->add_scripts(['main_m.js']);
        }

        // Renderizar la cabecera
        $renderer->render_head();

        // Renderizar la barra de navegación con parámetros
        $renderer->render_nav([
            'routes' => array_values($CFG->routes),
        ]);

        $proyects = $DB->get_records('SELECT id, name, source, source_type, cover_project_id, timeupdated FROM proyects WHERE active = 1');

        foreach ($proyects as &$proyect) {
            $proyect->source_image = true;
            $proyect->source_video = false;
            if ($proyect->source_type === 'video') {
                $proyect->source_image = false;
                $proyect->source_video = true;
            }
        }

        // Renderizar el HTML completo (incluye head, nav y body)
        $renderer->render_html('home', ['proyects' => $proyects, 'is_manager' => $is_manager]);

    }
}