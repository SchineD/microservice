--
-- Initial data inserted after creating schema
--

-- fiware_instances
insert into fiware_instance (name, is_test, is_ready,
                             context_broker_url,
                             agent_ul_url, agent_mqtt_url, agent_lora_url, agent_lwm2m_url)
values ('PACE Test', true, true,
        'https://stp-test.wien.gv.at:4543/iot_contextbroker',
        'https://stp-test.wien.gv.at:4543/iot_agent_lxpace01/d00001', null, null, null);    -- 1

insert into fiware_instance (name, is_test, is_ready,
                             context_broker_url,
                             agent_ul_url, agent_mqtt_url, agent_lora_url, agent_lwm2m_url)
values ('MA01 Prod', false, false,
        'https://stp.wien.gv.at:4543/iot_contextbroker',
        'https://stp.wien.gv.at:4543/iot_agent_lxpace01/d00001', null, null, null);         -- 2

-- tenants
-- - MA01
insert into tenant
(name, short_name, fiware_instance_id, contact, contact_email, geo_longitude, geo_latitude, geo_zoom)
values
('MA 01 - Wien Digital', 'ma01', 1,
 'MA 01 - Wien Digital, 22.; Stadlauer Straße 54 und 56 - Star 22',
 'post@ma01.wien.gv.at', 16.456410102546215, 48.22919469303079, 16);                    -- 1
insert into tenant
(name, short_name, fiware_instance_id, contact, contact_email, parent_id, geo_longitude, geo_latitude, geo_zoom)
values
('MA 01 - PACE', 'pace', 1,
 'PACE - Digitale Innovation und agile Softwareentwicklung',
 'pace@ma14.wien.gv.at', 1, 16.3548616692424, 48.2105661140506, 16);                    -- 2
-- - deep
insert into tenant
(name, short_name, fiware_instance_id, contact, contact_email, geo_longitude, geo_latitude, geo_zoom)
values
('Verschachtelt', 'deep', 1,
 'Root tenant of a deeply nested organisation',
 'deep@ma14.wien.gv.at', 13.845576848834753, 46.61320957438895, 15);                                     -- 3
insert into tenant
(name, short_name, fiware_instance_id, contact, contact_email, parent_id, geo_longitude, geo_latitude, geo_zoom)
values
('Verschachtelt, Abteilung A', 'deepsub', 1,
 'Sub-tenant of a deeply nested organisation',
 'deepsub@ma14.wien.gv.at', 3, 13.845576848834753, 46.61320957438895, 17);                               -- 4
insert into tenant
(name, short_name, fiware_instance_id, contact, contact_email, parent_id, geo_longitude, geo_latitude, geo_zoom)
values
('Verschachtelt, Abteilung A, Gruppe X', 'deepsubsub', 1,
 'SubSub-tenant of a deeply nested organisation',
 'deepsubsub@ma14.wien.gv.at', 4, 13.845576848834753, 46.61320957438895, 18);                            -- 5
insert into tenant
(name, short_name, fiware_instance_id, contact, contact_email, parent_id, geo_longitude, geo_latitude, geo_zoom)
values
('Verschachtelt, Abteilung A, Gruppe X, Referat 1', 'deepsubsubsub1', 1,
 'SubSubSub-tenant 1 of a deeply nested organisation',
 'deepsubsubsub1@ma14.wien.gv.at', 5, 13.845576848834753, 46.61320957438895, 19);                        -- 6
insert into tenant
(name, short_name, fiware_instance_id, contact, contact_email, parent_id, geo_longitude, geo_latitude, geo_zoom)
values
('Verschachtelt, Abteilung A, Gruppe X, Referat 2', 'deepsubsubsub2', 1,
 'SubSubSub-tenant 2 of a deeply nested organisation',
 'deepsubsubsub2@ma14.wien.gv.at', 5, 13.845576848834753, 46.61320957438895, 19);                        -- 7

-- user
insert into app_user
(network_id, full_name, email, tenant_id, is_root)
values
('wien1.man0001@wien.gv.at', 'Andreas Manessinger', 'andreas.manessinger@wien.gv.at', 1, true);      -- 1
insert into app_user
(network_id, full_name, email, tenant_id, is_root)
values
('wien1.fui0001@wien.gv.at', 'Michael Führer', 'michael.fuehrer@wien.gv.at', 1, true);               -- 2
insert into app_user
(network_id, full_name, email, tenant_id, is_root)
values
('wien1.hac0001@wien.gv.at', 'Christian Habernig', 'christian.habernig@wien.gv.at', 2, true);        -- 3
insert into app_user
(network_id, full_name, email, tenant_id, is_root)
values
('wien1.hic0001@wien.gv.at', 'Christoph Hillebrand', 'christoph.hillebrand@wien.gv.at', 2, false);   -- 4

insert into app_user
(network_id, full_name, email, tenant_id, is_root)
values
('wien1.deep@wien.gv.at', 'Root Deep', 'root.deep@wien.gv.at', 3, false);                            -- 5
insert into app_user
(network_id, full_name, email, tenant_id, is_root)
values
('wien1.deepsub@wien.gv.at', 'Sub Deep', 'sub.deep@wien.gv.at', 4, false);                           -- 6
insert into app_user
(network_id, full_name, email, tenant_id, is_root)
values
('wien1.deepsubsub@wien.gv.at', 'SubSub Deep', 'subsub.deep@wien.gv.at', 5, false);                  -- 7
insert into app_user
(network_id, full_name, email, tenant_id, is_root)
values
('wien1.deepsubsubsub1@wien.gv.at', 'SubSubSub1 Deep', 'subsubsub1.deep@wien.gv.at', 6, false);      -- 8
insert into app_user
(network_id, full_name, email, tenant_id, is_root)
values
('wien1.deepsubsubsub2@wien.gv.at', 'SubSubSub2 Deep', 'subsubsub2.deep@wien.gv.at', 7, false);      -- 9

-- country
insert into country (name) values ('Austria');                                            -- 1
insert into country (name) values ('Germany');                                            -- 2

-- region
insert into region (name, country_id) values ('Kärnten', 1);                              -- 1
insert into region (name, country_id) values ('Niederösterreich', 1);                     -- 2
insert into region (name, country_id) values ('Wien', 1);                                 -- 3

-- locality
insert into locality (name, region_id) values ('Donaustadt', 3);                          -- 1
insert into locality (name, region_id) values ('Josefstadt', 3);                          -- 2
insert into locality (name, region_id) values ('Langschlag', 2);                          -- 3
insert into locality (name, region_id) values ('Villach', 1);                             -- 4

-- entity_type
insert into entity_type (name) values ('Building');                                       -- 1
insert into entity_type (name) values ('Room');                                           -- 2
insert into entity_type (name) values ('PointOfInterest');                                -- 3

-- agent
insert into agent (name, protocol, transport) values ('agent_ul', 'IoTA-UL', 'HTTP');     -- 1
insert into agent (name, protocol, transport) values ('agent_mqtt', 'IoTA-UL', 'MQTT');   -- 2

-- measurement_type
insert into measurement_type
(name, ngsi_key, ul_object_id, display_precision)
values
('Lufttemperatur', 'temperature', 't', 2);                                              -- 1
insert into measurement_type
(name, ngsi_key, ul_object_id, display_precision)
values
('Luftdruck', 'pressure', 'p', 0);                                                      -- 2
insert into measurement_type
(name, ngsi_key, ul_object_id, display_precision)
values
('Luftfeuchtigkeit', 'humidity', 'h', 0);                                               -- 3
insert into measurement_type
(name, ngsi_key, ul_object_id)
values
('Beschreibung', 'description', 'd');                                                   -- 4
insert into measurement_type
(name, ngsi_key, ul_object_id)
values
('Besucheranzahl', 'visitor_count', 'vc');                                              -- 5
insert into measurement_type
(name, ngsi_key, ul_object_id)
values
('Türzustand', 'door_state', 'ds');                                                     -- 6
insert into measurement_type
(name, ngsi_key, ul_object_id)
values
('Ventilzustand', 'valve_state', 'vs');                                                 -- 7
insert into measurement_type
(name, ngsi_key, ul_object_id)
values
('Fahrzeuganzahl', 'car_count', 'cc');                                                  -- 8


-- unit
insert into unit (measurement_type_id, name) values (1, 'K');                             -- 1
insert into unit (measurement_type_id, name) values (1, 'ºC');                            -- 2
insert into unit (measurement_type_id, name) values (2, 'mbar');                          -- 3
insert into unit (measurement_type_id, name) values (2, 'bar');                           -- 4
insert into unit (measurement_type_id, name) values (2, 'Pa');                            -- 5
insert into unit (measurement_type_id, name) values (2, 'kPa');                           -- 6
insert into unit (measurement_type_id, name) values (3, '% rel.');                        -- 7
insert into unit (measurement_type_id, name) values (3, 'abs., g/m³');                    -- 8

-- device_type
insert into device_type
(manufacturer, model, revision, doc_url)
values
('PACE', 'Simulierte Wetterstation', 'v1.0',
 'https://bitbucket.org/ma14pace/iot_device_sim/');                                   -- 1
insert into device_type
(manufacturer, model, revision, doc_url)
values
('PACE', 'PACE-Car + maxim integrated DS18B20', 'v1.0',
 'https://bitbucket.org/ma14pace/pace_car/');                                         -- 2
insert into device_type
(manufacturer, model, revision, doc_url)
values
('Deep', 'Simulierter Besucherzähler', 'v1.0',
 'https://bitbucket.org/ma14pace/iot_admin/src/master/doc/test_data.md');             -- 3
insert into device_type
(manufacturer, model, revision, doc_url)
values
('Deep', 'Simulierte Türzustandskontrolle', 'v1.0',
 'https://bitbucket.org/ma14pace/iot_admin/src/master/doc/test_data.md');             -- 4

-- sensor_continuous_type
insert into sensor_continuous_type
(measurement_type_id, unit_id, name, doc_url, min_value, max_value)
values
(1, 2,
 'Simulierter Lufttemperatursensor, ºC',
 'https://bitbucket.org/ma14pace/iot_device_sim/',
 -40, 50);                                                                              -- 1
insert into sensor_continuous_type
(measurement_type_id, unit_id, name, doc_url, min_value, max_value)
values
(2, 3,
 'Simulierter Luftdrucksensor, mbar',
 'https://bitbucket.org/ma14pace/iot_device_sim/',
 400, 1600);                                                                            -- 2
insert into sensor_continuous_type
(measurement_type_id, unit_id, name, doc_url, min_value, max_value)
values
(3, 7,
 'Simulierter Luftfeuchtigkeitssensor, % rel',
 'https://bitbucket.org/ma14pace/iot_device_sim/',
 0, 100);                                                                               -- 3
insert into sensor_continuous_type
(measurement_type_id, unit_id, name, doc_url, min_value, max_value)
values
(1, 2, 'DS18B20 Programmable Resolution 1-Wire Digital Thermometer',
 'https://datasheets.maximintegrated.com/en/ds/DS18B20.pdf',
 -55, 125);                                                                             -- 4

-- sensor_text_type
insert into sensor_text_type
(measurement_type_id, name, doc_url)
values
(4,
 'Simulierte Wetterbeschreibung',
 'https://bitbucket.org/ma14pace/iot_device_sim/');                                     -- 1
insert into sensor_text_type
(measurement_type_id, name, doc_url)
values
(4,
 'Simulierte Verkehrslage',
 'https://bitbucket.org/ma14pace/iot_device_sim/');                                     -- 2

-- sensor_counter_type
insert into sensor_counter_type
(measurement_type_id, name, doc_url)
values
(5,
 'Simulierter Besucherzähler',
 'https://bitbucket.org/ma14pace/iot_admin/src/master/doc/test_data.md');               -- 1
insert into sensor_counter_type
(measurement_type_id, name, doc_url)
values
(8,
 'Simulierter Fahrzeugzähler',
 'https://bitbucket.org/ma14pace/iot_admin/src/master/doc/test_data.md');               -- 2

-- sensor_boolean_type
insert into sensor_boolean_type
(measurement_type_id, name, doc_url, true_value_name, false_value_name)
values
(6,
 'Simulierter Türzustandssensor',
 'https://bitbucket.org/ma14pace/iot_admin/src/master/doc/test_data.md',
 'Offen', 'Geschlossen');                                                               -- 1
insert into sensor_boolean_type
(measurement_type_id, name, doc_url, true_value_name, false_value_name)
values
(7,
 'Simulierter Ventilzustandssensor',
 'https://bitbucket.org/ma14pace/iot_admin/src/master/doc/test_data.md',
 'Auf', 'Zu');                                                                          -- 2

-- many_device_type_has_many_sensor_continuous_type
insert into many_device_type_has_many_sensor_continuous_type
(id_device_type, id_sensor_continuous_type)
values
(1, 1);
insert into many_device_type_has_many_sensor_continuous_type
(id_device_type, id_sensor_continuous_type)
values
(1, 2);
insert into many_device_type_has_many_sensor_continuous_type
(id_device_type, id_sensor_continuous_type)
values
(1, 3);
insert into many_device_type_has_many_sensor_continuous_type
(id_device_type, id_sensor_continuous_type)
values
(2, 4);

-- many_device_type_has_many_sensor_text_type
insert into many_device_type_has_many_sensor_text_type
(id_device_type, id_sensor_text_type)
values
(1, 1);

-- many_device_type_has_many_sensor_counter_type
insert into many_device_type_has_many_sensor_counter_type
(id_device_type, id_sensor_counter_type)
values
(3, 1);

-- many_device_type_has_many_sensor_boolean_type
insert into many_device_type_has_many_sensor_boolean_type
(id_device_type, id_sensor_boolean_type)
values
(4, 1);

-- postal_address
insert into postal_address
(tenant_id, postal_code, street_address, locality_id)
values
(2, '1080', 'Friedrich-Schmidt-Platz 3', 2);                                             -- 1
insert into postal_address
(tenant_id, postal_code, street_address, locality_id)
values
(2, '1220', 'Stadlauder Straße 56', 1);                                                  -- 2
insert into postal_address
(tenant_id, postal_code, street_address, locality_id)
values
(2, '9500', 'Valentin-Schöffmann-Weg 7/6', 4);                                           -- 3
insert into postal_address
(tenant_id, postal_code, street_address, locality_id)
values
(2, '3921', 'Schmerbachweg 137', 3);                                                     -- 4

insert into postal_address
(tenant_id, postal_code, street_address, locality_id)
values
(4, '9500', 'Oberer Kirchenplatz 9', 3);                                                 -- 5
insert into postal_address
(tenant_id, postal_code, street_address, locality_id)
values
(2, '1220', 'Adelheid-Popp-Gasse 5/1/22', 1);                                            -- 6

-- static_entities
insert into static_entity
(tenant_id, name, short_name, geo_longitude, geo_latitude, geo_zoom, address_id, entity_type_id, parent_id)
values
(2,'CTR, Come Together Room', 'pace-ctr', 16.354858, 48.210607, 19, 1, 1, null);         -- 1
insert into static_entity
(tenant_id, name, short_name, geo_longitude, geo_latitude, geo_zoom, address_id, entity_type_id, parent_id)
values
(2,'Star 22, Bauteil B', 'star22b', 16.456582, 48.229227, 18, 2, 1, null);               -- 2
insert into static_entity
(tenant_id, name, short_name, geo_longitude, geo_latitude, geo_zoom, address_id, entity_type_id, parent_id)
values
(2,'PACE Star 22, Zimmer B 1.090', 'pace-star22', 16.456582, 48.229227, 20, 2, 2, 2);    -- 3
insert into static_entity
(tenant_id, name, short_name, geo_longitude, geo_latitude, geo_zoom, address_id, entity_type_id, parent_id)
values
(2,'PACE Villach', 'pace-villach', 13.867404, 46.609837, 18, 3, 1, null);                -- 4
insert into static_entity
(tenant_id, name, short_name, geo_longitude, geo_latitude, geo_zoom, address_id, entity_type_id, parent_id)
values
(2,'PACE Waldviertel', 'pace-waldviertel', 14.883174, 48.578391, 17, 4, 1, null);        -- 5

insert into static_entity
(tenant_id, name, short_name, geo_longitude, geo_latitude, geo_zoom, address_id, entity_type_id, parent_id)
values
(3,'Pfarrkirche Sankt Jakob', 'st_jakob_villach', 13.845684, 46.613313, 17, 5, 1, null); -- 6
insert into static_entity
(tenant_id, name, short_name, geo_longitude, geo_latitude, geo_zoom, address_id, entity_type_id, parent_id)
values
(4,'Stadtpfarrturm Villach', 'turm', 13.845212, 46.613337, 20, 5, 1, 6);                 -- 7
insert into static_entity
(tenant_id, name, short_name, geo_longitude, geo_latitude, geo_zoom, address_id, entity_type_id, parent_id)
values
(5,'Gotischer Chor', 'chor', 13.845801, 46.613361, 20, 5, 3, 6);                         -- 8
insert into static_entity
(tenant_id, name, short_name, geo_longitude, geo_latitude, geo_zoom, address_id, entity_type_id, parent_id)
values
(6,'Hochaltar', 'altar', 13.845896, 46.613368, 20, 5, 3, 8);                             -- 9
insert into static_entity
(tenant_id, name, short_name, geo_longitude, geo_latitude, geo_zoom, address_id, entity_type_id, parent_id)
values
(7,'Turmstube', 'turmstube', 13.845212, 46.613337, 20, 5, 1, 7);                         -- 10

-- device_group
insert into device_group
(tenant_id, name, short_name, agent_id, apikey)
values
(2, 'PACE-CTR HTTP/Ultralight', 'ctr', 1, '<insert PACE-CTR-APIKEY>');                          -- 1
insert into device_group
(tenant_id, name, short_name, agent_id, apikey)
values
(2, 'PACE-STAR22 HTTP/Ultralight', 'star22', 1, '<insert PACE-STAR22-APIKEY>');                 -- 2
insert into device_group
(tenant_id, name, short_name, agent_id, apikey)
values
(2, 'PACE-VILLACH HTTP/Ultralight', 'villach', 1, '<insert PACE-VILLACH-APIKEY>');              -- 3
insert into device_group
(tenant_id, name, short_name, agent_id, apikey)
values
(2, 'PACE-WALDVIERTEL HTTP/Ultralight', 'waldviertel', 1, '<insert PACE-WALDVIERTEL-APIKEY>');  -- 4

insert into device_group
(tenant_id, name, short_name, agent_id, apikey)
values
(5, 'DEEP-CHOR HTTP/Ultralight', 'chor', 1, '<insert DEEP-CHOR-APIKEY>');                       -- 5
insert into device_group
(tenant_id, name, short_name, agent_id, apikey)
values
(6, 'DEEP-ALTAR HTTP/Ultralight', 'altar', 1, '<insert DEEP-ALTAR-APIKEY>');                    -- 6
insert into device_group
(tenant_id, name, short_name, agent_id, apikey)
values
(7, 'DEEP-TURMSTUBE HTTP/Ultralight', 'turmstube', 1, '<insert DEEP-TURMSTUBE-APIKEY>');        -- 7

-- device
--   pace
insert into device
(device_type_id, tenant_id, name, device_group_id, location_ref,
 serial_number, asset_number, geo_longitude, geo_latitude, geo_zoom)
values
(1, 2, 'Simulierte Wetterstation CTR', 1, 1, 'PACE0001', 'M01-PACE0001',
 16.354858, 48.210607, 19);                                                                   -- 1
insert into sensor_continuous
(device_id, sensor_continuous_type_id, name, short_name,
 min_value_expected, max_value_expected, min_value_warn, max_value_warn, normal_value)
values
(1, 1, 'Lufttemperatur', 'temp', -30, 45, -10, 35, 20);
insert into sensor_continuous
(device_id, sensor_continuous_type_id, name, short_name,
 min_value_expected, max_value_expected, min_value_warn, max_value_warn, normal_value)
values
(1, 2, 'Luftdruck', 'pres', 500, 1500, 800, 1200, 1000);
insert into sensor_continuous
(device_id, sensor_continuous_type_id, name, short_name,
 min_value_expected, max_value_expected, min_value_warn, max_value_warn, normal_value)
values
(1, 3, 'Luftfeuchtigkeit', 'humi', 10, 100, 20, 95, 50);
insert into sensor_text
(device_id, sensor_text_type_id, name, short_name)
values
(1, 1, 'Wetterlage', 'desc');

insert into device
(device_type_id, tenant_id, name, device_group_id, location_ref,
 serial_number, asset_number, geo_longitude, geo_latitude, geo_zoom)
values
(1, 2, 'Simulierte Wetterstation Star 22', 2, 3, 'PACE0002', 'M01-PACE0002',
 16.456582, 48.229227, 20);                                                                   -- 2
insert into sensor_continuous
(device_id, sensor_continuous_type_id, name, short_name,
 min_value_expected, max_value_expected, min_value_warn, max_value_warn, normal_value)
values
(2, 1, 'Lufttemperatur', 'temp', -30, 45, -10, 35, 20);
insert into sensor_continuous
(device_id, sensor_continuous_type_id, name, short_name,
 min_value_expected, max_value_expected, min_value_warn, max_value_warn, normal_value)
values
(2, 2, 'Luftdruck', 'pres', 500, 1500, 800, 1200, 1000);
insert into sensor_continuous
(device_id, sensor_continuous_type_id, name, short_name,
 min_value_expected, max_value_expected, min_value_warn, max_value_warn, normal_value)
values
(2, 3, 'Luftfeuchtigkeit', 'humi', 10, 100, 20, 95, 50);
insert into sensor_text
(device_id, sensor_text_type_id, name, short_name)
values
(2, 1, 'Wetterlage', 'desc');

insert into device
(device_type_id, tenant_id, name, device_group_id, location_ref,
 serial_number, asset_number, geo_longitude, geo_latitude, geo_zoom)
values
(1, 2, 'Simulierte Wetterstation Villach', 3, 4, 'PACE0003', 'M01-PACE0003',
 13.867404, 46.609837, 18);                                                                   -- 3
insert into sensor_continuous
(device_id, sensor_continuous_type_id, name, short_name,
 min_value_expected, max_value_expected, min_value_warn, max_value_warn, normal_value)
values
(3, 1, 'Lufttemperatur', 'temp', -30, 45, -10, 35, 20);
insert into sensor_continuous
(device_id, sensor_continuous_type_id, name, short_name,
 min_value_expected, max_value_expected, min_value_warn, max_value_warn, normal_value)
values
(3, 2, 'Luftdruck', 'pres', 500, 1500, 800, 1200, 1000);
insert into sensor_continuous
(device_id, sensor_continuous_type_id, name, short_name,
 min_value_expected, max_value_expected, min_value_warn, max_value_warn, normal_value)
values
(3, 3, 'Luftfeuchtigkeit', 'humi', 10, 100, 20, 95, 50);
insert into sensor_text
(device_id, sensor_text_type_id, name, short_name)
values
(3, 1, 'Wetterlage', 'desc');

insert into device
(device_type_id, tenant_id, name, device_group_id, location_ref,
 serial_number, asset_number, geo_longitude, geo_latitude, geo_zoom)
values
(1, 2, 'Simulierte Wetterstation Waldviertel', 4, 5, 'PACE0004', 'M01-PACE0004',
 14.883174, 48.578391, 20);                                                                   -- 4
insert into sensor_continuous
(device_id, sensor_continuous_type_id, name, short_name,
 min_value_expected, max_value_expected, min_value_warn, max_value_warn, normal_value)
values
(4, 1, 'Lufttemperatur', 'temp', -30, 45, -10, 35, 20);
insert into sensor_continuous
(device_id, sensor_continuous_type_id, name, short_name,
 min_value_expected, max_value_expected, min_value_warn, max_value_warn, normal_value)
values
(4, 2, 'Luftdruck', 'pres', 500, 1500, 800, 1200, 1000);
insert into sensor_continuous
(device_id, sensor_continuous_type_id, name, short_name,
 min_value_expected, max_value_expected, min_value_warn, max_value_warn, normal_value)
values
(4, 3, 'Luftfeuchtigkeit', 'humi', 10, 100, 20, 95, 50);
insert into sensor_text
(device_id, sensor_text_type_id, name, short_name)
values
(4, 1, 'Wetterlage', 'desc');

--   deep
insert into device
(device_type_id, tenant_id, name, device_group_id, location_ref,
 serial_number, asset_number, geo_longitude, geo_latitude, geo_zoom)
values
(3, 5, 'Simulierter Besucherzähler', 5, 8, 'DEEP0001', 'DEEP-S-S0001',
 13.845801, 46.613361, 20);                                                                   -- 5
insert into sensor_counter
(device_id, sensor_counter_type_id, name, short_name)
values
(5, 1, 'Besucher Chor', 'vis_choir');

insert into device
(device_type_id, tenant_id, name, device_group_id, location_ref,
 serial_number, asset_number, geo_longitude, geo_latitude, geo_zoom)
values
(3, 6, 'Simulierter Besucherzähler', 6, 9, 'DEEP0002', 'DEEP-S-S-S10001',
 13.845896, 46.613368, 20);                                                                   -- 6
insert into sensor_counter
(device_id, sensor_counter_type_id, name, short_name)
values
(6, 1, 'Besucher Hochaltar', 'vis_altar');

insert into device
(device_type_id, tenant_id, name, device_group_id, location_ref,
 serial_number, asset_number, geo_longitude, geo_latitude, geo_zoom)
values
(4, 7, 'Simulierte Türzustandskontrolle', 7, 10, 'DEEP0003', 'DEEP-S-S-S20001',
 13.845212, 46.613337, 20);                                                                   -- 7
insert into sensor_boolean
(device_id, sensor_boolean_type_id, name, short_name)
values
(7, 1, 'Tür Turmstube', 'door_tower');

-- PACE Car
insert into device
(device_type_id, tenant_id, name, device_group_id, location_ref,
 serial_number, asset_number, geo_longitude, geo_latitude, geo_zoom)
values
(2, 2, 'PACE-Car + maxim integrated DS18B20', 1, 1, 'PACE0005', 'M01-PACE0005',
 16.354858, 48.210607, 19);                                                                   -- 8
insert into sensor_continuous
(device_id, sensor_continuous_type_id, name, short_name,
 min_value_expected, max_value_expected, min_value_warn, max_value_warn, normal_value)
values
(8, 4, 'Lufttemperatur', 'temp', -35, 50, -10, 35, 20);
