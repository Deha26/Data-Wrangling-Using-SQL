---Quality checks for second.crm_cst_info---
select cst_id
from second.crm_cust_info
group by cst_id
having count(*)>1;

select cst_key
from  second.crm_cust_info
where cst_key<>trim(cst_key);


---Quality checks for second.crm_prd_info---
select prd_id 
from second.crm_prd_info
group by prd_id
having count(*)>1 or prd_id is NULL;

select prd_key
from second.crm_prd_info
where trim(prd_key)<>prd_key or prd_key is null;

select prd_nm
from second.crm_prd_info
where trim(prd_nm)<> prd_nm or prd_nm is null;

select distinct prd_line
from second.crm_prd_info;

select prd_cost
from second.crm_prd_info
where prd_cost<0 or prd_cost is null;

select prd_start_dt, prd_end_dt
from second.crm_prd_info
where prd_end_dt<prd_start_dt;

---Quality checks for second.crm_sales_details---
select sls_due_dt
from second.crm_sales_details
where sls_due_dt is null or
      len(sls_due_dt) <> 10;

select sls_order_dt,sls_due_dt,sls_ship_dt
from second.crm_sales_details
where sls_order_dt>sls_due_dt or
	  sls_order_dt>sls_ship_dt;

select sls_sales,sls_quantity,sls_price
from second.crm_sales_details
where sls_sales<>sls_quantity*sls_price or
	  sls_sales is null or
	  sls_quantity is null or
	  sls_price is null or
	  sls_sales<=0 or
	  sls_quantity<=0 or
	  sls_price<=0;

---Quality Checks for second.erp_cust_az12---
select distinct gen
from second.erp_cust_az12;

select bdate
from second.erp_cust_az12
where bdate > GETDATE();

---Quality Checks for second.erp_loc_a101--
select distinct cntry
from second.erp_loc_a101;

---Quality Checks for second.erp_px_cat_g1v2---
select cat,subcat,maintenance
from second.erp_px_cat_g1v2
where TRIM(cat)<>cat or
	  TRIM(subcat)<>subcat or
	  TRIM(maintenance)<>maintenance;

select distinct maintenance
from second.erp_px_cat_g1v2;