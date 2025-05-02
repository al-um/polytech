drop table if exists etablissement;
drop table if exists prof;
drop table if exists niveau;
drop table if exists eleve;
drop table if exists exercice;
drop table if exists devoir;
drop table if exists notion;
drop table if exists contenu;
drop table if exists passage;

SET DateStyle TO 'European' ;

create table ETABLISSEMENT(		RNE varchar(8), 
								NOM varchar(50) not null, 
								LOCALITE varchar(30),
								constraint cp_etab Primary Key (RNE));

create table PROF(				IDP integer not null, 
								NOM varchar(20) not null, 
								ANNEE_NAISSANCE integer,
								RNE varchar(8),
								VILLE varchar(30),
								constraint cp_prof Primary Key (IDP),
								constraint ce_prof FOREIGN KEY (RNE) REFERENCES ETABLISSEMENT(RNE));

create table NIVEAU(			NIVEAU varchar(4), 
								constraint cp_niveau Primary Key (NIVEAU),
								constraint chk_niveau check (niveau in ('6eme', '5eme', '4eme','3eme')));

create table ELEVE(				IDEL integer not null, 
								NOM varchar(50) not null, 
								PRENOM varchar(30),
								COLLEGE varchar(8),
								NIVEAU varchar(4),
								constraint cp_eleve Primary Key (IDEL),
								constraint ce1_eleve FOREIGN KEY (COLLEGE) REFERENCES ETABLISSEMENT(RNE),
								constraint ce2_eleve FOREIGN KEY (NIVEAU) REFERENCES NIVEAU(NIVEAU));

create table EXERCICE(			IDEX integer not null, 
								CONTENU varchar(250), 
								NIVEAU varchar(4), 
								PROPRIETAIRE integer, 
								DATE_CREATION date,
								constraint cp_exercice primary key (IDEX),
								constraint ce1_exercice FOREIGN KEY (NIVEAU) REFERENCES NIVEAU(NIVEAU),
								constraint ce2_exercice FOREIGN KEY (PROPRIETAIRE) REFERENCES PROF(IDP));

create table DEVOIR(			IDD integer not null, 
								DATE_CREATION date, 
								PROF_CREATEUR integer not null, 
								NIVEAU varchar(4),
								constraint cp_devoir primary key (IDD),
								constraint ce1_devoir FOREIGN KEY (PROF_CREATEUR) REFERENCES PROF(IDP),
								constraint ce2_devoir FOREIGN KEY (NIVEAU) REFERENCES NIVEAU(NIVEAU));

create table NOTION(			IDEXO integer, 
								NOTION varchar(20),
								constraint cp_notion primary key (IDEXO),
								constraint ce1_notion FOREIGN KEY (IDEXO) REFERENCES EXERCICE(IDEX));


create table CONTENU(			IDD integer,
								IDEX integer,
								BAREME real,
								constraint cp_contenu primary key (IDD,IDEX),
								constraint ce1_contenu FOREIGN KEY (IDD) REFERENCES DEVOIR(IDD),
								constraint ce2_contenu FOREIGN KEY (IDEX) REFERENCES EXERCICE(IDEX));

create table PASSAGE(			IDD integer,
								IDEL integer,
								DATE_PASSAGE date,
								NOTE integer,
								constraint cp_passage primary key (IDD,IDEL,DATE_PASSAGE),
								constraint ce1_passage FOREIGN KEY (IDD) REFERENCES DEVOIR(IDD),
								constraint ce2_passage FOREIGN KEY (IDEL) REFERENCES ELEVE(IDEL));


insert into Etablissement values ('0341278E','College Arthur Rimbaud','Montpellier');
insert into Etablissement values ('0341280G','College Les Pins','Castries');
insert into Etablissement values ('0340008Z','College Victor Hugo','Bessan');
insert into Etablissement values ('0301094B','College Diderot','Nimes');
 

insert into Prof values (1,'James Bond',1972,'0341278E','Montpellier');
insert into Prof values (2,'Bioman',1970,'0341278E','Lunel');
insert into Prof values (3,'Superman',1978,'0341280G','Castries');
insert into Prof values (4,'Batman',1972,'0340008Z','Juvignac');
insert into Prof values (5,'Hulk',1979,'0340008Z','Montpellier');
insert into Prof values (6,'Wonder Woman',1983,'0341280G','Montpellier');
insert into Prof values (7,'Tintin',1974,'0340008Z','Grabels');
insert into Prof values (8,'Zorro',1972,'0340008Z','Castries');

insert into Niveau values('6eme');
insert into Niveau values('5eme');
insert into Niveau values('4eme');
insert into Niveau values('3eme');

insert into Eleve values (1,'RAMI','ALEXANDRE','0341278E','6eme');
insert into Eleve values (2,'DUPONT','MAXIME','0340008Z','4eme');
insert into Eleve values (3,'DUPONT','ARNAUD','0341278E','6eme');
insert into Eleve values (4,'VIGROS','HELENE','0341278E','6eme');	
insert into Eleve values (5,'GOMAZ','GILLE','0341280G','5eme');	
insert into Eleve values (6,'CHOUMIN','KHALIL','0340008Z','4eme');
insert into Eleve values (7,'MONTEO','ILONA','0340008Z','3eme');	
insert into Eleve values (8,'MONTEO','MILAN','0340008Z','5eme');

insert into Exercice values (1,'Calculer 2+3','6eme',2,'08/02/2019');
insert into Exercice values (2,'Developper 2(3x+5)','5eme',1,'07/01/2019');
insert into Exercice values (3,'Calculer (-3)-(2)','5eme',2,'10/01/2019');
insert into Exercice values (4,'Calculer la médiane de la série suivante : 12 - 14 - 15 - 19 -22 -25','5eme',1,'08/02/2019');
insert into Exercice values (5,'Tracer un triangle equilatéral de 6 cm de côte','6eme',3,'08/10/2018');
insert into Exercice values (6,'Calculer la longueur du segment [AB]','4eme',2,'10/11/2018');
insert into Exercice values (7,'Tracer l''image de A par la translation qui transforme B en C','4eme',2,'10/11/2018');
insert into Exercice values (8,'Simplifier l''expression suivante puis exprimer son double en fonction de x','4eme',2,'10/11/2018');
insert into Exercice values (9,'Calculer le triple de 9','6eme',2,'12/01/2019');
insert into Exercice values (10,'Effectuer les calculs suivants : 8 + 3 * 5 ; 17 - 3*2','6eme',5,'14/01/2019');
insert into Exercice values (11,'Developper l''expression suivante : (2x-5)²','3eme',5,'19/01/2019');	


insert into Devoir values (1,'14/02/2019',1,'6eme');
insert into Devoir values (2,'17/02/2019',1,'5eme');
insert into Devoir values (3,'17/02/2019',2,'4eme');
insert into Devoir values (4,'18/02/2019',1,'6eme');
insert into Devoir values (5,'20/02/2019',2,'5eme');
insert into Devoir values (6,'21/02/2019',3,'4eme');
insert into Devoir values (7,'21/02/2019',8,'4eme');
insert into Devoir values (8,'26/02/2019',4,'3eme');
insert into Devoir values (9,'28/02/2019',2,'3eme');
insert into Devoir values (10,'28/02/2019',5,'3eme');

insert into Notion values (1,'calcul numerique');
insert into Notion values (2,'calcul litteral');
insert into Notion values (3,'calcul numerique');
insert into Notion values (4,'calcul litteral');
insert into Notion values (5,'geometrie');
insert into Notion values (6,'geometrie');
insert into Notion values (7,'geometrie');
insert into Notion values (8,'calcul litteral');	
insert into Notion values (9,'calcul numerique');
insert into Notion values (10,'calcul numerique');
insert into Notion values (11,'calcul litteral');

insert into Contenu values (1,1,6);
insert into Contenu values (1,3,4);

insert into Contenu values (2,2,5);
insert into Contenu values (2,4,2);

insert into Contenu values (3,6,3);
insert into Contenu values (3,7,4);	
insert into Contenu values (3,8,3);	

insert into Contenu values (4,1,1);
insert into Contenu values (4,5,2);	
insert into Contenu values (4,9,1);	

insert into Contenu values (5,1,2);	
insert into Contenu values (5,3,5);	
insert into Contenu values (5,6,5);	
insert into Contenu values (5,2,3);		
insert into Contenu values (5,11,5);	

insert into Contenu values (6,1,3);	
insert into Contenu values (6,2,6);	
insert into Contenu values (6,4,5);	
insert into Contenu values (6,8,2);		

insert into Contenu values (7,2,3);	
insert into Contenu values (7,5,2);	


insert into Contenu values (8,5,2);	
insert into Contenu values (8,2,2);	
insert into Contenu values (8,7,2);	
insert into Contenu values (8,6,2);		
insert into Contenu values (8,11,2);	

insert into Contenu values (9,2,2);	
insert into Contenu values (9,4,2);	
insert into Contenu values (9,8,2);		
insert into Contenu values (9,11,4);

insert into Contenu values (10,1,2);	
insert into Contenu values (10,3,2);	
insert into Contenu values (10,6,2);		
insert into Contenu values (10,9,2);
insert into Contenu values (10,10,2);	
insert into Contenu values (10,4,2);


insert into PASSAGE values (1,1,'15/02/2019',5);
insert into PASSAGE values (1,3,'15/02/2019',6);
insert into PASSAGE values (1,4,'15/02/2019',4);	
insert into PASSAGE values (2,5,'18/02/2019',5);	
insert into PASSAGE values (2,2,'18/02/2019',6);	
insert into PASSAGE values (3,1,'20/02/2019',8);		
insert into PASSAGE values (3,2,'20/02/2019',8);	
insert into PASSAGE values (3,6,'20/02/2019',7);
insert into PASSAGE values (4,3,'23/02/2019',3);	
insert into PASSAGE values (5,5,'26/02/2019',14);	
insert into PASSAGE values (6,4,'28/02/2019',11);
insert into PASSAGE values (7,3,'22/02/2019',3);
insert into PASSAGE values (8,4,'27/02/2019',11);	
insert into PASSAGE values (9,4,'01/03/2019',11);	
insert into PASSAGE values (10,3,'28/02/2019',11);	

commit;
