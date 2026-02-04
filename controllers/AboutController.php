<?php

require_once __DIR__ . '/../core/Renderer.php';

use core\Renderer;

class AboutController
{
    public function index()
    {
        global $CFG, $DB;

        // Crear una instancia de la clase Renderer
        $renderer = new Renderer();

        // Establecer el título de la página
        $renderer->set_title('About');

        // Agregar archivos de estilo
        $renderer->add_styles(['about.css']);

        $renderer->add_scripts(['main.js']);

        // Renderizar la cabecera
        $renderer->render_head();

        // Renderizar la barra de navegación con parámetros
        $renderer->render_nav([
            'routes' => array_values($CFG->routes),
        ]);

        $config = $DB->get_record('SELECT value FROM config WHERE `name` = "img_about"');
        $config_footer = $DB->get_record('SELECT value FROM config WHERE `name` = "img_about_footer"');

        $is_manager = false;
        // Agregar archivos de script con parámetros adicionales
        if (!empty($_SESSION['user_id']) && !empty($_SESSION['role']) && $_SESSION['role'] === 'manager') {
            $is_manager = true;
        }

        // Renderizar el HTML completo (incluye head, nav y body)
        $renderer->render_html('about', [
            'img' => $config->value,
            'img_footer' => $config_footer->value,
            'is_manager' => $is_manager
        ], false);

    }
}