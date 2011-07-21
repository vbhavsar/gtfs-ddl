create table agency(
	id Integer AUTO_INCREMENT Primary Key,
	agency_id VARCHAR(250),
	agency_name VARCHAR(250) NULL,
	agency_url VARCHAR(250) NULL,
	agency_timezone VARCHAR(250) NULL,
	agency_lang VARCHAR(250),
	agency_phone VARCHAR(250),
	agency_fare_url VARCHAR(250));
create table calendar(
	service_id VARCHAR(250) Primary Key,
	monday Boolean NULL,
	tuesday Boolean NULL,
	wednesday Boolean NULL,
	thursday Boolean NULL,
	friday Boolean NULL,
	saturday Boolean NULL,
	sunday Boolean NULL,
	start_date Date NULL,
	end_date Date NULL);
create table calendar_dates(
	service_id VARCHAR(250),
	date Date,
	exception_type Integer NULL,
	Primary Key (service_id, date));
create table universal_calendar(
	service_id VARCHAR(250),
	date Date,
	Primary Key (service_id, date));
create table fare_attribute(
	fare_id VARCHAR(250) Primary Key,
	price Numeric(10,2) NULL,
	currency_type VARCHAR(250) NULL,
	payment_method Integer NULL,
	transfers Integer,
	transfer_duration Integer);
create table fare_rule(
	id Integer AUTO_INCREMENT Primary Key,
	fare_id VARCHAR(250) NULL,
	route_id VARCHAR(250),
	origin_id VARCHAR(250),
	destination_id VARCHAR(250),
	contains_id VARCHAR(250),
	service_id VARCHAR(250),
	Foreign Key (fare_id) references FareAttribute(fare_id) );
create table route_type(
	route_type Integer Primary Key,
	route_type_name VARCHAR(250),
	route_type_desc VARCHAR(250));
create table routes(
	route_id VARCHAR(250) Primary Key,
	agency_id VARCHAR(250),
	route_short_name VARCHAR(250),
	route_long_name VARCHAR(250),
	route_desc VARCHAR(250),
	route_type Integer,
	route_url VARCHAR(250),
	route_color VARCHAR(6),
	route_text_color VARCHAR(6));
create table pattern(
	shape_id VARCHAR(250) Primary Key,
	pattern_dist Numeric(20,10));
create table shapes(
	shape_id VARCHAR(250),
	shape_pt_lat Numeric(12,9),
	shape_pt_lon Numeric(12,9),
	shape_pt_sequence Integer,
	shape_dist_traveled Numeric(20,10),
	Primary Key (shape_id, shape_pt_sequence));
create table stops(
	stop_id VARCHAR(250) Primary Key,
	stop_code VARCHAR(250),
	stop_name VARCHAR(250) NULL,
	stop_desc VARCHAR(250),
	stop_lat Numeric(12,9) NULL,
	stop_lon Numeric(12,9) NULL,
	zone_id VARCHAR(250),
	stop_url VARCHAR(250),
	location_type Integer default 0,
	parent_station VARCHAR(250));
create table stop_times(
	trip_id VARCHAR(250),
	arrival_time VARCHAR(250),
	departure_time VARCHAR(250),
	stop_id VARCHAR(250) NULL,
	stop_sequence Integer,
	stop_headsign VARCHAR(250),
	pickup_type Integer default 0,
	drop_off_type Integer default 0,
	shape_dist_traveled Numeric(20,10),
	timepoint Boolean default False,
	Primary Key (trip_id, stop_sequence),
	Foreign Key (timepoint) references Trip(trip_id));
create table transfers(
	id Integer AUTO_INCREMENT Primary Key,
	from_stop_id VARCHAR(250),
	to_stop_id VARCHAR(250),
	transfer_type Integer default 0,
	min_transfer_time Integer);
create table trips(
	route_id VARCHAR(250) NULL,
	service_id VARCHAR(250) NULL,
	trip_id VARCHAR(250) Primary Key,
	trip_headsign VARCHAR(250),
	trip_short_name VARCHAR(250),
	direction_id Integer,
	block_id VARCHAR(250),
	shape_id VARCHAR(250) NULL,
	trip_type VARCHAR(250),
	trip_bikes_allowed Integer,
	Foreign Key (route_id) references Route(route_id),
	Foreign Key (shape_id) references Pattern(shape_id)
	);
create table frequency(
	trip_id VARCHAR(250),
	start_time VARCHAR(250),
	end_time VARCHAR(250),
	headway_secs Integer,
	exact_times Integer,
	Primary key (trip_id, start_time),
	Foreign Key (trip_id) references Trip(trip_id)
);
