-- Table des utilisateurs
-- DROP TABLE IF EXISTS `T_USER_USR`;
CREATE TABLE T_USER_USR (
  USR_ID bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  USR_LOGIN varchar(255) NOT NULL,
  USR_MAIL varchar(255) NOT NULL,
  USR_NAME varchar(255) NOT NULL,
  USR_FIRSTNAME varchar(255) NOT NULL,
  USR_PASS varchar(40) NOT NULL,
  USR_LEVEL tinyint(20) NOT NULL DEFAULT '0',
  USR_AVATAR varchar(80) DEFAULT NULL,
  PRIMARY KEY (USR_ID),
  UNIQUE (USR_LOGIN),
  UNIQUE (USR_MAIL)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- Table des unités
-- DROP TABLE IF EXISTS T_UNIT_UNT;
CREATE TABLE T_UNIT_UNT (
  UNT_ID bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  UNT_LABEL varchar(30) NOT NULL,
  UNT_SHORT_LABEL varchar(15) NOT NULL,
  UNT_OWNER bigint(20) unsigned,
  PRIMARY KEY (UNT_ID),
  FOREIGN KEY (UNT_OWNER) REFERENCES T_USER_USR(USR_ID),
  UNIQUE (UNT_LABEL),
  UNIQUE (UNT_SHORT_LABEL)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- Table des recettes
-- DROP TABLE IF EXISTS T_RECIPE_RCP;
CREATE TABLE T_RECIPE_RCP (
  RCP_ID bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  RCP_DATE_CREATE timestamp NOT NULL DEFAULT NOW(),
  RCP_DATE_MODIF timestamp NOT NULL DEFAULT NOW(),
  RCP_DATE_VALIDATION timestamp NOT NULL DEFAULT NOW(),
  RCP_TITLE varchar(80) NOT NULL,
  RCP_DESCRIPTION longtext NOT NULL,
  RCP_TEMPS_PREPARATION time NOT NULL,
  RCP_TEMPS_CUISSON time NULL DEFAULT '00:00:00',
  RCP_TEMPS_REPOS time  NULL DEFAULT '00:00:00',
  RCP_DIFFICULTY ENUM("facile","moyen","difficile") NOT NULL DEFAULT 'facile',
  RCP_COUT ENUM("faible","moyen","eleve") NOT NULL DEFAULT 'faible',
  RCP_STATUT ENUM("brouillon","soumise","finale") NOT NULL DEFAULT 'brouillon',
  RCP_ILLUSTRATION varchar(80) NOT NULL,
  USR_ID bigint(20) unsigned NOT NULL,
  RCP_NBPERSONNE int NOT NULL,
  PRIMARY KEY (RCP_ID),
  FOREIGN KEY (USR_ID) REFERENCES T_USER_USR(USR_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- Table des catégories
-- DROP TABLE IF EXISTS T_CATEGORY_CAT;
CREATE TABLE T_CATEGORY_CAT (
  CAT_ID bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  CAT_LABEL varchar(255) NOT NULL,
  CAT_DESCRIPTION mediumtext NOT NULL,
  CAT_ILLUSTRATION varchar(80) NOT NULL,
  PRIMARY KEY (CAT_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

-- Table d'association entre recettes et  catégories
-- DROP TABLE IF EXISTS TJ_CAT_RCP;
CREATE TABLE TJ_CAT_RCP (
  CAT_ID bigint(20) unsigned NOT NULL,
  RCP_ID bigint(20) unsigned NOT NULL,
  FOREIGN KEY (CAT_ID) REFERENCES T_CATEGORY_CAT(CAT_ID),
  FOREIGN KEY (RCP_ID) REFERENCES T_RECIPE_RCP(RCP_ID),
  PRIMARY KEY (CAT_ID,RCP_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

-- Table des ingrédients
-- DROP TABLE IF EXISTS T_INGREDIENT_IGD;
CREATE TABLE T_INGREDIENT_IGD (
  IGD_LABEL varchar(255) NOT NULL,
  IGD_DESCRIPTION mediumtext NOT NULL,
  IGD_ILLUSTRATION varchar(80) NULL DEFAULT NULL,
  USR_ID bigint(20) unsigned NULL DEFAULT NULL,
  PRIMARY KEY (IGD_LABEL),
  FOREIGN KEY (USR_ID) REFERENCES T_USER_USR(USR_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;


-- Table d'association (composed) des recettes, ingédients et UNTtés
-- DROP TABLE IF EXISTS TJ_IGD_RCP_UNT;
CREATE TABLE TJ_IGD_RCP_UNT (
  RCP_ID bigint(20) unsigned NOT NULL,
  IGD_LABEL varchar(255)  NOT NULL,
  UNT_LABEL varchar(30) NOT NULL,
  IGD_RCP_UNT_QUANTITE int(11) NOT NULL,
  FOREIGN KEY (RCP_ID) REFERENCES T_RECIPE_RCP(RCP_ID),
  FOREIGN KEY (IGD_LABEL) REFERENCES T_INGREDIENT_IGD(IGD_LABEL),
  FOREIGN KEY (UNT_LABEL) REFERENCES T_UNIT_UNT(UNT_LABEL),
  PRIMARY KEY (RCP_ID, IGD_LABEL, UNT_LABEL)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

-- Table de commentaires
-- DROP TABLE IF EXISTS T_COMMENT_COM;
CREATE TABLE T_COMMENT_COM (
  COM_ID bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  COM_TEXT mediumtext NOT NULL,
  COM_DATE timestamp NOT NULL DEFAULT NOW(),
  USR_ID bigint(20) unsigned NULL,
  RCP_ID bigint(20) unsigned NOT NULL,
  PRIMARY KEY (COM_ID),
  FOREIGN KEY (USR_ID) REFERENCES T_USER_USR(USR_ID),
  FOREIGN KEY (RCP_ID) REFERENCES T_RECIPE_RCP(RCP_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;


insert into T_USER_USR values(0,'napoleon789','laurentdoiteau@free.fr','Laurent','DOITEAU',sha1('pwdtest'),default,default)
  
insert into T_CATEGORY_CAT values(0,'dessert','C\'est bon ! wow!','dessert.jpg')



-- création des clés étrangéres

-- ALTER TABLE TJ_CAT_RCP
--  ADD CONSTRAINT C_FK_CAT_CAT_RCP FOREIGN KEY (CAT_ID) REFERENCES T_CATEGORY_CAT (CAT_ID) ,
--  ADD CONSTRAINT C_FK_RCP_CAT_RCP FOREIGN KEY (RCP_ID) REFERENCES T_RECIPE_RCP (RCP_ID) ;
--
-- ALTER TABLE  T_UNIT_UNT
--  ADD CONSTRAINT C_FK_UNT_USR FOREIGN KEY (USR_ID) REFERENCES T_USER_USR (USR_ID) ;
--
-- ALTER TABLE T_COMMENT_COM
--  ADD CONSTRAINT C_FK_USR_COM FOREIGN KEY (USR_ID) REFERENCES T_USER_USR (USR_ID) ,
--  ADD CONSTRAINT C_FK_RCP_COM FOREIGN KEY (RCP_ID) REFERENCES T_RECIPE_RCP (RCP_ID) ;
--
-- ALTER TABLE TJ_IGD_RCP_UNT
--  ADD CONSTRAINT C_FK_RCP_IGD_RCP_UNT FOREIGN KEY (RCP_ID) REFERENCES T_RECIPE_RCP (RCP_ID) ,
--  ADD CONSTRAINT C_FK_IGD_IGD_RCP_UNT FOREIGN KEY (IGD_LABEL) REFERENCES T_INGREDIENT_IGD(IGD_LABEL),
--  ADD CONSTRAINT C_FK_UNT_IGD_RCP_UNT FOREIGN KEY (UNT_LABEL) REFERENCES T_UNIT_UNT (UNT_LABEL) ;
--
-- ALTER TABLE T_INGREDIENT_IGD
--  ADD CONSTRAINT C_FK_USR_IGD FOREIGN KEY (USR_ID) REFERENCES T_USER_USR (USR_ID) ;
--
-- ALTER TABLE T_RECIPE_RCP
--  ADD CONSTRAINT C_FK_USR_RCP FOREIGN KEY (USR_ID) REFERENCES T_USER_USR (USR_ID) ;
