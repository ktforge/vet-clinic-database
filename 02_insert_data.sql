-- owners (Maria Lopez has 3 pets to test one owner to many pets)
INSERT INTO owners (first_name, last_name, phone, email)
VALUES
  ('Maria', 'Lopez', '937-555-0141', 'maria.lopez@example.com'),
  ('James', 'Carter', '937-555-0187', 'jcarter@example.com'),
  ('Aisha', 'Bell', '937-555-0122', NULL),
  ('Tom', 'Nguyen', '937-555-0199', 'tom.nguyen@example.com');

-- pets
INSERT INTO pets (owner_id, name, species, breed, birth_date, weight_lbs)
VALUES
  (1, 'Rocky', 'dog', 'Boxer', '2019-04-12', 62.0),
  (1, 'Luna', 'cat', 'Domestic Shorthair', '2021-08-03', 9.5),
  (1, 'Peanut', 'rabbit', 'Holland Lop', '2023-02-20', 3.2),
  (2, 'Bear', 'dog', 'Labrador Retriever', '2016-11-30', 78.4),
  (3, 'Mochi', 'cat', 'Siamese', '2020-06-15', 8.1),
  (4, 'Ziggy', 'dog', 'Beagle', '2022-01-09', 24.6);

-- microchips (not every pet is chipped)
INSERT INTO microchips (chip_number, pet_id, implant_date)
VALUES
  ('985112003456781', 1, '2019-07-01'),
  ('985112003456799', 4, '2017-02-14'),
  ('985112003456812', 6, '2022-04-22');

-- vets
INSERT INTO vets (first_name, last_name, license_number)
VALUES
  ('Sarah', 'Kim', 'OH-VET-30481'),
  ('David', 'Okafor', 'OH-VET-31527'),
  ('Emily', 'Price', 'OH-VET-29966');

-- price list
INSERT INTO treatments (name, price)
VALUES
  ('Wellness exam', 65.00),
  ('Rabies vaccine', 28.00),
  ('DHPP vaccine', 32.00),
  ('FVRCP vaccine', 30.00),
  ('Nail trim', 15.00),
  ('Dental cleaning', 350.00),
  ('Bloodwork panel', 120.00);

-- appointments (Rocky sees two different vets, Dr. Kim sees several pets)
INSERT INTO appointments (pet_id, vet_id, appointment_time, reason)
VALUES
  (1, 1, '2026-03-04 09:00', 'Annual checkup'),
  (2, 1, '2026-03-04 09:30', 'Annual checkup'),
  (4, 2, '2026-04-10 14:00', 'Dental cleaning'),
  (5, 3, '2026-05-22 11:15', 'Vaccines due'),
  (1, 2, '2026-08-18 16:00', 'Limping on back leg'),
  (6, 1, '2026-09-02 10:45', 'Puppy shots follow up'),
  (3, 3, '2026-10-07 13:30', 'Nail trim');

-- treatments given at each appointment
INSERT INTO appointment_treatments (appointment_id, treatment_id, quantity)
VALUES
  (1, 1, 1),
  (1, 2, 1),
  (1, 3, 1),
  (2, 1, 1),
  (2, 4, 1),
  (3, 6, 1),
  (3, 7, 1),
  (4, 1, 1),
  (4, 4, 1),
  (5, 1, 1),
  (6, 3, 1),
  (6, 5, 1),
  (7, 5, 1);
