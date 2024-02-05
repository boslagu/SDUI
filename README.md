Requirements
1. Postgres
2. Flutter and IDE
3. GoLang

NOTE: Please check IP and ports in GoLang Service placed in main.go. Also check the IP and ports in Flutter App placed in main.dart.

Instruction for backend service
1. Create a database named as sdui_service
2. Apply the script below for creating table
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
3. Apply the script below for adding and setting auto increment
    CREATE SEQUENCE public.required_fields_seq
        INCREMENT 1
        START 1
        MINVALUE 1
        MAXVALUE 9223372036854775807
        CACHE 1;

    ALTER SEQUENCE public.required_fields_seq
        OWNER TO postgres;
	
    ALTER TABLE required_fields ALTER COLUMN id SET DEFAULT nextval('required_fields_seq');
    UPDATE required_fields SET id = nextval('required_fields_seq');
4. Apply the script below to add a fields in table required_fields
   INSERT INTO public.required_fields(
    	field_display,
    	field_name,
    	field_type,
    	field_max_len,
    	field_min_len,
    	is_required
    )
    VALUES ('Username', 'username', 'ALPHANUMERIC', '10', '6', true);
    
    INSERT INTO public.required_fields(
    	field_display,
    	field_name,
    	field_type,
    	field_max_len,
    	field_min_len,
    	is_required
    )
    VALUES ('Password', 'password', 'ALPHANUMERIC', '10', '6', true);
