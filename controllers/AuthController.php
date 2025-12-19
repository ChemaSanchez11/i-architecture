<?php

require_once __DIR__ . '/../core/Renderer.php';
use core\Renderer;

class AuthController {

    public function login() {
        global $DB;

        $renderer = new Renderer();

        $error = false;

        if (!empty($_POST)) {
            $user = $DB->get_record("SELECT * FROM users WHERE username = ?", [$_POST['username']]);

            if ($user && password_verify($_POST['password'], $user->password)) {
                $_SESSION['user_id'] = $user->id;
                $_SESSION['username'] = $user->username;
                $_SESSION['role'] = $user->role;

                $base = rtrim(dirname($_SERVER['SCRIPT_NAME']), '/');
                header('Location: ' . $base . '/');
                exit();
            } else {
                $error = "Usuario o contraseña incorrectos";
            }
        }

        $renderer->set_title('Login | i-architecture');
        $renderer->add_styles(['login.css']);

        // Renderiza la vista
        $renderer->render_head();
        $renderer->render_html('core/login', ['error' => $error], false);
    }

    public function logout() {
        global $DB;

        // Vaciar todas las variables de sesión
        $_SESSION = [];

        // Destruir la sesión
        session_destroy();

        // (Opcional) Eliminar la cookie de sesión en el navegador
        if (ini_get("session.use_cookies")) {
            $params = session_get_cookie_params();
            setcookie(session_name(), '', time() - 42000,
                $params["path"], $params["domain"],
                $params["secure"], $params["httponly"]
            );
        }

        // Redirigir al login o home
        $base = rtrim(dirname($_SERVER['SCRIPT_NAME']), '/');
        header('Location: ' . $base . '/');
        exit();
    }
}