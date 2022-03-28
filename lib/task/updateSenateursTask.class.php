<?php

class updateSenateursTask extends sfBaseTask
{
  protected function configure()
  {
    $this->namespace = 'update';
    $this->name = 'Senateurs';
    $this->briefDescription = 'Update Senateurs';
    $this->addOption('env', null, sfCommandOption::PARAMETER_OPTIONAL, 'Changes the environment this task is run in', 'test');
    $this->addOption('app', null, sfCommandOption::PARAMETER_OPTIONAL, 'Changes the environment this task is run in', 'frontend');
  }

  protected function splitArrayJson($json) {
    $res = array();
    foreach($json as $j) {
      if ($j)
	array_push($res, explode(' / ', $j));
    }
    return $res;
  }

  protected function execute($arguments = array(), $options = array())
  {
    $dir = dirname(__FILE__).'/../../batch/senateur/out/';
    $manager = new sfDatabaseManager($this->configuration);

    $villes = json_decode(file_get_contents($dir.'../static/villes.json'));

    $sites = array();
    $row = 0;
    if (($handle = fopen($dir."../twitter.csv", "r")) !== FALSE) {
        fgetcsv($handle);
        while (($data = fgetcsv($handle)) !== FALSE) {
            $row++;
            if ($row == 1) continue;
            $sites[$data[18]] = explode("|", $data[16]);
            $sites[$data[18]][] = "https://twitter.com/".$data[0];
        }
        fclose($handle);
    }

    if (is_dir($dir)) {
      if ($dh = opendir($dir)) {
        while (($file = readdir($dh)) !== false) {
	  $sections = array();
	  if (preg_match('/^\./', $file))
	    continue;
//	  echo "$dir$file\n";
	  foreach(file($dir.$file) as $line) {
	    $json = json_decode($line);
	    if (!isset($json->nom) || !strlen($json->nom)) {
	      echo "WARNING: ".$dir.$file." doesn't appear to be a json file\n";
	      continue;
	    }
	    $json->nom = trim($json->nom);
        if (!isset($json->fin_mandat))
          $json->fin_mandat = "";
	    //	    echo "-".$json->nom.strlen($json->nom)." ".$json->id_institution."\n";
	    if (preg_match('/(\d{4})$/', $json->fin_mandat, $match)) {
              if ($match[1] < 2004) continue;
            }
	    $parl = Doctrine::getTable('Parlementaire')->findOneByNom($json->nom);
	    if (!$parl) {
		echo "WARNING: New senateurs : ".$json->nom." \n";
	      $parl = new Parlementaire();
	      $parl->type = 'senateur';
	      $parl->nom = $json->nom;
	      $parl->nom_de_famille = $json->nom_de_famille;
	      $parl->sexe = $json->sexe;
	    }
	    if ($json->naissance)
               $parl->date_naissance = $json->naissance;
	    if ($json->circonscription)
	      $parl->circonscription = $json->circonscription;
	    if (isset($json->adresses) && $json->adresses)
	      $parl->adresses = $json->adresses;
	    if (isset($json->autresmandats) && $json->autresmandats)
	      $parl->autres_mandats = $json->autresmandats;
	    if ($json->premiers_mandats)
              $parl->anciens_mandats = $json->premiers_mandats;
	    if ($json->groupe)
	      $parl->groupe = $this->splitArrayJson($json->groupe);
            if ($json->fonctions)
              $parl->fonctions = $this->splitArrayJson($json->fonctions);
	    if (isset($json->extras) && $json->extras)
	      $parl->extras = $this->splitArrayJson($json->extras);
	    if ($json->groupes)
	      $parl->groupes = $this->splitArrayJson($json->groupes);
	    $parl->debut_mandat = $json->debut_mandat;
	    $parl->fin_mandat = $json->fin_mandat;
	    if ($json->id_institution)
	      $parl->id_institution = $json->id_institution;
	    if ($json->mails)
		$parl->mails = $json->mails;
	    if ($json->photo)
	      $parl->photo = $json->photo;
	    if ($json->place_hemicycle)
	      $parl->place_hemicycle = $json->place_hemicycle;
	    if ($json->profession)
	      $parl->profession = $json->profession;
        $done_sites = array();
	    if (isset($json->sites_web) && $json->sites_web)
          foreach (array_keys($json->sites_web) as $i) {
            $json->sites_web[$i] = preg_replace("|(://[^/]+)/$|", "$1", $json->sites_web[$i]);
            $done_sites[preg_replace("#^(https?://|www\.)*(.*)$#", "$2", $json->sites_web[$i])] = 1;
          }
        if (isset($sites[$parl->slug]) && $sites[$parl->slug]) {
          foreach ($sites[$parl->slug] as $site) {
            $site = preg_replace("|(://[^/]+)/$|", "$1", $site);
            $rootsite = preg_replace("#^(https?://|www\.)*(.*)$#", "$2", $site);
            if (!isset($done_sites[$rootsite]))
              $json->sites_web[] = $site;
            $done_sites[$rootsite] = 1;
          }
        }
	    if (isset($json->sites_web) && $json->sites_web)
	      $parl->sites_web = $json->sites_web;
	    if ($json->url_institution)
	      $parl->url_institution = $json->url_institution;
	    if (isset($json->suppleant_de))
	      $parl->setSuppleantDe($json->suppleant_de);
            $vi = "";
	    if (isset($villes->{$parl->getNumDepartement()})) foreach(get_object_vars($villes->{$parl->getNumDepartement()}) as $v) {
              if ($vi) $vi .= ", ";
              $vi .= $v;
            }
            $parl->villes = $vi;
	    $parl->save();
	  }
	}
      }
    }
  }
}
