CREATE DATABASE loja_de_instrumentos;
USE loja_de_instrumentos;

CREATE TABLE pedidos(
	id INT NOT NULL AUTO_INCREMENT,
    item VARCHAR(50) NOT NULL,
	modelo VARCHAR(10) NOT NULL,
    nome VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    PRIMARY KEY(id)
);

INSERT INTO pedidos (item, modelo, nome, email, preco)
VALUES ('Violão Yamaha', 'ABCDE-10', 'Julio Santos', 'juliodiaz_santos@hotmail.com', 10900);

INSERT INTO pedidos (item, modelo, nome, email, preco)
VALUES ('Piano Yamaha', 'YZKXW-72', 'Bruna Gomez', 'bruna_gomez@hotmail.com', 30300);

INSERT INTO pedidos (item, modelo, nome, email, preco)
VALUES ('Guitarra Yamaha', 'FJKEL-93', 'Antonio Bandeira', 'antonio_bandeira@hotmail.com', 60500);

INSERT INTO pedidos (item, modelo, nome, email, preco)
VALUES ('Bateria Yamaha', 'EDCBA-07', 'Gabriela Alvez', 'gabriela_alvez@hotmail.com', 20100);

SELECT * FROM `pedidos`;
