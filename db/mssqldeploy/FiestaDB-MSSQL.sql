-- MS SQL   
-- Database Name: Fiesta
-- ------------------------------------------------------
-- 


--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS [products];
CREATE TABLE products (
  [id] INT PRIMARY KEY IDENTITY (1, 1),
  [product_name] varchar(255) NOT NULL,
  [product_price] decimal(5,2) NOT NULL,
  [product_image_url] varchar(max) NOT NULL,
  [product_comment] varchar(255) DEFAULT NULL,
);

--
-- Dumping data for table `products`
--

INSERT INTO products ([product_name],[product_price],[product_image_url],[product_comment]) VALUES ('12 large ballons',2.30,'https://cdn.shopify.com/s/files/1/1832/6341/products/BLOON_MET_GOLD__01_1000x.jpg?v=1571327220','On back order');
INSERT INTO products ([product_name],[product_price],[product_image_url],[product_comment]) VALUES ('Single Banquet Chair Cover',2.99,'https://cdn.shopify.com/s/files/1/1832/6341/products/SASH_71_046_D04_0a16a508-5cd5-422f-ab7d-45acee11f6d1_1000x.jpg?v=1571323936','Vendor in on Wednesdays only.');
INSERT INTO products ([product_name],[product_price],[product_image_url],[product_comment]) VALUES ('90x132 Rectangle Table Cloth',24.50,'https://cdn.shopify.com/s/files/1/1832/6341/products/TAB_02_5454_SILV__02_7bb66485-2943-489e-a7c7-8d3f2d810fc5.progressive.jpg?v=1571325198','Table cloth quality issues. Need to talk to vendor.');
INSERT INTO products ([product_name],[product_price],[product_image_url],[product_comment]) VALUES ('120" Round Table Cloth',14.00,'https://cdn.shopify.com/s/files/1/1832/6341/products/TAB_120_WHT-2_1000x.jpg?v=1571323057','Need double order next time.');
INSERT INTO products ([product_name],[product_price],[product_image_url],[product_comment]) VALUES ('5 Pack Linen Napkins',5.25,'https://cdn.shopify.com/s/files/1/1832/6341/products/NAP_OSC_WHT_1000x.jpg?v=1571323239','Dont buy the gray ones. Only Beige or white colors sell.');
INSERT INTO products ([product_name],[product_price],[product_image_url],[product_comment]) VALUES ('12"x108" Inch Table Runner',2.42,'https://cdn.shopify.com/s/files/1/1832/6341/products/RUN_STN_CHMP-2_large.progressive.jpg?v=1571323435','Vendor is discontinuing these July 2020.');
INSERT INTO products ([product_name],[product_price],[product_image_url],[product_comment]) VALUES ('21 FT Table Skirt',15.00,'https://cdn.shopify.com/s/files/1/1832/6341/products/SKT_POLY_WHT_21__01_1000x.jpg?v=1571323258','Get more variety from vendor as per customers feedback. ');
INSERT INTO products ([product_name],[product_price],[product_image_url],[product_comment]) VALUES ('Pretty Flowers Center Piece',25.50,'https://cdn.shopify.com/s/files/1/1832/6341/products/PROP_CUPK_001__02_1000x.jpg?v=1571323944',NULL);
INSERT INTO products ([product_name],[product_price],[product_image_url],[product_comment]) VALUES ('10 Champagne Flutes',4.50,'https://cdn.shopify.com/s/files/1/1832/6341/products/PLST_CU0071_GOLD_1000x.jpg?v=1571325883','Place an order with vendor of 24 packets by next Saturday.');
INSERT INTO products ([product_name],[product_price],[product_image_url],[product_comment]) VALUES ('Confetti Squares',3.99,'https://cdn.shopify.com/s/files/1/1832/6341/products/BOTT_GLIT_002_GOLD__02_1000x.jpg?v=1571327289','On back order.');

--
-- Table structure for table `stores`
--

DROP TABLE IF EXISTS [stores];
CREATE TABLE stores (
  [id] INT PRIMARY KEY IDENTITY (1, 1),
  [store_name] varchar(255) NOT NULL,
  [store_city] varchar(255) NOT NULL,
  [store_state] varchar(255) NOT NULL,
)   ;

--
-- Dumping data for table `stores`
--

INSERT INTO stores ([store_name],[store_city],[store_state]) VALUES ('Party Xtravaganza','Durham','NC');
INSERT INTO stores ([store_name],[store_city],[store_state]) VALUES ('Party Xperience','San Jose','CA');
INSERT INTO stores ([store_name],[store_city],[store_state]) VALUES ('Party with Us','New York','NY');
INSERT INTO stores ([store_name],[store_city],[store_state]) VALUES ('IneXpensive Party','Northboro','Iowa');

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS [inventory];
CREATE TABLE inventory (
  [id] INT PRIMARY KEY IDENTITY (1, 1),
  [product_id] int NOT NULL,
  [store_id] int NOT NULL,
  [quantity] int DEFAULT '0',
  [local_price] decimal(5,2) NOT NULL,
  [comment] varchar(max)
 ,
  CONSTRAINT [inventory_ibfk_1] FOREIGN KEY ([product_id]) REFERENCES products ([id]) ON UPDATE CASCADE,
  CONSTRAINT [inventory_ibfk_2] FOREIGN KEY ([store_id]) REFERENCES stores ([id]) ON UPDATE CASCADE
)   ;

CREATE INDEX [product_id] ON inventory ([product_id]);
CREATE INDEX [store_id] ON inventory ([store_id]);


--
-- Dumping data for table `inventory`
--

INSERT INTO inventory ([product_id],[store_id],[quantity],[local_price],[comment]) VALUES (2,1,30,4.05,'These chair cover sell a lot in beige and dont sell enough in other colors. ');
INSERT INTO inventory ([product_id],[store_id],[quantity],[local_price],[comment]) VALUES (3,1,100,29.99,'');
INSERT INTO inventory ([product_id],[store_id],[quantity],[local_price],[comment]) VALUES (5,1,10,6.99,'The best napkins, believe me. ');
INSERT INTO inventory ([product_id],[store_id],[quantity],[local_price],[comment]) VALUES (7,1,56,17.99,'');
INSERT INTO inventory ([product_id],[store_id],[quantity],[local_price],[comment]) VALUES (8,1,100,29.99,'If not sold within first 24 hrs. Advertise as 50% off.');
INSERT INTO inventory ([product_id],[store_id],[quantity],[local_price],[comment]) VALUES (9,1,98,7.99,'Clear Plastic.');
INSERT INTO inventory ([product_id],[store_id],[quantity],[local_price],[comment]) VALUES (1,2,47,2.99,'The biggest ballons');
INSERT INTO inventory ([product_id],[store_id],[quantity],[local_price],[comment]) VALUES (2,2,16,3.66,'Stretchy kind.');
INSERT INTO inventory ([product_id],[store_id],[quantity],[local_price],[comment]) VALUES (3,2,60,25.95,'These table cloths are not popular in this store.');
INSERT INTO inventory ([product_id],[store_id],[quantity],[local_price],[comment]) VALUES (4,2,1,15.99,'Good quality materials. popular product. Re-order.');
INSERT INTO inventory ([product_id],[store_id],[quantity],[local_price],[comment]) VALUES (5,2,100,5.99,'');
INSERT INTO inventory ([product_id],[store_id],[quantity],[local_price],[comment]) VALUES (6,2,23,3.99,'');
INSERT INTO inventory ([product_id],[store_id],[quantity],[local_price],[comment]) VALUES (7,2,0,18.99,'Sold out');
INSERT INTO inventory ([product_id],[store_id],[quantity],[local_price],[comment]) VALUES (8,2,2,29.99,'If not sold within first 24 hrs. Advertise as 50% off.');
INSERT INTO inventory ([product_id],[store_id],[quantity],[local_price],[comment]) VALUES (9,2,100,7.99,'');
INSERT INTO inventory ([product_id],[store_id],[quantity],[local_price],[comment]) VALUES (1,3,100,3.99,'');
INSERT INTO inventory ([product_id],[store_id],[quantity],[local_price],[comment]) VALUES (2,3,100,4.99,'');
INSERT INTO inventory ([product_id],[store_id],[quantity],[local_price],[comment]) VALUES (3,3,100,20.00,'On sale, discontinuing product.');
INSERT INTO inventory ([product_id],[store_id],[quantity],[local_price],[comment]) VALUES (4,3,3,15.95,'Popular item.');
INSERT INTO inventory ([product_id],[store_id],[quantity],[local_price],[comment]) VALUES (5,3,64,4.99,'Order only light beige color next time.');
INSERT INTO inventory ([product_id],[store_id],[quantity],[local_price],[comment]) VALUES (6,3,0,5.99,'Sold out. ');
INSERT INTO inventory ([product_id],[store_id],[quantity],[local_price],[comment]) VALUES (7,3,100,0.00,'');
INSERT INTO inventory ([product_id],[store_id],[quantity],[local_price],[comment]) VALUES (8,3,3,25.99,'If not sold within first 24 hrs. Advertize as 50% off.');
INSERT INTO inventory ([product_id],[store_id],[quantity],[local_price],[comment]) VALUES (9,3,87,5.99,'Clear Plastic');

