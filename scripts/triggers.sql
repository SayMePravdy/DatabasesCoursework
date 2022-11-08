create trigger tg_get_user_cashback
    after update
    on t_order
    for each row
execute procedure f_get_cashback();

create trigger tg_spend_points
    after insert
    on t_order
    for each row
execute procedure f_spend_points();

create trigger tg_use_offer
    after insert
    on t_order
    for each row
execute procedure f_use_offer();

