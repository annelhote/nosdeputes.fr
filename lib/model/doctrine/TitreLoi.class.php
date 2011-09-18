<?php

/**
 * This class has been auto-generated by the Doctrine ORM Framework
 */
class TitreLoi extends BaseTitreLoi
{

  public function setAuteur($senateur) {
    $sexe = null;
    if (preg_match('/^\s*(M+[\s\.ml]{1})[a-z]*\s*([dA-Z].*)\s*$/', $senateur, $match)) {
        $nom = $match[2];
        if (preg_match('/M[ml]/', $match[1]))
          $sexe = 'F';
        else $sexe = 'H';
    } else $nom = preg_replace("/^\s*(.*)\s*$/", "\\1", $senateur);
    $senateur = Doctrine::getTable('Parlementaire')->findOneByNomSexeGroupeCirco($nom, $sexe);
    if (!$senateur) print "ERROR: Auteur introuvable in ".$this->source." : ".$nom." // ".$sexe."\n";
    else {
      $this->_set('Parlementaire', $senateur);
    }
  }

  public function getLargeTitre() {
    $titre = '';
    if ($this->titre_loi_id != $this->id) {
      if (isset($this->chapitre) && $this->chapitre != 0) {
        $titre .= '<a href="@loi_chapitre">Chapitre '.$this->chapitre;
        if (isset($this->section) && $this->section != 0)
          $titre .= '</a> - <a href="@loi_section">section '.$this->section;
        $titre .= ' : '.$this->titre.'</a>';
      }
    }
    return $titre;
  }

  public function getDossier() {
    $section = Doctrine_Query::create()
      ->select('s.id')
      ->from('Section s, Tagging ta, Tag t')
      ->where('s.section_id = s.id')
      ->andWhere('ta.taggable_id = s.id')
      ->andWhere('ta.tag_id = t.id')
      ->andWhere('ta.taggable_model = ?', "Section")
      ->andWhere('t.name = ?', "loi:numero=".preg_replace('/^(\d+)-.*/', '\\1', $this->texteloi_id))
      ->fetchOne();
    return $section;
  }

}
