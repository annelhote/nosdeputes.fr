<?php

class loadCommissionTask extends sfBaseTask
{
  protected function configure()
  {
    $this->namespace = 'load';
    $this->name = 'Commission';
    $this->briefDescription = 'Load Commission data';
    $this->addOption('env', null, sfCommandOption::PARAMETER_OPTIONAL, 'Changes the environment this task is run in', 'prod');
    $this->addOption('app', null, sfCommandOption::PARAMETER_OPTIONAL, 'Changes the environment this task is run in', 'frontend');
  }
 
  protected function execute($arguments = array(), $options = array())
  {
    // your code here
    $dir = dirname(__FILE__).'/../../batch/commission/out/';
    $manager = new sfDatabaseManager($this->configuration);    

    if (is_dir($dir)) {
      if ($dh = opendir($dir)) {
        $count = 0;
        while (($file = readdir($dh)) !== false) {
          $sections = array();
	  if (preg_match('/^\./', $file))
	    continue;
	  echo "$dir$file\n";
          $debug = 1;
          if (!filesize($dir.$file)) {
                echo "ERROR file empty : $file\n";
		unlink($dir.$file);
                continue;
          }
          if ($count == 50)
            exit(1);
          $count++;
	  $lines = file($dir.$file);
	  if (count($lines) <= 1) {
	    echo "ERROR: file should have more than 1 line ($file)\n";
	    unlink($dir.$file);
	    continue;
	  }
	  $oldSeance = 0;
	  foreach($lines as $line) {
	    $json = json_decode($line);
            $error = 0;
            if (!$json)
                $error = "cannot parse json";
            else if (!$json->intervention)
                $error = "pas d'intervention";
            else if (!$json->date)
                $error = "pas de date";
            else if (!$json->commission)
                $error = "pas de nom de commission";
            else if (!$json->source)
                $error = "pas de source";
            if ($error) {
              echo "ERROR json ($error): ";
              echo $line;
              echo "\n => ";
              print_r($json);
              $contraints = get_defined_constants(true);
              print_r($contraints["json"]);
              continue;
            }
	    if ($json->session < 20042005) {
	      echo "saute séance trop vieille : ".$json->session."\n";
              break;
            }
	    $json->intervention = html_entity_decode($json->intervention, ENT_NOQUOTES, "UTF-8");
	    $json->commission = html_entity_decode($json->commission, ENT_NOQUOTES, "UTF-8");
	    $json->contexte = html_entity_decode($json->contexte, ENT_NOQUOTES, "UTF-8");
	    if (strlen($json->commission) > 255) {
	      $json->commission = preg_replace('/ \S+$/', '', substr($json->commission, 0, 255));
	    }

            $date = $json->date;
	    $id = md5($json->intervention.$json->date.$json->heure.$json->commission.$json->timestamp);
	    $intervention = Doctrine::getTable('Intervention')->findOneByMd5($id);
	    if (!$intervention) {
	      $oldid = md5($json->intervention.$json->date.$json->heure.$json->commission);
	      $intervention = Doctrine::getTable('Intervention')->findOneByMd5($oldid);
	    }

	    if ($oldSeance && !$intervention) { 
	      $inter = Doctrine::getTable('Intervention')->findOneBySeanceTimestamp($oldSeance, $json->timestamp); 
	      if ($inter) { 
		$res = similar_text($inter->getIntervention(), $json->intervention, $pc); 
		if ($res > 0 && $pc > 75) 
		  $intervention = $inter; 
		$intervention->setIntervention($json->intervention); 
		$intervention->md5 = $id; 
		echo "WARNING : Intervention en double trouvée : seance/".$oldSeance."#inter_".$id."\n";  
	      } 
	    } 
	    
	    if(!$intervention) {
	      $intervention = new Intervention();
	      $intervention->md5 = $id;
	      $intervention->setIntervention($json->intervention);
              $intervention->date = $json->date;
	      $intervention->setSeance('commission', $json->date, $json->heure, $json->session, $json->commission);
	      $intervention->setSource($json->source);
	      $intervention->setTimestamp($json->timestamp);
	    }else $oldSeance = $intervention->seance_id;
	    if ($intervention->md5 != $id) {
	      $intervention->md5 = $id;
	    }
            if (!isset($json->numeros_loi))
              $json->numeros_loi = '';
            if ($json->timestamp) {
              $debug = $intervention->setContexte($json->contexte, $json->date.$json->heure, $json->timestamp, $json->numeros_loi, $debug);
            }
            if (isset($json->amendements))
              $intervention->setAmendements($json->amendements);
	    if ($json->intervenant) {
              $p = null;
              if ($json->intervenant_url) {
                $p = Doctrine::getTable('Parlementaire')
                  ->findOneByUrlInstitution($json->intervenant_url);
                if ($p) {
                  $intervention->setParlementaire($p);
                  $intervention->setFonction($json->fonction);
                }
              }
              if (!$p) {
                $intervention->setPersonnaliteByNom($json->intervenant, $json->fonction);
              }
	    }
	    $intervention->save();
            if (!isset($sections[$intervention->getSection()->id]))
              $sections[$intervention->getSection()->id] = $intervention->getSection();
	  }
          foreach(array_values($sections) as $section) {
	    if ($section) {
              $section->updateNbInterventions();
              $section->setMaxDate($date);
            }
          }
	  unlink($dir.$file);
	}
        closedir($dh);
      }
    }
  }
}
