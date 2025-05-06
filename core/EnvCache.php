<?php

declare(strict_types=1);

namespace core;

/**
 * Clase para gestionar variables de entorno con cacheo.
 */
class EnvCache
{
    private string $envPath;
    private string $cachePath;

    /**
     * Constructor.
     *
     * @param string $envPath Ruta al archivo .env original.
     * @param string $cachePath Ruta al archivo de caché PHP generado.
     */
    public function __construct(string $envPath, string $cachePath)
    {
        $this->envPath = $envPath;
        $this->cachePath = $cachePath;
    }

    /**
     * Carga las variables de entorno desde caché o .env y las establece en $_ENV y putenv().
     */
    public function load(): void
    {
        if (!file_exists($this->cachePath) || filemtime($this->envPath) > filemtime($this->cachePath)) {
            $this->buildCache();
        }

        $env = require $this->cachePath;

        foreach ($env as $key => $value) {
            $_ENV[$key] = $value;
            putenv("$key=$value");
        }
    }

    /**
     * Genera el archivo de caché a partir del archivo .env.
     */
    private function buildCache(): void
    {
        if (!file_exists($this->envPath)) {
            http_response_code(500);
            exit('.env file not found at ' . $this->envPath);
        }

        $env = [];
        $lines = file($this->envPath, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);

        foreach ($lines as $line) {
            $line = trim($line);
            if ($line === '' || str_starts_with($line, '#')) continue;
            if (!str_contains($line, '=')) continue;

            [$name, $value] = explode('=', $line, 2);
            $env[trim($name)] = trim($value);
        }

        $content = "<?php\n\nreturn " . var_export($env, true) . ";\n";
        file_put_contents($this->cachePath, $content, LOCK_EX);
    }
}
