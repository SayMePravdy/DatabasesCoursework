create or replace function f_get_cashback() returns trigger as
$$
declare
    cashback integer;
    user_id  integer := old.user_id;
begin
    if ((select status
         from t_order_status
         where id = new.order_status_id) = 'completed') then
        if (exists(select * from t_loyalty_card tlc where tlc.user_id = user_id)) then
            cashback := (select cashback_with_card from t_partner);
        else
            cashback := (select cashback from t_partner);
        end if;
        update t_user set points = points + cast(new.order_sum * cashback as integer);
    end if;
end;
$$ language plpgsql;

create or replace function f_spend_points() returns trigger as
$$
begin
    update t_user set points = points - new.points_count;
end;
$$ language plpgsql;

create or replace function f_use_offer() returns trigger as
$$
begin
    update t_offer set using_count = using_count + 1;
end;
$$ language plpgsql;

create or replace function get_offers() returns setof t_offer as
$$
begin
    select * from t_offer;
end;
$$ language plpgsql;
create or replace function get_static() returns setof t_review as
$$
begin
    select * from t_review;
end;
$$ language plpgsql;
create or replace function get_orders() returns setof t_order as
$$
begin
    select * from t_order;
end;
$$ language plpgsql;
create or replace function get_feedback() returns setof t_review as
$$
begin
    select * from t_review;
end;
$$ language plpgsql;
create or replace function get_offers_by_product_name(productName varchar(255) default '') returns setof t_review as
$$
begin
    select *
    from t_offer
             inner join t_product tp on tp.id = t_offer.product_id
    where tp.name like productName;
end;
$$ language plpgsql;




