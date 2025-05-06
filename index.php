<?php

require_once 'config.php';
require_once 'Router.php';

global $CFG;

$router = new Router('/i-architecture');
$router->load_routes($CFG->routes);
$router->dispatch($_SERVER['REQUEST_URI']);