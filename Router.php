<?php

require_once __DIR__ . '/core/Renderer.php';
use core\Renderer;

class Router {
    private array $routes = [];
    private string $base_path = '/';

    public function __construct($base_path = '/') {
        $this->base_path = rtrim($base_path, '/') . '/';
    }

    public function load_routes($routes) {
        $this->routes = $routes;
    }

    public function dispatch($request_uri) {
        global $CFG;

        foreach ($this->routes as $link => &$cfg_route) {
            $cfg_route['route'] = $link;
        }

        $path = parse_url($request_uri, PHP_URL_PATH);
        $route = ltrim(str_replace($this->base_path, '', $path), '/');

        if (empty($route)) {
            $route = 'home';
        }

        $segments = explode('/', $route);
        $route_base = '/' . ($segments[0] ?? 'home');
        $param_id = $segments[1] ?? null;

        if (!empty($segments[0]) && $segments[0] === 'api') {
            $service = $segments[1] ?? null;
            require_once __DIR__ . '/controllers/ApiController.php';

            $apiController = new ApiController(array_merge($_POST, $_GET));
            $apiController->handle_request($service);
            exit();
        }

        if (!isset($this->routes[$route_base])) {
            http_response_code(404);
            // Crear una instancia de la clase Renderer
            $renderer = new Renderer();

            // Establecer el título de la página
            $renderer->set_title('404 | i-architecture');

            // Agregar archivos de estilo
            $renderer->add_styles(['home.css']);

            // Renderizar la cabecera
            $renderer->render_head();

            // Renderizar el HTML completo (incluye head, nav y body)
            $renderer->render_html('core/404', [], false);
            return;
        }

        $this->routes[$route_base]['current'] = true;
        $current_route = $this->routes[$route_base];

        $CFG->routes = $this->routes;

        if ($current_route['has_params'] && $param_id !== null) {
            $_GET['id'] = $param_id;
        }

        $controller = $current_route['controller'];
        $method = $current_route['method'];

        $controller_path = "controllers/$controller.php";

        if (!file_exists($controller_path)) {
            http_response_code(500);
            echo "Controller file not found.";
            return;
        }

        require_once $controller_path;

        if (!class_exists($controller)) {
            http_response_code(500);
            echo "Controller class not found.";
            return;
        }

        $ctrl = new $controller();

        if (!method_exists($ctrl, $method)) {
            http_response_code(500);
            echo "Method not found in controller.";
            return;
        }

        call_user_func([$ctrl, $method]);
    }
}
