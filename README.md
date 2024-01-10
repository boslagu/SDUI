Requirements
1. Postgres
2. Flutter and IDE
3. GoLang

Instruction for backend service
1. Create a database named as sdui_service
2. Apply the script below
    -- Table: public.required_fields
    -- DROP TABLE public.required_fields;
    CREATE TABLE public.required_fields
    (
        id bigint NOT NULL,
        field_display character varying COLLATE pg_catalog."default",
        field_name character varying COLLATE pg_catalog."default",
        field_type character varying COLLATE pg_catalog."default",
        field_max_len bigint,
        field_min_len bigint,
        is_required boolean,
        CONSTRAINT required_fields_pkey PRIMARY KEY (id)
    )
    TABLESPACE pg_default;
