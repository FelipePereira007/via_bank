USE via_bank;

-- Autenticação
SELECT id, name, email, password_hash, enabled
FROM users
WHERE LOWER(email) = LOWER(?)
LIMIT 1;

-- Conta de um usuário
SELECT * FROM bank_accounts WHERE user_id = ? LIMIT 1;

-- Resolver chave PIX
SELECT pk.id, pk.key_type, pk.key_value, ba.id AS account_id, ba.status
FROM pix_keys pk
JOIN bank_accounts ba ON ba.id = pk.account_id
WHERE pk.key_value = ?
LIMIT 1;

-- Lock pessimista antes de debitar/creditar
SELECT * FROM bank_accounts WHERE id = ? FOR UPDATE;

-- Extrato de 30 dias
SELECT *
FROM transactions
WHERE account_id = ?
  AND created_at >= UTC_TIMESTAMP() - INTERVAL 30 DAY
ORDER BY created_at DESC
LIMIT ? OFFSET ?;

-- Gastos por categoria
SELECT COALESCE(category, 'Outros') AS category,
       ABS(SUM(amount)) AS total
FROM transactions
WHERE account_id = ?
  AND amount < 0
  AND created_at >= ?
GROUP BY COALESCE(category, 'Outros')
ORDER BY total DESC;

-- Conferir as duas pontas de um PIX
SELECT id, account_id, counterparty_account_id, type, amount,
       transfer_reference, created_at
FROM transactions
WHERE transfer_reference = ?
ORDER BY id;

-- Portfólio
SELECT i.id, i.principal, i.current_value, i.monthly_return,
       p.name AS product_name, p.risk
FROM investments i
JOIN investment_products p ON p.id = i.product_id
WHERE i.account_id = ?;

-- Limpeza de tokens revogados já expirados
DELETE FROM revoked_tokens WHERE expires_at < UTC_TIMESTAMP();
