connect
system/bdadmin
create user p1diego identified by diego;
create user p1bloqueado identified by bloqueado;
create user p1entrenador identified by entrenador;
create user p1controladorliga identified by controladorliga;
GRANT CREATE ANY VIEW TO p1diego;
grant connect, resource to p1diego;
grant connect, resource to p1bloqueado;
grant connect, resource to p1entrenador;
grant connect, resource to p1controladorliga;
connect p1diego/diego


create table patrocinador
(
   cif varchar(10) constraint pat_cif_pk primary key, 
   nombre varchar(25), 
   web varchar(25), 
   telefono varchar(20), 
   email varchar(30)
);
create table liga
(
   numdivision number(1),
   region varchar(20),
   numequipos number(3),
   fechaini date,
   telefono varchar(20),
   email varchar (30),
   constraint lig_div_reg_pk primary key (numdivision,region)
);
create table entrenador
(
   nickentrenador varchar(20) constraint ent_ent_pk primary key,
   nombre varchar(25), 
   apellido1 varchar(25), 
   telefono varchar(30), 
   edad number(2),
   email varchar (30)
);
create table equipo
(
   nickequipo varchar(20) constraint equ_equ_pk primary key, 
   numjugadores number (1) constraint equ_jug_ch check (numjugadores between 5 and 7), 
   procedencia varchar(30), 
   fechcreacion date,
   nickentrenador varchar(20) constraint equ_ent_fk references entrenador,
   numdivision number (1),
   region varchar(20),
   constraint equ_div_reg_fk foreign key (numdivision,region) references liga (numdivision,region)
);
create table patrocinar
(
   codpatrocinar varchar(20),
   importe number(10),
   nickequipo varchar (20) constraint patr_equ_fk references equipo, 
   cif varchar(10) constraint patr_cif_fk references patrocinador,
   meses number (4),
   constraint patr_equ_cif_imp_pk primary key (nickequipo,cif,importe)
);
create table dirigir 
(
    nickentrenador varchar(20) constraint dir_ent_fk references entrenador, 
    nickequipo varchar (20) constraint dir_equ_fk references equipo,
    constraint patr_equ_ent_pk primary key (nickequipo,nickentrenador)
);
create table jugador
(
   nickjugador varchar (20) constraint jug_jug_pk primary key,
   nickequipo varchar (20) constraint jug_equ_fk references equipo,
   nombre varchar(25), 
   apellido1 varchar(25), 
   telefono varchar(30), 
   edad number(2),
   posicion varchar(15) constraint jug_pos_ch check (posicion in('top','mid','adc','support','jungler','suplente'))
);
create table clasificacion
(
   numdivision number (1),
   region varchar (20), 
   puesto number (2),
   numvictorias number (2),
   numderrotas number (2),
   nickequipo varchar(20) constraint cla_equ_fk references equipo,
   constraint cla_div_reg_fk foreign key (numdivision,region) references liga (numdivision,region),
   constraint cla_div_reg_equ_pue_pk primary key(numdivision,region,nickequipo,puesto)   
);

create table mostrar
(
   numdivision number (1),
   region varchar (20), 
   puesto number (2) ,
   nickequipo varchar(20),
   constraint mos_div_req_equ_pue_fk foreign key (numdivision,region,nickequipo,puesto) references clasificacion(numdivision,region,nickequipo,puesto),
   constraint mos_div_reg_equ_pue_pk primary key(numdivision,region,nickequipo,puesto)
)
;
create table analista
(
   nickanalista varchar(20) constraint ana_ana_pk primary key,
   nombre varchar(25), 
   apellido1 varchar(25), 
   telefono varchar(30), 
   edad number(2),
   email varchar (30)
);
create table caster
(
   nickcaster varchar(20) constraint cas_cas_pk primary key,
   nombre varchar(25), 
   apellido1 varchar(25),
   telefono varchar(30), 
   edad number(2),
   email varchar (30)
);
create table comentarios
(
nickanalista varchar(20),
nickcaster varchar (20),
idiomacomentarios varchar(20),
constraint com_ana_cas_pk primary key (nickanalista,nickcaster),
constraint com_ana_fk foreign key (nickanalista) references analista (nickanalista),
constraint com_cas_fk foreign key (nickcaster) references caster (nickcaster)
);
create table partido
(
   codigopartido varchar(20),
   nickequipo1 varchar(20),
   nickequipo2 varchar(20),
   jornada number(2),
   fecha date,
   nickanalista varchar(20),
   nickcaster varchar(20),
   constraint par_equ1_equ2_cod_pk primary key (nickequipo1,nickequipo2,codigopartido),
   constraint par_equ1_fk foreign key (nickequipo1) references equipo (nickequipo),
   constraint par_ana_fk foreign key (nickanalista) references analista (nickanalista),
   constraint par_cas_fk foreign key (nickcaster) references caster (nickcaster)
);
create table estadisticas
(
   codigopartido varchar(20),
   nickequipo1 varchar(20),
   nickequipo2 varchar(20),
   equipoganador varchar(20),
   numkillsMVP number(3),
   nickmvp varchar(20),
   constraint est_equ_cod_pk primary key (equipoganador,codigopartido),
   constraint est_equ_fk foreign key (equipoganador) references equipo(nickequipo),
   constraint est_equ1_equ2_cod_fk foreign key (nickequipo1,nickequipo2,codigopartido) references partido(nickequipo1,nickequipo2,codigopartido)
);

COMMIT;