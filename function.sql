CREATE OR REPLACE FUNCTION public.validar_cpf(cpf text)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
DECLARE
    cpf_limpo TEXT;
    soma INT;
    resto INT;
    i INT;
    dig1 INT;
    dig2 INT;
BEGIN
    -- remove caracteres não numéricos
    cpf_limpo := regexp_replace(cpf, '[^0-9]', '', 'g');

    -- tamanho inválido
    IF length(cpf_limpo) <> 11 THEN
        RETURN FALSE;
    END IF;

    -- elimina CPFs inválidos conhecidos
    IF cpf_limpo ~ '^(.)\1{10}$' THEN
        RETURN FALSE;
    END IF;

    -- cálculo do 1º dígito
    soma := 0;
    FOR i IN 1..9 LOOP
        soma := soma + (substring(cpf_limpo, i, 1)::INT * (11 - i));
    END LOOP;

    resto := soma % 11;
    IF resto < 2 THEN
        dig1 := 0;
    ELSE
        dig1 := 11 - resto;
    END IF;

    -- cálculo do 2º dígito
    soma := 0;
    FOR i IN 1..10 LOOP
        soma := soma + (substring(cpf_limpo, i, 1)::INT * (12 - i));
    END LOOP;

    resto := soma % 11;
    IF resto < 2 THEN
        dig2 := 0;
    ELSE
        dig2 := 11 - resto;
    END IF;

    -- valida dígitos finais
    IF dig1 = substring(cpf_limpo, 10, 1)::INT AND
       dig2 = substring(cpf_limpo, 11, 1)::INT THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$function$
;
