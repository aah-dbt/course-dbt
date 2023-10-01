User Conversion Rate: 62.4567

    SQL: select 100*(count(distinct case when checkouts > 0 then session_id end) /
    count(distinct session_id)) "Converion Rate"
    from fact_user_page_views_macro;

product Conversion rate:
    PRODUCT_NAME	Converion Rate
    Arrow Head	55.5556
    Pilea Peperomioides	47.4576
    Philodendron	48.3871
    Rubber Plant	51.8519
    Jade Plant	47.8261
    Orchid	45.3333
    Bird of Paradise	45
    Angel Wings Begonia	39.3443
    Aloe Vera	49.2308
    Boston Fern	41.2698
    Ponytail Palm	40
    Calathea Makoyana	50.9434
    String of pearls	60.9375
    Pothos	34.4262
    Cactus	54.5455
    Ficus	42.6471
    Birds Nest Fern	42.3077
    Snake Plant	39.726
    Majesty Palm	49.2537
    Bamboo	53.7313
    Spider Plant	47.4576
    Money Tree	46.4286
    Pink Anthurium	41.8919
    Monstera	51.0204
    Peace Lily	40.9091
    Devil's Ivy	48.8889
    ZZ Plant	53.9683
    Fiddle Leaf Fig	50
    Alocasia Polly	41.1765
    Dragon Tree	46.7742

    SQL:
    select product_name,
    100*(count(distinct case when checkout > 0 then session_id end) /
    count(distinct session_id)) "Converion Rate"
    from fact_user_product_page_views_macro
    group by all


product Snapshot changes:
    NAME	Snapshot inventory	Previous inventory
    Pothos	40	0
    Bamboo	56	44
    Philodendron	51	15
    Monstera	77	50
    String of pearls	58	0
    ZZ Plant	89	53

    SQL:
    select ps.name, ps.inventory "Snapshot inventory", p.inventory "Previous inventory"
    from products_snapshot ps
    left join stage_postgres__products p
    on p.product_id = ps.product_id
    where coalesce(p.inventory,0) <> coalesce(ps.inventory,0);