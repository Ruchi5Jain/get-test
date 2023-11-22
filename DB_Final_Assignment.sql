--Here we are trying to create database for a therapy center where they can
--1. record list of therapies center provides
--2. record therapist name specialised in therapy
--3. Patient details
--4. appointment schedule for patients and therapist
CREATE TABLE Therapy_Master (
  therapy_id SERIAL PRIMARY KEY,
  therapy_name TEXT,
  therapy_active BOOL
);
CREATE TABLE Therapist_Master (
  therapist_id SERIAL PRIMARY KEY,
  therapist_name TEXT,
  therapist_phone TEXT,
  therapy_active BOOL
);

Create Table Patient_Master (
	patient_id Serial primary key,
	patient_FName Text,
	patient_LName Text,
	Patient_Phone Text,
	Patient_Address Text,
	Patient_active Bool
);

--this appointment table will have foriegn keys to all other tables 
--like therapy, Therapist, Patient master tables
CREATE TABLE therapy_appiontment(
appionment_id serial primary key ,
patient_id integer, 
therapy_id integer,
therapist_id integer,
appiontment_date date,
appiontment_time text,
FOREIGN KEY (patient_id) REFERENCES patient_master (patient_id),
FOREIGN KEY (therapy_id) REFERENCES therapy_master (therapy_id),
FOREIGN KEY (therapist_id) REFERENCES therapist_master (therapist_id)
);


-- this query will give results of therapist and therapy they 
--provides in therapy center
SELECT therapy_name,therapist_name from therapy_master
inner join therapist_master
on therapist_master . therapy_id = therapy_master . therapy_id
order by therapist_name ASC;

--Here we are trying to see individual therapy and specialised therapist name
SELECT therapy_name,therapist_name from therapy_master
inner join therapist_master
on therapist_master . therapy_id = therapy_master . therapy_id
where therapy_name = 'Speech' ;

--In this query we will get appointment details like which patient 
--at what time for what therapy and who will be the therapist.
select 
ta.appionment_id, pm.patient_fname || ' '|| pm.patient_lname as patient_name, tm.therapy_name, 
tpist.therapist_name , appiontment_date|| ' at '|| appiontment_time as appionment_window
from therapy_appiontment ta
left join patient_master pm on ta.patient_id = pm.patient_id 
left join therapy_master tm on ta.therapy_id = tm.therapy_id
left join therapist_master tpist on ta.therapist_id = tpist.therapist_id;

-- Here we will use group by clause to get therapy count
select 
tm.therapy_name, tpist.therapist_name, count(tm.therapy_name)
from therapy_appiontment ta
left join patient_master pm on ta.patient_id = pm.patient_id 
left join therapy_master tm on ta.therapy_id = tm.therapy_id
left join therapist_master tpist on ta.therapist_id = tpist.therapist_id
--where tm.therapy_name = 'Speech';
group by tm.therapy_name, tpist.therapist_name ;







