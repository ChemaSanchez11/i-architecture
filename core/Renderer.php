<?php

namespace core;

use Exception;
use Mustache_Autoloader;
use Mustache_Engine;
use Mustache_Loader_FilesystemLoader;

class Renderer
{
    private ?Mustache_Engine $mustache;
    private array $styles = [];
    private array $scripts = [];
    private ?string $head = null;
    private ?string $nav = null;
    private ?string $title = null;
    private ?string $loading = 'images/loading.gif';
    private ?string $loading_style = 'position: absolute; width: 100%;';

    public function __construct()
    {
        $this->initialize_mustache();
    }

    public function set_loading(string $loading, $loading_style = 'position: absolute; width: 100%;'): void
    {
        $this->loading = $loading;
        $this->loading_style = $loading_style;
    }

    public function set_title(string $title): void
    {
        $this->title = $title;
    }

    public function add_styles(array|string $styles): void
    {
        foreach ((array)$styles as $style) {
            if (!in_array($style, $this->styles)) {
                $this->styles[] = $style;
            }
        }
    }

    public function add_scripts(array|string $scripts): void
    {
        foreach ((array)$scripts as $script) {
            if (!in_array($script, $this->scripts)) {
                $this->scripts[] = $script;
            }
        }
    }

    private function initialize_mustache(): void
    {
        require_once __DIR__ . '/../lib/mustache/src/Mustache/Autoloader.php';
        Mustache_Autoloader::register();

        $this->mustache = new Mustache_Engine([
            'loader' => new Mustache_Loader_FilesystemLoader(__DIR__ . '/../templates'),
            'partials_loader' => new Mustache_Loader_FilesystemLoader(__DIR__ . '/../templates')
        ]);

        // Detecta automáticamente la URL base
        $protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? "https" : "http";
        $host = $_SERVER['HTTP_HOST'];
        $path = rtrim(dirname($_SERVER['SCRIPT_NAME']), '/');
        $baseurl = $protocol . "://" . $host . $path;

        // Añadimos un helper "img"
        $this->mustache->addHelper('print_img', function($text, $render) use ($baseurl) {
            $filename = trim($render($text));

            if (str_starts_with($filename, 'data:')) {
                return $filename;
            }

            return $baseurl . '/assets/images/' . $filename;
        });

        // Añadimos un helper "video"
        $this->mustache->addHelper('print_video', function($text, $render) use ($baseurl) {
            $filename = trim($render($text));
            return $baseurl . '/assets/videos/' . $filename;
        });

        // Añadimos un helper "link"
        $this->mustache->addHelper('link', function($route, $render) use ($baseurl) {

            // Render del parámetro
            $route = $render($route);

            // Si es "/" queda vacío
            if ($route === '/') {
                $route = '';
            } else {
                // Quitar una / inicial si existe
                $route = ltrim($route, '/');
            }

            return $baseurl . '/' . $route;
        });
    }

    public function render_head(): void
    {
        global $CFG;

        $this->head = $this->render_template('core/head', [
            'base' => $CFG->proyect,
            'title' => $this->title ?? 'Untitled',
            'styles' => $this->styles,
            'js' => $this->scripts,
        ]);
    }

    public function render_nav(array $params): void
    {
        $this->nav = $this->render_template('core/nav', $params);
    }

    public function render_nav_transparent(array $params): void
    {
        $this->nav = $this->render_template('core/nav-transparent', $params);
    }

    public function render_template(string $template, array $data = []): string
    {
        try {
            return $this->mustache->render($template, $data);
        } catch (Exception $e) {
            throw new Exception("Error rendering template '$template': " . $e->getMessage());
        }
    }

    public function render_html(string $template, $params = [], $print_footer = true)
    {
        if (is_null($this->head)) {
            $this->render_head();
        }

        $body =  $this->render_template($template, $params);

        echo $this->render_template('core/html', [
            'loading' => $this->loading,
            'loading_style' => $this->loading_style,
            'head' => $this->head,
            'nav' => $this->nav,
            'body' => $body,
            'print_footer' => $print_footer
        ]);
    }
}
