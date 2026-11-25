# Interview Notes: Small Animal Vet Clinic

**Note:** this is a made-up interview. I didn't have a friend available to interview, so I wrote out a realistic conversation with a fictional vet tech to practice the research part of the project. The people, pets, and clinic are fictional.

**Who:** Jasmine, a vet tech at a small animal clinic with 3 vets
**Goal:** learn how the clinic keeps track of owners, pets, vets, visits, and billing, then turn that into a database

## The interview

**Q: Who are the main people and things you keep track of?**
Owners, their pets, our vets, appointments, and the treatments we bill for. We also scan microchips when a lost pet comes in.

**Q: Can one owner have more than one pet?**
All the time. We have families with 3 or 4 animals.

**Q: Can one pet have more than one owner?**
Sometimes a couple both bring the dog in, but we only keep one primary owner on file. That's who gets the bill and the reminder calls.

**Decision:** one owner to many pets. Each pet gets one `owner_id`. I left out co-owners to keep the design simple, the same way the publishing example left out movies.

**Q: How do microchips work?**
Each chip has a 15-digit number. One pet gets one chip, and a chip never moves to another pet. Not every pet has one.

**Decision:** one to one. `microchips.pet_id` is UNIQUE, so a pet can't have two chips. It's a separate table because many pets have no chip.

**Q: Does a pet always see the same vet?**
No. Whoever is free that day sees them. And each vet sees a lot of pets.

**Decision:** appointments sit between pets and vets. Each appointment has one `pet_id` and one `vet_id`.

**Q: What happens during an appointment?**
The vet does one or more things: an exam, vaccines, a nail trim, bloodwork. Each one is a line on the bill.

**Q: Is it the same list of services for everyone?**
Yes, we have a price list. A wellness exam is the same price for every pet.

**Decision:** many to many. One appointment can have many treatments, and one treatment shows up in many appointments. The `appointment_treatments` join table connects them, with a `quantity` column for things like 2 doses.

**Q: How do you tell vets apart in the system?**
By name, but the state license number is what's official. No two vets share one.

**Decision:** `license_number` is UNIQUE.

## Follow-up questions (after adding test data)

These came up while I was entering data. See `04_edit_schema.sql` for the fixes.

**Q: Where do you record a pet's weight?**
At every visit. Weight changes a lot, especially with puppies and older pets, so we track it over time.

**Fix:** I had `weight_lbs` on the `pets` table, which only holds one value. I moved it to `appointments` so each visit keeps its own weight.

**Q: How long are the notes for the reason of the visit?**
Sometimes a full paragraph if the owner explains a lot.

**Fix:** changed `reason` from VARCHAR(100) to TEXT.

**Q: Do your prices ever change?**
Every January. But an old bill should still show what the owner actually paid.

**Fix:** bills were looking up the current price from `treatments`, so a price change would rewrite old bills. I added `price_charged` to `appointment_treatments` to save the price at the time of the visit.

## Confirming the design

Walking through the diagram without the technical terms:

"One owner can have many pets, but each pet has one owner on file." Correct.
"A pet can have one chip at most." Correct.
"Any vet can see any pet, and each visit is one pet with one vet." Correct.
"One visit can include several services from the price list." Correct.
