<?php

namespace core;

use mysqli;
use mysqli_stmt;
use stdClass;

/**
 * Class DB
 * Manejador de base de datos usando mysqli con soporte para consultas preparadas,
 * obtención de múltiples registros, inserciones, y control de errores.
 */
class DB
{
    private ?mysqli $db;
    private bool $status = false;
    private ?string $error = null;

    /**
     * Constructor: establece la conexión con la base de datos.
     *
     * @param string $host     Servidor de la base de datos.
     * @param string $user     Usuario de la base de datos.
     * @param string $pass     Contraseña del usuario.
     * @param string $port     Puerto de conexión.
     * @param string $database Nombre de la base de datos a seleccionar.
     */
    public function __construct(string $host, string $user, string $pass, string $port, string $database)
    {
        $this->db = @mysqli_connect("$host:$port", $user, $pass, $database);

        if ($this->db !== false) {
            $this->status = true;
            mysqli_set_charset($this->db, "utf8mb4");
        } else {
            $this->error = mysqli_connect_error();
        }
    }

    /**
     * Obtiene múltiples registros como una lista de objetos.
     *
     * @param string $query  Consulta SQL con placeholders (?).
     * @param array  $params Parámetros para enlazar a la consulta.
     * @return stdClass[] Lista de objetos (puede estar vacía).
     */
    public function get_records(string $query, array $params = []): array
    {
        $data = [];
        $stmt = $this->prepare_statement($query, $params);
        if (!$stmt) {
            return $data;
        }

        $stmt->execute();
        $result = $stmt->get_result();

        if ($result && empty($this->db->error)) {
            while ($row = $result->fetch_assoc()) {
                $data[] = (object) $row;
            }
        }

        return $data;
    }

    /**
     * Obtiene un solo registro como objeto.
     *
     * @param string $query  Consulta SQL con placeholders (?).
     * @param array  $params Parámetros para enlazar a la consulta.
     * @return stdClass|null Objeto del registro o null si no se encontró.
     */
    public function get_record(string $query, array $params = []): ?stdClass
    {
        $stmt = $this->prepare_statement($query, $params);
        if (!$stmt) {
            return null;
        }

        $stmt->execute();
        $result = $stmt->get_result();

        if ($result && $result->num_rows === 1) {
            return (object) $result->fetch_assoc();
        }

        return null;
    }

    /**
     * Ejecuta una consulta preparada (INSERT, UPDATE, DELETE, etc.).
     *
     * @param string $query  Consulta SQL con placeholders (?).
     * @param array  $params Parámetros para enlazar a la consulta.
     * @return bool True si se ejecutó correctamente, False en caso contrario.
     */
    public function execute(string $query, array $params = []): bool
    {
        $stmt = $this->prepare_statement($query, $params);
        return $stmt && $stmt->execute();
    }

    /**
     * Ejecuta una inserción directa y devuelve el ID insertado.
     *
     * @param string $query Consulta SQL (INSERT).
     * @return int|false ID insertado o false si falla.
     */
    public function insert(string $query)
    {
        if ($this->db->query($query) === true) {
            return $this->db->insert_id;
        }
        return false;
    }

    /**
     * Prepara una consulta con parámetros y devuelve el statement listo.
     *
     * @param string $query  Consulta SQL con placeholders (?).
     * @param array  $params Parámetros a enlazar.
     * @return mysqli_stmt|null Statement preparado o null si falla.
     */
    private function prepare_statement(string $query, array $params): ?mysqli_stmt
    {
        $stmt = $this->db->prepare($query);
        if (!$stmt) {
            $this->error = $this->db->error;
            return null;
        }

        if (!empty($params)) {
            $types = $this->prepare_query_types($params);
            $stmt->bind_param($types, ...$params);
        }

        return $stmt;
    }

    /**
     * Genera la cadena de tipos para bind_param según los tipos de parámetros.
     *
     * @param array $params Parámetros a enlazar.
     * @return string Cadena de tipos (i=integer, d=double, s=string, b=blob).
     */
    private function prepare_query_types(array $params): string
    {
        return implode('', array_map(function ($param) {
            return match (true) {
                is_int($param)   => 'i',
                is_float($param) => 'd',
                is_string($param) => 's',
                default          => 'b',
            };
        }, $params));
    }

    /**
     * Verifica si la conexión con la base de datos fue exitosa.
     *
     * @return bool True si está conectado, false si falló.
     */
    public function get_status(): bool
    {
        return $this->status;
    }

    /**
     * Devuelve el último mensaje de error de conexión o ejecución.
     *
     * @return string|null Mensaje de error o null si no hay errores.
     */
    public function get_error(): ?string
    {
        return $this->error;
    }
}
