-- one to many: how many pets each owner has
SELECT owners.first_name, owners.last_name, COUNT(pets.pet_id) AS pet_count
FROM owners
LEFT JOIN pets ON pets.owner_id = owners.owner_id
GROUP BY owners.owner_id, owners.first_name, owners.last_name
ORDER BY pet_count DESC;

-- one to one: each pet and its chip (LEFT JOIN keeps pets with no chip)
SELECT pets.name, pets.species, microchips.chip_number
FROM pets
LEFT JOIN microchips ON microchips.pet_id = pets.pet_id
ORDER BY pets.pet_id;

-- one pet, many vets: Rocky's visit history
SELECT pets.name, appointments.appointment_time, vets.last_name AS vet, appointments.reason
FROM appointments
JOIN pets ON pets.pet_id = appointments.pet_id
JOIN vets ON vets.vet_id = appointments.vet_id
WHERE pets.name = 'Rocky'
ORDER BY appointments.appointment_time;

-- many to many, side 1: every treatment in each appointment
SELECT appointments.appointment_id, pets.name, treatments.name AS treatment, treatments.price
FROM appointment_treatments
JOIN appointments ON appointments.appointment_id = appointment_treatments.appointment_id
JOIN pets ON pets.pet_id = appointments.pet_id
JOIN treatments ON treatments.treatment_id = appointment_treatments.treatment_id
ORDER BY appointments.appointment_id;

-- many to many, side 2: how many appointments used each treatment
SELECT treatments.name, COUNT(appointment_treatments.appointment_id) AS times_used
FROM treatments
LEFT JOIN appointment_treatments ON appointment_treatments.treatment_id = treatments.treatment_id
GROUP BY treatments.treatment_id, treatments.name
ORDER BY times_used DESC, treatments.name;
