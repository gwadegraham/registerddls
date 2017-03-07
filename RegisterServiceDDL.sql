CREATE EXTENSION "uuid-ossp";

CREATE TABLE product (
  id uuid NOT NULL,
  lookupcode character varying(32) NOT NULL DEFAULT(''),
  count int NOT NULL DEFAULT(0),
  createdon timestamp without time zone NOT NULL DEFAULT now(),
  CONSTRAINT product_pkey PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);

CREATE INDEX ix_product_lookupcode
  ON product
  USING btree
  (lower(lookupcode::text) COLLATE pg_catalog."default");

INSERT INTO product VALUES (
       uuid_generate_v4()
     , 'lookupcode1'
     , 100
     , current_timestamp
);

INSERT INTO product VALUES (
       uuid_generate_v4()
     , 'lookupcode1'
     , 125
     , current_timestamp
);

INSERT INTO product VALUES (
       uuid_generate_v4()
     , 'lookupcode3'
     , 150
     , current_timestamp
);


/**************** EMPLOYEEE TABLE ******************/

CREATE EXTENSION "uiid-ossp";

CREATE TYPE role AS ENUM ('general manager', 'shift manager', 'cashier');

CREATE TABLE employee (
  id uuid NOT NULL,
  firstName character varying(32) NOT NULL DEFAULT(''),
  lastName character varying(32) NOT NULL DEFAULT(''),
  employeeID character varying(32) NOT NULL DEFAULT(''),
  active boolean NOT NULL DEFAULT(FALSE),
  currentRole role NOT NULL DEFAULT('cashier'),
  managerID uuid NOT NULL,
  password character varying(15) NOT NULL DEFAULT(''),
  createdon timestamp without time zone NOT NULL DEFAULT now(),
  CONSTRAINT R_ID PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);

CREATE INDEX emplyee_employeeID
ON employee
USING btree(employeeID);

INSERT INTO employee VALUES (
	uuid_generate_v4()
   , 'Quinn'
   , 'Childress'
   , 'employee001'
   , TRUE
   , 'cashier'
   , uuid_generate_v4()
   , 'testing'
   , current_timestamp

);