CREATE table t_photo
(
    id    serial primary key,
    image bytea
);

CREATE table t_partner
(
    id                 serial primary key,
    name               varchar(30) not null,
    cashback           float check (cashback > 0),
    cashback_with_card float check (cashback_with_card >= t_partner.cashback),
    photo_id           integer
        constraint t_partner_t_photo_id_fk
            references t_photo
);


CREATE table t_role
(
    id   integer primary key,
    name varchar(30) not null
);

CREATE table t_user
(
    id         serial primary key,
    name       varchar(255),
    surname    varchar(255),
    login      varchar(15) unique,
    password   varchar(255) not null,
    points     integer check (points >= 0),
    role_id    integer
        constraint t_user_t_role_id_fk
            references t_role,
    partner_id integer
        constraint t_user_t_partner_id_fk
            references t_partner
);

CREATE table t_product
(
    id         serial primary key,
    name       varchar(255),
    price      float check (price >= 0),
    weight     float,
    partner_id integer
        constraint t_product_t_partner_id_fk
            references t_partner,
    photo_id   integer
        constraint t_product_t_photo_id_fk
            references t_photo
);
CREATE table t_loyalty_card
(
    id             serial primary key,
    number_of_card integer unique,
    partner_id     integer
        constraint t_loyalty_card_t_partner_id_fk
            references t_partner,
    user_id        integer
        constraint t_loyalty_card_t_user_id_fk
            references t_user
);

CREATE table t_review
(
    id          serial primary key,
    user_review varchar(255),
    partner_id  integer
        constraint t_review_t_partner_id_fk
            references t_partner,
    user_id     integer
        constraint t_review_t_user_id_fk
            references t_user
);

CREATE table t_offer
(
    id               serial primary key,
    start_time       timestamp,
    end_time         timestamp,
    discount_percent integer check (discount_percent > 0 and discount_percent < 100),
    using_count      integer default 0 check (using_count >= 0),
    product_id       integer unique
        constraint t_offer_t_product_id_fk
            references t_product
);

CREATE table t_order_status
(
    id     integer primary key,
    status varchar(100)
);

CREATE table t_bank_card
(
    id             serial primary key,
    number_of_card integer unique,
    cvv            integer,
    end_time       date
);

CREATE table t_order
(
    id              serial primary key,
    start_time      timestamp,
    end_time        timestamp,
    points_count    float check (points_count >= 0 and points_count <= order_sum),
    order_sum       integer check (order_sum > 0),
    address         varchar(255),
    order_status_id integer
        constraint t_order_t_order_status_id_fk
            references t_order_status,
    user_id         integer
        constraint t_order_t_user_id_fk
            references t_user,
    courier_id      integer
        constraint t_order_t_courier_id_fk
            references t_user,
    offer_id        integer
        constraint t_order_t_offer_id_fk
            references t_offer
);

CREATE table t_user_bank_card
(
    user_id      integer
        constraint t_user_bank_card_t_user_id_fk
            references t_user,
    bank_card_id integer
        constraint t_user_bank_card_t_bank_card_id_fk
            references t_bank_card,
    primary key (user_id, bank_card_id)
);
