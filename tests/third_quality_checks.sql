---Quality Checks for third.customer_dim---
select customer_index
from third.customer_dim
group by customer_index
having count(*)>1;


---Quality Checks for third.product_dim---
select product_index
from third.product_dim
group by product_index
having count(*)>1;


---Quality Checks for third.sales_fact---
select * 
from third.sales_fact sf
LEFT JOIN third.customer_dim cd
on sf.customer_index=cd.customer_index
LEFT JOIN third.product_dim pd
on sf.product_index=pd.product_index
WHERE cd.customer_index is null or pd.product_index is null;