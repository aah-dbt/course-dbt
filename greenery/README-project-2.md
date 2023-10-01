
Repeat Rate:
  76.1538
select 
     (count( CASE WHEN number_of_order>=2 then user_id END) / count( user_id))*100 "Repeat Rate"
from fact_user_order;

Snapshot: Product inventory Changes:
Product          Current Inventory Previous Inventory
Pothos	          40	              0
Bamboo	          56	              44
Philodendron	    51	              15
Monstera	        77	              50
String of pearls	58	              0
ZZ Plant	        89	              53

select ps.name, ps.inventory "Current inventory", p.inventory "Previous inventory"
from products_snapshot ps
left join stage_postgres__products p
on p.product_id = ps.product_id
where coalesce(p.inventory,0) <> coalesce(ps.inventory,0);
