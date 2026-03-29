CREATE DATABASE agriculture_db;

DROP TABLE IF EXISTS user_roles CASCADE;
DROP TABLE IF EXISTS roles CASCADE;
DROP TABLE IF EXISTS users CASCADE;

CREATE TABLE roles (
 id SERIAL PRIMARY KEY,
 name VARCHAR(50) UNIQUE NOT NULL,
 description_fr VARCHAR(150),
 description_ar VARCHAR(150)
);

CREATE TABLE users (
 id SERIAL PRIMARY KEY,
 nom_fr VARCHAR(100) NOT NULL,
 nom_ar VARCHAR(100),
 prenom_fr VARCHAR(100) NOT NULL,
 prenom_ar VARCHAR(100),
 email VARCHAR(150) UNIQUE NOT NULL,
 password_hash TEXT NOT NULL,
 tel VARCHAR(30),
 status BOOLEAN DEFAULT TRUE,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_roles (
 user_id INT NOT NULL,
 role_id INT NOT NULL,

 PRIMARY KEY (user_id, role_id),

 CONSTRAINT fk_user
 FOREIGN KEY(user_id)
 REFERENCES users(id)
 ON DELETE CASCADE,

 CONSTRAINT fk_role
 FOREIGN KEY(role_id)
 REFERENCES roles(id)
 ON DELETE CASCADE
);

INSERT INTO roles(name,description_fr,description_ar) VALUES
('admin','Administrateur système','مدير النظام'),
('supervisor','Contrôleur','مراقب'),
('agent','Agent recenseur','عون الإحصاء');

INSERT INTO users(
 nom_fr,
 nom_ar,
 prenom_fr,
 prenom_ar,
 email,
 password_hash,
 tel
)
VALUES
(
 'Admin',
 'المدير',
 'System',
 'النظام',
 'admin@agri.dz',
 'hashed_password',
 '0550000000'
);

INSERT INTO user_roles(user_id,role_id)
VALUES (1,1);

INSERT INTO users(
 nom_fr, nom_ar,
 prenom_fr, prenom_ar,
 email, password_hash, tel
)
VALUES
('Benamar','بن عمر','Ali','علي','ali@agri.dz','hash','0551111111'),
('Brahimi','براهيمي','Karim','كريم','karim@agri.dz','hash','0552222222');

INSERT INTO user_roles(user_id,role_id)
VALUES
(2,3),
(3,3);

DROP TABLE IF EXISTS communes CASCADE;
DROP TABLE IF EXISTS wilayas CASCADE;

CREATE TABLE wilayas (
    id SERIAL PRIMARY KEY,
    code VARCHAR(10) UNIQUE NOT NULL,
    nom_fr VARCHAR(150) NOT NULL,
    nom_ar VARCHAR(150)
);

CREATE TABLE communes (
    id SERIAL PRIMARY KEY,
    wilaya_id INT NOT NULL,
    nom_fr VARCHAR(150) NOT NULL,
    nom_ar VARCHAR(150),

    CONSTRAINT fk_commune_wilaya
        FOREIGN KEY (wilaya_id)
        REFERENCES wilayas(id)
        ON DELETE CASCADE
);

CREATE INDEX idx_communes_wilaya ON communes(wilaya_id);

INSERT INTO wilayas(code, nom_fr, nom_ar) VALUES
('01','Adrar','أدرار'),
('02','Chlef','الشلف'),
('03','Laghouat','الأغواط'),
('04','Oum El Bouaghi','أم البواقي'),
('05','Batna','باتنة'),
('06','Béjaïa','بجاية'),
('07','Biskra','بسكرة'),
('08','Béchar','بشار'),
('09','Blida','البليدة'),
('10','Bouira','البويرة'),
('11','Tamanrasset','تمنراست'),
('12','Tébessa','تبسة'),
('13','Tlemcen','تلمسان'),
('14','Tiaret','تيارت'),
('15','Tizi Ouzou','تيزي وزو'),
('16','Alger','الجزائر'),
('17','Djelfa','الجلفة'),
('18','Jijel','جيجل'),
('19','Sétif','سطيف'),
('20','Saïda','سعيدة'),
('21','Skikda','سكيكدة'),
('22','Sidi Bel Abbès','سيدي بلعباس'),
('23','Annaba','عنابة'),
('24','Guelma','قالمة'),
('25','Constantine','قسنطينة'),
('26','Médéa','المدية'),
('27','Mostaganem','مستغانم'),
('28','M''Sila','المسيلة'),
('29','Mascara','معسكر'),
('30','Ouargla','ورقلة'),
('31','Oran','وهران'),
('32','El Bayadh','البيض'),
('33','Illizi','إليزي'),
('34','Bordj Bou Arréridj','برج بوعريريج'),
('35','Boumerdès','بومرداس'),
('36','El Tarf','الطارف'),
('37','Tindouf','تندوف'),
('38','Tissemsilt','تيسمسيلت'),
('39','El Oued','الوادي'),
('40','Khenchela','خنشلة'),
('41','Souk Ahras','سوق أهراس'),
('42','Tipaza','تيبازة'),
('43','Mila','ميلة'),
('44','Aïn Defla','عين الدفلى'),
('45','Naâma','النعامة'),
('46','Aïn Témouchent','عين تموشنت'),
('47','Ghardaïa','غرداية'),
('48','Relizane','غليزان'),
('49','Timimoun','تيميمون'),
('50','Bordj Badji Mokhtar','برج باجي مختار'),
('51','Ouled Djellal','أولاد جلال'),
('52','Béni Abbès','بني عباس'),
('53','In Salah','عين صالح'),
('54','In Guezzam','عين قزام'),
('55','Touggourt','تقرت'),
('56','Djanet','جانت'),
('57','El M''Ghair','المغير'),
('58','El Menia','المنيعة');

INSERT INTO communes(wilaya_id, nom_fr, nom_ar) VALUES
(1,'Talmine','تالمين'),
(2,'Tenes','تنس'),
(3,'Laghouat','الأغواط'),
(4,'Ain Beida','عين البيضاء'),
(5,'Batna','باتنة'),
(6,'Bejaia','بجاية'),
(7,'Biskra','بسكرة'),
(8,'Bechar','بشار'),
(9,'Blida','البليدة'),
(10,'Bouira','البويرة'),
(11,'Tamanrasset','تمنراست'),
(12,'Tebessa','تبسة'),
(13,'Tlemcen','تلمسان'),
(14,'Tiaret','تيارت'),
(15,'Tizi Ouzou','تيزي وزو'),
(16,'Alger Centre','الجزائر الوسطى'),
(17,'Djelfa','الجلفة'),
(18,'Jijel','جيجل'),
(19,'Setif','سطيف'),
(20,'Saida','سعيدة');

DROP TABLE IF EXISTS niveau_instruction CASCADE;

CREATE TABLE niveau_instruction(
 id SERIAL PRIMARY KEY,
 nom_fr VARCHAR(100) NOT NULL,
 nom_ar VARCHAR(100)
);

INSERT INTO niveau_instruction(nom_fr, nom_ar) VALUES
('Aucun','بدون'),
('Primaire','ابتدائي'),
('Moyen','متوسط'),
('Secondaire','ثانوي'),
('Universitaire','جامعي');

DROP TABLE IF EXISTS formation_agricole CASCADE;

CREATE TABLE formation_agricole(
 id SERIAL PRIMARY KEY,
 nom_fr VARCHAR(100) NOT NULL,
 nom_ar VARCHAR(100)
);

INSERT INTO formation_agricole(nom_fr, nom_ar) VALUES
('Aucun','بدون'),
('Perfectionnement','تكوين تكميلي'),
('Agent technique','تقني'),
('Agent technique spécialisé','تقني متخصص'),
('Technicien','تقني سامي'),
('Technicien supérieur','تقني سامي متخصص'),
('Ingénieur','مهندس'),
('Vétérinaire','طبيب بيطري'),
('Formation PRCHAT','تكوين PRCHAT');

DROP TABLE IF EXISTS statut_juridique CASCADE;

CREATE TABLE statut_juridique(
 id SERIAL PRIMARY KEY,
 nom_fr VARCHAR(150) NOT NULL,
 nom_ar VARCHAR(150)
);

INSERT INTO statut_juridique(nom_fr, nom_ar) VALUES
('Personne physique','شخص طبيعي'),
('Société civile','شركة مدنية'),
('SARL','شركة ذات مسؤولية محدودة'),
('EURL','مؤسسة ذات مسؤولية محدودة'),
('Coopérative','تعاونية'),
('Groupement','تجمع'),
('Location','إيجار'),
('Association','جمعية'),
('Partenariat','شراكة'),
('Sans statut juridique','بدون صفة قانونية'),
('Autre','أخرى');

DROP TABLE IF EXISTS type_accessibilite CASCADE;

CREATE TABLE type_accessibilite(
 id SERIAL PRIMARY KEY,
 nom_fr VARCHAR(150) NOT NULL,
 nom_ar VARCHAR(150)
);

INSERT INTO type_accessibilite(id, nom_fr, nom_ar) VALUES
(1,'Route nationale','طريق وطنية'),
(2,'Chemin de wilaya','طريق ولائية'),
(3,'Route communale','طريق بلدية'),
(4,'Piste rurale','مسلك ريفي'),
(5,'Piste agricole','مسلك فلاحي'),
(6,'Autre','أخرى');

drop table if exists mode_exploitation cascade;

CREATE TABLE mode_exploitation(
 id INT PRIMARY KEY,
 nom_fr VARCHAR(200) NOT NULL,
 nom_ar VARCHAR(200)
);

INSERT INTO mode_exploitation(id, nom_fr, nom_ar) VALUES
(1,'APFA','الاستصلاح في إطار APFA'),
(2,'EAC','مستثمرة فلاحية جماعية'),
(3,'EAI','مستثمرة فلاحية فردية'),
(4,'GCA','مستثمرة فلاحية جماعية'),
(5,'CDARS','التنمية الريفية CDARS'),
(6,'Concession CIM 108, CIM 1839','امتياز فلاحي'),
(7,'Nouvelle concession OTAS','امتياز جديد OTAS'),
(8,'Nouvelle concession ODAS','امتياز جديد ODAS'),
(9,'Exploitation sans titre','استغلال بدون سند'),
(10,'Ferme pilote','مزرعة نموذجية'),
(11,'Etablissement public (EPA, EPIC, EPE)','مؤسسة عمومية'),
(12,'Droit d’usage des forêts','حق استعمال الغابات'),
(13,'Inconnu','غير معروف');

DROP TABLE IF EXISTS statut_terre CASCADE;

CREATE TABLE statut_terre(
 id INT PRIMARY KEY,
 nom_fr VARCHAR(200) NOT NULL,
 nom_ar VARCHAR(200)
);

INSERT INTO statut_terre(id, nom_fr, nom_ar) VALUES
(1,'Melk personnel titré','ملك شخصي موثق'),
(2,'Melk personnel non titré','ملك شخصي غير موثق'),
(3,'Melk en indivision titré','ملك مشترك موثق'),
(4,'Melk en indivision non titré','ملك مشترك غير موثق'),
(5,'Domaine public','الملك العمومي'),
(6,'Domaine privé de l''Etat','ملك خاص للدولة'),
(7,'Wakf privé','وقف خاص'),
(8,'Wakf public','وقف عام'),
(9,'Inconnu','غير معروف');

DROP TABLE IF EXISTS type_superficie CASCADE;

CREATE TABLE type_superficie(
 id SERIAL PRIMARY KEY,
 nom_fr VARCHAR(150) NOT NULL,
 nom_ar VARCHAR(150),
 categorie VARCHAR(50)
);

INSERT INTO type_superficie(nom_fr, nom_ar, categorie) VALUES
('Cultures herbacées','محاصيل عشبية','SAU'),
('Terres en jachère','أراضي بور','SAU'),
('Cultures pérennes','محاصيل دائمة','SAU'),
('Prairies naturelles','مروج طبيعية','SAU'),
('Pacages et parcours','مراعي','SAT'),
('Surfaces improductives','مساحات غير منتجة','SAT'),
('Terres forestières','أراضي الغابات','SAT');

drop table if exists source_energie_type cascade;

CREATE TABLE source_energie_type(
 id INT PRIMARY KEY,
 nom_fr VARCHAR(150) NOT NULL,
 nom_ar VARCHAR(150)
);

INSERT INTO source_energie_type(id, nom_fr, nom_ar) VALUES
(1,'Réseau électrique','الشبكة الكهربائية'),
(2,'Groupe électrogène','مولد كهربائي'),
(3,'Énergie solaire','الطاقة الشمسية'),
(4,'Énergie éolienne','طاقة الرياح'),
(5,'Autres sources','مصادر أخرى');

DROP TABLE IF EXISTS categorie_culture CASCADE;

CREATE TABLE categorie_culture(
 id SERIAL PRIMARY KEY,
 nom_fr VARCHAR(150) NOT NULL,
 nom_ar VARCHAR(150)
);

INSERT INTO categorie_culture(nom_fr, nom_ar) VALUES
('Céréales','الحبوب'),
('Légumineuses sèches','البقول الجافة'),
('Cultures industrielles','المحاصيل الصناعية'),
('Cultures fourragères','المحاصيل العلفية'),
('Cultures maraîchères','الخضر'),
('Cultures condimentaires','التوابل'),
('Plantes aromatiques et médicinales','النباتات العطرية والطبية'),
('Autres cultures','محاصيل أخرى');

DROP TABLE IF EXISTS type_culture CASCADE;

CREATE TABLE type_culture(
 id SERIAL PRIMARY KEY,
 categorie_id INT NOT NULL,
 nom_fr VARCHAR(150) NOT NULL,
 nom_ar VARCHAR(150),

 CONSTRAINT fk_type_culture_categorie
 FOREIGN KEY (categorie_id)
 REFERENCES categorie_culture(id)
);

INSERT INTO type_culture(categorie_id, nom_fr, nom_ar) VALUES
(1,'Blé dur','قمح صلب'),
(1,'Blé tendre','قمح لين'),
(1,'Orge','شعير'),
(1,'Avoine','شوفان'),
(1,'Maïs grain','ذرة'),
(1,'Maïs fourrager','ذرة علفية'),
(1,'Sorgho','ذرة رفيعة'),
(1,'Mil','دخن'),
(1,'Triticale','تريتيكال');

INSERT INTO type_culture(categorie_id, nom_fr, nom_ar) VALUES
(2,'Pois chiche','حمص'),
(2,'Lentilles','عدس'),
(2,'Fève','فول'),
(2,'Féverole','فول علفي'),
(2,'Haricot sec','فاصوليا جافة'),
(2,'Pois sec','بازلاء جافة'),
(2,'Lupin','ترمس');

INSERT INTO type_culture(categorie_id, nom_fr, nom_ar) VALUES
(3,'Tournesol','عباد الشمس'),
(3,'Colza','سلجم زيتي'),
(3,'Soja','صوجا'),
(3,'Betterave sucrière','شمندر سكري'),
(3,'Tabac','تبغ'),
(3,'Coton','قطن'),
(3,'Tomate industrielle','طماطم صناعية');

INSERT INTO type_culture(categorie_id, nom_fr, nom_ar) VALUES
(4,'Luzerne','فصة'),
(4,'Sulla','سولا'),
(4,'Trèfle','برسيم'),
(4,'Ray grass','راي غراس'),
(4,'Orge fourragère','شعير علفي'),
(4,'Avoine fourragère','شوفان علفي'),
(4,'Maïs ensilage','ذرة سيلاج');

INSERT INTO type_culture(categorie_id, nom_fr, nom_ar) VALUES
(5,'Pomme de terre','بطاطا'),
(5,'Oignon','بصل'),
(5,'Ail','ثوم'),
(5,'Tomate','طماطم'),
(5,'Poivron','فلفل'),
(5,'Piment','فلفل حار'),
(5,'Aubergine','باذنجان'),
(5,'Courgette','كوسة'),
(5,'Concombre','خيار'),
(5,'Carotte','جزر'),
(5,'Navet','لفت'),
(5,'Betterave','شمندر'),
(5,'Chou','كرنب'),
(5,'Chou fleur','قرنبيط'),
(5,'Laitue','خس'),
(5,'Haricot vert','فاصوليا خضراء'),
(5,'Pastèque','بطيخ'),
(5,'Melon','شمام');

INSERT INTO type_culture(categorie_id, nom_fr, nom_ar) VALUES
(6,'Coriandre','قزبر'),
(6,'Persil','معدنوس'),
(6,'Cumin','كمون'),
(6,'Fenouil','شمر'),
(6,'Anis','يانسون');

INSERT INTO type_culture(categorie_id, nom_fr, nom_ar) VALUES
(7,'Romarin','إكليل الجبل'),
(7,'Thym','زعتر'),
(7,'Lavande','خزامى'),
(7,'Menthe','نعناع'),
(7,'Verveine','لويزة');

INSERT INTO type_culture(categorie_id, nom_fr, nom_ar) VALUES
(8,'Autres cultures','محاصيل أخرى');

DROP TABLE IF EXISTS type_arbre CASCADE;

CREATE TABLE type_arbre(
 id SERIAL PRIMARY KEY,
 nom_fr VARCHAR(150) NOT NULL,
 nom_ar VARCHAR(150)
);

INSERT INTO type_arbre(nom_fr, nom_ar) VALUES
('Olivier','زيتون'),
('Figuier','تين'),
('Agrumes','حمضيات'),
('Pommier','تفاح'),
('Amandier','لوز'),
('Palmier dattier','نخيل'),
('Grenadier','رمان'),
('Caroubier','خروب'),
('Autres arbres','أشجار أخرى');

DROP TABLE IF EXISTS type_animal CASCADE;

CREATE TABLE type_animal(
 id SERIAL PRIMARY KEY,
 nom_fr VARCHAR(150) NOT NULL,
 nom_ar VARCHAR(150)
);

INSERT INTO type_animal(nom_fr, nom_ar) VALUES
('Bovins','أبقار'),
('Ovins','أغنام'),
('Caprins','ماعز'),
('Camelins','إبل'),
('Equins','خيول'),
('Mulets','بغال'),
('Asins','حمير'),
('Cuniculture','أرانب');

DROP TABLE IF EXISTS categorie_bovin CASCADE;

CREATE TABLE categorie_bovin(
 id SERIAL PRIMARY KEY,
 nom_fr VARCHAR(150) NOT NULL,
 nom_ar VARCHAR(150)
);

INSERT INTO categorie_bovin(nom_fr, nom_ar) VALUES
('Vaches laitières BLM','أبقار الحلوب المتطورة'),
('Vaches laitières BLA','أبقار الحلوب المحسنة'),
('Vaches laitières BLL','أبقار الحلوب الحلية');

DROP TABLE IF EXISTS type_aviculture CASCADE;

CREATE TABLE type_aviculture(
 id SERIAL PRIMARY KEY,
 nom_fr VARCHAR(150) NOT NULL,
 nom_ar VARCHAR(150)
);

INSERT INTO type_aviculture(nom_fr, nom_ar) VALUES
('Poules','دجاج'),
('Dindes','ديك رومي'),
('Autre aviculture','دواجن أخرى');

DROP TABLE IF EXISTS type_ruche CASCADE;

CREATE TABLE type_ruche(
 id SERIAL PRIMARY KEY,
 nom_fr VARCHAR(150) NOT NULL,
 nom_ar VARCHAR(150)
);

INSERT INTO type_ruche(nom_fr, nom_ar) VALUES
('Ruches modernes','خلايا عصرية'),
('Ruches traditionnelles','خلايا تقليدية');

DROP TABLE IF EXISTS categorie_batiment CASCADE;

CREATE TABLE categorie_batiment(
 id SERIAL PRIMARY KEY,
 nom_fr VARCHAR(150) NOT NULL,
 nom_ar VARCHAR(150)
);

INSERT INTO categorie_batiment(nom_fr, nom_ar) VALUES
('Habitation','سكن'),
('Élevage','تربية المواشي'),
('Production','إنتاج'),
('Stockage','تخزين'),
('Transformation','تحويل'),
('Collecte','جمع');

DROP TABLE IF EXISTS type_batiment CASCADE;

CREATE TABLE type_batiment(
 id SERIAL PRIMARY KEY,
 nom_fr VARCHAR(150) NOT NULL,
 nom_ar VARCHAR(150),
 categorie_id INT,

 CONSTRAINT fk_type_batiment_categorie
 FOREIGN KEY (categorie_id)
 REFERENCES categorie_batiment(id)
);

INSERT INTO type_batiment(nom_fr, nom_ar, categorie_id) VALUES
('Bâtiment d’habitation','سكن',1),
('Bergerie','إسطبل الأغنام',2),
('Étable','إسطبل الأبقار',2),
('Poulailler','بيت الدواجن',2),
('Serre tunnel','بيت بلاستيكي نفق',3),
('Serre multi chapelle','بيت بلاستيكي متعدد',3),
('Bâtiment de stockage','مخزن',4),
('Chambre froide','غرفة تبريد',4),
('Unité de transformation','وحدة تحويل',5),
('Centre de collecte de lait','مركز جمع الحليب',6);

DROP TABLE IF EXISTS type_materiel CASCADE;

CREATE TABLE type_materiel(
 id SERIAL PRIMARY KEY,
 nom_fr VARCHAR(150) NOT NULL,
 nom_ar VARCHAR(150)
);

INSERT INTO type_materiel(nom_fr, nom_ar) VALUES
('Tracteur','جرار'),
('Moissonneuse batteuse','حصادة'),
('Motoculteur','آلة حرث صغيرة'),
('Charrue','محراث'),
('Cover crop','آلة تسوية'),
('Epandeur d’engrais','آلة نثر السماد'),
('Pulvérisateur','آلة رش'),
('Semoir','آلة بذر'),
('Arracheuse pomme de terre','آلة قلع البطاطا'),
('Motopompe','مضخة');

DROP TABLE IF EXISTS type_ouvrage_eau CASCADE;

CREATE TABLE type_ouvrage_eau(
 id SERIAL PRIMARY KEY,
 nom_fr VARCHAR(150) NOT NULL,
 nom_ar VARCHAR(150),
 categorie VARCHAR(50)
);

INSERT INTO type_ouvrage_eau(nom_fr, nom_ar, categorie) VALUES
('Barrage','سد','GPI'),
('Station de pompage','محطة ضخ','GPI'),
('Forage','بئر ارتوازي','PMH'),
('Puits','بئر','PMH'),
('Foggara','فقارة','PMH'),
('Source','عين ماء','PMH'),
('Petit barrage','سد صغير','PMH'),
('Retenue collinaire','بحيرة جبلية','PMH');

DROP TABLE IF EXISTS mode_irrigation CASCADE;

CREATE TABLE mode_irrigation(
 id SERIAL PRIMARY KEY,
 nom_fr VARCHAR(150) NOT NULL,
 nom_ar VARCHAR(150)
);

INSERT INTO mode_irrigation(nom_fr, nom_ar) VALUES
('Aspersion classique','رش'),
('Gravitaire','ري سطحي'),
('Epandage de crues','ري بالفيض'),
('Goutte à goutte','ري بالتنقيط'),
('Pivot','محور'),
('Enrouleur','مدفع ري'),
('Pluie artificielle','أمطار اصطناعية'),
('Foggara','فقارة'),
('Autre','أخرى');

DROP TABLE IF EXISTS mode_stockage_eau CASCADE;

CREATE TABLE mode_stockage_eau(
 id SERIAL PRIMARY KEY,
 nom_fr VARCHAR(150) NOT NULL,
 nom_ar VARCHAR(150)
);

INSERT INTO mode_stockage_eau(nom_fr, nom_ar) VALUES
('Bassin de stockage','حوض تخزين'),
('Réservoir / citerne','خزان'),
('Château d''eau','خزان مرتفع'),
('Retenue collinaire','بحيرة جبلية'),
('Barrage','سد'),
('Autre mode de stockage','طريقة تخزين أخرى');

DROP TABLE IF EXISTS type_travail CASCADE;

CREATE TABLE type_travail(
 id SERIAL PRIMARY KEY,
 nom_fr VARCHAR(150) NOT NULL,
 nom_ar VARCHAR(150),
 categorie VARCHAR(50)
);

INSERT INTO type_travail(nom_fr, nom_ar, categorie) VALUES
('Co-exploitants','مستثمرون مشاركون','familial'),
('Ouvriers permanents','عمال دائمون','salarié'),
('Ouvriers saisonniers','عمال موسميون','salarié'),
('Main d’œuvre familiale','عمل عائلي','familial');

drop table if exists type_temps_travail cascade;

CREATE TABLE type_temps_travail(
 id SERIAL PRIMARY KEY,
 nom_fr VARCHAR(50),
 nom_ar VARCHAR(50)
);

INSERT INTO type_temps_travail(nom_fr,nom_ar) VALUES
('Permanent','دائم'),
('Saisonnier','موسمي'),
('Occasionnel','عرضي');

drop table if exists sexe cascade;

CREATE TABLE sexe(
 id SERIAL PRIMARY KEY,
 nom_fr VARCHAR(20),
 nom_ar VARCHAR(20)
);

INSERT INTO sexe(nom_fr, nom_ar) VALUES
('Masculin','ذكر'),
('Féminin','أنثى');

drop table if exists type_assurance cascade;

CREATE TABLE type_assurance(
 id SERIAL PRIMARY KEY,
 nom_fr VARCHAR(50),
 nom_ar VARCHAR(50)
);

INSERT INTO type_assurance(nom_fr, nom_ar) VALUES
('CASNOS','كاسنوس'),
('CNAS','كنـاس');

drop table if exists nature_exploitant cascade;

CREATE TABLE nature_exploitant(
 id SERIAL PRIMARY KEY,
 nom_fr VARCHAR(50),
 nom_ar VARCHAR(50)
);

INSERT INTO nature_exploitant(nom_fr, nom_ar) VALUES
('Propriétaire','مالك'),
('Locataire','مستأجر'),
('Autre','أخرى');

DROP TABLE IF EXISTS type_activite CASCADE;

CREATE TABLE type_activite(
 id SERIAL PRIMARY KEY,
 nom_fr VARCHAR(100),
 nom_ar VARCHAR(100)
);

INSERT INTO type_activite(nom_fr,nom_ar) VALUES
('Production végétale','إنتاج نباتي'),
('Production animale','إنتاج حيواني'),
('Mixte','نشاط مختلط');

DROP TABLE IF EXISTS type_activite_exploitant CASCADE;

CREATE TABLE type_telephone(
 id SERIAL PRIMARY KEY,
 nom_fr VARCHAR(50),
 nom_ar VARCHAR(50)
);

INSERT INTO type_telephone(nom_fr,nom_ar) VALUES
('Fixe','هاتف ثابت'),
('Mobile','هاتف نقال');

DROP TABLE IF EXISTS exploitants CASCADE;

CREATE TABLE exploitants(

 id SERIAL PRIMARY KEY,

 nom_fr VARCHAR(150),
 nom_ar VARCHAR(150),

 prenom_fr VARCHAR(150),
 prenom_ar VARCHAR(150),

 sexe_id INT,

 date_naissance DATE,

 nin VARCHAR(50),
 nis VARCHAR(50),

 telephone VARCHAR(30),
 email VARCHAR(150),

 adresse_fr TEXT,
 adresse_ar TEXT,

 niveau_instruction_id INT,
 formation_agricole_id INT,

 inscrit_chambre_agri BOOLEAN,
 inscrit_chambre_peche BOOLEAN,
 inscrit_union_paysans BOOLEAN,
 inscrit_chambre_artisanat BOOLEAN,
 inscrit_chambre_commerce BOOLEAN,
 beneficie_dispositif_social BOOLEAN,

 type_assurance_id INT,
 num_securite_sociale VARCHAR(50),

 issu_famille_agricole BOOLEAN,
 est_exploitant_principal BOOLEAN,

 nb_coexploitants INT,

 nature_exploitant_id INT,

 FOREIGN KEY(niveau_instruction_id)
 REFERENCES niveau_instruction(id),

 FOREIGN KEY(formation_agricole_id)
 REFERENCES formation_agricole(id),

 FOREIGN KEY(sexe_id)
 REFERENCES sexe(id),

 FOREIGN KEY(type_assurance_id)
 REFERENCES type_assurance(id),

 FOREIGN KEY(nature_exploitant_id)
 REFERENCES nature_exploitant(id)

);

INSERT INTO exploitants(
 nom_fr, nom_ar,
 prenom_fr, prenom_ar,
 sexe_id,
 date_naissance,
 nin,
 nis,
 telephone,
 email,
 adresse_fr, adresse_ar,
 niveau_instruction_id,
 formation_agricole_id,
 inscrit_chambre_agri,
 inscrit_chambre_peche,
 inscrit_union_paysans,
 inscrit_chambre_artisanat,
 inscrit_chambre_commerce,
 beneficie_dispositif_social,
 type_assurance_id,
 num_securite_sociale,
 issu_famille_agricole,
 est_exploitant_principal,
 nb_coexploitants,
 nature_exploitant_id
) VALUES

('Benali','بن علي','Ahmed','أحمد',1,'1975-03-15','197503150012345','123456789012345','0550123456','ahmed.benali@mail.com','Tiaret','تيارت',3,2,TRUE,FALSE,TRUE,FALSE,FALSE,TRUE,1,'987654321',TRUE,TRUE,2,1),

('Kaci','قاسي','Fatima','فاطمة',2,'1982-07-22','198207220045678','223456789012345','0660456789','fatima.kaci@mail.com','Sougueur','سوقر',4,3,TRUE,FALSE,TRUE,FALSE,FALSE,FALSE,2,'987654322',TRUE,TRUE,1,1),

('Bouzid','بوزيد','Mohamed','محمد',1,'1968-11-10','196811100078912','323456789012345','0550789123','m.bouzid@mail.com','Frenda','فرندة',2,1,FALSE,FALSE,TRUE,FALSE,FALSE,TRUE,1,'987654323',TRUE,TRUE,3,2),

('Zerrouki','زروقي','Samira','سميرة',2,'1990-05-05','199005050012222','423456789012345','0670122223','samira.zerrouki@mail.com','Mahdia','المهدية',5,7,TRUE,FALSE,FALSE,FALSE,FALSE,FALSE,2,'987654324',FALSE,TRUE,0,1);

drop table if exists exploitation_accessibilite cascade;
DROP TABLE IF EXISTS sources_energie CASCADE;
drop table if exists blocks cascade;
DROP TABLE IF EXISTS exploitations CASCADE;

CREATE TABLE exploitations(

 id SERIAL PRIMARY KEY,

 exploitant_id INT NOT NULL,
 commune_id INT NOT NULL,

 nom_exploitation_fr VARCHAR(200),
 nom_exploitation_ar VARCHAR(200),

 district_fr VARCHAR(150),
 district_ar VARCHAR(150),

 statut_juridique_id INT,

 latitude DECIMAL(10,7),
 longitude DECIMAL(10,7),

 geom GEOMETRY(Point,4326),

 activite_exploitation_id INT,

 acces_reseau_electrique BOOLEAN,
 acces_reseau_telephonique BOOLEAN,

 type_telephone_id INT,

 acces_internet BOOLEAN,
 internet_agri BOOLEAN,

 eac_concession BOOLEAN,
 nb_exploitants_eac INT,

 logement_occupant BOOLEAN,
 nb_menages INT,

 superficie_batie DECIMAL(12,2),
 superficie_non_batie DECIMAL(12,2),

 CONSTRAINT fk_exploitation_exploitant
 FOREIGN KEY(exploitant_id)
 REFERENCES exploitants(id),

 CONSTRAINT fk_exploitation_commune
 FOREIGN KEY(commune_id)
 REFERENCES communes(id),

 CONSTRAINT fk_exploitation_statut
 FOREIGN KEY(statut_juridique_id)
 REFERENCES statut_juridique(id),

 CONSTRAINT fk_exploitation_activite
 FOREIGN KEY(activite_exploitation_id)
 REFERENCES type_activite(id),

 CONSTRAINT fk_exploitation_telephone
 FOREIGN KEY(type_telephone_id)
 REFERENCES type_telephone(id)
);

CREATE INDEX idx_exploitations_geom
ON exploitations
USING GIST (geom);

CREATE TABLE exploitation_accessibilite(
 exploitation_id INT,
 accessibilite_id INT,

 PRIMARY KEY (exploitation_id, accessibilite_id),

 CONSTRAINT fk_access_exploitation
 FOREIGN KEY(exploitation_id)
 REFERENCES exploitations(id),

 CONSTRAINT fk_access_type
 FOREIGN KEY(accessibilite_id)
 REFERENCES type_accessibilite(id)

);

CREATE TABLE sources_energie(
 exploitation_id INT,
 type_source_id INT,

 PRIMARY KEY (exploitation_id, type_source_id),

 CONSTRAINT fk_source_exploitation
 FOREIGN KEY(exploitation_id)
 REFERENCES exploitations(id),

 CONSTRAINT fk_source_type
 FOREIGN KEY(type_source_id)
 REFERENCES source_energie_type(id)
);

CREATE TABLE blocks(
 id SERIAL PRIMARY KEY,

 exploitation_id INT,

 mode_exploi_id INT,
 statut_terre_id INT,

 superficie DECIMAL(12,2),

 FOREIGN KEY(exploitation_id)
 REFERENCES exploitations(id),

 FOREIGN KEY(mode_exploi_id)
 REFERENCES mode_exploitation(id),

 FOREIGN KEY(statut_terre_id)
 REFERENCES statut_terre(id)

);

INSERT INTO exploitations(
 exploitant_id,
 commune_id,
 nom_exploitation_fr,
 nom_exploitation_ar,
 district_fr,
 district_ar,
 statut_juridique_id,
 latitude,
 longitude,
 geom,
 activite_exploitation_id,
 acces_reseau_electrique,
 acces_reseau_telephonique,
 type_telephone_id,
 acces_internet,
 internet_agri,
 eac_concession,
 nb_exploitants_eac,
 logement_occupant,
 nb_menages,
 superficie_batie,
 superficie_non_batie
) VALUES

(
1,1,
'Ferme Benali','مزرعة بن علي',
'Zone agricole nord','المنطقة الفلاحية الشمالية',
1,
35.3712000,1.3215000,
ST_SetSRID(ST_MakePoint(1.3215,35.3712),4326),
3,
TRUE,TRUE,
2,
TRUE,TRUE,
FALSE,0,
TRUE,1,
120.5,35.2
),

(
2,2,
'Exploitation Kaci','مستثمرة قاسي',
'District Sougueur','منطقة السوقر',
2,
35.1880000,1.2950000,
ST_SetSRID(ST_MakePoint(1.2950,35.1880),4326),
1,
TRUE,TRUE,
2,
TRUE,FALSE,
FALSE,0,
TRUE,2,
80.3,20.5
),

(
3,3,
'Ferme Bouzid','مزرعة بوزيد',
'Plaine Frenda','سهل فرندة',
1,
35.0610000,1.0480000,
ST_SetSRID(ST_MakePoint(1.0480,35.0610),4326),
2,
FALSE,TRUE,
2,
FALSE,FALSE,
TRUE,4,
TRUE,3,
60.0,12.5
),

(
4,4,
'Exploitation Zerrouki','مستثمرة زروقي',
'Mahdia Est','المهدية الشرقية',
3,
35.4320000,1.0830000,
ST_SetSRID(ST_MakePoint(1.0830,35.4320),4326),
3,
TRUE,TRUE,
2,
TRUE,TRUE,
FALSE,0,
TRUE,1,
150.0,40.0
);

INSERT INTO exploitation_accessibilite(
 exploitation_id,
 accessibilite_id
) VALUES

(1,1),
(2,2),
(3,3),
(4,2);

INSERT INTO sources_energie(
 exploitation_id,
 type_source_id
) VALUES

(1,1),
(1,2),

(2,1),

(3,3),

(4,1),
(4,2);

INSERT INTO blocks(
 exploitation_id,
 mode_exploi_id,
 statut_terre_id,
 superficie
)
VALUES

-- Exploitation 1 : Ferme Benali
(1,3,1,15.50),
(1,3,1,12.30),
(1,6,2,7.80),

-- Exploitation 2 : Exploitation Kaci
(2,3,1,10.00),
(2,3,3,5.60),

-- Exploitation 3 : Ferme Bouzid
(3,2,6,20.00),
(3,2,6,14.20),
(3,9,2,3.50),

-- Exploitation 4 : Exploitation Zerrouki
(4,6,1,18.75),
(4,6,1,9.40),
(4,12,5,6.00);

DROP TABLE IF EXISTS recensements CASCADE;
DROP TABLE IF EXISTS recensement_campagne CASCADE;
DROP TABLE IF EXISTS recensement_status CASCADE;

CREATE TABLE recensement_status(
 id SERIAL PRIMARY KEY,
 nom_fr VARCHAR(50),
 nom_ar VARCHAR(50)
);

CREATE TABLE recensement_campagne(
 id SERIAL PRIMARY KEY,
 nom_fr VARCHAR(150) NOT NULL,
 nom_ar VARCHAR(150),
 annee INT NOT NULL UNIQUE,
 date_debut DATE,
 date_fin DATE
);

CREATE TABLE recensements(
 id SERIAL PRIMARY KEY,
 campagne_id INT NOT NULL,
 exploitation_id INT NOT NULL,
 recenseur_id INT,
 controleur_id INT,
 date_recensement DATE,
 date_controle DATE,
 status_id INT,

 CONSTRAINT fk_recensement_campagne
 FOREIGN KEY(campagne_id)
 REFERENCES recensement_campagne(id),

 CONSTRAINT fk_recensement_exploitation
 FOREIGN KEY(exploitation_id)
 REFERENCES exploitations(id),

 CONSTRAINT fk_recensement_recenseur
 FOREIGN KEY(recenseur_id)
 REFERENCES users(id),

 CONSTRAINT fk_recensement_controleur
 FOREIGN KEY(controleur_id)
 REFERENCES users(id),

 CONSTRAINT fk_recensement_status
 FOREIGN KEY(status_id)
 REFERENCES recensement_status(id),

 CONSTRAINT unique_recensement
 UNIQUE(campagne_id, exploitation_id)
);

INSERT INTO recensement_status(id, nom_fr, nom_ar) VALUES
(1,'En cours','قيد الإنجاز'),
(2,'Recensé','تم الإحصاء'),
(3,'Contrôlé','تم المراقبة'),
(4,'Validé','تم الاعتماد'),
(5,'Rejeté','مرفوض');

INSERT INTO recensement_campagne(
 nom_fr,
 nom_ar,
 annee,
 date_debut,
 date_fin
)
VALUES
(
'Recensement Agricole 2025',
'الإحصاء الفلاحي 2025',
2025,
'2025-01-01',
'2025-12-31'
);

INSERT INTO recensements(
 campagne_id,
 exploitation_id,
 recenseur_id,
 controleur_id,
 date_recensement,
 status_id
)
VALUES
(1,1,2,NULL,'2025-03-01',2),
(1,2,2,NULL,'2025-03-02',2),
(1,3,3,NULL,'2025-03-03',2),
(1,4,3,NULL,'2025-03-04',2);

DROP TABLE IF EXISTS superficies CASCADE;
DROP TABLE IF EXISTS cultures CASCADE;
DROP TABLE IF EXISTS arbres CASCADE;

CREATE TABLE superficies(
 recensement_id INT,
 type_superficie_id INT,
 surface_sec DECIMAL(12,2),
 surface_irrigue DECIMAL(12,2),

 PRIMARY KEY (recensement_id, type_superficie_id),

 FOREIGN KEY(recensement_id)
 REFERENCES recensements(id),

 FOREIGN KEY(type_superficie_id)
 REFERENCES type_superficie(id)
);

CREATE TABLE cultures(
 recensement_id INT,
 type_culture_id INT,
 surface_sec DECIMAL(12,2),
 surface_irrigue DECIMAL(12,2),
 surface_intercalaire DECIMAL(12,2),

 PRIMARY KEY (recensement_id, type_culture_id),

 FOREIGN KEY(recensement_id)
 REFERENCES recensements(id),

 FOREIGN KEY(type_culture_id)
 REFERENCES type_culture(id)
);

CREATE TABLE arbres(
 recensement_id INT,
 type_arbre_id INT,
 nombre INT,

 PRIMARY KEY (recensement_id, type_arbre_id),

 FOREIGN KEY(recensement_id)
 REFERENCES recensements(id),

 FOREIGN KEY(type_arbre_id)
 REFERENCES type_arbre(id)
);

INSERT INTO superficies VALUES
(1,1,20,5),
(1,2,10,0),
(1,3,3,0);

INSERT INTO cultures VALUES
(1,1,10,2,0),
(1,2,5,1,0),
(1,3,4,0,0);

INSERT INTO arbres VALUES
(1,1,120),
(1,2,50),
(1,3,30);

DROP TABLE IF EXISTS cheptel CASCADE;

CREATE TABLE cheptel(
 recensement_id INT,
 animal_type_id INT,
 nombre_total INT,
 nb_femelle INT,

 PRIMARY KEY(recensement_id, animal_type_id),

 FOREIGN KEY(recensement_id)
 REFERENCES recensements(id),

 FOREIGN KEY(animal_type_id)
 REFERENCES type_animal(id)
);

DROP TABLE IF EXISTS bovins CASCADE;

CREATE TABLE bovins(
 recensement_id INT,
 categorie_bovin_id INT,
 nombre INT,

 PRIMARY KEY(recensement_id, categorie_bovin_id),

 FOREIGN KEY(recensement_id)
 REFERENCES recensements(id),

 FOREIGN KEY(categorie_bovin_id)
 REFERENCES categorie_bovin(id)
);

DROP TABLE IF EXISTS aviculture CASCADE;

CREATE TABLE aviculture(
 recensement_id INT,
 type_aviculture_id INT,
 nb_ponte INT,
 nb_chaire INT,

 PRIMARY KEY(recensement_id, type_aviculture_id),

 FOREIGN KEY(recensement_id)
 REFERENCES recensements(id),

 FOREIGN KEY(type_aviculture_id)
 REFERENCES type_aviculture(id)
);

DROP TABLE IF EXISTS apiculture CASCADE;

CREATE TABLE apiculture(
 recensement_id INT,
 type_ruche_id INT,
 nb_ruches_total INT,
 nb_ruches_pleine INT,

 PRIMARY KEY(recensement_id, type_ruche_id),

 FOREIGN KEY(recensement_id)
 REFERENCES recensements(id),

 FOREIGN KEY(type_ruche_id)
 REFERENCES type_ruche(id)
);

INSERT INTO cheptel(
 recensement_id,
 animal_type_id,
 nombre_total,
 nb_femelle
)
VALUES
(1,2,120,80),   -- Ovins
(1,3,45,30),    -- Caprins
(1,4,12,8),     -- Camelins
(1,5,6,4),      -- Equins
(1,8,20,12);    -- Cuniculture

INSERT INTO bovins(
 recensement_id,
 categorie_bovin_id,
 nombre
)
VALUES
(1,1,15),  -- BLM
(1,2,10),  -- BLA
(1,3,8);   -- BLL

INSERT INTO aviculture(
 recensement_id,
 type_aviculture_id,
 nb_ponte,
 nb_chaire
)
VALUES
(1,1,200,50),   -- Poules
(1,2,20,10),    -- Dindes
(1,3,30,15);    -- Autres volailles

INSERT INTO apiculture(
 recensement_id,
 type_ruche_id,
 nb_ruches_total,
 nb_ruches_pleine
)
VALUES
(1,1,40,30),   -- Ruches modernes
(1,2,15,8);    -- Ruches traditionnelles

DROP TABLE IF EXISTS batiments CASCADE;

CREATE TABLE batiments(
 recensement_id INT,
 type_batiment_id INT,
 nombre INT,
 surface DECIMAL(12,2),

 PRIMARY KEY(recensement_id, type_batiment_id),

 FOREIGN KEY(recensement_id)
 REFERENCES recensements(id),

 FOREIGN KEY(type_batiment_id)
 REFERENCES type_batiment(id)
);

DROP TABLE IF EXISTS materiels CASCADE;

CREATE TABLE materiels(
 recensement_id INT,
 type_materiel_id INT,
 nombre INT,

 PRIMARY KEY(recensement_id, type_materiel_id),

 FOREIGN KEY(recensement_id)
 REFERENCES recensements(id),

 FOREIGN KEY(type_materiel_id)
 REFERENCES type_materiel(id)
);

DROP TABLE IF EXISTS main_oeuvre CASCADE;

CREATE TABLE main_oeuvre(
 recensement_id INT,
 type_travail_id INT,
 sexe_id INT,
 type_temps_id INT,
 nb INT,

 PRIMARY KEY(recensement_id,type_travail_id,sexe_id,type_temps_id),

 FOREIGN KEY(recensement_id)
 REFERENCES recensements(id),

 FOREIGN KEY(type_travail_id)
 REFERENCES type_travail(id),

 FOREIGN KEY(sexe_id)
 REFERENCES sexe(id),

 FOREIGN KEY(type_temps_id)
 REFERENCES type_temps_travail(id)
);

DROP TABLE IF EXISTS menage_agricole CASCADE;

CREATE TABLE menage_agricole(
 recensement_id INT PRIMARY KEY,
 nb_personnes INT,
 nb_adultes INT,
 nb_enfants INT,

 FOREIGN KEY(recensement_id)
 REFERENCES recensements(id)
);

INSERT INTO batiments(
 recensement_id,
 type_batiment_id,
 nombre,
 surface
)
VALUES
(1,1,1,120),   -- habitation
(1,2,2,300),   -- bergerie
(1,3,1,250),   -- étable
(1,5,3,450),   -- serre tunnel
(1,7,1,180);   -- bâtiment stockage

INSERT INTO materiels(
 recensement_id,
 type_materiel_id,
 nombre
)
VALUES
(1,1,2),   -- tracteurs
(1,2,1),   -- moissonneuse
(1,3,3),   -- motoculteur
(1,6,2),   -- épandeur engrais
(1,10,4);  -- motopompe

INSERT INTO main_oeuvre(
 recensement_id,
 type_travail_id,
 sexe_id,
 type_temps_id,
 nb
)
VALUES
(1,1,1,1,1),   -- exploitant homme
(1,4,2,1,1),   -- aide familiale femme
(1,2,1,1,2),   -- ouvriers permanents hommes
(1,3,1,2,5),   -- ouvriers saisonniers hommes
(1,3,2,2,3);   -- ouvriers saisonniers femmes

INSERT INTO menage_agricole(
 recensement_id,
 nb_personnes,
 nb_adultes,
 nb_enfants
)
VALUES
(1,6,4,2);

DROP TABLE IF EXISTS ouvrages_eau CASCADE;

CREATE TABLE ouvrages_eau(
 recensement_id INT,
 type_ouvrage_id INT,
 nombre INT,
 PRIMARY KEY(recensement_id, type_ouvrage_id),

 FOREIGN KEY(recensement_id)
 REFERENCES recensements(id),

 FOREIGN KEY(type_ouvrage_id)
 REFERENCES type_ouvrage_eau(id)
);

DROP TABLE IF EXISTS irrigation CASCADE;

CREATE TABLE irrigation(
 recensement_id INT,
 mode_irrigation_id INT,
 surface DECIMAL(12,2),

 PRIMARY KEY(recensement_id, mode_irrigation_id),

 FOREIGN KEY(recensement_id)
 REFERENCES recensements(id),

 FOREIGN KEY(mode_irrigation_id)
 REFERENCES mode_irrigation(id)
);

DROP TABLE IF EXISTS intrants CASCADE;

CREATE TABLE intrants(

 recensement_id INT PRIMARY KEY,
 semences_selectionnees BOOLEAN,
 semences_certifiees BOOLEAN,
 bio BOOLEAN,
 semences_ferme BOOLEAN,
 engrais_azotes BOOLEAN,
 engrais_phosphates BOOLEAN,
 engrais_mineraux BOOLEAN,
 fumier_organique BOOLEAN,
 produits_phytosanitaires BOOLEAN,

 FOREIGN KEY(recensement_id)
 REFERENCES recensements(id)
);

INSERT INTO ouvrages_eau VALUES
(1,1,1),   -- barrage
(1,3,2),   -- forage
(1,4,1);   -- puits

INSERT INTO irrigation VALUES
(1,1,20),   -- aspersion
(1,4,15),   -- goutte à goutte
(1,5,10);   -- pivot

INSERT INTO intrants VALUES
(
1,
TRUE,
FALSE,
FALSE,
TRUE,
TRUE,
TRUE,
FALSE,
TRUE,
TRUE
);

