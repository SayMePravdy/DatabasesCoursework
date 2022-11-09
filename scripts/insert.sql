DO
$$
    DECLARE
        roles             text[] := '{"CLIENT", "CURIER", "PARTNER"}';
        order_statuses    text[] := '{"CREATED", "IN_PROCESS", "DELIVERED"}';
        manNames          text[] :=
                    '{"Антон", "Андрей", "Арсений", "Александр", "Борис", "Булат", "Виктор", "Иван", "Василий", ' ||
                    '"Максим", "Роберт", "Денис", "Даниил", "Михаил", "Кирилл", "Алексей", "Богдан", "Николай", ' ||
                    '"Артем", "Владимир", "Вадим", "Олег", "Юрий", "Сергей", "Роман", "Илья", "Дмитрий"}';
        womanNames        text[] :=
                        '{"Алина", "Жанна", "Анна", "Кристина", "Диана", "Ангелина", "Евгения", "Лилия", "Виктория", ' ||
                        '"Екатерина", "Вера", "Ксения", "Дарья", "Татьяна", "Ирина", "Ольга", "Ульяна", "Варвара", ' ||
                        '"Вероника", "Юлия", "Алла", "Софья", "Мария", "Марина", "Любовь", "Светлана", "Полина", ' ||
                        '"Нина", "Наталья", "Маргарита"}';
        surnames          text[] :=
                            '{"Петров", "Максимов", "Иванов", "Жамков", "Пупкин", "Денисов", "Алексеев", "Богданов", "Штангов", ' ||
                            '"Красиков", "Антонов", "Мишин", "Китаев", "Дождев", "Тучкин", "Пупкин", "Николаев", "Дорохов", ' ||
                            '"Петряев", "Красоткин", "Галиев", "Семёнов", "Шипачев", "Радулов", "Стулов", "Китов", "Морев", ' ||
                            '"Молотов", "Войнов", "Драконов", "Кошкин", "Ежов", "Васильев", "Викторов", "Победилов", "Кораблев", ' ||
                            '"Романов", "Сергеев", "Дмитриев", "Ильин"}';
        partners          text[] :=
                '{"Пятерочка", "Магнит", "Uber", "Yandex.Market", "Karri", "Mvideo", "DNS", "Tinkoff", "Ростелеком", ' ||
                '"Acer", "Dell", "Перекресток", "Шаверма у Шера"}';
        curr_name         text   := '';
        curr_surname      text   := '';
        generate_sex      int    := 0;
        count_of_users    int    := 120;
        count_of_partners int    := 13;
    begin
        for i in 1..3
            loop
                insert into t_role values (i, roles[i]);
            end loop;
        for i in 1..3
            loop
                insert into t_order_status values (i, order_statuses[i]);
            end loop;
        for i in 1..count_of_partners
            loop
                insert into t_photo values (i, convert_to(md5(random()::text), 'LATIN1'));
            end loop;
        for i in 1..count_of_users
            loop
                insert into t_bank_card
                values (i, 1000 + round(random() * 999999999), round(random() * 3 + 100),
                        (timestamp '01.01.2022' + random() * (timestamp '01.01.2027' - timestamp '01.01.2022'))::date);
            end loop;
        for i in 1..count_of_partners
            loop
                curr_name := concat(partners[round(random() * 13) + 1]);

                insert into t_partner values (i, curr_name, round(random() * 10) + 1, round(random() * 99) + 10, i);
            end loop;
        for i in 1..count_of_users
            loop
                curr_name := concat(womanNames[round(random() * 29) + 1]);
                curr_surname = concat(surnames[round(random() * 39) + 1]);
                generate_sex := round(random());
                if generate_sex = 1 then
                    curr_name := concat(manNames[round(random() * 26) + 1]);
                    curr_surname = concat(surnames[round(random() * 39) + 1]);
                end if;
                insert into t_user
                values (i, curr_name, curr_surname,
                        concat(substr(md5(random()::text), 0, 10)),
                        concat(substr(md5(random()::text), 0, 10)),
                        round(random() * 15000),
                        random() * 2 + 1,
                        round(random() * 12 + 1));
            end loop;
        for i in 1..count_of_partners
            loop
                curr_name := concat(partners[round(random() * 13) + 1]);

                insert into t_product
                values (i, curr_name, round(random() * 5550000) + 1, round(random() * 99) + 10, i, i);
            end loop;
        for i in 1..count_of_partners
            loop
                insert into t_offer
                values (i,
                        (timestamp '01.01.2022' + random() * (timestamp '01.01.2027' - timestamp '01.01.2022'))::date,
                        (timestamp '01.01.2022' + random() * (timestamp '01.01.2090' - timestamp '01.01.2022'))::date,
                        round(random() * 10) + 10, i, i);
            end loop;
        for i in 1..count_of_users
            loop
                insert into t_loyalty_card
                values (i, 1000 + round(random() * 999999999), round(random() * 12 + 1), round(random() * 119 + 1));
            end loop;
        for i in 1..count_of_users
            loop
                insert into t_review
                values (i, concat(substr(md5(random()::text), 0, 10)), round(random() * 12 + 1),
                        round(random() * 119 + 1));
            end loop;
        for i in 1..count_of_users
            loop
                insert into t_order
                values (i,
                        (timestamp '01.01.2022' + random() * (timestamp '01.01.2027' - timestamp '01.01.2022'))::date,
                        (timestamp '01.01.2022' + random() * (timestamp '01.01.2090' - timestamp '01.01.2022'))::date,
                        10.0, 1000 + round(random() * 999999999),
                        concat(substr(md5(random()::text), 0, 10)), random() * 2 + 1, round(random() * 12 + 1),
                        round(random() * 12 + 1), round(random() * 12 + 1));
            end loop;
    end
$$;
