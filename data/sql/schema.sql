CREATE TABLE alerte (id BIGINT AUTO_INCREMENT, email VARCHAR(128), query TEXT, filter TEXT, query_md5 VARCHAR(32), titre TEXT, confirmed TINYINT(1), no_human_query TINYINT(1), period VARCHAR(255), next_mail datetime, last_mail datetime, citoyen_id BIGINT, verif VARCHAR(128), created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, UNIQUE INDEX index_uniq_idx (email, citoyen_id, query_md5), INDEX citoyen_id_idx (citoyen_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = MyISAM;
CREATE TABLE alinea (id BIGINT AUTO_INCREMENT, nb_commentaires BIGINT, texteloi_id VARCHAR(20), article_loi_id BIGINT, numero BIGINT, texte TEXT, ref_loi VARCHAR(255), created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, UNIQUE INDEX iarticleloinumero_idx (texteloi_id, article_loi_id, numero), INDEX article_loi_id_idx (article_loi_id), INDEX texteloi_id_idx (texteloi_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = MyISAM;
CREATE TABLE amendement (id BIGINT AUTO_INCREMENT, nb_commentaires BIGINT, source VARCHAR(255), texteloi_id VARCHAR(20), numero VARCHAR(8), rectif BIGINT, sujet VARCHAR(100), sort VARCHAR(255), avis_comm VARCHAR(255), avis_gouv VARCHAR(255), date DATE, signataires TEXT, texte TEXT, expose TEXT, ref_loi VARCHAR(255), organisme_id BIGINT, numero_pere BIGINT, content_md5 VARCHAR(36), created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, FULLTEXT INDEX ft_amendements_idx (sujet, texte, expose), UNIQUE INDEX uniq_loi_num_idx (texteloi_id, numero, rectif), INDEX texteloi_id_idx (texteloi_id), INDEX organisme_id_idx (organisme_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = MyISAM;
CREATE TABLE article_version (id BIGINT, nb_commentaires BIGINT, titre VARCHAR(254), corps TEXT, user_corps TEXT, categorie VARCHAR(128), citoyen_id BIGINT, article_id BIGINT, link VARCHAR(255), status VARCHAR(255) DEFAULT 'brouillon', object_id BIGINT, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, version BIGINT, PRIMARY KEY(id, version)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = MyISAM;
CREATE TABLE article (id BIGINT AUTO_INCREMENT, nb_commentaires BIGINT, titre VARCHAR(254), corps TEXT, user_corps TEXT, categorie VARCHAR(128), citoyen_id BIGINT, article_id BIGINT, link VARCHAR(255), status VARCHAR(255) DEFAULT 'brouillon', object_id BIGINT, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, version BIGINT, slug VARCHAR(255), INDEX icategories_idx (categorie), INDEX iobject_idx (categorie, object_id), INDEX ititre_idx (categorie, titre(200)), INDEX ititrecitoyen_idx (categorie, titre(200), citoyen_id), INDEX iarticle_idx (article_id), UNIQUE INDEX article_sluggable_idx (slug), INDEX citoyen_id_idx (citoyen_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = MyISAM;
CREATE TABLE article_loi (id BIGINT AUTO_INCREMENT, nb_commentaires BIGINT, texteloi_id VARCHAR(20), titre VARCHAR(20), ordre BIGINT, precedent VARCHAR(20), suivant VARCHAR(20), expose TEXT, titre_loi_id BIGINT, slug VARCHAR(255), UNIQUE INDEX iloititre_idx (texteloi_id, titre), INDEX iloiarticle_idx (texteloi_id, ordre), INDEX titre_loi_id_idx (titre_loi_id), INDEX texteloi_id_idx (texteloi_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = MyISAM;
CREATE TABLE citoyen (id BIGINT AUTO_INCREMENT, login VARCHAR(128) UNIQUE, password VARCHAR(40), email VARCHAR(255) NOT NULL UNIQUE, activite VARCHAR(255), url_site VARCHAR(255), employe_institution TINYINT(1) DEFAULT '0', travail_pour BIGINT, naissance DATE, sexe VARCHAR(255), nom_circo VARCHAR(255), num_circo BIGINT, photo LONGBLOB, activation_id VARCHAR(32), is_active TINYINT(1) DEFAULT '0', role VARCHAR(255) DEFAULT 'membre', last_login DATETIME, parametres TEXT, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, slug VARCHAR(255), INDEX is_active_idx (is_active), INDEX role_idx (role), UNIQUE INDEX citoyen_sluggable_idx (slug), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = MyISAM;
CREATE TABLE commentaire (id BIGINT AUTO_INCREMENT, rate BIGINT, citoyen_id BIGINT, commentaire TEXT, is_public TINYINT(1), ip_address TEXT, object_type VARCHAR(64), object_id VARCHAR(16), lien VARCHAR(128), presentation TEXT, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX commentable_idx (object_type, object_id), INDEX citoyen_id_idx (citoyen_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = MyISAM;
CREATE TABLE commentaire_object (id BIGINT AUTO_INCREMENT, object_type VARCHAR(64), object_id BIGINT, commentaire_id BIGINT, UNIQUE INDEX unique_idx (object_type, object_id, commentaire_id), INDEX commentaire_id_idx (commentaire_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = MyISAM;
CREATE TABLE intervention (id BIGINT AUTO_INCREMENT, nb_commentaires BIGINT, nb_mots BIGINT, md5 VARCHAR(36) UNIQUE, intervention TEXT, timestamp BIGINT, source VARCHAR(128), seance_id BIGINT, section_id BIGINT, type VARCHAR(255), date DATE, personnalite_id BIGINT, parlementaire_id BIGINT, fonction TEXT, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX date_intervention_idx (date), FULLTEXT INDEX ft_intervention_idx (intervention), INDEX section_id_idx (section_id), INDEX seance_id_idx (seance_id), INDEX personnalite_id_idx (personnalite_id), INDEX parlementaire_id_idx (parlementaire_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = MyISAM;
CREATE TABLE object_commentable (id BIGINT AUTO_INCREMENT, nb_commentaires BIGINT, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = MyISAM;
CREATE TABLE object_rated (id BIGINT AUTO_INCREMENT, rate BIGINT, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = MyISAM;
CREATE TABLE organisme (id BIGINT AUTO_INCREMENT, nom TEXT, type VARCHAR(255), created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, slug VARCHAR(255), UNIQUE INDEX organisme_sluggable_idx (slug), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = MyISAM;
CREATE TABLE parlementaire (id BIGINT AUTO_INCREMENT, nb_commentaires BIGINT, nom VARCHAR(255), nom_de_famille VARCHAR(255), sexe VARCHAR(255), date_naissance DATE, nom_circo VARCHAR(255), num_circo BIGINT, sites_web TEXT, debut_mandat DATE, fin_mandat DATE, place_hemicycle BIGINT, url_institution VARCHAR(255), profession VARCHAR(255), autoflip TINYINT(1), id_institution VARCHAR(64) UNIQUE, type VARCHAR(255), groupe_acronyme VARCHAR(8), parti VARCHAR(255), adresses TEXT, suppleant_de_id BIGINT, anciens_mandats TEXT, autres_mandats TEXT, mails TEXT, top TEXT, villes TEXT, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, slug VARCHAR(255), UNIQUE INDEX uniq_url_idx (url_institution), UNIQUE INDEX parlementaire_sluggable_idx (slug), INDEX suppleant_de_id_idx (suppleant_de_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = MyISAM;
CREATE TABLE parlementaire_amendement (id BIGINT AUTO_INCREMENT, parlementaire_id BIGINT, amendement_id VARCHAR(36), numero_signataire BIGINT, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX parlementaire_id_idx (parlementaire_id), INDEX amendement_id_idx (amendement_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = MyISAM;
CREATE TABLE parlementaire_organisme (fonction TEXT, importance BIGINT, debut_fonction DATE, organisme_id BIGINT, parlementaire_id BIGINT, PRIMARY KEY(organisme_id, parlementaire_id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = MyISAM;
CREATE TABLE parlementaire_photo (id BIGINT AUTO_INCREMENT, slug VARCHAR(255), photo LONGTEXT, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = MyISAM;
CREATE TABLE parlementaire_texteloi (id BIGINT AUTO_INCREMENT, parlementaire_id BIGINT, texteloi_id VARCHAR(20), importance BIGINT, fonction VARCHAR(255), created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX parlementaire_id_idx (parlementaire_id), INDEX texteloi_id_idx (texteloi_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = MyISAM;
CREATE TABLE personnalite (id BIGINT AUTO_INCREMENT, nb_commentaires BIGINT, nom VARCHAR(255), nom_de_famille VARCHAR(255), sexe VARCHAR(255), date_naissance DATE, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, slug VARCHAR(255), UNIQUE INDEX personnalite_sluggable_idx (slug), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = MyISAM;
CREATE TABLE presence (id BIGINT AUTO_INCREMENT, parlementaire_id BIGINT, seance_id BIGINT, nb_preuves BIGINT, date DATE, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX parlementaire_id_idx (parlementaire_id), INDEX seance_id_idx (seance_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = MyISAM;
CREATE TABLE preuve_presence (id BIGINT AUTO_INCREMENT, presence_id BIGINT, type VARCHAR(255), source VARCHAR(200), created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX presence_id_idx (presence_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = MyISAM;
CREATE TABLE question (id BIGINT AUTO_INCREMENT, nb_commentaires BIGINT, source VARCHAR(255) UNIQUE, legislature BIGINT, type VARCHAR(255), numero VARCHAR(8), date DATE, date_cloture DATE, ministere TEXT, titre TEXT, question TEXT, reponse TEXT, motif_retrait TEXT, content_md5 VARCHAR(36), parlementaire_id BIGINT, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, UNIQUE INDEX uniq_num_idx (legislature, numero), INDEX parlementaire_id_idx (parlementaire_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = MyISAM;
CREATE TABLE rate (id BIGINT AUTO_INCREMENT, object_type VARCHAR(50), object_id BIGINT, rate BIGINT, citoyen_id BIGINT, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, UNIQUE INDEX unique_idx (object_type, object_id, citoyen_id), INDEX citoyen_id_idx (citoyen_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = MyISAM;
CREATE TABLE seance (id BIGINT AUTO_INCREMENT, nb_commentaires BIGINT, date DATE, numero_semaine BIGINT, annee BIGINT, type VARCHAR(255), moment VARCHAR(30), organisme_id BIGINT, tagged TINYINT(1), session VARCHAR(10), created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, UNIQUE INDEX uniq_index_idx (organisme_id, date, moment), INDEX index_session_idx (session), INDEX index_semaine_idx (annee, numero_semaine), INDEX index_annee_idx (annee), INDEX organisme_id_idx (organisme_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = MyISAM;
CREATE TABLE section (id BIGINT AUTO_INCREMENT, nb_commentaires BIGINT, md5 VARCHAR(36) UNIQUE, titre TEXT, titre_complet TEXT, section_id BIGINT, min_date VARCHAR(15), max_date DATE, timestamp BIGINT, nb_interventions BIGINT, id_dossier_institution VARCHAR(255), created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX section_id_idx (section_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = MyISAM;
CREATE TABLE tag (id BIGINT AUTO_INCREMENT, name VARCHAR(100), is_triple TINYINT(1), triple_namespace VARCHAR(100), triple_key VARCHAR(100), triple_value VARCHAR(100), INDEX name_idx (name), INDEX triple1_idx (triple_namespace), INDEX triple2_idx (triple_key), INDEX triple3_idx (triple_value), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = MyISAM;
CREATE TABLE tagging (id BIGINT AUTO_INCREMENT, tag_id BIGINT NOT NULL, taggable_model VARCHAR(30), taggable_id VARCHAR(20), INDEX tag_idx (tag_id), INDEX taggable_idx (taggable_model, taggable_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = MyISAM;
CREATE TABLE texteloi (id VARCHAR(20) UNIQUE, nb_commentaires BIGINT, numero BIGINT, annexe VARCHAR(12), type VARCHAR(255), type_details TEXT, categorie VARCHAR(128), id_dossier_institution VARCHAR(255), titre TEXT, date DATE, source VARCHAR(128) UNIQUE, organisme_id BIGINT, signataires TEXT, contenu TEXT, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX index_url_idx (id_dossier_institution), INDEX index_alpha_idx (numero, annexe), INDEX index_type_idx (type(30), type_details(200)), INDEX index_date_idx (date), INDEX organisme_id_idx (organisme_id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = MyISAM;
CREATE TABLE titre_loi (id BIGINT AUTO_INCREMENT, nb_commentaires BIGINT, texteloi_id VARCHAR(20), chapitre VARCHAR(8), section VARCHAR(8), titre TEXT, expose TEXT, parlementaire_id BIGINT, date DATE, source VARCHAR(128) UNIQUE, nb_articles BIGINT, titre_loi_id BIGINT, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, INDEX parlementaire_id_idx (parlementaire_id), INDEX titre_loi_id_idx (titre_loi_id), INDEX texteloi_id_idx (texteloi_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = MyISAM;
CREATE TABLE variable_globale (id BIGINT AUTO_INCREMENT, champ VARCHAR(32), value LONGBLOB, created_at DATETIME NOT NULL, updated_at DATETIME NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ENGINE = MyISAM;
ALTER TABLE alerte ADD CONSTRAINT alerte_citoyen_id_citoyen_id FOREIGN KEY (citoyen_id) REFERENCES citoyen(id);
ALTER TABLE alinea ADD CONSTRAINT alinea_texteloi_id_texteloi_id FOREIGN KEY (texteloi_id) REFERENCES texteloi(id);
ALTER TABLE alinea ADD CONSTRAINT alinea_article_loi_id_article_loi_id FOREIGN KEY (article_loi_id) REFERENCES article_loi(id);
ALTER TABLE amendement ADD CONSTRAINT amendement_texteloi_id_texteloi_id FOREIGN KEY (texteloi_id) REFERENCES texteloi(id);
ALTER TABLE amendement ADD CONSTRAINT amendement_organisme_id_organisme_id FOREIGN KEY (organisme_id) REFERENCES organisme(id);
ALTER TABLE article_version ADD CONSTRAINT article_version_id_article_id FOREIGN KEY (id) REFERENCES article(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE article ADD CONSTRAINT article_citoyen_id_citoyen_id FOREIGN KEY (citoyen_id) REFERENCES citoyen(id);
ALTER TABLE article ADD CONSTRAINT article_article_id_article_id FOREIGN KEY (article_id) REFERENCES article(id);
ALTER TABLE article_loi ADD CONSTRAINT article_loi_titre_loi_id_titre_loi_id FOREIGN KEY (titre_loi_id) REFERENCES titre_loi(id);
ALTER TABLE article_loi ADD CONSTRAINT article_loi_texteloi_id_texteloi_id FOREIGN KEY (texteloi_id) REFERENCES texteloi(id);
ALTER TABLE commentaire ADD CONSTRAINT commentaire_citoyen_id_citoyen_id FOREIGN KEY (citoyen_id) REFERENCES citoyen(id);
ALTER TABLE commentaire_object ADD CONSTRAINT commentaire_object_commentaire_id_commentaire_id FOREIGN KEY (commentaire_id) REFERENCES commentaire(id);
ALTER TABLE intervention ADD CONSTRAINT intervention_section_id_section_id FOREIGN KEY (section_id) REFERENCES section(id);
ALTER TABLE intervention ADD CONSTRAINT intervention_seance_id_seance_id FOREIGN KEY (seance_id) REFERENCES seance(id);
ALTER TABLE intervention ADD CONSTRAINT intervention_personnalite_id_personnalite_id FOREIGN KEY (personnalite_id) REFERENCES personnalite(id);
ALTER TABLE intervention ADD CONSTRAINT intervention_parlementaire_id_parlementaire_id FOREIGN KEY (parlementaire_id) REFERENCES parlementaire(id);
ALTER TABLE parlementaire ADD CONSTRAINT parlementaire_suppleant_de_id_parlementaire_id FOREIGN KEY (suppleant_de_id) REFERENCES parlementaire(id);
ALTER TABLE parlementaire_amendement ADD CONSTRAINT parlementaire_amendement_parlementaire_id_parlementaire_id FOREIGN KEY (parlementaire_id) REFERENCES parlementaire(id);
ALTER TABLE parlementaire_amendement ADD CONSTRAINT parlementaire_amendement_amendement_id_amendement_id FOREIGN KEY (amendement_id) REFERENCES amendement(id);
ALTER TABLE parlementaire_organisme ADD CONSTRAINT parlementaire_organisme_parlementaire_id_parlementaire_id FOREIGN KEY (parlementaire_id) REFERENCES parlementaire(id);
ALTER TABLE parlementaire_organisme ADD CONSTRAINT parlementaire_organisme_organisme_id_organisme_id FOREIGN KEY (organisme_id) REFERENCES organisme(id);
ALTER TABLE parlementaire_texteloi ADD CONSTRAINT parlementaire_texteloi_texteloi_id_texteloi_id FOREIGN KEY (texteloi_id) REFERENCES texteloi(id);
ALTER TABLE parlementaire_texteloi ADD CONSTRAINT parlementaire_texteloi_parlementaire_id_parlementaire_id FOREIGN KEY (parlementaire_id) REFERENCES parlementaire(id);
ALTER TABLE presence ADD CONSTRAINT presence_seance_id_seance_id FOREIGN KEY (seance_id) REFERENCES seance(id);
ALTER TABLE presence ADD CONSTRAINT presence_parlementaire_id_parlementaire_id FOREIGN KEY (parlementaire_id) REFERENCES parlementaire(id);
ALTER TABLE preuve_presence ADD CONSTRAINT preuve_presence_presence_id_presence_id FOREIGN KEY (presence_id) REFERENCES presence(id);
ALTER TABLE question ADD CONSTRAINT question_parlementaire_id_parlementaire_id FOREIGN KEY (parlementaire_id) REFERENCES parlementaire(id);
ALTER TABLE rate ADD CONSTRAINT rate_citoyen_id_citoyen_id FOREIGN KEY (citoyen_id) REFERENCES citoyen(id);
ALTER TABLE seance ADD CONSTRAINT seance_organisme_id_organisme_id FOREIGN KEY (organisme_id) REFERENCES organisme(id);
ALTER TABLE section ADD CONSTRAINT section_section_id_section_id FOREIGN KEY (section_id) REFERENCES section(id);
ALTER TABLE texteloi ADD CONSTRAINT texteloi_organisme_id_organisme_id FOREIGN KEY (organisme_id) REFERENCES organisme(id);
ALTER TABLE titre_loi ADD CONSTRAINT titre_loi_titre_loi_id_titre_loi_id FOREIGN KEY (titre_loi_id) REFERENCES titre_loi(id);
ALTER TABLE titre_loi ADD CONSTRAINT titre_loi_texteloi_id_texteloi_id FOREIGN KEY (texteloi_id) REFERENCES texteloi(id);
ALTER TABLE titre_loi ADD CONSTRAINT titre_loi_parlementaire_id_parlementaire_id FOREIGN KEY (parlementaire_id) REFERENCES parlementaire(id);
