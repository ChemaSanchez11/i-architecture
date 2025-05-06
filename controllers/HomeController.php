<?php

require_once __DIR__ . '/../core/Renderer.php';

use core\Renderer;

class HomeController
{
    public function index()
    {
        global $CFG;

        // Crear una instancia de la clase Renderer
        $renderer = new Renderer();

        // Establecer el título de la página
        $renderer->set_title('Inicio');

        // Agregar archivos de estilo
        $renderer->add_styles(['home.css']);

        // Agregar archivos de script con parámetros adicionales
//        $renderer->add_scripts('script.js');

        // Renderizar la cabecera
        $renderer->render_head();

        // Renderizar la barra de navegación con parámetros
        $renderer->render_nav([
            'routes' => array_values($CFG->routes),
        ]);

        // Renderizar el HTML completo (incluye head, nav y body)
        $renderer->render_html('home');

    }
}