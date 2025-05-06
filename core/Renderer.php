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

    public function __construct()
    {
        $this->initialize_mustache();
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
    }

    public function render_head(): void
    {
        $this->head = $this->render_template('core/head', [
            'title' => $this->title ?? 'Untitled',
            'styles' => $this->styles,
            'js' => $this->scripts,
        ]);
    }

    public function render_nav(array $params): void
    {
        $this->nav = $this->render_template('core/nav', $params);
    }

    public function render_template(string $template, array $data = []): string
    {
        try {
            return $this->mustache->render($template, $data);
        } catch (Exception $e) {
            throw new Exception("Error rendering template '$template': " . $e->getMessage());
        }
    }

    public function render_html(string $template, $params = [])
    {
        if (is_null($this->head)) {
            $this->render_head();
        }

        $body =  $this->render_template($template, $params);

        echo $this->render_template('core/html', [
            'head' => $this->head,
            'nav' => $this->nav,
            'body' => $body
        ]);
    }
}
