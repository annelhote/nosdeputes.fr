<?php

/**
 * BaseCitoyen
 * 
 * This class has been auto-generated by the Doctrine ORM Framework
 * 
 * @property string $login
 * @property string $password
 * @property string $email
 * @property string $activite
 * @property string $url_site
 * @property boolean $employe_institution
 * @property integer $travail_pour
 * @property date $naissance
 * @property enum $sexe
 * @property string $nom_circo
 * @property integer $num_circo
 * @property blob $photo
 * @property string $activation_id
 * @property boolean $is_active
 * @property enum $role
 * @property timestamp $last_login
 * @property string $parametres
 * @property Doctrine_Collection $Commentaires
 * @property Doctrine_Collection $Rates
 * @property Doctrine_Collection $Articles
 * @property Doctrine_Collection $Alertes
 * 
 * @method string              getLogin()               Returns the current record's "login" value
 * @method string              getPassword()            Returns the current record's "password" value
 * @method string              getEmail()               Returns the current record's "email" value
 * @method string              getActivite()            Returns the current record's "activite" value
 * @method string              getUrl_site()            Returns the current record's "url_site" value
 * @method boolean             getEmployE_institution() Returns the current record's "employe_institution" value
 * @method integer             getTravail_pour()        Returns the current record's "travail_pour" value
 * @method date                getNaissaNce()           Returns the current record's "naissance" value
 * @method enum                getSexe()                Returns the current record's "sexe" value
 * @method string              getNom_circo()           Returns the current record's "nom_circo" value
 * @method integer             getNum_circo()           Returns the current record's "num_circo" value
 * @method blob                getPhoto()               Returns the current record's "photo" value
 * @method string              getActivAtion_id()       Returns the current record's "activation_id" value
 * @method boolean             getIs_actIve()           Returns the current record's "is_active" value
 * @method enum                getRole()                Returns the current record's "role" value
 * @method timestamp           getLast_Login()          Returns the current record's "last_login" value
 * @method string              getParametres()          Returns the current record's "parametres" value
 * @method Doctrine_Collection getCommentaires()        Returns the current record's "Commentaires" collection
 * @method Doctrine_Collection getRates()               Returns the current record's "Rates" collection
 * @method Doctrine_Collection getArticles()            Returns the current record's "Articles" collection
 * @method Doctrine_Collection getAlertes()             Returns the current record's "Alertes" collection
 * @method Citoyen             setLogin()               Sets the current record's "login" value
 * @method Citoyen             setPassword()            Sets the current record's "password" value
 * @method Citoyen             setEmail()               Sets the current record's "email" value
 * @method Citoyen             setActivite()            Sets the current record's "activite" value
 * @method Citoyen             setUrl_site()            Sets the current record's "url_site" value
 * @method Citoyen             setEmployE_institution() Sets the current record's "employe_institution" value
 * @method Citoyen             setTravail_pour()        Sets the current record's "travail_pour" value
 * @method Citoyen             setNaissaNce()           Sets the current record's "naissance" value
 * @method Citoyen             setSexe()                Sets the current record's "sexe" value
 * @method Citoyen             setNom_circo()           Sets the current record's "nom_circo" value
 * @method Citoyen             setNum_circo()           Sets the current record's "num_circo" value
 * @method Citoyen             setPhoto()               Sets the current record's "photo" value
 * @method Citoyen             setActivAtion_id()       Sets the current record's "activation_id" value
 * @method Citoyen             setIs_actIve()           Sets the current record's "is_active" value
 * @method Citoyen             setRole()                Sets the current record's "role" value
 * @method Citoyen             setLast_Login()          Sets the current record's "last_login" value
 * @method Citoyen             setParametres()          Sets the current record's "parametres" value
 * @method Citoyen             setCommentaires()        Sets the current record's "Commentaires" collection
 * @method Citoyen             setRates()               Sets the current record's "Rates" collection
 * @method Citoyen             setArticles()            Sets the current record's "Articles" collection
 * @method Citoyen             setAlertes()             Sets the current record's "Alertes" collection
 * 
 * @package    senat
 * @subpackage model
 * @author     Your name here
 * @version    SVN: $Id: Builder.php 7490 2010-03-29 19:53:27Z jwage $
 */
abstract class BaseCitoyen extends sfDoctrineRecord
{
    public function setTableDefinition()
    {
        $this->setTableName('citoyen');
        $this->hasColumn('login', 'string', 128, array(
             'type' => 'string',
             'unique' => true,
             'length' => 128,
             ));
        $this->hasColumn('password', 'string', 40, array(
             'type' => 'string',
             'length' => 40,
             ));
        $this->hasColumn('email', 'string', 255, array(
             'type' => 'string',
             'unique' => true,
             'notnull' => true,
             'length' => 255,
             ));
        $this->hasColumn('activite', 'string', 255, array(
             'type' => 'string',
             'length' => 255,
             ));
        $this->hasColumn('url_site', 'string', 255, array(
             'type' => 'string',
             'length' => 255,
             ));
        $this->hasColumn('employe_institution', 'boolean', null, array(
             'type' => 'boolean',
             'default' => 0,
             ));
        $this->hasColumn('travail_pour', 'integer', null, array(
             'type' => 'integer',
             ));
        $this->hasColumn('naissance', 'date', null, array(
             'type' => 'date',
             ));
        $this->hasColumn('sexe', 'enum', null, array(
             'type' => 'enum',
             'values' => 
             array(
              0 => NULL,
              1 => 'H',
              2 => 'F',
             ),
             ));
        $this->hasColumn('nom_circo', 'string', 255, array(
             'type' => 'string',
             'length' => 255,
             ));
        $this->hasColumn('num_circo', 'integer', null, array(
             'type' => 'integer',
             ));
        $this->hasColumn('photo', 'blob', null, array(
             'type' => 'blob',
             ));
        $this->hasColumn('activation_id', 'string', 32, array(
             'type' => 'string',
             'length' => 32,
             ));
        $this->hasColumn('is_active', 'boolean', null, array(
             'type' => 'boolean',
             'default' => 0,
             ));
        $this->hasColumn('role', 'enum', null, array(
             'type' => 'enum',
             'values' => 
             array(
              0 => 'membre',
              1 => 'moderateur',
              2 => 'admin',
             ),
             'default' => 'membre',
             ));
        $this->hasColumn('last_login', 'timestamp', null, array(
             'type' => 'timestamp',
             ));
        $this->hasColumn('parametres', 'string', null, array(
             'type' => 'string',
             ));


        $this->index('is_active', array(
             'fields' => 
             array(
              0 => 'is_active',
             ),
             ));
        $this->index('role', array(
             'fields' => 
             array(
              0 => 'role',
             ),
             ));
        $this->option('type', 'MyISAM');
        $this->option('collate', 'utf8_unicode_ci');
        $this->option('charset', 'utf8');
    }

    public function setUp()
    {
        parent::setUp();
        $this->hasMany('Commentaire as Commentaires', array(
             'local' => 'id',
             'foreign' => 'citoyen_id'));

        $this->hasMany('Rate as Rates', array(
             'local' => 'id',
             'foreign' => 'citoyen_id'));

        $this->hasMany('Article as Articles', array(
             'local' => 'id',
             'foreign' => 'citoyen_id'));

        $this->hasMany('Alerte as Alertes', array(
             'local' => 'id',
             'foreign' => 'citoyen_id'));

        $timestampable0 = new Doctrine_Template_Timestampable();
        $sluggable0 = new Doctrine_Template_Sluggable(array(
             'fields' => 
             array(
              0 => 'login',
             ),
             'unique' => true,
             ));
        $this->actAs($timestampable0);
        $this->actAs($sluggable0);
    }
}