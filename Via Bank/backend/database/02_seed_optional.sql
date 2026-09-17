USE via_bank;

INSERT INTO investment_products (name, description, risk, return_label, active) VALUES
('Reserva Via', 'Produto de renda fixa para reserva de liquidez.', 'LOW', 'Rentabilidade definida pelo produto', TRUE),
('Renda Fixa Via', 'Produto de renda fixa com prazo definido.', 'LOW', 'Consulte a taxa vigente', TRUE),
('Fundo Diversificado', 'Carteira diversificada com oscilação de mercado.', 'MODERATE', 'Rentabilidade variável', TRUE);
