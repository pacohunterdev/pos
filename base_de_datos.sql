create database pos;
	use pos;

	create table categorias(
		id bigint unsigned primary key auto_increment, 
		nombreCategoria varchar(50) not null
	);

	create table marcas(
		id bigint unsigned primary key auto_increment, 
		nombreMarca varchar(50) not null
	);

	create table productos(
		id bigint unsigned primary key auto_increment,
		codigo varchar(50) not null,
		nombre varchar(255) not null,
		precioCompra decimal(8,2) not null,
		precioVenta decimal(8,2) not null,
		existencia int not null,
		vendidoMayoreo boolean, 
		precioMayoreo decimal(8,2), 
		cantidadMayoreo decimal(8,2),
		marca bigint unsigned,
		categoria bigint unsigned
	);

	create table clientes(
		id bigint unsigned primary key auto_increment,
		nombre varchar(100) not null,
		telefono varchar(20)
	);

	create table usuarios(
		id bigint unsigned primary key auto_increment,
		usuario varchar(50) not null,
		nombre varchar(100) not null,
		telefono varchar(20) not null,
		password varchar(255) not null
	);

	create table ventas(
		id bigint unsigned primary key auto_increment,
		fecha datetime not null,
		total decimal(9,2) not null,
		pagado decimal(9,2) not null,
		idCliente bigint,
		idUsuario bigint not null
	);	

	create table cuentas_apartados(
		id bigint unsigned primary key auto_increment,
		fecha datetime not null,
		total decimal(9,2) not null,
		pagado decimal(9,2) not null,
		porPagar decimal(9,2) not null,
		tipo enum('apartado', 'cuenta') not null,
		idCliente bigint,
		idUsuario bigint not null
	);	



	create table productos_vendidos(
		id bigint unsigned primary key auto_increment,
		cantidad decimal(5,2) not null,
		precio decimal(8,2) not null,
		idProducto bigint not null,
		idReferencia bigint not null,
		tipo enum('apartado', 'cuenta', 'venta') not null
	);

	alter table productos_vendidos modify tipo enum('apartado','cuenta', 'venta', 'cotiza');

	create table cotizaciones(
		id bigint unsigned primary key auto_increment,
		fecha datetime not null,
		total decimal(9,2) not null,
		idCliente bigint,
		idUsuario bigint not null
	);


	create table configuracion(
		nombre varchar(255),
		telefono varchar(20),
		logo varchar(255)
	);