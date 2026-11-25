-- fix 1: weight changes from visit to visit, so it belongs on the appointment, not the pet
ALTER TABLE appointments
ADD COLUMN weight_lbs NUMERIC(5,1);

UPDATE appointments SET weight_lbs = 61.5 WHERE appointment_id = 1;
UPDATE appointments SET weight_lbs = 9.5 WHERE appointment_id = 2;
UPDATE appointments SET weight_lbs = 78.4 WHERE appointment_id = 3;
UPDATE appointments SET weight_lbs = 8.1 WHERE appointment_id = 4;
UPDATE appointments SET weight_lbs = 62.0 WHERE appointment_id = 5;
UPDATE appointments SET weight_lbs = 24.6 WHERE appointment_id = 6;
UPDATE appointments SET weight_lbs = 3.2 WHERE appointment_id = 7;

ALTER TABLE pets
DROP COLUMN weight_lbs;

-- fix 2: vets write long notes, so 100 characters is too short
ALTER TABLE appointments
ALTER COLUMN reason SET DATA TYPE TEXT;

-- fix 3: prices change, so save what was actually charged at the visit
ALTER TABLE appointment_treatments
ADD COLUMN price_charged NUMERIC(8,2);

-- copy today's price list into every past visit
UPDATE appointment_treatments
SET price_charged = treatments.price
FROM treatments
WHERE treatments.treatment_id = appointment_treatments.treatment_id;

ALTER TABLE appointment_treatments
ALTER COLUMN price_charged SET NOT NULL;

-- fix 4: block bad numbers
ALTER TABLE treatments
ADD CONSTRAINT price_not_negative CHECK (price >= 0);

ALTER TABLE appointment_treatments
ADD CONSTRAINT quantity_at_least_one CHECK (quantity > 0);

ALTER TABLE appointment_treatments
ADD CONSTRAINT charged_not_negative CHECK (price_charged >= 0);

-- the clinic raises the exam price
UPDATE treatments
SET price = 70.00
WHERE name = 'Wellness exam';

-- old bills stay the same because they use price_charged
SELECT appointments.appointment_id, pets.name,
  SUM(appointment_treatments.price_charged * appointment_treatments.quantity) AS total_bill
FROM appointments
JOIN pets ON pets.pet_id = appointments.pet_id
JOIN appointment_treatments ON appointment_treatments.appointment_id = appointments.appointment_id
GROUP BY appointments.appointment_id, pets.name
ORDER BY appointments.appointment_id;
