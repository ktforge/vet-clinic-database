-- every statement in this file should FAIL

-- a pet can't have a second chip (one to one)
INSERT INTO microchips (chip_number, pet_id, implant_date)
VALUES ('985112003456830', 1, '2026-11-01');

-- a pet can't belong to an owner who doesn't exist
INSERT INTO pets (owner_id, name, species)
VALUES (99, 'Ghost', 'cat');

-- two vets can't share a license number
INSERT INTO vets (first_name, last_name, license_number)
VALUES ('Fake', 'Vet', 'OH-VET-30481');

-- the same treatment can't be listed twice on one appointment (use quantity instead)
INSERT INTO appointment_treatments (appointment_id, treatment_id, quantity, price_charged)
VALUES (1, 1, 1, 65.00);

-- prices can't be negative
INSERT INTO treatments (name, price)
VALUES ('Free hug', -5.00);

-- quantity has to be at least 1
INSERT INTO appointment_treatments (appointment_id, treatment_id, quantity, price_charged)
VALUES (7, 1, 0, 70.00);

-- can't delete an owner who still has pets
DELETE FROM owners
WHERE owner_id = 1;
