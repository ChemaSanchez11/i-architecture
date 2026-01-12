ALTER TABLE proyects
    ADD COLUMN cover_project_id INT UNSIGNED NULL AFTER header_source;

ALTER TABLE proyects
    ADD CONSTRAINT fk_proyects_cover
        FOREIGN KEY (cover_project_id)
            REFERENCES proyects (id)
            ON DELETE SET NULL
            ON UPDATE CASCADE;