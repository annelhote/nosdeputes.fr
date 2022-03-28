<?php

/**
 * BaseParlementairePhoto
 * 
 * This class has been auto-generated by the Doctrine ORM Framework
 * 
 * @property string $slug
 * @property clob $photo
 * 
 * @method string             getSlug()  Returns the current record's "slug" value
 * @method clob               getPhoto() Returns the current record's "photo" value
 * @method ParlementairePhoto setSlug()  Sets the current record's "slug" value
 * @method ParlementairePhoto setPhoto() Sets the current record's "photo" value
 * 
 * @package    senat
 * @subpackage model
 * @author     Your name here
 * @version    SVN: $Id: Builder.php 7490 2010-03-29 19:53:27Z jwage $
 */
abstract class BaseParlementairePhoto extends sfDoctrineRecord
{
    public function setTableDefinition()
    {
        $this->setTableName('parlementaire_photo');
        $this->hasColumn('slug', 'string', 255, array(
             'type' => 'string',
             'length' => 255,
             ));
        $this->hasColumn('photo', 'clob', null, array(
             'type' => 'clob',
             ));

        $this->option('type', 'MyISAM');
        $this->option('collate', 'utf8_unicode_ci');
        $this->option('charset', 'utf8');
    }

    public function setUp()
    {
        parent::setUp();
        
    }
}