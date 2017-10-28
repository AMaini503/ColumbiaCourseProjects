CREATE DATABASE  IF NOT EXISTS `hw3` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `hw3`;
-- MySQL dump 10.13  Distrib 5.7.17, for Linux (x86_64)
--
-- Host: localhost    Database: hw3
-- ------------------------------------------------------
-- Server version	5.7.19-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Faculty`
--

DROP TABLE IF EXISTS `Faculty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Faculty` (
  `UNI` varchar(12) NOT NULL,
  `pay_grade` int(11) NOT NULL,
  `title` varchar(20) NOT NULL,
  PRIMARY KEY (`UNI`),
  CONSTRAINT `fk_Faculty_uni` FOREIGN KEY (`UNI`) REFERENCES `Person` (`UNI`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Faculty`
--

LOCK TABLES `Faculty` WRITE;
/*!40000 ALTER TABLE `Faculty` DISABLE KEYS */;
INSERT INTO `Faculty` VALUES ('ALAS-1',5,'Adjunct Professor'),('AUTU-1',4,'Adjunct Professor'),('BABO-1',4,'Assistant Professor'),('BURO-1',1,'Assistant Professor'),('CAST-1',3,'Assistant Professor'),('CHMI-1',4,'Adjunct Professor'),('COZA-1',4,'Senior Prof'),('DEGL-1',5,'Adjunct Professor'),('DENO-1',3,'Adjunct Professor'),('EAGU-1',3,'Adjunct Professor'),('EDNI-1',5,'Adjunct Professor'),('ENOP-1',3,'Adjunct Professor'),('FALU-1',2,'Senior Prof'),('GACO-1',5,'Assistant Professor'),('GOLE-1',4,'Adjunct Professor'),('GOVI-1',2,'Senior Prof'),('HABE-2',2,'Assistant Professor'),('HADE-1',5,'Adjunct Professor'),('IZOC-1',5,'Senior Prof'),('KUKI-1',1,'Senior Prof'),('LELU-1',3,'Senior Prof'),('LLKY-1',3,'Adjunct Professor'),('LYSH-1',1,'Adjunct Professor'),('MCHE-1',3,'Assistant Professor'),('MCMA-1',2,'Assistant Professor'),('MESC-1',5,'Senior Prof'),('MIFR-1',1,'Assistant Professor'),('MOZS-1',1,'Assistant Professor'),('O\'GE-1',3,'Assistant Professor'),('OLCA-1',2,'Adjunct Professor'),('OTFL-1',2,'Senior Prof'),('OTTI-1',4,'Assistant Professor'),('PATH-1',3,'Adjunct Professor'),('PENO-1',3,'Adjunct Professor'),('POGR-1',4,'Assistant Professor'),('PRWA-1',4,'Senior Prof'),('RIHA-1',5,'Assistant Professor'),('SEMA-1',2,'Senior Prof'),('SIFI-1',4,'Assistant Professor'),('SLME-1',5,'Senior Prof'),('STFA-1',2,'Assistant Professor'),('STZE-1',3,'Senior Prof'),('TIAN-1',1,'Assistant Professor'),('TODA-1',3,'Senior Prof'),('UPEV-1',4,'Senior Prof'),('WAAL-1',5,'Adjunct Professor'),('WAGL-1',3,'Assistant Professor'),('WEEN-1',2,'Assistant Professor'),('WEFE-1',4,'Senior Prof'),('WHBO-1',4,'Assistant Professor');
/*!40000 ALTER TABLE `Faculty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Person`
--

DROP TABLE IF EXISTS `Person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Person` (
  `UNI` varchar(12) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `department` varchar(32) NOT NULL,
  PRIMARY KEY (`UNI`),
  KEY `fk_Person_dept_idx` (`department`),
  CONSTRAINT `fk_Person_dept` FOREIGN KEY (`department`) REFERENCES `department` (`dname`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Person`
--

LOCK TABLES `Person` WRITE;
/*!40000 ALTER TABLE `Person` DISABLE KEYS */;
INSERT INTO `Person` VALUES ('ABAD-1','Abramov','Adler','aabramov0@nbcnews.com','Anthropology'),('AIAN-1','Ailsbury','Andros','aailsbury1i@php.net','Electrical Engineering'),('AKAN-1','Akaster','Anica','aakaster14@noaa.gov','Digital Marketting'),('ALAS-1','Alkins','Ashley','aalkins6j@de.vu','Physics'),('ALZA-1','Allon','Zared','zallon2j@intel.com','Mathematics'),('ANBR-1','Anniwell','Brendis','banniwell4@csmonitor.com','Anthropology'),('ANLU-1','Antonucci','Luelle','lantonuccih@washingtonpost.com','Business Administration'),('APOB-1','Apthorpe','Obidiah','oapthorpe1y@qq.com','Ethnicity and Race'),('ASGA-1','Ashington','Gayle','gashington58@illinois.edu','Electrical Engineering'),('AUTU-1','Austwick','Tully','taustwick5v@admin.ch','Criminal Defense'),('BAAR-1','Baskerfield','Arlen','abaskerfield1x@mediafire.com','Estate Planning'),('BABO-1','Bailey','Bobby','bbailey6x@msu.edu','Finance Management'),('BADE-1','Barbie','Delmer','dbarbiem@ucoz.ru','Computer Science'),('BAZE-1','Baldini','Zebedee','zbaldiniu@mlb.com','Criminal Defense'),('BEBR-1','Bebbell','Brok','bbebbell47@furl.net','Computer Science'),('BEFA-1','Bein','Falito','fbein49@youku.com','Finance Management'),('BELO-1','Beckley','Lorens','lbeckley3h@bbb.org','Tax'),('BETA-1','Bearward','Tamiko','tbearward5j@discuz.net','Physics'),('BEVA-1','Bellham','Vaughan','vbellham4c@pagesperso-orange.fr','Ethnicity and Race'),('BEWI-1','Benmore','Winfield','wbenmore1r@tumblr.com','Estate Planning'),('BLJI-1','Blackburn','Jill','jblackburn2p@joomla.org','Mathematics'),('BLKE-1','Blew','Keslie','kblew55@php.net','Philosophy'),('BOBU-1','Bouskill','Burton','bbouskill1t@topsy.com','Estate Planning'),('BOPR-1','Bonnaire','Prince','pbonnaire4r@networkadvertising.org','Ethnicity and Race'),('BRAU-1','Breslau','Aurthur','abreslau4y@berkeley.edu','Anthropology'),('BRAV-1','Brann','Avictor','abrann1q@ucoz.com','Estate Planning'),('BRQU-1','Brangan','Quill','qbrangan1c@weebly.com','Digital Marketting'),('BUCA-1','Bullent','Carla','cbullent3l@stanford.edu','Tax'),('BULU-1','Bumpas','Lucio','lbumpast@netlog.com','Computer Science'),('BURO-1','Bumford','Ronni','rbumford5w@liveinternet.ru','Digital Marketting'),('CABR-1','Castagnaro','Brien','bcastagnaro4p@shop-pro.jp','Tax'),('CACL-1','Cantu','Claudia','ccantu1v@so-net.ne.jp','Estate Planning'),('CADE-1','Cappleman','Devonne','dcapplemani@list-manage.com','Business Administration'),('CADO-1','Cartledge','Donaugh','dcartledge1w@cafepress.com','Estate Planning'),('CAST-1','Capell','Stephan','scapell6i@phoca.cz','Physics'),('CEMA-1','Ceyssen','Mata','mceyssen11@goo.ne.jp','Criminal Defense'),('CHAL-1','Chave','Alisun','achave53@cdbaby.com','Computer Science'),('CHDE-1','Churching','Delinda','dchurching17@icio.us','Digital Marketting'),('CHFR-1','Christophers','Frants','fchristophers13@guardian.co.uk','Criminal Defense'),('CHJE-1','Chippindall','Jeanelle','jchippindall4u@livejournal.com','Digital Marketting'),('CHME-1','Chiddy','Mellie','mchiddy2n@usa.gov','Mathematics'),('CHME-2','Chaimson','Merna','mchaimson4d@shareasale.com','Physics'),('CHMI-1','Chatwin','Mirilla','mchatwin6l@admin.ch','Tax'),('CIDW-1','Cicculini','Dwain','dcicculini4z@google.de','Physics'),('CLNO-1','Clemensen','Noam','nclemensenj@cdc.gov','Business Administration'),('COBR-1','Cobain','Bridget','bcobain2s@t.co','Philosophy'),('COKA-1','Cosely','Kay','kcosely1a@twitter.com','Digital Marketting'),('CORE-1','Coulsen','Reginald','rcoulsen4j@amazon.co.uk','Electrical Engineering'),('COZA-1','Coneybeer','Zahara','zconeybeer6w@wordpress.com','Computer Science'),('CRKE-1','Crowcombe','Kesley','kcrowcombe4t@ucsd.edu','Philosophy'),('CRNI-1','Crucetti','Nicoline','ncrucetti3z@house.gov','Physics'),('CZJO-1','Czapla','Joellyn','jczapla3r@rambler.ru','Business Administration'),('DAJA-1','Danes','Jamal','jdanes3v@gov.uk','Criminal Defense'),('DANI-1','Dauney','Niels','ndauneyb@opera.com','Business Administration'),('DASA-1','Daniels','Sarette','sdaniels4b@sfgate.com','Business Administration'),('DEAL-1','Derrick','Alexis','aderrick15@studiopress.com','Digital Marketting'),('DEAL-2','De Filippo','Alexi','adefilippo3t@examiner.com','Tax'),('DEGL-1','Demsey','Glyn','gdemsey5x@123-reg.co.uk','Digital Marketting'),('DENO-1','De Roeck','Nonie','nderoeck6f@chron.com','Philosophy'),('DEPA-1','de Glanville','Parry','pdeglanville46@tripod.com','Ethnicity and Race'),('DOWE-1','Dooley','Wendel','wdooley44@howstuffworks.com','Finance Management'),('DUBR-1','Dun','Brigitte','bdun27@friendfeed.com','Ethnicity and Race'),('DUMA-1','Dunklee','May','mdunklee3@cornell.edu','Anthropology'),('DURO-1','Dunbar','Roby','rdunbar4v@google.ru','Computer Science'),('DYJE-1','Dyke','Jerrome','jdyke43@comsenz.com','Physics'),('DYJO-1','Dyka','Jorrie','jdyka9@prlog.org','Anthropology'),('DYLI-1','Dyble','Lion','ldyble3e@photobucket.com','Tax'),('DZJA-1','Dziwisz','Jacki','jdziwisz3u@woothemes.com','Mathematics'),('EAGU-1','Ealden','Gus','gealden5m@sbwire.com','Anthropology'),('EDED-1','Edens','Edan','eedensd@earthlink.net','Business Administration'),('EDME-1','Edwinson','Melisse','medwinson19@mysql.com','Digital Marketting'),('EDNI-1','Edworthie','Nicoline','nedworthie5k@uol.com.br','Anthropology'),('EMRU-1','Emerson','Russell','remerson40@google.co.uk','Business Administration'),('ENOP-1','Endean','Ophelie','oendean6t@people.com.cn','Estate Planning'),('EWCA-1','Ewdale','Catherine','cewdale5g@photobucket.com','Mathematics'),('FACA-1','Fancet','Carly','cfancet2k@usa.gov','Mathematics'),('FALU-1','Favill','Lucine','lfavill6n@surveymonkey.com','Electrical Engineering'),('FECO-1','Felgate','Corrine','cfelgate21@deviantart.com','Ethnicity and Race'),('FIKA-1','Fishenden','Kania','kfishenden3y@dyndns.org','Computer Science'),('FIMA-1','Filipczynski','Mario','mfilipczynski29@desdev.cn','Finance Management'),('FOMI-1','Follitt','Miltie','mfollittn@dailymotion.com','Computer Science'),('FORO-1','Forsbey','Roselin','rforsbeyg@house.gov','Business Administration'),('FOSH-1','Folkes','Shawna','sfolkes1e@wisc.edu','Electrical Engineering'),('FRAL-1','Freiberg','Alisun','afreiberg1l@google.com.br','Electrical Engineering'),('FRGA-1','Fransinelli','Gael','gfransinelli1f@webeden.co.uk','Electrical Engineering'),('FRKE-1','Franck','Kendell','kfranckp@cornell.edu','Computer Science'),('FRNI-1','Frend','Nissie','nfrend1p@hao123.com','Estate Planning'),('GACO-1','Gammett','Cortney','cgammett5z@shop-pro.jp','Electrical Engineering'),('GASA-1','Gaddes','Sam','sgaddes45@xinhuanet.com','Electrical Engineering'),('GEEA-1','Geraud','Earvin','egeraud3i@jigsy.com','Tax'),('GICH-1','Giabuzzi','Chad','cgiabuzzi2r@mayoclinic.com','Mathematics'),('GLAN-1','Glaister','Andeee','aglaister2q@tripod.com','Mathematics'),('GLAV-1','Gleadhell','Ava','agleadhell48@unc.edu','Electrical Engineering'),('GOLE-1','Goodlip','Leonelle','lgoodlip64@illinois.edu','Estate Planning'),('GOVI-1','Gorges','Vivia','vgorges6s@acquirethisname.com','Estate Planning'),('GRLO-1','Greswell','Louisette','lgreswell2w@technorati.com','Philosophy'),('GRTI-1','Grassick','Tilda','tgrassick3g@google.co.jp','Tax'),('GRTO-1','Greenhall','Toddy','tgreenhall3s@umich.edu','Electrical Engineering'),('HAAL-1','Halgarth','Alexandr','ahalgarth3b@cbc.ca','Physics'),('HAAN-1','Hanney','Annadiane','ahanney3f@quantcast.com','Tax'),('HABE-1','Hannah','Benjie','bhannah2i@weebly.com','Mathematics'),('HABE-2','Harpur','Benjie','bharpur6b@noaa.gov','Mathematics'),('HABR-1','Halligan','Brodie','bhalliganf@taobao.com','Business Administration'),('HADE-1','Harraway','Deeanne','dharraway6c@twitpic.com','Mathematics'),('HAPE-1','Habbon','Perice','phabbon24@intel.com','Ethnicity and Race'),('HEBE-1','Heister','Bernette','bheister1g@bloglovin.com','Electrical Engineering'),('HEEU-1','Hess','Eugine','ehess3p@biglobe.ne.jp','Mathematics'),('HEJA-1','Healey','Janela','jhealey3w@discovery.com','Business Administration'),('HEKE-1','Hempshall','Kermie','khempshall1k@wunderground.com','Electrical Engineering'),('HOAB-1','Howsan','Abbie','ahowsan4i@princeton.edu','Finance Management'),('HOFR-1','Hoofe','Frankie','fhoofe2h@go.com','Finance Management'),('HOFR-2','Hoyles','Francyne','fhoyles41@pinterest.com','Business Administration'),('HOMO-1','Hogbin','Moria','mhogbinw@google.cn','Criminal Defense'),('HOMU-1','Howsin','Mufinella','mhowsin3q@google.com.hk','Mathematics'),('HUCA-1','Hupka','Carry','chupka5b@google.ru','Anthropology'),('IFMA-1','Ife','Mala','mife2l@aboutads.info','Mathematics'),('IZOC-1','Izkovitz','Octavius','oizkovitz5n@goo.gl','Business Administration'),('JANA-1','Jankin','Nate','njankine@unesco.org','Business Administration'),('JEHE-1','Jeavon','Hernando','hjeavon4x@tripadvisor.com','Estate Planning'),('JODI-1','Joao','Dieter','djoao22@wisc.edu','Ethnicity and Race'),('JOMA-1','Joska','Malachi','mjoska16@miitbeian.gov.cn','Digital Marketting'),('KECH-1','Kellogg','Chrissie','ckelloggk@merriam-webster.com','Computer Science'),('KEJI-1','Keysel','Jilly','jkeysel20@marketwatch.com','Ethnicity and Race'),('KODO-1','Korn','Doll','dkorn23@goo.ne.jp','Ethnicity and Race'),('KRBR-1','Kroch','Britta','bkroch5h@forbes.com','Criminal Defense'),('KUKI-1','Kurton','Kippie','kkurton6k@privacy.gov.au','Tax'),('LARA-1','Laurisch','Raynard','rlaurisch37@merriam-webster.com','Physics'),('LEKE-1','Leverington','Keir','kleverington6@foxnews.com','Anthropology'),('LELU-1','Lesurf','Ludvig','llesurf66@360.cn','Ethnicity and Race'),('LERI-1','Leythley','Rice','rleythley3a@nba.com','Physics'),('LIAN-1','Linder','Anna','alinder4l@mayoclinic.com','Business Administration'),('LIWA-1','Lighterness','Warden','wlighterness57@rakuten.co.jp','Philosophy'),('LLKY-1','Llop','Kynthia','kllop6q@redcross.org','Philosophy'),('LOJA-1','Loiterton','Jamaal','jloiterton54@newyorker.com','Criminal Defense'),('LYSH-1','Lynagh','Sheela','slynagh5r@vkontakte.ru','Computer Science'),('MABE-1','MacGow','Bethena','bmacgow2d@twitter.com','Finance Management'),('MABO-1','Matuszyk','Bourke','bmatuszyk5a@tripadvisor.com','Criminal Defense'),('MACA-1','Maciejak','Candace','cmaciejak4m@pcworld.com','Digital Marketting'),('MACH-1','Mabson','Che','cmabson25@ebay.com','Ethnicity and Race'),('MAEL-1','Mackison','Elizabeth','emackison10@opensource.org','Criminal Defense'),('MAGI-1','Mars','Gillan','gmars4h@earthlink.net','Business Administration'),('MAME-1','Maginn','Mel','mmaginn51@blogger.com','Digital Marketting'),('MARE-1','Maltster','Reinaldos','rmaltstery@desdev.cn','Criminal Defense'),('MARE-2','Mapes','Reggie','rmapes3x@blog.com','Tax'),('MARH-1','Marsay','Rhiamon','rmarsay2u@sina.com.cn','Philosophy'),('MARO-1','MacGill','Rorke','rmacgill2t@indiegogo.com','Philosophy'),('MCHE-1','McGarrie','Hersch','hmcgarrie62@wordpress.com','Estate Planning'),('MCMA-1','McGlashan','Martyn','mmcglashan6d@ebay.co.uk','Mathematics'),('MEGI-1','Meeking','Giorgi','gmeekingv@phpbb.com','Criminal Defense'),('MEPA-1','Merfin','Paolo','pmerfin2x@reverbnation.com','Philosophy'),('MESC-1','Menier','Scarface','smenier6a@csmonitor.com','Finance Management'),('MIFR-1','Mitchener','Friedrick','fmitchener69@skyrock.com','Finance Management'),('MIJE-1','Minigo','Jereme','jminigo2o@sourceforge.net','Mathematics'),('MILA-1','Mityushin','Lazaro','lmityushin36@mediafire.com','Physics'),('MILI-1','Mitten','Lindie','lmitten12@geocities.com','Criminal Defense'),('MOAR-1','Monteith','Artemus','amonteith3k@japanpost.jp','Tax'),('MODI-1','Morland','Dionisio','dmorland5f@wikispaces.com','Finance Management'),('MODO-1','Mogra','Dominica','dmogra4f@ucoz.com','Criminal Defense'),('MONE-1','Moniker','Nettie','nmoniker5@feedburner.com','Anthropology'),('MOTI-1','Monketon','Timmy','tmonketonz@dyndns.org','Criminal Defense'),('MOZS-1','Moulsdale','Zsa zsa','zmoulsdale5o@mapy.cz','Business Administration'),('MULO-1','Murphey','Lon','lmurphey2m@weebly.com','Mathematics'),('MUOL-1','Muskett','Olympe','omuskett2f@icq.com','Finance Management'),('NABR-1','Nast','Bride','bnast4n@mail.ru','Finance Management'),('NAJA-1','Naden','Jasmine','jnaden2g@icq.com','Finance Management'),('O\'GE-1','O\'Lagene','Gerianne','golagene6e@skyrock.com','Philosophy'),('O\'HE-1','O\'Dwyer','Hetty','hodwyer3m@surveymonkey.com','Physics'),('O\'SH-1','O\'Shaughnessy','Sharron','soshaughnessy5e@amazonaws.com','Criminal Defense'),('OLCA-1','Olczyk','Cassondra','colczyk65@hc360.com','Ethnicity and Race'),('OTDE-1','Otham','Denver','dotham2@scientificamerican.com','Anthropology'),('OTFL-1','Ottey','Floria','fottey68@lulu.com','Finance Management'),('OTTI-1','Otham','Timmy','totham67@so-net.ne.jp','Ethnicity and Race'),('OXGO-1','Oxtarby','Gordan','goxtarby26@wikia.com','Ethnicity and Race'),('PAAK-1','Pardi','Akim','apardi31@vk.com','Philosophy'),('PAME-1','Partlett','Merrick','mpartlett8@usa.gov','Anthropology'),('PARO-1','Patrick','Roxine','rpatrick3j@wiley.com','Tax'),('PATH-1','Pattison','Thalia','tpattison5u@dailymail.co.uk','Criminal Defense'),('PEKE-1','Pesek','Keith','kpesek2e@admin.ch','Finance Management'),('PENO-1','Percifer','Norine','npercifer6u@slate.com','Digital Marketting'),('PIMA-1','Pichmann','Mariquilla','mpichmann4k@geocities.com','Digital Marketting'),('POBR-1','Poultney','Brand','bpoultney4w@is.gd','Anthropology'),('POGR-1','Poel','Grady','gpoel5s@comsenz.com','Computer Science'),('PRMA-1','Prebble','Margarita','mprebble33@vinaora.com','Physics'),('PRWA-1','Presley','Waly','wpresley60@nps.gov','Electrical Engineering'),('PUCA-1','Pudan','Carilyn','cpudan3o@japanpost.jp','Digital Marketting'),('PUGA-1','Purrington','Garth','gpurrington5c@ft.com','Computer Science'),('RAHO-1','Rawles','Horten','hrawles30@mit.edu','Philosophy'),('RAJA-1','Raithby','Jany','jraithby1h@fema.gov','Electrical Engineering'),('REAA-1','Renowden','Aaren','arenowdenl@sogou.com','Computer Science'),('RIDE-1','Rivel','Dee dee','drivel2y@indiatimes.com','Philosophy'),('RIHA-1','Rintoul','Harald','hrintoul6r@go.com','Ethnicity and Race'),('RINE-1','Riccard','Nevile','nriccard4a@wsj.com','Digital Marketting'),('ROCA-1','Roseborough','Carry','croseborough1n@sphinn.com','Electrical Engineering'),('RODU-1','Roskruge','Dulciana','droskrugea@google.ca','Business Administration'),('ROGA-1','Rohmer','Gabriell','grohmer3n@tinypic.com','Philosophy'),('SAAD-1','Salleir','Adler','asalleir1m@dot.gov','Electrical Engineering'),('SCAR-1','Schimann','Arlana','aschimann1s@multiply.com','Estate Planning'),('SCLE-1','Scholte','Leann','lscholte1b@cdbaby.com','Digital Marketting'),('SCLI-1','Scheu','Lilyan','lscheu2v@behance.net','Philosophy'),('SEMA-1','Seivertsen','Mathew','mseivertsen6p@ebay.com','Philosophy'),('SHAL-1','Sharpin','Algernon','asharpin1@cnn.com','Anthropology'),('SHHA-1','Sherrock','Harrie','hsherrock7@seesaa.net','Anthropology'),('SHMA-1','Shwenn','Marisa','mshwenn38@guardian.co.uk','Physics'),('SHSI-1','Shimwall','Sibilla','sshimwall2z@barnesandnoble.com','Philosophy'),('SHVA-1','Shackesby','Valencia','vshackesby1z@meetup.com','Ethnicity and Race'),('SIEM-1','Sillito','Emiline','esillito1o@guardian.co.uk','Estate Planning'),('SIFI-1','Simoneau','Field','fsimoneau5p@mit.edu','Business Administration'),('SION-1','Simonett','Onfre','osimonett4q@unicef.org','Electrical Engineering'),('SIPA-1','Simione','Paolo','psimione4e@cisco.com','Physics'),('SKLU-1','Skellorne','Luz','lskellorne42@mit.edu','Finance Management'),('SLME-1','Slaymaker','Mechelle','mslaymaker5t@1688.com','Criminal Defense'),('SMKE-1','Smales','Kevon','ksmales1j@phoca.cz','Electrical Engineering'),('SPEL-1','Sparrow','Eleen','esparrow4g@umn.edu','Tax'),('SPHU-1','Sparry','Huberto','hsparry34@amazon.com','Physics'),('SPMO-1','Spalding','Moria','mspaldingr@simplemachines.org','Computer Science'),('STFA-1','Styan','Fara','fstyan5q@army.mil','Computer Science'),('STIL-1','Stickel','Ilario','istickelo@disqus.com','Computer Science'),('STZE-1','Standley','Zebadiah','zstandley6h@msu.edu','Physics'),('SUDO-1','Sumbler','Dori','dsumbler1d@census.gov','Digital Marketting'),('SWEL-1','Swainson','Elvin','eswainson4o@wikispaces.com','Anthropology'),('TAAL-1','Tatum','Alan','atatum3c@freewebs.com','Tax'),('TARA-1','Tathacott','Rancell','rtathacott4s@dropbox.com','Digital Marketting'),('TAWE-1','Taffrey','Weylin','wtaffrey2a@com.com','Finance Management'),('TIAN-1','Timpany','Anna-diana','atimpany5y@hugedomains.com','Digital Marketting'),('TIBU-1','Tiley','Burnard','btiley3d@yale.edu','Tax'),('TODA-1','Tonsley','Damon','dtonsley6g@so-net.ne.jp','Philosophy'),('TOHO-1','Toffaloni','Hoebart','htoffaloni28@paginegialle.it','Finance Management'),('TOKE-1','Towle','Kelila','ktowlec@oracle.com','Business Administration'),('TRST-1','Tranckle','Stewart','stranckle39@instagram.com','Physics'),('UPEV-1','Upjohn','Evangelina','eupjohn5l@bbb.org','Anthropology'),('VAEL-1','Varah','Ellie','evarah2c@instagram.com','Finance Management'),('VARI-1','Van Zon','Richard','rvanzonq@ask.com','Computer Science'),('VECH-1','Vedenyapin','Chris','cvedenyapin5d@blogger.com','Tax'),('VEEL-1','Vesco','Else','evesco56@adobe.com','Anthropology'),('VEKI-1','Verick','Kit','kvericks@pagesperso-orange.fr','Computer Science'),('VEOR-1','Verheijden','Orran','overheijden50@wsj.com','Computer Science'),('VIRI-1','Videler','Richmond','rvideler1u@usda.gov','Estate Planning'),('VOBE-1','Vondrys','Beverlie','bvondrys35@slideshare.net','Physics'),('WAAL-1','Warry','Allsun','awarry6m@themeforest.net','Tax'),('WAEZ-1','Wasbey','Eziechiele','ewasbey2b@usgs.gov','Finance Management'),('WAGL-1','Wadworth','Gloriana','gwadworth6o@salon.com','Finance Management'),('WEEN-1','Weddeburn','Enos','eweddeburn6v@netscape.com','Tax'),('WEFE-1','Welden','Felicio','fwelden63@scientificamerican.com','Estate Planning'),('WEIG-1','Wesson','Ignacio','iwesson32@ox.ac.uk','Physics'),('WEJO-1','Wentworth','Joellyn','jwentworth59@spiegel.de','Ethnicity and Race'),('WHBE-1','Whatman','Bennett','bwhatman52@fc2.com','Mathematics'),('WHBO-1','Whyffen','Boone','bwhyffen61@ning.com','Electrical Engineering'),('WIBR-1','Winborn','Brynna','bwinborn5i@tumblr.com','Tax'),('WILA-1','Wink','Lauretta','lwink18@theatlantic.com','Digital Marketting'),('YAAL-1','Yateman','Alan','ayatemanx@sitemeter.com','Criminal Defense');
/*!40000 ALTER TABLE `Person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `School`
--

DROP TABLE IF EXISTS `School`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `School` (
  `sid` varchar(12) NOT NULL,
  `sname` varchar(45) NOT NULL,
  PRIMARY KEY (`sid`),
  UNIQUE KEY `sname_UNIQUE` (`sname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `School`
--

LOCK TABLES `School` WRITE;
/*!40000 ALTER TABLE `School` DISABLE KEYS */;
INSERT INTO `School` VALUES ('3','Arts'),('5','Business & Management'),('1','Engineering'),('4','Law '),('2','Natural Sciences');
/*!40000 ALTER TABLE `School` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Student`
--

DROP TABLE IF EXISTS `Student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Student` (
  `UNI` varchar(12) NOT NULL,
  `year` int(11) NOT NULL,
  PRIMARY KEY (`UNI`),
  CONSTRAINT `fk_table1_uni` FOREIGN KEY (`UNI`) REFERENCES `Person` (`UNI`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Student`
--

LOCK TABLES `Student` WRITE;
/*!40000 ALTER TABLE `Student` DISABLE KEYS */;
INSERT INTO `Student` VALUES ('ABAD-1',2004),('AIAN-1',2004),('AKAN-1',2014),('ALZA-1',1992),('ANBR-1',2013),('ANLU-1',2008),('APOB-1',1996),('ASGA-1',2017),('BAAR-1',2008),('BADE-1',2006),('BAZE-1',1996),('BEBR-1',2004),('BEFA-1',1997),('BELO-1',1998),('BETA-1',2010),('BEVA-1',2013),('BEWI-1',2013),('BLJI-1',1997),('BLKE-1',2016),('BOBU-1',2004),('BOPR-1',1999),('BRAU-1',2003),('BRAV-1',1994),('BRQU-1',1990),('BUCA-1',1998),('BULU-1',2016),('CABR-1',2004),('CACL-1',2008),('CADE-1',1994),('CADO-1',2017),('CEMA-1',2008),('CHAL-1',1998),('CHDE-1',2015),('CHFR-1',2012),('CHJE-1',2009),('CHME-1',1998),('CHME-2',2005),('CIDW-1',2001),('CLNO-1',1997),('COBR-1',2016),('COKA-1',2005),('CORE-1',2017),('CRKE-1',1998),('CRNI-1',2003),('CZJO-1',1995),('DAJA-1',1992),('DANI-1',1997),('DASA-1',2012),('DEAL-1',2011),('DEAL-2',2000),('DEPA-1',2015),('DOWE-1',1998),('DUBR-1',1990),('DUMA-1',2014),('DURO-1',2005),('DYJE-1',2010),('DYJO-1',2007),('DYLI-1',1990),('DZJA-1',2006),('EDED-1',1996),('EDME-1',1992),('EMRU-1',1990),('EWCA-1',2000),('FACA-1',1999),('FECO-1',1999),('FIKA-1',2009),('FIMA-1',1992),('FOMI-1',1994),('FORO-1',2008),('FOSH-1',2017),('FRAL-1',2009),('FRGA-1',2015),('FRKE-1',2010),('FRNI-1',2015),('GASA-1',2004),('GEEA-1',2001),('GICH-1',1991),('GLAN-1',2011),('GLAV-1',2011),('GRLO-1',1999),('GRTI-1',1995),('GRTO-1',2017),('HAAL-1',2004),('HAAN-1',1995),('HABE-1',1993),('HABR-1',2008),('HAPE-1',2002),('HEBE-1',1995),('HEEU-1',1993),('HEJA-1',2003),('HEKE-1',2017),('HOAB-1',2005),('HOFR-1',2004),('HOFR-2',2005),('HOMO-1',2001),('HOMU-1',2008),('HUCA-1',1991),('IFMA-1',2001),('JANA-1',1992),('JEHE-1',1997),('JODI-1',1993),('JOMA-1',2008),('KECH-1',2003),('KEJI-1',2011),('KODO-1',1997),('KRBR-1',2008),('LARA-1',2011),('LEKE-1',2001),('LERI-1',1993),('LIAN-1',2011),('LIWA-1',1998),('LOJA-1',1997),('MABE-1',2005),('MABO-1',2014),('MACA-1',2014),('MACH-1',2008),('MAEL-1',2015),('MAGI-1',2017),('MAME-1',2009),('MARE-1',1999),('MARE-2',2008),('MARH-1',2001),('MARO-1',1992),('MEGI-1',2017),('MEPA-1',1995),('MIJE-1',2004),('MILA-1',2004),('MILI-1',2009),('MOAR-1',2007),('MODI-1',2002),('MODO-1',2016),('MONE-1',1994),('MOTI-1',1996),('MULO-1',1999),('MUOL-1',1995),('NABR-1',2013),('NAJA-1',2000),('O\'HE-1',2014),('O\'SH-1',2004),('OTDE-1',2005),('OXGO-1',1994),('PAAK-1',2015),('PAME-1',2003),('PARO-1',2016),('PEKE-1',2015),('PIMA-1',1994),('POBR-1',1996),('PRMA-1',1999),('PUCA-1',1992),('PUGA-1',1998),('RAHO-1',2012),('RAJA-1',2003),('REAA-1',1997),('RIDE-1',1999),('RINE-1',1995),('ROCA-1',2016),('RODU-1',2003),('ROGA-1',2012),('SAAD-1',1995),('SCAR-1',1991),('SCLE-1',1991),('SCLI-1',1999),('SHAL-1',2008),('SHHA-1',2016),('SHMA-1',1995),('SHSI-1',2016),('SHVA-1',2006),('SIEM-1',2008),('SION-1',2006),('SIPA-1',2002),('SKLU-1',1996),('SMKE-1',1993),('SPEL-1',2007),('SPHU-1',2014),('SPMO-1',1999),('STIL-1',1991),('SUDO-1',1999),('SWEL-1',1994),('TAAL-1',2004),('TARA-1',2011),('TAWE-1',2011),('TIBU-1',2004),('TOHO-1',2014),('TOKE-1',1998),('TRST-1',2012),('VAEL-1',1993),('VARI-1',2017),('VECH-1',2000),('VEEL-1',2000),('VEKI-1',1996),('VEOR-1',2007),('VIRI-1',2010),('VOBE-1',1991),('WAEZ-1',2006),('WEIG-1',1999),('WEJO-1',2009),('WHBE-1',2010),('WIBR-1',2014),('WILA-1',2012),('YAAL-1',2012);
/*!40000 ALTER TABLE `Student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_participant`
--

DROP TABLE IF EXISTS `course_participant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_participant` (
  `UNI` varchar(12) NOT NULL,
  `section_call_no` char(5) NOT NULL,
  PRIMARY KEY (`UNI`,`section_call_no`),
  KEY `cp_section_fk` (`section_call_no`),
  CONSTRAINT `cp_participant_fk` FOREIGN KEY (`UNI`) REFERENCES `Person` (`UNI`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `cp_section_fk` FOREIGN KEY (`section_call_no`) REFERENCES `sections` (`call_no`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_participant`
--

LOCK TABLES `course_participant` WRITE;
/*!40000 ALTER TABLE `course_participant` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_participant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_prereqs`
--

DROP TABLE IF EXISTS `course_prereqs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_prereqs` (
  `course_id` varchar(12) NOT NULL,
  `prereq_id` varchar(12) NOT NULL,
  PRIMARY KEY (`course_id`,`prereq_id`),
  KEY `prereq_prereq_fk` (`prereq_id`),
  CONSTRAINT `prereq_course_fk` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `prereq_prereq_fk` FOREIGN KEY (`prereq_id`) REFERENCES `courses` (`course_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_prereqs`
--

LOCK TABLES `course_prereqs` WRITE;
/*!40000 ALTER TABLE `course_prereqs` DISABLE KEYS */;
INSERT INTO `course_prereqs` VALUES ('ANTHBC4664','ANTHBC6633'),('ANTHBC4664','ANTHC1571'),('ANTHBC9400','ANTHC2365'),('ANTHBC9400','ANTHC9311'),('ANTHBC9400','ANTHE4987'),('ANTHC2365','ANTHE4987'),('ANTHBC9400','ANTHE6465'),('ANTHC9311','ANTHE6465'),('ANTHBC9400','ANTHF4341'),('ANTHC2365','ANTHF4341'),('ANTHBC4664','ANTHF4356'),('ANTHC1571','ANTHF4356'),('ANTHF6825','ANTHG2496'),('ANTHF6825','ANTHG8127'),('ANTHG2573','ANTHV4627'),('ANTHG2573','ANTHV8727'),('ANTHG2573','ANTHV8865'),('ANTHV4627','ANTHV8865'),('ANTHG2573','ANTHV9795'),('ANTHV8727','ANTHV9795'),('ANTHG2573','ANTHX2279'),('ANTHV4627','ANTHX2279'),('ANTHF6825','ANTHX6484'),('ANTHG8127','ANTHX6484'),('BSADBC1953','BSADBC4555'),('BSADBC1953','BSADBC8699'),('BSADBC8433','BSADBC8870'),('BSADBC8433','BSADC1682'),('BSADBC8433','BSADC6651'),('BSADBC8870','BSADC6651'),('BSADBC8433','BSADC6865'),('BSADC1682','BSADC6865'),('BSADBC8433','BSADC8554'),('BSADBC8870','BSADC8554'),('BSADBC1953','BSADC8765'),('BSADBC8699','BSADC8765'),('BSADC8964','BSADE3189'),('BSADC8964','BSADG8748'),('BSADF9911','BSADV2917'),('BSADF9911','BSADW1592'),('BSADF9911','BSADW9793'),('BSADV2917','BSADW9793'),('BSADF9911','BSADX0996'),('BSADW1592','BSADX0996'),('BSADF9911','BSADX6387'),('BSADV2917','BSADX6387'),('BSADC8964','BSADX9206'),('BSADG8748','BSADX9206'),('COMSBC8405','COMSC1522'),('COMSBC8405','COMSE0567'),('COMSC8629','COMSF4770'),('COMSC8629','COMSF4911'),('COMSC8629','COMSF8425'),('COMSF4770','COMSF8425'),('COMSC8629','COMSF9600'),('COMSF4911','COMSF9600'),('COMSC8629','COMSG0317'),('COMSF4770','COMSG0317'),('COMSBC8405','COMSG0473'),('COMSE0567','COMSG0473'),('COMSG0977','COMSG9915'),('COMSG0977','COMSV4944'),('COMSV3570','COMSV8367'),('COMSV3570','COMSW3815'),('COMSV3570','COMSW8556'),('COMSV8367','COMSW8556'),('COMSV3570','COMSX0580'),('COMSW3815','COMSX0580'),('COMSV3570','COMSX2262'),('COMSV8367','COMSX2262'),('COMSG0977','COMSX9791'),('COMSV4944','COMSX9791'),('CRDFBC2191','CRDFC4197'),('CRDFBC2191','CRDFE0584'),('CRDFC8486','CRDFE4264'),('CRDFC8486','CRDFE4909'),('CRDFC8486','CRDFE8436'),('CRDFE4264','CRDFE8436'),('CRDFC8486','CRDFF0511'),('CRDFE4909','CRDFF0511'),('CRDFC8486','CRDFF9778'),('CRDFE4264','CRDFF9778'),('CRDFBC2191','CRDFG4739'),('CRDFE0584','CRDFG4739'),('CRDFV1208','CRDFV1241'),('CRDFV1208','CRDFV4916'),('CRDFV4462','CRDFW3825'),('CRDFV4462','CRDFW3864'),('CRDFV4462','CRDFW9799'),('CRDFW3825','CRDFW9799'),('CRDFV4462','CRDFX3298'),('CRDFW3864','CRDFX3298'),('CRDFV4462','CRDFX4334'),('CRDFW3825','CRDFX4334'),('CRDFV1208','CRDFX4648'),('CRDFV4916','CRDFX4648'),('DGMKBC0680','DGMKBC1889'),('DGMKBC0680','DGMKC1809'),('DGMKBC2307','DGMKC4917'),('DGMKBC2307','DGMKC9551'),('DGMKBC2307','DGMKE4514'),('DGMKC4917','DGMKE4514'),('DGMKBC2307','DGMKF0136'),('DGMKC9551','DGMKF0136'),('DGMKBC2307','DGMKF2144'),('DGMKC4917','DGMKF2144'),('DGMKBC0680','DGMKF6640'),('DGMKC1809','DGMKF6640'),('DGMKG0893','DGMKG2843'),('DGMKG0893','DGMKV8346'),('DGMKV8209','DGMKV8828'),('DGMKV8209','DGMKV9957'),('DGMKV8209','DGMKW0854'),('DGMKV8828','DGMKW0854'),('DGMKV8209','DGMKW4745'),('DGMKV9957','DGMKW4745'),('DGMKV8209','DGMKX2524'),('DGMKV8828','DGMKX2524'),('DGMKG0893','DGMKX4392'),('DGMKV8346','DGMKX4392'),('EENGBC0861','EENGBC4729'),('EENGBC0861','EENGC8196'),('EENGC8107','EENGC8206'),('EENGC8107','EENGE6664'),('EENGC8107','EENGF1975'),('EENGC8206','EENGF1975'),('EENGC8107','EENGF2889'),('EENGE6664','EENGF2889'),('EENGC8107','EENGF4269'),('EENGC8206','EENGF4269'),('EENGBC0861','EENGF8406'),('EENGC8196','EENGF8406'),('EENGG3543','EENGG3598'),('EENGG3543','EENGV4850'),('EENGG8216','EENGV9751'),('EENGG8216','EENGW1537'),('EENGG8216','EENGW4993'),('EENGV9751','EENGW4993'),('EENGG8216','EENGX2115'),('EENGW1537','EENGX2115'),('EENGG8216','EENGX2242'),('EENGV9751','EENGX2242'),('EENGG3543','EENGX4478'),('EENGV4850','EENGX4478'),('ESPLBC1895','ESPLBC6832'),('ESPLBC1895','ESPLE0706'),('ESPLC2274','ESPLE1414'),('ESPLC2274','ESPLE2146'),('ESPLC2274','ESPLE8759'),('ESPLE1414','ESPLE8759'),('ESPLC2274','ESPLF4745'),('ESPLE2146','ESPLF4745'),('ESPLC2274','ESPLF4888'),('ESPLE1414','ESPLF4888'),('ESPLBC1895','ESPLF8621'),('ESPLE0706','ESPLF8621'),('ESPLF9265','ESPLG4955'),('ESPLF9265','ESPLV8364'),('ESPLV8168','ESPLV8402'),('ESPLV8168','ESPLX4573'),('ESPLV8168','ESPLX4833'),('ESPLV8402','ESPLX4833'),('ESPLV8168','ESPLX4898'),('ESPLX4573','ESPLX4898'),('ESPLV8168','ESPLX8587'),('ESPLV8402','ESPLX8587'),('ESPLF9265','ESPLX8852'),('ESPLV8364','ESPLX8852'),('ETHRBC4135','ETHRBC4281'),('ETHRBC4135','ETHRBC8285'),('ETHRBC4413','ETHRC0876'),('ETHRBC4413','ETHRC2529'),('ETHRBC4413','ETHRE0588'),('ETHRC0876','ETHRE0588'),('ETHRBC4413','ETHRE0882'),('ETHRC2529','ETHRE0882'),('ETHRBC4413','ETHRF4353'),('ETHRC0876','ETHRF4353'),('ETHRBC4135','ETHRF8283'),('ETHRBC8285','ETHRF8283'),('ETHRG1929','ETHRG3589'),('ETHRG1929','ETHRG6390'),('ETHRG4428','ETHRG8417'),('ETHRG4428','ETHRV4306'),('ETHRG4428','ETHRW2604'),('ETHRG8417','ETHRW2604'),('ETHRG4428','ETHRW8337'),('ETHRV4306','ETHRW8337'),('ETHRG4428','ETHRX3180'),('ETHRG8417','ETHRX3180'),('ETHRG1929','ETHRX6258'),('ETHRG6390','ETHRX6258'),('FNMGBC0742','FNMGBC8419'),('FNMGBC0742','FNMGE0989'),('FNMGC8776','FNMGE8204'),('FNMGC8776','FNMGE8727'),('FNMGC8776','FNMGF8848'),('FNMGE8204','FNMGF8848'),('FNMGC8776','FNMGF9657'),('FNMGE8727','FNMGF9657'),('FNMGC8776','FNMGG4805'),('FNMGE8204','FNMGG4805'),('FNMGBC0742','FNMGG8427'),('FNMGE0989','FNMGG8427'),('FNMGV1900','FNMGV6563'),('FNMGV1900','FNMGW3278'),('FNMGW1780','FNMGW4917'),('FNMGW1780','FNMGW6391'),('FNMGW1780','FNMGW8774'),('FNMGW4917','FNMGW8774'),('FNMGW1780','FNMGX1387'),('FNMGW6391','FNMGX1387'),('FNMGW1780','FNMGX4212'),('FNMGW4917','FNMGX4212'),('FNMGV1900','FNMGX4931'),('FNMGW3278','FNMGX4931'),('MATHBC2670','MATHBC4580'),('MATHBC2670','MATHC0601'),('MATHBC6639','MATHC0795'),('MATHBC6639','MATHE9413'),('MATHBC6639','MATHG2964'),('MATHC0795','MATHG2964'),('MATHBC6639','MATHG3589'),('MATHE9413','MATHG3589'),('MATHBC6639','MATHG4762'),('MATHC0795','MATHG4762'),('MATHBC2670','MATHG4859'),('MATHC0601','MATHG4859'),('MATHG9502','MATHW0474'),('MATHG9502','MATHW3817'),('MATHW2295','MATHW6869'),('MATHW2295','MATHW9581'),('MATHW2295','MATHX0639'),('MATHW6869','MATHX0639'),('MATHW2295','MATHX2738'),('MATHW9581','MATHX2738'),('MATHW2295','MATHX3104'),('MATHW6869','MATHX3104'),('MATHG9502','MATHX8164'),('MATHW3817','MATHX8164'),('PHILBC1855','PHILBC3929'),('PHILBC1855','PHILC1732'),('PHILBC8739','PHILC9904'),('PHILBC8739','PHILE6443'),('PHILBC8739','PHILF4212'),('PHILC9904','PHILF4212'),('PHILBC8739','PHILF6974'),('PHILE6443','PHILF6974'),('PHILBC8739','PHILF8289'),('PHILC9904','PHILF8289'),('PHILBC1855','PHILF8318'),('PHILC1732','PHILF8318'),('PHILG0169','PHILG0272'),('PHILG0169','PHILG4952'),('PHILG4790','PHILV3162'),('PHILG4790','PHILV4364'),('PHILG4790','PHILW8696'),('PHILV3162','PHILW8696'),('PHILG4790','PHILW9743'),('PHILV4364','PHILW9743'),('PHILG4790','PHILX4168'),('PHILV3162','PHILX4168'),('PHILG0169','PHILX8665'),('PHILG4952','PHILX8665'),('PHYSBC0922','PHYSBC1496'),('PHYSBC0922','PHYSBC4559'),('PHYSBC2938','PHYSC1853'),('PHYSBC2938','PHYSC3962'),('PHYSBC2938','PHYSE0799'),('PHYSC1853','PHYSE0799'),('PHYSBC2938','PHYSF0214'),('PHYSC3962','PHYSF0214'),('PHYSBC2938','PHYSF0292'),('PHYSC1853','PHYSF0292'),('PHYSBC0922','PHYSF4167'),('PHYSBC4559','PHYSF4167'),('PHYSF4249','PHYSF9966'),('PHYSF4249','PHYSG4822'),('PHYSG0839','PHYSV4186'),('PHYSG0839','PHYSW3678'),('PHYSG0839','PHYSW4373'),('PHYSV4186','PHYSW4373'),('PHYSG0839','PHYSX0418'),('PHYSW3678','PHYSX0418'),('PHYSG0839','PHYSX2476'),('PHYSV4186','PHYSX2476'),('PHYSF4249','PHYSX9490'),('PHYSG4822','PHYSX9490'),('TAXLBC2834','TAXLBC4262'),('TAXLBC2834','TAXLC0335'),('TAXLBC9295','TAXLC0449'),('TAXLBC9295','TAXLC8749'),('TAXLBC9295','TAXLE1253'),('TAXLC0449','TAXLE1253'),('TAXLBC9295','TAXLE6971'),('TAXLC8749','TAXLE6971'),('TAXLBC9295','TAXLF1503'),('TAXLC0449','TAXLF1503'),('TAXLBC2834','TAXLF2154'),('TAXLC0335','TAXLF2154'),('TAXLG9683','TAXLV1642'),('TAXLG9683','TAXLV4124'),('TAXLV2536','TAXLV4243'),('TAXLV2536','TAXLV8986'),('TAXLV2536','TAXLW0175'),('TAXLV4243','TAXLW0175'),('TAXLV2536','TAXLW0664'),('TAXLV8986','TAXLW0664'),('TAXLV2536','TAXLW3368'),('TAXLV4243','TAXLW3368'),('TAXLG9683','TAXLX9588'),('TAXLV4124','TAXLX9588');
/*!40000 ALTER TABLE `course_prereqs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses` (
  `dept_code` char(4) NOT NULL,
  `faculty_code` enum('BC','C','E','F','G','V','W','X') NOT NULL,
  `level` enum('0','1','2','3','4','6','8','9') NOT NULL,
  `number` char(3) NOT NULL,
  `title` varchar(32) NOT NULL,
  `description` varchar(128) NOT NULL,
  `course_id` varchar(12) GENERATED ALWAYS AS (concat(`dept_code`,`faculty_code`,`level`,`number`)) STORED,
  `full_number` char(4) GENERATED ALWAYS AS (concat(`level`,`number`)) VIRTUAL,
  PRIMARY KEY (`dept_code`,`faculty_code`,`level`,`number`),
  UNIQUE KEY `course_id` (`course_id`),
  FULLTEXT KEY `keywords` (`title`,`description`),
  CONSTRAINT `course2_dept_fk` FOREIGN KEY (`dept_code`) REFERENCES `department` (`code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` (`dept_code`, `faculty_code`, `level`, `number`, `title`, `description`) VALUES ('ANTH','BC','4','664','Anthropology-3','lorem ipsum'),('ANTH','BC','6','633','Anthropology-9','lorem ipsum'),('ANTH','BC','9','400','Anthropology-13','lorem ipsum'),('ANTH','C','1','571','Anthropology-10','lorem ipsum'),('ANTH','C','2','365','Anthropology-11','lorem ipsum'),('ANTH','C','9','311','Anthropology-20','lorem ipsum'),('ANTH','E','4','987','Anthropology-18','lorem ipsum'),('ANTH','E','6','465','Anthropology-4','lorem ipsum'),('ANTH','F','4','341','Anthropology-16','lorem ipsum'),('ANTH','F','4','356','Anthropology-15','lorem ipsum'),('ANTH','F','6','825','Anthropology-2','lorem ipsum'),('ANTH','G','2','496','Anthropology-1','lorem ipsum'),('ANTH','G','2','573','Anthropology-17','lorem ipsum'),('ANTH','G','8','127','Anthropology-5','lorem ipsum'),('ANTH','V','4','627','Anthropology-19','lorem ipsum'),('ANTH','V','8','727','Anthropology-6','lorem ipsum'),('ANTH','V','8','865','Anthropology-12','lorem ipsum'),('ANTH','V','9','795','Anthropology-7','lorem ipsum'),('ANTH','X','2','279','Anthropology-8','lorem ipsum'),('ANTH','X','6','484','Anthropology-14','lorem ipsum'),('BSAD','BC','1','953','Business Administration-6','lorem ipsum'),('BSAD','BC','4','555','Business Administration-13','lorem ipsum'),('BSAD','BC','8','433','Business Administration-16','lorem ipsum'),('BSAD','BC','8','699','Business Administration-3','lorem ipsum'),('BSAD','BC','8','870','Business Administration-8','lorem ipsum'),('BSAD','C','1','682','Business Administration-5','lorem ipsum'),('BSAD','C','6','651','Business Administration-17','lorem ipsum'),('BSAD','C','6','865','Business Administration-10','lorem ipsum'),('BSAD','C','8','554','Business Administration-2','lorem ipsum'),('BSAD','C','8','765','Business Administration-15','lorem ipsum'),('BSAD','C','8','964','Business Administration-18','lorem ipsum'),('BSAD','E','3','189','Business Administration-4','lorem ipsum'),('BSAD','F','9','911','Business Administration-19','lorem ipsum'),('BSAD','G','8','748','Business Administration-20','lorem ipsum'),('BSAD','V','2','917','Business Administration-7','lorem ipsum'),('BSAD','W','1','592','Business Administration-14','lorem ipsum'),('BSAD','W','9','793','Business Administration-1','lorem ipsum'),('BSAD','X','0','996','Business Administration-12','lorem ipsum'),('BSAD','X','6','387','Business Administration-11','lorem ipsum'),('BSAD','X','9','206','Business Administration-9','lorem ipsum'),('COMS','BC','8','405','Computer Science-9','lorem ipsum'),('COMS','C','1','522','Computer Science-13','lorem ipsum'),('COMS','C','8','629','Computer Science-18','lorem ipsum'),('COMS','E','0','567','Computer Science-3','lorem ipsum'),('COMS','F','4','770','Computer Science-4','lorem ipsum'),('COMS','F','4','911','Computer Science-7','lorem ipsum'),('COMS','F','8','425','Computer Science-5','lorem ipsum'),('COMS','F','9','600','Computer Science-6','lorem ipsum'),('COMS','G','0','317','Computer Science-2','lorem ipsum'),('COMS','G','0','473','Computer Science-15','lorem ipsum'),('COMS','G','0','977','Computer Science-17','lorem ipsum'),('COMS','G','9','915','Computer Science-12','lorem ipsum'),('COMS','V','3','570','Computer Science-19','lorem ipsum'),('COMS','V','4','944','Computer Science-16','lorem ipsum'),('COMS','V','8','367','Computer Science-8','lorem ipsum'),('COMS','W','3','815','Computer Science-14','lorem ipsum'),('COMS','W','8','556','Computer Science-11','lorem ipsum'),('COMS','X','0','580','Computer Science-20','lorem ipsum'),('COMS','X','2','262','Computer Science-1','lorem ipsum'),('COMS','X','9','791','Computer Science-10','lorem ipsum'),('CRDF','BC','2','191','Criminal Defense-6','lorem ipsum'),('CRDF','C','4','197','Criminal Defense-16','lorem ipsum'),('CRDF','C','8','486','Criminal Defense-20','lorem ipsum'),('CRDF','E','0','584','Criminal Defense-7','lorem ipsum'),('CRDF','E','4','264','Criminal Defense-2','lorem ipsum'),('CRDF','E','4','909','Criminal Defense-19','lorem ipsum'),('CRDF','E','8','436','Criminal Defense-11','lorem ipsum'),('CRDF','F','0','511','Criminal Defense-18','lorem ipsum'),('CRDF','F','9','778','Criminal Defense-9','lorem ipsum'),('CRDF','G','4','739','Criminal Defense-10','lorem ipsum'),('CRDF','V','1','208','Criminal Defense-15','lorem ipsum'),('CRDF','V','1','241','Criminal Defense-17','lorem ipsum'),('CRDF','V','4','462','Criminal Defense-3','lorem ipsum'),('CRDF','V','4','916','Criminal Defense-8','lorem ipsum'),('CRDF','W','3','825','Criminal Defense-12','lorem ipsum'),('CRDF','W','3','864','Criminal Defense-5','lorem ipsum'),('CRDF','W','9','799','Criminal Defense-4','lorem ipsum'),('CRDF','X','3','298','Criminal Defense-1','lorem ipsum'),('CRDF','X','4','334','Criminal Defense-14','lorem ipsum'),('CRDF','X','4','648','Criminal Defense-13','lorem ipsum'),('DGMK','BC','0','680','Digital Marketting-17','lorem ipsum'),('DGMK','BC','1','889','Digital Marketting-2','lorem ipsum'),('DGMK','BC','2','307','Digital Marketting-19','lorem ipsum'),('DGMK','C','1','809','Digital Marketting-6','lorem ipsum'),('DGMK','C','4','917','Digital Marketting-20','lorem ipsum'),('DGMK','C','9','551','Digital Marketting-5','lorem ipsum'),('DGMK','E','4','514','Digital Marketting-13','lorem ipsum'),('DGMK','F','0','136','Digital Marketting-4','lorem ipsum'),('DGMK','F','2','144','Digital Marketting-8','lorem ipsum'),('DGMK','F','6','640','Digital Marketting-12','lorem ipsum'),('DGMK','G','0','893','Digital Marketting-11','lorem ipsum'),('DGMK','G','2','843','Digital Marketting-1','lorem ipsum'),('DGMK','V','8','209','Digital Marketting-14','lorem ipsum'),('DGMK','V','8','346','Digital Marketting-10','lorem ipsum'),('DGMK','V','8','828','Digital Marketting-7','lorem ipsum'),('DGMK','V','9','957','Digital Marketting-15','lorem ipsum'),('DGMK','W','0','854','Digital Marketting-18','lorem ipsum'),('DGMK','W','4','745','Digital Marketting-9','lorem ipsum'),('DGMK','X','2','524','Digital Marketting-16','lorem ipsum'),('DGMK','X','4','392','Digital Marketting-3','lorem ipsum'),('EENG','BC','0','861','Electrical Engineering-18','lorem ipsum'),('EENG','BC','4','729','Electrical Engineering-12','lorem ipsum'),('EENG','C','8','107','Electrical Engineering-8','lorem ipsum'),('EENG','C','8','196','Electrical Engineering-10','lorem ipsum'),('EENG','C','8','206','Electrical Engineering-16','lorem ipsum'),('EENG','E','6','664','Electrical Engineering-9','lorem ipsum'),('EENG','F','1','975','Electrical Engineering-14','lorem ipsum'),('EENG','F','2','889','Electrical Engineering-15','lorem ipsum'),('EENG','F','4','269','Electrical Engineering-6','lorem ipsum'),('EENG','F','8','406','Electrical Engineering-20','lorem ipsum'),('EENG','G','3','543','Electrical Engineering-13','lorem ipsum'),('EENG','G','3','598','Electrical Engineering-3','lorem ipsum'),('EENG','G','8','216','Electrical Engineering-17','lorem ipsum'),('EENG','V','4','850','Electrical Engineering-7','lorem ipsum'),('EENG','V','9','751','Electrical Engineering-2','lorem ipsum'),('EENG','W','1','537','Electrical Engineering-11','lorem ipsum'),('EENG','W','4','993','Electrical Engineering-4','lorem ipsum'),('EENG','X','2','115','Electrical Engineering-1','lorem ipsum'),('EENG','X','2','242','Electrical Engineering-19','lorem ipsum'),('EENG','X','4','478','Electrical Engineering-5','lorem ipsum'),('ESPL','BC','1','895','Estate Planning-12','lorem ipsum'),('ESPL','BC','6','832','Estate Planning-16','lorem ipsum'),('ESPL','C','2','274','Estate Planning-8','lorem ipsum'),('ESPL','E','0','706','Estate Planning-10','lorem ipsum'),('ESPL','E','1','414','Estate Planning-7','lorem ipsum'),('ESPL','E','2','146','Estate Planning-3','lorem ipsum'),('ESPL','E','8','759','Estate Planning-19','lorem ipsum'),('ESPL','F','4','745','Estate Planning-9','lorem ipsum'),('ESPL','F','4','888','Estate Planning-11','lorem ipsum'),('ESPL','F','8','621','Estate Planning-20','lorem ipsum'),('ESPL','F','9','265','Estate Planning-17','lorem ipsum'),('ESPL','G','4','955','Estate Planning-14','lorem ipsum'),('ESPL','V','8','168','Estate Planning-18','lorem ipsum'),('ESPL','V','8','364','Estate Planning-6','lorem ipsum'),('ESPL','V','8','402','Estate Planning-5','lorem ipsum'),('ESPL','X','4','573','Estate Planning-2','lorem ipsum'),('ESPL','X','4','833','Estate Planning-15','lorem ipsum'),('ESPL','X','4','898','Estate Planning-1','lorem ipsum'),('ESPL','X','8','587','Estate Planning-13','lorem ipsum'),('ESPL','X','8','852','Estate Planning-4','lorem ipsum'),('ETHR','BC','4','135','Ethnicity and Race-18','lorem ipsum'),('ETHR','BC','4','281','Ethnicity and Race-1','lorem ipsum'),('ETHR','BC','4','413','Ethnicity and Race-11','lorem ipsum'),('ETHR','BC','8','285','Ethnicity and Race-5','lorem ipsum'),('ETHR','C','0','876','Ethnicity and Race-8','lorem ipsum'),('ETHR','C','2','529','Ethnicity and Race-15','lorem ipsum'),('ETHR','E','0','588','Ethnicity and Race-3','lorem ipsum'),('ETHR','E','0','882','Ethnicity and Race-13','lorem ipsum'),('ETHR','F','4','353','Ethnicity and Race-14','lorem ipsum'),('ETHR','F','8','283','Ethnicity and Race-10','lorem ipsum'),('ETHR','G','1','929','Ethnicity and Race-4','lorem ipsum'),('ETHR','G','3','589','Ethnicity and Race-9','lorem ipsum'),('ETHR','G','4','428','Ethnicity and Race-19','lorem ipsum'),('ETHR','G','6','390','Ethnicity and Race-20','lorem ipsum'),('ETHR','G','8','417','Ethnicity and Race-12','lorem ipsum'),('ETHR','V','4','306','Ethnicity and Race-7','lorem ipsum'),('ETHR','W','2','604','Ethnicity and Race-6','lorem ipsum'),('ETHR','W','8','337','Ethnicity and Race-16','lorem ipsum'),('ETHR','X','3','180','Ethnicity and Race-17','lorem ipsum'),('ETHR','X','6','258','Ethnicity and Race-2','lorem ipsum'),('FNMG','BC','0','742','Finance Management-12','lorem ipsum'),('FNMG','BC','8','419','Finance Management-20','lorem ipsum'),('FNMG','C','8','776','Finance Management-4','lorem ipsum'),('FNMG','E','0','989','Finance Management-9','lorem ipsum'),('FNMG','E','8','204','Finance Management-15','lorem ipsum'),('FNMG','E','8','727','Finance Management-2','lorem ipsum'),('FNMG','F','8','848','Finance Management-8','lorem ipsum'),('FNMG','F','9','657','Finance Management-11','lorem ipsum'),('FNMG','G','4','805','Finance Management-14','lorem ipsum'),('FNMG','G','8','427','Finance Management-10','lorem ipsum'),('FNMG','V','1','900','Finance Management-13','lorem ipsum'),('FNMG','V','6','563','Finance Management-6','lorem ipsum'),('FNMG','W','1','780','Finance Management-17','lorem ipsum'),('FNMG','W','3','278','Finance Management-19','lorem ipsum'),('FNMG','W','4','917','Finance Management-1','lorem ipsum'),('FNMG','W','6','391','Finance Management-3','lorem ipsum'),('FNMG','W','8','774','Finance Management-7','lorem ipsum'),('FNMG','X','1','387','Finance Management-18','lorem ipsum'),('FNMG','X','4','212','Finance Management-16','lorem ipsum'),('FNMG','X','4','931','Finance Management-5','lorem ipsum'),('MATH','BC','2','670','Mathematics-6','lorem ipsum'),('MATH','BC','4','580','Mathematics-3','lorem ipsum'),('MATH','BC','6','639','Mathematics-18','lorem ipsum'),('MATH','C','0','601','Mathematics-4','lorem ipsum'),('MATH','C','0','795','Mathematics-2','lorem ipsum'),('MATH','E','9','413','Mathematics-15','lorem ipsum'),('MATH','G','2','964','Mathematics-8','lorem ipsum'),('MATH','G','3','589','Mathematics-13','lorem ipsum'),('MATH','G','4','762','Mathematics-7','lorem ipsum'),('MATH','G','4','859','Mathematics-16','lorem ipsum'),('MATH','G','9','502','Mathematics-9','lorem ipsum'),('MATH','W','0','474','Mathematics-10','lorem ipsum'),('MATH','W','2','295','Mathematics-11','lorem ipsum'),('MATH','W','3','817','Mathematics-19','lorem ipsum'),('MATH','W','6','869','Mathematics-5','lorem ipsum'),('MATH','W','9','581','Mathematics-17','lorem ipsum'),('MATH','X','0','639','Mathematics-20','lorem ipsum'),('MATH','X','2','738','Mathematics-12','lorem ipsum'),('MATH','X','3','104','Mathematics-14','lorem ipsum'),('MATH','X','8','164','Mathematics-1','lorem ipsum'),('PHIL','BC','1','855','Philosophy-6','lorem ipsum'),('PHIL','BC','3','929','Philosophy-3','lorem ipsum'),('PHIL','BC','8','739','Philosophy-12','lorem ipsum'),('PHIL','C','1','732','Philosophy-11','lorem ipsum'),('PHIL','C','9','904','Philosophy-2','lorem ipsum'),('PHIL','E','6','443','Philosophy-1','lorem ipsum'),('PHIL','F','4','212','Philosophy-7','lorem ipsum'),('PHIL','F','6','974','Philosophy-14','lorem ipsum'),('PHIL','F','8','289','Philosophy-15','lorem ipsum'),('PHIL','F','8','318','Philosophy-10','lorem ipsum'),('PHIL','G','0','169','Philosophy-16','lorem ipsum'),('PHIL','G','0','272','Philosophy-17','lorem ipsum'),('PHIL','G','4','790','Philosophy-9','lorem ipsum'),('PHIL','G','4','952','Philosophy-13','lorem ipsum'),('PHIL','V','3','162','Philosophy-5','lorem ipsum'),('PHIL','V','4','364','Philosophy-19','lorem ipsum'),('PHIL','W','8','696','Philosophy-8','lorem ipsum'),('PHIL','W','9','743','Philosophy-18','lorem ipsum'),('PHIL','X','4','168','Philosophy-4','lorem ipsum'),('PHIL','X','8','665','Philosophy-20','lorem ipsum'),('PHYS','BC','0','922','Physics-13','lorem ipsum'),('PHYS','BC','1','496','Physics-9','lorem ipsum'),('PHYS','BC','2','938','Physics-16','lorem ipsum'),('PHYS','BC','4','559','Physics-10','lorem ipsum'),('PHYS','C','1','853','Physics-1','lorem ipsum'),('PHYS','C','3','962','Physics-11','lorem ipsum'),('PHYS','E','0','799','Physics-18','lorem ipsum'),('PHYS','F','0','214','Physics-12','lorem ipsum'),('PHYS','F','0','292','Physics-2','lorem ipsum'),('PHYS','F','4','167','Physics-14','lorem ipsum'),('PHYS','F','4','249','Physics-20','lorem ipsum'),('PHYS','F','9','966','Physics-8','lorem ipsum'),('PHYS','G','0','839','Physics-6','lorem ipsum'),('PHYS','G','4','822','Physics-15','lorem ipsum'),('PHYS','V','4','186','Physics-17','lorem ipsum'),('PHYS','W','3','678','Physics-4','lorem ipsum'),('PHYS','W','4','373','Physics-7','lorem ipsum'),('PHYS','X','0','418','Physics-5','lorem ipsum'),('PHYS','X','2','476','Physics-3','lorem ipsum'),('PHYS','X','9','490','Physics-19','lorem ipsum'),('TAXL','BC','2','834','Tax-7','lorem ipsum'),('TAXL','BC','4','262','Tax-13','lorem ipsum'),('TAXL','BC','9','295','Tax-3','lorem ipsum'),('TAXL','C','0','335','Tax-5','lorem ipsum'),('TAXL','C','0','449','Tax-10','lorem ipsum'),('TAXL','C','8','749','Tax-2','lorem ipsum'),('TAXL','E','1','253','Tax-8','lorem ipsum'),('TAXL','E','6','971','Tax-4','lorem ipsum'),('TAXL','F','1','503','Tax-17','lorem ipsum'),('TAXL','F','2','154','Tax-12','lorem ipsum'),('TAXL','G','9','683','Tax-1','lorem ipsum'),('TAXL','V','1','642','Tax-15','lorem ipsum'),('TAXL','V','2','536','Tax-6','lorem ipsum'),('TAXL','V','4','124','Tax-18','lorem ipsum'),('TAXL','V','4','243','Tax-19','lorem ipsum'),('TAXL','V','8','986','Tax-9','lorem ipsum'),('TAXL','W','0','175','Tax-16','lorem ipsum'),('TAXL','W','0','664','Tax-20','lorem ipsum'),('TAXL','W','3','368','Tax-14','lorem ipsum'),('TAXL','X','9','588','Tax-11','lorem ipsum');
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `code` char(4) NOT NULL,
  `dname` varchar(32) NOT NULL,
  `sname` varchar(45) NOT NULL,
  PRIMARY KEY (`code`),
  UNIQUE KEY `dname_UNIQUE` (`dname`),
  KEY `fk_department_sname_idx` (`sname`),
  CONSTRAINT `fk_department_sname` FOREIGN KEY (`sname`) REFERENCES `School` (`sname`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES ('ANTH','Anthropology','Arts'),('BSAD','Business Administration','Business & Management'),('COMS','Computer Science','Engineering'),('CRDF','Criminal Defense','Law'),('DGMK','Digital Marketting','Business & Management'),('EENG','Electrical Engineering','Engineering'),('ESPL','Estate Planning','Law'),('ETHR','Ethnicity and Race','Arts'),('FNMG','Finance Management','Business & Management'),('MATH','Mathematics','Natural Sciences'),('PHIL','Philosophy','Arts'),('PHYS','Physics','Natural Sciences'),('TAXL','Tax','Law');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections` (
  `call_no` char(5) NOT NULL,
  `course_id` varchar(12) NOT NULL,
  `section_no` varchar(45) NOT NULL,
  `year` int(11) NOT NULL,
  `semester` varchar(45) NOT NULL,
  `section_key` varchar(45) GENERATED ALWAYS AS (concat(`year`,`semester`,`course_id`,`section_no`)) STORED,
  PRIMARY KEY (`call_no`),
  UNIQUE KEY `unique` (`course_id`,`section_no`,`year`,`semester`),
  CONSTRAINT `section_course_fk` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'hw3'
--

--
-- Dumping routines for database 'hw3'
--
/*!50003 DROP FUNCTION IF EXISTS `generate_uni_for_person` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `generate_uni_for_person`(last_name VARCHAR(45), first_name VARCHAR(45)) RETURNS varchar(12) CHARSET latin1
BEGIN
	DECLARE fn CHAR(2);
    DECLARE ln CHAR(2);
	DECLARE pattern CHAR(5);
    DECLARE old_uni_count INT;
    DECLARE UNI varchar(12);
    
    SET fn = UPPER(SUBSTR(last_name, 1, 2));
    SET ln = UPPER(SUBSTR(first_name, 1, 2)); 
    SET pattern = CONCAT(fn, ln);
SELECT 
    COUNT(*)
INTO old_uni_count FROM
    Person
WHERE
    Person.UNI LIKE CONCAT(pattern, '%');
    SET UNI = CONCAT(pattern, "-", old_uni_count + 1); 
    
RETURN UNI;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertFaculty` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertFaculty`(IN last_name varchar(45), IN first_name varchar(45), IN email varchar(45), IN department varchar(32), IN pay_grade INT, IN title varchar(20))
BEGIN
	DECLARE UNI varchar(45);
    SET UNI = generate_uni_for_person(last_name, first_name);
    INSERT INTO Person VALUES(UNI, last_name, first_name, email, department);
    INSERT INTO Faculty VALUES(UNI, pay_grade, title);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insertStudent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertStudent`(IN last_name varchar(45), IN first_name varchar(45), IN email varchar(45), IN department varchar(32), IN year INT)
BEGIN
	DECLARE UNI VARCHAR(12);
    SET UNI = generate_uni_for_person(last_name, first_name);
    INSERT INTO Person VALUES(UNI, last_name, first_name, email,department);
    INSERT INTO Student VALUES(UNI, year);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-10-27 21:16:06
