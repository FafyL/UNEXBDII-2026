
CREATE OR REPLACE PROCEDURE public.realizar_venda(IN p_produto_id integer, IN p_quantidade integer)
 LANGUAGE plpgsql
AS $procedure$
DECLARE
    v_preco DECIMAL(10, 2);
    v_estoque_atual INT;
    v_valor_total DECIMAL(10, 2);
BEGIN
    
    SELECT preco, estoque INTO v_preco, v_estoque_atual
    FROM produtos
    WHERE id = p_produto_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Erro: Produto com ID % não encontrado.', p_produto_id;
    END IF;

    
    IF v_estoque_atual < p_quantidade THEN
        RAISE EXCEPTION 'Erro: Estoque insuficiente. Disponível: %, Solicitado: %', v_estoque_atual, p_quantidade;
    END IF;

   
    v_valor_total := v_preco * p_quantidade;

    
    INSERT INTO vendas (produto_id, quantidade, valor_total)
    VALUES (p_produto_id, p_quantidade, v_valor_total);

   
    UPDATE produtos
    SET estoque = estoque - p_quantidade
    WHERE id = p_produto_id;

    RAISE NOTICE 'Venda realizada com sucesso! Total: R$ %', v_valor_total;

EXCEPTION
    WHEN OTHERS THEN
        
        RAISE NOTICE 'Transação abortada: %', SQLERRM;
        ROLLBACK;
END;
$procedure$
;


CALL realizar_venda(1, 2);
SELECT * FROM produtos;
SELECT * FROM vendas;
