CREATE OR REPLACE FUNCTION trg_validar_cpf()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT validar_cpf(NEW.cpf) THEN
        RAISE EXCEPTION 'CPF inválido: %', NEW.cpf;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;



CREATE TRIGGER validar_cpf_clientes
BEFORE INSERT ON clientes
FOR EACH ROW
EXECUTE FUNCTION trg_validar_cpf();
