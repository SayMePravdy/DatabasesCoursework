create index if not exists user_order_index
    on t_order using hash (user_id);

create index if not exists product_name_index
    on t_product(name);

create index if not exists product_partner_index
    on t_product using hash (partner_id);
    
create index if not exists partner_review_index
    on t_review using hash (partner_id);

create index if not exists user_card_index
    on t_loyalty_card using hash (user_id);
