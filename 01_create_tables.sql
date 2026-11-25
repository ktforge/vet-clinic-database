-- people who bring pets to the clinic
CREATE TABLE owners (
  owner_id SERIAL PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  phone VARCHAR(20) NOT NULL,
  email VARCHAR(100)
);

-- each pet has one primary owner on file (one owner to many pets)
CREATE TABLE pets (
  pet_id SERIAL PRIMARY KEY,
  owner_id INTEGER NOT NULL REFERENCES owners(owner_id),
  name VARCHAR(50) NOT NULL,
  species VARCHAR(30) NOT NULL,
  breed VARCHAR(50),
  birth_date DATE,
  weight_lbs NUMERIC(5,1)
);

-- one chip per pet and one pet per chip (one to one)
CREATE TABLE microchips (
  chip_number VARCHAR(15) PRIMARY KEY,
  pet_id INTEGER NOT NULL UNIQUE REFERENCES pets(pet_id),
  implant_date DATE NOT NULL
);

-- the clinic's veterinarians
CREATE TABLE vets (
  vet_id SERIAL PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  license_number VARCHAR(20) NOT NULL UNIQUE
);

-- one visit: one pet seen by one vet (pets and vets each have many appointments)
CREATE TABLE appointments (
  appointment_id SERIAL PRIMARY KEY,
  pet_id INTEGER NOT NULL REFERENCES pets(pet_id),
  vet_id INTEGER NOT NULL REFERENCES vets(vet_id),
  appointment_time TIMESTAMP NOT NULL,
  reason VARCHAR(100)
);

-- the clinic's price list
CREATE TABLE treatments (
  treatment_id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL UNIQUE,
  price NUMERIC(8,2) NOT NULL
);

-- join table: one appointment can have many treatments,
-- and one treatment can show up in many appointments (many to many)
CREATE TABLE appointment_treatments (
  appointment_id INTEGER REFERENCES appointments(appointment_id),
  treatment_id INTEGER REFERENCES treatments(treatment_id),
  quantity INTEGER NOT NULL DEFAULT 1,
  PRIMARY KEY (appointment_id, treatment_id)
);
