CREATE TABLE conta (
    id SERIAL PRIMARY KEY,
    titular VARCHAR(100),
    saldo NUMERIC(10,2) CHECK (saldo >= 0)
);

INSERT INTO conta (id, titular, saldo)
VALUES
(1, 'João', 1000),
(2, 'Maria', 500);



UPDATE conta
SET saldo = saldo - 100
WHERE id = 1;

UPDATE conta
SET saldo = -500
WHERE id = 2;



BEGIN;

UPDATE conta
SET saldo = saldo - 100
WHERE id = 1;

-- ERRO
UPDATE conta
SET saldo = -500
WHERE id = 2;

ROLLBACK;


CREATE OR REPLACE PROCEDURE transferencia(
    origem INT,
    destino INT,
    valor NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN

    UPDATE conta
    SET saldo = saldo - valor
    WHERE id = origem;

    UPDATE conta
    SET saldo = saldo + valor
    WHERE id = destino;

EXCEPTION
    WHEN OTHERS THEN

        ROLLBACK;

        RAISE NOTICE 'Erro na transferência: %', SQLERRM;
END;
$$;

CALL transferencia(1, 2, 100);
