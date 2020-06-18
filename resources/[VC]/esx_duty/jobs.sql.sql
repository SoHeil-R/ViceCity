INSERT INTO `jobs` (name, label,whitelisted) VALUES
  ('offpolice','Off-Duty',1),
  ('offambulance','Off-Duty',1)
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  ('offpolice',0,'recruit','Cadet',0,'{}','{}'),
  ('offpolice',1,'officer','Police Officer I',0,'{}','{}'),
  ('offpolice',2,'officer','Police Officer II',0,'{}','{}'),
  ('offpolice',3,'officer','Police Officer III',0,'{}','{}'),
  ('offpolice',4,'lieutenant','Senior Lead Officer',0,'{}','{}'),
  ('offpolice',5,'sergeant','Sergeant',0,'{}','{}'),
  ('offpolice',6,'chef','Commander',0,'{}','{}'),
  ('offpolice',7,'boss','Deputy Chief',0,'{}','{}'),
  ('offpolice',8,'boss','Chief Of LSPD',0,'{}','{}'),
  ('offambulance',0,'ambulance','Rannade doctor',0,'{}','{}'),
  ('offambulance',1,'doctor','Doctor',0,'{}','{}'),
  ('offambulance',2,'chief_doctor','Rayis doctora',0,'{}','{}'),
  ('offambulance',3,'boss','Rais',0,'{}','{}')
;