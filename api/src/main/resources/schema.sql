-- CREATE ROLE IF NOT EXISTS iot_fiware_admin;
-- CREATE SCHEMA IF NOT EXISTS iot_fiware_admin AUTHORIZATION iot_fiware_admin;
-- SET SCHEMA iot_fiware_admin;


DROP TABLE IF EXISTS tenant;
CREATE TABLE tenant(
	id integer NOT NULL GENERATED ALWAYS AS IDENTITY ,
	name varchar NOT NULL,
	short_name varchar NOT NULL,
	fiware_instance_id integer NOT NULL,
	contact varchar NOT NULL,
	contact_email varchar NOT NULL,
	parent_id integer,
	geo_longitude float NOT NULL,
	geo_latitude float NOT NULL,
	geo_zoom integer NOT NULL,
	create_user varchar DEFAULT 'admin',
	create_time timestamp DEFAULT CURRENT_TIMESTAMP,
	mod_user varchar,
	mod_time timestamp,
	CONSTRAINT tenant_pk PRIMARY KEY (id),
	CONSTRAINT tenant_name_uq UNIQUE (name),
	CONSTRAINT tenant_short_name_uq UNIQUE (short_name)

);
-- ddl-end --
-- ALTER TABLE tenant OWNER TO iot_fiware_admin;
-- ddl-end --

-- object: static_entity | type: TABLE --
DROP TABLE IF EXISTS static_entity;
CREATE TABLE static_entity(
	id integer NOT NULL GENERATED ALWAYS AS IDENTITY ,
	tenant_id integer NOT NULL,
	name varchar NOT NULL,
	short_name varchar NOT NULL,
	geo_longitude float NOT NULL,
	geo_latitude float NOT NULL,
	geo_zoom integer NOT NULL,
	address_id integer,
	entity_type_id integer NOT NULL,
	parent_id integer,
	create_user varchar DEFAULT 'admin',
	create_time timestamp DEFAULT CURRENT_TIMESTAMP,
	mod_user varchar,
	mod_time timestamp,
	CONSTRAINT static_entity_pk PRIMARY KEY (id)

);
-- ddl-end --
-- ALTER TABLE static_entity OWNER TO iot_fiware_admin;
-- ddl-end --

-- object: entity_type | type: TABLE --
DROP TABLE IF EXISTS entity_type;
CREATE TABLE entity_type(
	id integer NOT NULL GENERATED ALWAYS AS IDENTITY ,
	name varchar NOT NULL,
	create_user varchar DEFAULT 'admin',
	create_time timestamp DEFAULT CURRENT_TIMESTAMP,
	mod_user varchar,
	mod_time timestamp,
	CONSTRAINT entity_type_pk PRIMARY KEY (id),
	CONSTRAINT entity_type_name_uq UNIQUE (name)

);
-- ddl-end --
-- ALTER TABLE entity_type OWNER TO iot_fiware_admin;
-- ddl-end --

-- object: country | type: TABLE --
DROP TABLE IF EXISTS country;
CREATE TABLE country(
	id integer NOT NULL GENERATED ALWAYS AS IDENTITY ,
	name varchar NOT NULL,
	create_user varchar DEFAULT 'admin',
	create_time timestamp DEFAULT CURRENT_TIMESTAMP,
	mod_user varchar,
	mod_time timestamp,
	CONSTRAINT country_pk PRIMARY KEY (id),
	CONSTRAINT country_name_uq UNIQUE (name)

);
-- ddl-end --
-- ALTER TABLE country OWNER TO iot_fiware_admin;
-- ddl-end --

-- object: region | type: TABLE --
DROP TABLE IF EXISTS region;
CREATE TABLE region(
	id integer NOT NULL GENERATED ALWAYS AS IDENTITY ,
	name varchar NOT NULL,
	country_id integer NOT NULL,
	create_user varchar DEFAULT 'admin',
	create_time timestamp DEFAULT CURRENT_TIMESTAMP,
	mod_user varchar,
	mod_time timestamp,
	CONSTRAINT region_pk PRIMARY KEY (id)

);
-- ddl-end --
-- ALTER TABLE region OWNER TO iot_fiware_admin;
-- ddl-end --

-- object: postal_address | type: TABLE --
DROP TABLE IF EXISTS postal_address;
CREATE TABLE postal_address(
	id integer NOT NULL GENERATED ALWAYS AS IDENTITY ,
	tenant_id integer NOT NULL,
	postal_code varchar NOT NULL,
	street_address varchar NOT NULL,
	locality_id integer NOT NULL,
	create_user varchar DEFAULT 'admin',
	create_time timestamp DEFAULT CURRENT_TIMESTAMP,
	mod_user varchar,
	mod_time timestamp,
	CONSTRAINT postal_address_pk PRIMARY KEY (id)

);
-- ddl-end --
-- ALTER TABLE postal_address OWNER TO iot_fiware_admin;
-- ddl-end --

-- object: locality | type: TABLE --
DROP TABLE IF EXISTS locality;
CREATE TABLE locality(
	id integer NOT NULL GENERATED ALWAYS AS IDENTITY ,
	name varchar NOT NULL,
	region_id integer NOT NULL,
	create_user varchar DEFAULT 'admin',
	create_time timestamp DEFAULT CURRENT_TIMESTAMP,
	mod_user varchar,
	mod_time timestamp,
	CONSTRAINT locality_pk PRIMARY KEY (id)

);
-- ddl-end --
-- ALTER TABLE locality OWNER TO iot_fiware_admin;
-- ddl-end --

-- object: device_group | type: TABLE --
DROP TABLE IF EXISTS device_group;
CREATE TABLE device_group(
	id integer NOT NULL GENERATED ALWAYS AS IDENTITY ,
	name varchar NOT NULL,
	short_name varchar NOT NULL,
	tenant_id integer NOT NULL,
	agent_id integer NOT NULL,
	apikey varchar NOT NULL,
	create_user varchar DEFAULT 'admin',
	create_time timestamp DEFAULT CURRENT_TIMESTAMP,
	mod_user varchar,
	mod_time timestamp,
	CONSTRAINT device_group_pk PRIMARY KEY (id),
	CONSTRAINT device_group_apikey_uq UNIQUE (apikey),
	CONSTRAINT device_group_short_name_uq UNIQUE (short_name)

);
-- ddl-end --
-- ALTER TABLE device_group OWNER TO iot_fiware_admin;
-- ddl-end --

-- object: agent | type: TABLE --
DROP TABLE IF EXISTS agent;
CREATE TABLE agent(
	id integer NOT NULL GENERATED ALWAYS AS IDENTITY ,
	name varchar NOT NULL,
	protocol varchar NOT NULL,
	transport varchar NOT NULL,
	create_user varchar DEFAULT 'admin',
	create_time timestamp DEFAULT CURRENT_TIMESTAMP,
	mod_user varchar,
	mod_time timestamp,
	CONSTRAINT agent_pk PRIMARY KEY (id),
	CONSTRAINT agent_name_uq UNIQUE (name)

);
-- ddl-end --
-- ALTER TABLE agent OWNER TO iot_fiware_admin;
-- ddl-end --

-- object: device_type | type: TABLE --
DROP TABLE IF EXISTS device_type;
CREATE TABLE device_type(
	id integer NOT NULL GENERATED ALWAYS AS IDENTITY ,
	manufacturer varchar NOT NULL,
	model varchar NOT NULL,
	revision varchar,
	doc_url varchar,
	create_user varchar DEFAULT 'admin',
	create_time timestamp DEFAULT CURRENT_TIMESTAMP,
	mod_user varchar,
	mod_time timestamp,
	CONSTRAINT device_type_pk PRIMARY KEY (id)

);
-- ddl-end --
-- ALTER TABLE device_type OWNER TO iot_fiware_admin;
-- ddl-end --

-- object: device | type: TABLE --
DROP TABLE IF EXISTS device;
CREATE TABLE device(
	id integer NOT NULL GENERATED ALWAYS AS IDENTITY ,
	device_type_id integer NOT NULL,
	tenant_id integer NOT NULL,
	name varchar NOT NULL,
	device_group_id integer NOT NULL,
	location_ref integer NOT NULL,
	serial_number varchar,
	asset_number varchar,
	endpoint varchar,
	geo_longitude float,
	geo_latitude float,
	geo_zoom integer,
	create_user varchar DEFAULT 'admin',
	create_time timestamp DEFAULT CURRENT_TIMESTAMP,
	mod_user varchar,
	mod_time timestamp,
	CONSTRAINT device_pk PRIMARY KEY (id)

);
-- ddl-end --
-- ALTER TABLE device OWNER TO iot_fiware_admin;
-- ddl-end --

-- object: app_user | type: TABLE --
DROP TABLE IF EXISTS app_user;
CREATE TABLE app_user(
	id integer NOT NULL GENERATED ALWAYS AS IDENTITY ,
	network_id varchar NOT NULL,
	full_name varchar,
	email varchar,
	tenant_id integer,
	is_root boolean NOT NULL,
	create_user varchar DEFAULT 'admin',
	create_time timestamp DEFAULT CURRENT_TIMESTAMP,
	mod_user varchar,
	mod_time timestamp,
	CONSTRAINT app_user_pk PRIMARY KEY (id),
	CONSTRAINT app_user_network_id_uq UNIQUE (network_id)

);
-- ddl-end --
-- ALTER TABLE app_user OWNER TO iot_fiware_admin;
-- ddl-end --

-- object: measurement_type | type: TABLE --
DROP TABLE IF EXISTS measurement_type;
CREATE TABLE measurement_type(
	id integer NOT NULL GENERATED ALWAYS AS IDENTITY ,
	name varchar NOT NULL,
	ngsi_key varchar NOT NULL,
	ul_object_id varchar NOT NULL,
	display_precision integer,
	create_user varchar DEFAULT 'admin',
	create_time timestamp DEFAULT CURRENT_TIMESTAMP,
	mod_user varchar,
	mod_time timestamp,
	CONSTRAINT measurement_type_pk PRIMARY KEY (id),
	CONSTRAINT measurement_type_name_uq UNIQUE (name)

);
-- ddl-end --
-- ALTER TABLE measurement_type OWNER TO iot_fiware_admin;
-- ddl-end --

-- object: unit | type: TABLE --
DROP TABLE IF EXISTS unit;
CREATE TABLE unit(
	id integer NOT NULL GENERATED ALWAYS AS IDENTITY ,
	measurement_type_id integer NOT NULL,
	name varchar NOT NULL,
	create_user varchar DEFAULT 'admin',
	create_time timestamp DEFAULT CURRENT_TIMESTAMP,
	mod_user varchar,
	mod_time timestamp,
	CONSTRAINT unit_pk PRIMARY KEY (id),
	CONSTRAINT unit_name_uq UNIQUE (name)

);
-- ddl-end --
-- ALTER TABLE unit OWNER TO iot_fiware_admin;
-- ddl-end --

-- object: fiware_instance | type: TABLE --
DROP TABLE IF EXISTS fiware_instance;
CREATE TABLE fiware_instance(
	id integer NOT NULL GENERATED ALWAYS AS IDENTITY ,
	name varchar NOT NULL,
	is_test boolean NOT NULL,
	is_ready boolean NOT NULL,
	context_broker_url varchar NOT NULL,
	agent_ul_url varchar,
	agent_mqtt_url varchar,
	agent_lora_url varchar,
	agent_lwm2m_url varchar,
	create_user varchar DEFAULT 'admin',
	create_time timestamp DEFAULT CURRENT_TIMESTAMP,
	mod_user varchar,
	mod_time timestamp,
	CONSTRAINT fiware_instance_pk PRIMARY KEY (id),
	CONSTRAINT fiware_instance_name_uq UNIQUE (name)

);
-- ddl-end --
-- ALTER TABLE fiware_instance OWNER TO iot_fiware_admin;
-- ddl-end --

-- object: sensor_continuous_type | type: TABLE --
DROP TABLE IF EXISTS sensor_continuous_type;
CREATE TABLE sensor_continuous_type(
	id integer NOT NULL GENERATED ALWAYS AS IDENTITY ,
	measurement_type_id integer NOT NULL,
	unit_id integer NOT NULL,
	name varchar NOT NULL,
	doc_url varchar,
	min_value float,
	max_value float,
	create_user varchar DEFAULT 'admin',
	create_time timestamp DEFAULT CURRENT_TIMESTAMP,
	mod_user varchar,
	mod_time timestamp,
	CONSTRAINT sensor_continuous_type_name_uq UNIQUE (name),
	CONSTRAINT sensor_continuous_type_pk PRIMARY KEY (id)

);
-- ddl-end --
-- ALTER TABLE sensor_continuous_type OWNER TO iot_fiware_admin;
-- ddl-end --

-- object: sensor_continuous | type: TABLE --
DROP TABLE IF EXISTS sensor_continuous;
CREATE TABLE sensor_continuous(
	id integer NOT NULL GENERATED ALWAYS AS IDENTITY ,
	device_id integer NOT NULL,
	sensor_continuous_type_id integer NOT NULL,
	name varchar NOT NULL,
	short_name varchar NOT NULL,
	min_value_expected float,
	max_value_expected float,
	min_value_warn float,
	max_value_warn float,
	normal_value float,
	create_user varchar DEFAULT 'admin',
	create_time timestamp DEFAULT CURRENT_TIMESTAMP,
	mod_user varchar,
	mod_time timestamp,
	CONSTRAINT sensor_continuous_pk PRIMARY KEY (id)

);
-- ddl-end --
-- ALTER TABLE sensor_continuous OWNER TO iot_fiware_admin;
-- ddl-end --

-- object: sensor_counter_type | type: TABLE --
DROP TABLE IF EXISTS sensor_counter_type;
CREATE TABLE sensor_counter_type(
	id integer NOT NULL GENERATED ALWAYS AS IDENTITY ,
	measurement_type_id integer NOT NULL,
	name varchar NOT NULL,
	doc_url varchar,
	create_user varchar DEFAULT 'admin',
	create_time timestamp DEFAULT CURRENT_TIMESTAMP,
	mod_user varchar,
	mod_time timestamp,
	CONSTRAINT sensor_counter_type_name_uq UNIQUE (name),
	CONSTRAINT sensor_counter_type_pk PRIMARY KEY (id)

);
-- ddl-end --
-- ALTER TABLE sensor_counter_type OWNER TO iot_fiware_admin;
-- ddl-end --

-- object: sensor_boolean_type | type: TABLE --
DROP TABLE IF EXISTS sensor_boolean_type;
CREATE TABLE sensor_boolean_type(
	id integer NOT NULL GENERATED ALWAYS AS IDENTITY ,
	measurement_type_id integer NOT NULL,
	name varchar NOT NULL,
	doc_url varchar,
	true_value_name varchar,
	false_value_name varchar,
	create_user varchar DEFAULT 'admin',
	create_time timestamp DEFAULT CURRENT_TIMESTAMP,
	mod_user varchar,
	mod_time timestamp,
	CONSTRAINT sensor_boolean_type_name_uq UNIQUE (name),
	CONSTRAINT sensor_boolean_type_pk PRIMARY KEY (id)

);
-- ddl-end --
-- ALTER TABLE sensor_boolean_type OWNER TO iot_fiware_admin;
-- ddl-end --

-- object: sensor_text_type | type: TABLE --
DROP TABLE IF EXISTS sensor_text_type;
CREATE TABLE sensor_text_type(
	id integer NOT NULL GENERATED ALWAYS AS IDENTITY ,
	measurement_type_id integer NOT NULL,
	name varchar NOT NULL,
	doc_url varchar,
	create_user varchar DEFAULT 'admin',
	create_time timestamp DEFAULT CURRENT_TIMESTAMP,
	mod_user varchar,
	mod_time timestamp,
	CONSTRAINT sensor_text_type_name_uq UNIQUE (name),
	CONSTRAINT sensor_text_type_pk PRIMARY KEY (id)

);
-- ddl-end --
-- ALTER TABLE sensor_text_type OWNER TO iot_fiware_admin;
-- ddl-end --

-- object: sensor_boolean | type: TABLE --
DROP TABLE IF EXISTS sensor_boolean;
CREATE TABLE sensor_boolean(
	id integer NOT NULL GENERATED ALWAYS AS IDENTITY ,
	device_id integer NOT NULL,
	sensor_boolean_type_id integer NOT NULL,
	name varchar NOT NULL,
	short_name varchar NOT NULL,
	create_user varchar DEFAULT 'admin',
	create_time timestamp DEFAULT CURRENT_TIMESTAMP,
	mod_user varchar,
	mod_time timestamp,
	CONSTRAINT sensor_boolean_pk PRIMARY KEY (id)

);
-- ddl-end --
-- ALTER TABLE sensor_boolean OWNER TO iot_fiware_admin;
-- ddl-end --

-- object: sensor_counter | type: TABLE --
DROP TABLE IF EXISTS sensor_counter;
CREATE TABLE sensor_counter(
	id integer NOT NULL GENERATED ALWAYS AS IDENTITY ,
	device_id integer NOT NULL,
	sensor_counter_type_id integer NOT NULL,
	name varchar NOT NULL,
	short_name varchar NOT NULL,
	create_user varchar DEFAULT 'admin',
	create_time timestamp DEFAULT CURRENT_TIMESTAMP,
	mod_user varchar,
	mod_time timestamp,
	CONSTRAINT sensor_counter_pk PRIMARY KEY (id)

);
-- ddl-end --
-- ALTER TABLE sensor_counter OWNER TO iot_fiware_admin;
-- ddl-end --

-- object: sensor_text | type: TABLE --
DROP TABLE IF EXISTS sensor_text;
CREATE TABLE sensor_text(
	id integer NOT NULL GENERATED ALWAYS AS IDENTITY ,
	device_id integer NOT NULL,
	sensor_text_type_id integer NOT NULL,
	name varchar NOT NULL,
	short_name varchar NOT NULL,
	create_user varchar DEFAULT 'admin',
	create_time timestamp DEFAULT CURRENT_TIMESTAMP,
	mod_user varchar,
	mod_time timestamp,
	CONSTRAINT sensor_text_pk PRIMARY KEY (id)

);
-- ddl-end --
-- ALTER TABLE sensor_text OWNER TO iot_fiware_admin;
-- ddl-end --

-- object: many_device_type_has_many_sensor_continuous_type | type: TABLE --
DROP TABLE IF EXISTS many_device_type_has_many_sensor_continuous_type;
CREATE TABLE many_device_type_has_many_sensor_continuous_type(
	id_device_type integer NOT NULL,
	id_sensor_continuous_type integer NOT NULL,
	CONSTRAINT many_device_type_has_many_sensor_continuous_type_pk PRIMARY KEY (id_device_type,id_sensor_continuous_type)

);
-- ddl-end --

-- object: device_type_fk | type: CONSTRAINT --
-- ALTER TABLE many_device_type_has_many_sensor_continuous_type DROP CONSTRAINT IF EXISTS device_type_fk;
ALTER TABLE many_device_type_has_many_sensor_continuous_type ADD CONSTRAINT device_type_fk FOREIGN KEY (id_device_type)
REFERENCES device_type (id);
-- ddl-end --

-- object: sensor_continuous_type_fk | type: CONSTRAINT --
-- ALTER TABLE many_device_type_has_many_sensor_continuous_type DROP CONSTRAINT IF EXISTS sensor_continuous_type_fk;
ALTER TABLE many_device_type_has_many_sensor_continuous_type ADD CONSTRAINT sensor_continuous_type_fk FOREIGN KEY (id_sensor_continuous_type)
REFERENCES sensor_continuous_type (id);
-- ddl-end --

-- object: many_device_type_has_many_sensor_boolean_type | type: TABLE --
DROP TABLE IF EXISTS many_device_type_has_many_sensor_boolean_type;
CREATE TABLE many_device_type_has_many_sensor_boolean_type(
	id_device_type integer NOT NULL,
	id_sensor_boolean_type integer NOT NULL,
	CONSTRAINT many_device_type_has_many_sensor_boolean_type_pk PRIMARY KEY (id_device_type,id_sensor_boolean_type)

);
-- ddl-end --

-- object: device_type_fk | type: CONSTRAINT --
ALTER TABLE many_device_type_has_many_sensor_boolean_type DROP CONSTRAINT IF EXISTS device_type_fk;
ALTER TABLE many_device_type_has_many_sensor_boolean_type ADD CONSTRAINT device_type_fk FOREIGN KEY (id_device_type)
REFERENCES device_type (id);
-- ddl-end --

-- object: sensor_boolean_type_fk | type: CONSTRAINT --
ALTER TABLE many_device_type_has_many_sensor_boolean_type DROP CONSTRAINT IF EXISTS sensor_boolean_type_fk;
ALTER TABLE many_device_type_has_many_sensor_boolean_type ADD CONSTRAINT sensor_boolean_type_fk FOREIGN KEY (id_sensor_boolean_type)
REFERENCES sensor_boolean_type (id);
-- ddl-end --

-- object: many_device_type_has_many_sensor_counter_type | type: TABLE --
DROP TABLE IF EXISTS many_device_type_has_many_sensor_counter_type;
CREATE TABLE many_device_type_has_many_sensor_counter_type(
	id_device_type integer NOT NULL,
	id_sensor_counter_type integer NOT NULL,
	CONSTRAINT many_device_type_has_many_sensor_counter_type_pk PRIMARY KEY (id_device_type,id_sensor_counter_type)

);
-- ddl-end --

-- object: device_type_fk | type: CONSTRAINT --
ALTER TABLE many_device_type_has_many_sensor_counter_type DROP CONSTRAINT IF EXISTS device_type_fk;
ALTER TABLE many_device_type_has_many_sensor_counter_type ADD CONSTRAINT device_type_fk FOREIGN KEY (id_device_type)
REFERENCES device_type (id);
-- ddl-end --

-- object: sensor_counter_type_fk | type: CONSTRAINT --
ALTER TABLE many_device_type_has_many_sensor_counter_type DROP CONSTRAINT IF EXISTS sensor_counter_type_fk;
ALTER TABLE many_device_type_has_many_sensor_counter_type ADD CONSTRAINT sensor_counter_type_fk FOREIGN KEY (id_sensor_counter_type)
REFERENCES sensor_counter_type (id);
-- ddl-end --

-- object: many_device_type_has_many_sensor_text_type | type: TABLE --
DROP TABLE IF EXISTS many_device_type_has_many_sensor_text_type;
CREATE TABLE many_device_type_has_many_sensor_text_type(
	id_device_type integer NOT NULL,
	id_sensor_text_type integer NOT NULL,
	CONSTRAINT many_device_type_has_many_sensor_text_type_pk PRIMARY KEY (id_device_type,id_sensor_text_type)

);
-- ddl-end --

-- object: device_type_fk | type: CONSTRAINT --
ALTER TABLE many_device_type_has_many_sensor_text_type DROP CONSTRAINT IF EXISTS device_type_fk;
ALTER TABLE many_device_type_has_many_sensor_text_type ADD CONSTRAINT device_type_fk FOREIGN KEY (id_device_type)
REFERENCES device_type (id);
-- ddl-end --

-- object: sensor_text_type_fk | type: CONSTRAINT --
ALTER TABLE many_device_type_has_many_sensor_text_type DROP CONSTRAINT IF EXISTS sensor_text_type_fk;
ALTER TABLE many_device_type_has_many_sensor_text_type ADD CONSTRAINT sensor_text_type_fk FOREIGN KEY (id_sensor_text_type)
REFERENCES sensor_text_type (id);
-- ddl-end --

-- object: tenant_tenant_fk | type: CONSTRAINT --
ALTER TABLE tenant DROP CONSTRAINT IF EXISTS tenant_tenant_fk;
ALTER TABLE tenant ADD CONSTRAINT tenant_tenant_fk FOREIGN KEY (parent_id)
REFERENCES tenant (id);
-- ddl-end --

-- object: tenant_fiware_instace_fk | type: CONSTRAINT --
ALTER TABLE tenant DROP CONSTRAINT IF EXISTS tenant_fiware_instace_fk;
ALTER TABLE tenant ADD CONSTRAINT tenant_fiware_instace_fk FOREIGN KEY (fiware_instance_id)
REFERENCES fiware_instance (id);
-- ddl-end --

-- object: static_entity_tenant_fk | type: CONSTRAINT --
ALTER TABLE static_entity DROP CONSTRAINT IF EXISTS static_entity_tenant_fk;
ALTER TABLE static_entity ADD CONSTRAINT static_entity_tenant_fk FOREIGN KEY (tenant_id)
REFERENCES tenant (id);
-- ddl-end --

-- object: static_entity_entity_type_fk | type: CONSTRAINT --
ALTER TABLE static_entity DROP CONSTRAINT IF EXISTS static_entity_entity_type_fk;
ALTER TABLE static_entity ADD CONSTRAINT static_entity_entity_type_fk FOREIGN KEY (entity_type_id)
REFERENCES entity_type (id);
-- ddl-end --

-- object: static_entity_postal_address_fk | type: CONSTRAINT --
ALTER TABLE static_entity DROP CONSTRAINT IF EXISTS static_entity_postal_address_fk;
ALTER TABLE static_entity ADD CONSTRAINT static_entity_postal_address_fk FOREIGN KEY (address_id)
REFERENCES postal_address (id);
-- ddl-end --

-- object: static_entity_static_entity_fk | type: CONSTRAINT --
ALTER TABLE static_entity DROP CONSTRAINT IF EXISTS static_entity_static_entity_fk;
ALTER TABLE static_entity ADD CONSTRAINT static_entity_static_entity_fk FOREIGN KEY (parent_id)
REFERENCES static_entity (id);
-- ddl-end --

-- object: region_country_fk | type: CONSTRAINT --
ALTER TABLE region DROP CONSTRAINT IF EXISTS region_country_fk;
ALTER TABLE region ADD CONSTRAINT region_country_fk FOREIGN KEY (country_id)
REFERENCES country (id);
-- ddl-end --

-- object: postal_address_locality_fk | type: CONSTRAINT --
ALTER TABLE postal_address DROP CONSTRAINT IF EXISTS postal_address_locality_fk;
ALTER TABLE postal_address ADD CONSTRAINT postal_address_locality_fk FOREIGN KEY (locality_id)
REFERENCES locality (id);
-- ddl-end --

-- object: postal_address_static_entity_fk | type: CONSTRAINT --
ALTER TABLE postal_address DROP CONSTRAINT IF EXISTS postal_address_static_entity_fk;
ALTER TABLE postal_address ADD CONSTRAINT postal_address_static_entity_fk FOREIGN KEY (tenant_id)
REFERENCES tenant (id);
-- ddl-end --

-- object: locality_region_fk | type: CONSTRAINT --
ALTER TABLE locality DROP CONSTRAINT IF EXISTS locality_region_fk;
ALTER TABLE locality ADD CONSTRAINT locality_region_fk FOREIGN KEY (region_id)
REFERENCES region (id);
-- ddl-end --

-- object: device_group_tenant_fk | type: CONSTRAINT --
ALTER TABLE device_group DROP CONSTRAINT IF EXISTS device_group_tenant_fk;
ALTER TABLE device_group ADD CONSTRAINT device_group_tenant_fk FOREIGN KEY (tenant_id)
REFERENCES tenant (id);
-- ddl-end --

-- object: device_group_agent_fk | type: CONSTRAINT --
ALTER TABLE device_group DROP CONSTRAINT IF EXISTS device_group_agent_fk;
ALTER TABLE device_group ADD CONSTRAINT device_group_agent_fk FOREIGN KEY (agent_id)
REFERENCES agent (id);
-- ddl-end --

-- object: device_device_group_fk | type: CONSTRAINT --
ALTER TABLE device DROP CONSTRAINT IF EXISTS device_device_group_fk;
ALTER TABLE device ADD CONSTRAINT device_device_group_fk FOREIGN KEY (device_group_id)
REFERENCES device_group (id);
-- ddl-end --

-- object: device_device_type_fk | type: CONSTRAINT --
ALTER TABLE device DROP CONSTRAINT IF EXISTS device_device_type_fk;
ALTER TABLE device ADD CONSTRAINT device_device_type_fk FOREIGN KEY (device_type_id)
REFERENCES device_type (id);
-- ddl-end --

-- object: device_static_entity_fk | type: CONSTRAINT --
ALTER TABLE device DROP CONSTRAINT IF EXISTS device_static_entity_fk;
ALTER TABLE device ADD CONSTRAINT device_static_entity_fk FOREIGN KEY (location_ref)
REFERENCES static_entity (id);
-- ddl-end --

-- object: device_tenant_fk | type: CONSTRAINT --
ALTER TABLE device DROP CONSTRAINT IF EXISTS device_tenant_fk;
ALTER TABLE device ADD CONSTRAINT device_tenant_fk FOREIGN KEY (tenant_id)
REFERENCES tenant (id);
-- ddl-end --

-- object: app_user_tenant_fk | type: CONSTRAINT --
ALTER TABLE app_user DROP CONSTRAINT IF EXISTS app_user_tenant_fk;
ALTER TABLE app_user ADD CONSTRAINT app_user_tenant_fk FOREIGN KEY (tenant_id)
REFERENCES tenant (id);
-- ddl-end --

-- object: unit_measurement_type_fk | type: CONSTRAINT --
ALTER TABLE unit DROP CONSTRAINT IF EXISTS unit_measurement_type_fk;
ALTER TABLE unit ADD CONSTRAINT unit_measurement_type_fk FOREIGN KEY (measurement_type_id)
REFERENCES measurement_type (id);
-- ddl-end --

-- object: sensor_continuous_type_measurement_type_id | type: CONSTRAINT --
ALTER TABLE sensor_continuous_type DROP CONSTRAINT IF EXISTS sensor_continuous_type_measurement_type_id;
ALTER TABLE sensor_continuous_type ADD CONSTRAINT sensor_continuous_type_measurement_type_id FOREIGN KEY (measurement_type_id)
REFERENCES measurement_type (id);
-- ddl-end --

-- object: sensor_continuous_unit_fk | type: CONSTRAINT --
ALTER TABLE sensor_continuous_type DROP CONSTRAINT IF EXISTS sensor_continuous_unit_fk;
ALTER TABLE sensor_continuous_type ADD CONSTRAINT sensor_continuous_unit_fk FOREIGN KEY (unit_id)
REFERENCES unit (id);
-- ddl-end --

-- object: sensor_continuous_device_fk | type: CONSTRAINT --
ALTER TABLE sensor_continuous DROP CONSTRAINT IF EXISTS sensor_continuous_device_fk;
ALTER TABLE sensor_continuous ADD CONSTRAINT sensor_continuous_device_fk FOREIGN KEY (device_id)
REFERENCES device (id);
-- ddl-end --

-- object: sensor_continuous_sensor_continuous_type_fk | type: CONSTRAINT --
ALTER TABLE sensor_continuous DROP CONSTRAINT IF EXISTS sensor_continuous_sensor_continuous_type_fk;
ALTER TABLE sensor_continuous ADD CONSTRAINT sensor_continuous_sensor_continuous_type_fk FOREIGN KEY (sensor_continuous_type_id)
REFERENCES sensor_continuous_type (id);
-- ddl-end --

-- object: sensor_counter_measurement_type_fk | type: CONSTRAINT --
ALTER TABLE sensor_counter_type DROP CONSTRAINT IF EXISTS sensor_counter_measurement_type_fk;
ALTER TABLE sensor_counter_type ADD CONSTRAINT sensor_counter_measurement_type_fk FOREIGN KEY (measurement_type_id)
REFERENCES measurement_type (id);
-- ddl-end --

-- object: sensor_boolean_measurement_type_fk | type: CONSTRAINT --
ALTER TABLE sensor_boolean_type DROP CONSTRAINT IF EXISTS sensor_boolean_measurement_type_fk;
ALTER TABLE sensor_boolean_type ADD CONSTRAINT sensor_boolean_measurement_type_fk FOREIGN KEY (measurement_type_id)
REFERENCES measurement_type (id);
-- ddl-end --

-- object: sensor_text_measurement_type_fk | type: CONSTRAINT --
ALTER TABLE sensor_text_type DROP CONSTRAINT IF EXISTS sensor_text_measurement_type_fk;
ALTER TABLE sensor_text_type ADD CONSTRAINT sensor_text_measurement_type_fk FOREIGN KEY (measurement_type_id)
REFERENCES measurement_type (id);
-- ddl-end --

-- object: sensor_boolean_device_fk | type: CONSTRAINT --
ALTER TABLE sensor_boolean DROP CONSTRAINT IF EXISTS sensor_boolean_device_fk;
ALTER TABLE sensor_boolean ADD CONSTRAINT sensor_boolean_device_fk FOREIGN KEY (device_id)
REFERENCES device (id);
-- ddl-end --

-- object: sensor_boolean_sensor_boolean_type_fk | type: CONSTRAINT --
ALTER TABLE sensor_boolean DROP CONSTRAINT IF EXISTS sensor_boolean_sensor_boolean_type_fk;
ALTER TABLE sensor_boolean ADD CONSTRAINT sensor_boolean_sensor_boolean_type_fk FOREIGN KEY (sensor_boolean_type_id)
REFERENCES sensor_boolean_type (id);
-- ddl-end --

-- object: sensor_counter_device_fk | type: CONSTRAINT --
ALTER TABLE sensor_counter DROP CONSTRAINT IF EXISTS sensor_counter_device_fk;
ALTER TABLE sensor_counter ADD CONSTRAINT sensor_counter_device_fk FOREIGN KEY (device_id)
REFERENCES device (id);
-- ddl-end --

-- object: sensor_counter_sensor_counter_type_fk | type: CONSTRAINT --
ALTER TABLE sensor_counter DROP CONSTRAINT IF EXISTS sensor_counter_sensor_counter_type_fk;
ALTER TABLE sensor_counter ADD CONSTRAINT sensor_counter_sensor_counter_type_fk FOREIGN KEY (sensor_counter_type_id)
REFERENCES sensor_counter_type (id);
-- ddl-end --

-- object: sensor_text_device_fk | type: CONSTRAINT --
ALTER TABLE sensor_text DROP CONSTRAINT IF EXISTS sensor_text_device_fk;
ALTER TABLE sensor_text ADD CONSTRAINT sensor_text_device_fk FOREIGN KEY (device_id)
REFERENCES device (id);
-- ddl-end --

-- object: sensor_text_sensor_text_type_fk | type: CONSTRAINT --
ALTER TABLE sensor_text DROP CONSTRAINT IF EXISTS sensor_text_sensor_text_type_fk;
ALTER TABLE sensor_text ADD CONSTRAINT sensor_text_sensor_text_type_fk FOREIGN KEY (sensor_text_type_id)
REFERENCES sensor_text_type (id);
-- ddl-end --
