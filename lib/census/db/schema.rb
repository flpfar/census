CREATE_TABLE_STATES = 'CREATE TABLE IF NOT EXISTS states ('\
                        'id integer NOT NULL,'\
                        'initials varchar(2) NOT NULL,'\
                        'name varchar(40) NOT NULL,'\
                        'PRIMARY KEY (id)'\
                      ');'.freeze

CREATE_TABLE_CITIES = 'CREATE TABLE IF NOT EXISTS cities ('\
                        'id integer NOT NULL,'\
                        'name varchar(40) NOT NULL,'\
                        'state_id integer,'\
                        'PRIMARY KEY (id)'\
                      ');'.freeze

CREATE_TABLE_RANKINGS = 'CREATE TABLE IF NOT EXISTS rankings ('\
                          'id SERIAL PRIMARY KEY,'\
                          'locale_id integer NOT NULL,'\
                          'name varchar(40) NOT NULL,'\
                          'rate integer NOT NULL,'\
                          'ranking integer NOT NULL,'\
                          'gender CHAR(1) NOT NULL,'\
                          'UNIQUE (locale_id, name, gender)'\
                        ');'.freeze

REMOVE_NOTICE_IF_TABLE_EXISTS = 'SET client_min_messages = error;'.freeze

CREATE_TABLES = (CREATE_TABLE_STATES + CREATE_TABLE_CITIES + CREATE_TABLE_RANKINGS).freeze
