CREATE database tugassql;

-- NO 1

CREATE TABLE product (
	id int,
  product_name varchar(255) not null,
  price int not null,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP , 
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  );

CREATE TABLE user (
	id int not null,
  username varchar(255) not null,
  password varchar(255) not null,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP , 
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE transaction_product (
	transaction_id int not null,
  product_id int not null,
  quantity int not null
);

CREATE TABLE transaction (
	id int not null,
  user_id int,
  total_price int not null,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP , 
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- NO 2

ALTER TABLE product
ADD primary key(id),
MODIFY column id int auto_increment;

ALTER TABLE transaction
ADD primary key(id),
MODIFY column id int auto_increment;

ALTER TABLE user
ADD primary key(id),
MODIFY column id int auto_increment;

ALTER TABLE transaction
ADD foreign key (user_id) references user(id);

ALTER TABLE transaction_product
ADD foreign key (transaction_id) references transaction(id);

ALTER TABLE transaction_product
ADD foreign key (product_id) references product(id);


-- NO 3A

INSERT INTO user (username, password) VALUES
("andi", "andi123"),
("budi", "budi_ganteng999");


-- NO 3B

INSERT INTO product (product_name, price) VALUES
("baju", 67000),
("celana", 86000),
("buku", 24000),
("sepatu", 128000),
("sepeda", 1500000),
("bola", 17000),
("komputer", 8956000),
("gelas", 96400);


-- NO 3C

INSERT INTO transaction (user_id, total_price) VALUES
(1, 67000*2),
(1, 86000*3),
(2, 8956000*1),
(2, 1500000*1),
(2, 86000*4),
(2, 24000*4),
(1, 96400*2),
(1, 128000*2);

-- NO 3D

INSERT INTO transaction_product (transaction_id, product_id, quantity) VALUES
(1, 1, 2),
(2, 2, 3),
(3, 7, 1),
(4, 4, 1),
(5, 2, 4),
(6, 3, 4),
(7, 8, 2),
(8, 4, 2);

-- NO 3E

UPDATE transaction_product SET quantity = 1 
where transaction_product.transaction_id in (select id from transaction 
where user_id in (select id from user where username = 'andi')) and
transaction_product.product_id in (select id from product where product_name = 'gelas');

-- NO 3F

DELETE FROM product WHERE price = ( SELECT MIN(price) FROM product);

-- NO 4

SELECT * FROM product WHERE price > 50000 ORDER BY price ASC LIMIT 2, 3;

-- NO 5

-- NO 6

SELECT product.product_name, transaction_product.quantity 
FROM product JOIN transaction_product
ON product.product_id = transaction_product.product_id
ORDER BY transaction_product.quantity DESC;

