<div id="ecrire"></div><?php echo $form->renderFormTag(url_for('@commentaire_post?type='.$type.'&id='.$id)); ?>
<table class="commentaires_table">
  <tr>
    <th colspan="3" style="text-align:left;"><?php echo $form['commentaire']->renderLabel() ?></th>
  </tr>
  <tr>
    <td colspan="3">
      <?php echo $form['commentaire']->renderError();
      if (myTools::isCommentairesLocked()) echo '<p class="flash_error">'.(myTools::isFinLegislature() ? 'Cette législature étant désormais achevée, les commentaires sont désactivés.<br/>Vous pouvez commenter les travaux des nouveaux députés sur le <a href="https://www.nosdeputes.fr">NosDéputés.fr de la législature en cours</a>' : 'Pour raisons techniques, le dépôt des commentaires est momentanément désactivé').'.</p></td></tr>';
      else {
        echo $form['commentaire']->render(); ?>
    </td>
  </tr>
  <?php if (!$sf_user->isAuthenticated()) { ?>
  <tr>
    <td>
      <table class="inscription">
	    <tr>
		  <th colspan="3">Inscription</th>
		</tr>
	    <tr>
		  <th><?php echo $form['nom']->renderLabel(); ?></th>
		  <td>
		  <?php echo $form['nom']->renderError(); ?>
          <?php echo $form['nom']; ?>
		  </td>
		</tr>
	    <tr>
		  <th><?php echo $form['email']->renderLabel(); ?></th>
		  <td>
		  <?php echo $form['email']->renderError(); ?>
          <?php echo $form['email']; ?>
		  </td>
		</tr>
      </table>
	</td>
	<th>ou</th>
	<td>
	  <table class="connexion">
	    <tr>
		  <th colspan="3">Connexion</th>
		</tr>
		<tr>
		  <th><?php echo $form['login']->renderLabel(); ?></th>
		  <td>
		  <?php echo $form['login']->renderError(); ?>
          <?php echo $form['login']; ?>
		  </td>
		</tr>
		<tr>
		  <th><?php echo $form['password']->renderLabel(); ?></th>
		  <td colspan="2">
		  <?php echo $form['password']->renderError(); ?>
          <?php echo $form['password']; ?>
		  </td>
		</tr>
      </table>
	</td>
  </tr>
  <?php } ?>
  <tr><td><input type="checkbox" name="follow_talk" id="follow_talk"<?php if  ($follow_talk) echo " checked"; ?>/><label for="follow_talk">M'alerter par e-mail lorsque quelqu'un réagit à mon commentaire</label></td></tr>
  <tr>
    <td colspan="3" style="height:40px;">
      <input type="hidden" name="unique_form" value="<?php echo $unique_form; ?>"/>
      <input type='submit' value='Prévisualiser'/>
      <?php if (isset($sendButton)) : ?>
      <input type='submit' name='ok' value='Envoyer'/>
      <?php endif; ?>
    </td>
  </tr>
  <?php } ?>
</table>
</form>
