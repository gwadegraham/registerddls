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

INSERT INTO product VALUES (
       uuid_generate_v4()
     , 'lookupcode4'
     , 1231
     , current_timestamp
);

INSERT INTO product VALUES (
       uuid_generate_v4()
     , 'lookupcode5'
     , 39
     , current_timestamp
);

INSERT INTO product VALUES (
       uuid_generate_v4()
     , 'lookupcode6'
     , 42
     , current_timestamp
);

/**************** EMPLOYEEE TABLE ******************/

CREATE TABLE employee (
  id uuid NOT NULL,
  employeeid character varying(32) NOT NULL DEFAULT(''),
  firstname character varying(128) NOT NULL DEFAULT(''),
  lastname character varying(128) NOT NULL DEFAULT(''),
  password character varying(512) NOT NULL DEFAULT(''),
  active boolean NOT NULL DEFAULT(FALSE), 
  classification int NOT NULL DEFAULT(0),
  managerid uuid NOT NULL,
  createdon timestamp without time zone NOT NULL DEFAULT now(),
  CONSTRAINT employee_pkey PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);

CREATE INDEX ix_employee_employeeid
  ON employee
  USING hash(employeeid);

/** Transaction Table **/

CREATE TABLE transaction (
	id UUID NOT NULL,
	recordId varchar(32) NOT NULL DEFAULT(''),
	cashierId varchar(32) NOT NULL DEFAULT(''),
	totalAmount DECIMAL(10, 2) NOT NULL,
	type character(1) NOT NULL DEFAULT('s'),
	referenceId varchar(32) NOT NULL DEFAULt(''),
	createdOn timestamp without time zone NOT NULL DEFAULT NOW(),
	CONSTRAINT transaction_pkey PRIMARY KEY (id)
) WITH (
	OIDS = FALSE
);

CREATE INDEX ix_transaction_recordid
  ON transaction
  USING btree(recordId);

/** Transaction Entry table **/

CREATE TABLE transactionEntry (
	id UUID NOT NULL,
	transactionId VARCHAR(32) NOT NULL DEFAULT(''),
	productId VARCHAR(32) NOT NULL DEFAULT(''),
	amountSold INT NOT NULL DEFAULT(0),
	soldPrice DECIMAL(10, 2) NOT NULL DEFAULT(0),
	CONSTRAINT transactionEntry_pkey PRIMARY KEY (id)
) WITH (
	OIDS = FALSE
);

CREATE INDEX ix_transactionEntry_recordid
  ON transactionEntry
  USING btree(transactionId, amountSold);
	

ALTER TABLE product
ADD COLUMN price DECIMAL(10, 2) NOT NULL DEFAULT(0);

ALTER TABLE product
ADD COLUMN active BOOLEAN NOT NULL DEFAULT(FALSE);

ALTER TABLE product
RENAME COLUMN count TO quantity;
