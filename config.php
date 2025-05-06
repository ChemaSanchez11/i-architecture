<?php

use core\DB;
use core\EnvCache;

require_once(__DIR__ . '/core/DB.php');
require_once(__DIR__ . '/core/EnvCache.php');

unset($CFG, $DB);
global $CFG, $DB;

$CFG = new stdClass();

session_name('i_architecture_session');
session_start();

$CFG->routes = [
    '/home' => [
        'name' => 'Inicio',
        'visible' => false,
        'controller' => 'HomeController',
        'method' => 'index',
        'has_params' => false,
    ],
    '/projects' => [
        'name' => 'projects',
        'visible' => true,
        'controller' => 'HomeController',
        'method' => 'index',
        'has_params' => false,
    ],
    '/about' => [
        'name' => 'about',
        'visible' => true,
        'controller' => 'FileController',
        'method' => 'list',
        'has_params' => false,
    ],
    '/file' => [
        'visible' => false,
        'controller' => 'FileController',
        'method' => 'handle',
        'has_params' => true,
    ],
];

$env_file = __DIR__ . '/.env';
$cache_file = __DIR__ . '/.env.cache.php';

$env = new EnvCache(__DIR__ . '/.env', __DIR__ . '/storage/cache/env.php');
$env->load();

$DB = new DB(
    $_ENV['DB_HOST'],
    $_ENV['DB_USER'],
    $_ENV['DB_PASS'],
    $_ENV['DB_PORT'],
    $_ENV['DB_NAME']
);