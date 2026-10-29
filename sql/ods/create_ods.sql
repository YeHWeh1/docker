-- 第1周 ODS 层建表与导入脚本
-- 库：ydsh_ods   分隔符：,   跳过表头：skip.header.line.count=1
create database if not exists ydsh_ods;

-- 1) 用户信息表
create table if not exists ydsh_ods.ods_user (
  user_id string, user_name string, gender string, age int,
  city string, province string, register_date string,
  member_level string, phone string, email string
) row format delimited fields terminated by ','
tblproperties('skip.header.line.count'='1');

-- 2) 商品信息表
create table if not exists ydsh_ods.ods_product (
  product_id string, product_name string, category string, sub_category string,
  brand string, price double, cost double, stock int, status string, launch_date string
) row format delimited fields terminated by ','
tblproperties('skip.header.line.count'='1');

-- 3) 门店信息表
create table if not exists ydsh_ods.ods_store (
  store_id string, store_name string, province string, city string,
  district string, address string, open_date string, area int, manager string
) row format delimited fields terminated by ','
tblproperties('skip.header.line.count'='1');

-- 4) 订单主表
create table if not exists ydsh_ods.ods_order (
  order_id string, user_id string, store_id string, order_date string, order_time string,
  pay_amount double, discount_amount double, pay_type string, order_status string, channel string
) row format delimited fields terminated by ','
tblproperties('skip.header.line.count'='1');

-- 5) 订单明细表
create table if not exists ydsh_ods.ods_order_item (
  item_id string, order_id string, product_id string, quantity int,
  unit_price double, discount double
) row format delimited fields terminated by ','
tblproperties('skip.header.line.count'='1');

-- 6) 用户行为日志表
create table if not exists ydsh_ods.ods_user_behavior (
  behavior_id string, user_id string, product_id string, behavior_type string,
  behavior_time string, session_id string
) row format delimited fields terminated by ','
tblproperties('skip.header.line.count'='1');

-- 导入（/data 为容器内挂载点，对应宿主机 E:\dsh project\模拟数据）
load data local inpath '/data/ods_user.csv'         into table ydsh_ods.ods_user;
load data local inpath '/data/ods_product.csv'      into table ydsh_ods.ods_product;
load data local inpath '/data/ods_store.csv'        into table ydsh_ods.ods_store;
load data local inpath '/data/ods_order.csv'        into table ydsh_ods.ods_order;
load data local inpath '/data/ods_order_item.csv'   into table ydsh_ods.ods_order_item;
load data local inpath '/data/ods_user_behavior.csv' into table ydsh_ods.ods_user_behavior;

-- 行数校验：1000 / 600 / 60 / 15600 / 37549 / 60000
select 'ods_user' as t, count(*) as c from ydsh_ods.ods_user
union all select 'ods_product', count(*) from ydsh_ods.ods_product
union all select 'ods_store', count(*) from ydsh_ods.ods_store
union all select 'ods_order', count(*) from ydsh_ods.ods_order
union all select 'ods_order_item', count(*) from ydsh_ods.ods_order_item
union all select 'ods_user_behavior', count(*) from ydsh_ods.ods_user_behavior;
