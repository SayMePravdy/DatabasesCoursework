create index if not exists user_order_index
    on using hash t_order(user_id);

create index if not exists product_name_index
    on t_product(name);

create index if not exists product_partner_index
    on using hash t_product(partner_id);
    
create index if not exists partner_review_index
    on using hash t_review(partner_id);

create index if not exists user_card_index
    on using hash t_loyalty_card(user_id);

--and all indexes on pk and unique fields
