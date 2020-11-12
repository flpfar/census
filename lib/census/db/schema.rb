CREATE_TABLE_STATES = 'CREATE TABLE IF NOT EXISTS states ('\
                        'id integer NOT NULL,'\
                        'initials varchar(2) NOT NULL,'\
                        'name varchar(40) NOT NULL,'\
                        'PRIMARY KEY (id)'\
                      ');'.freeze

CREATE_TABLE_CITIES = 'CREATE TABLE IF NOT EXISTS cities ('\
                        'id integer NOT NULL,'\
                        'name varchar(40) NOT NULL,'\
                        'state integer,'\
                        'PRIMARY KEY (id)'\
                      ');'.freeze

CREATE_TABLES = (CREATE_TABLE_STATES + CREATE_TABLE_CITIES).freeze
