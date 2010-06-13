package lo43.projet.utboheme.carteview;

import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Image;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.swing.JPanel;

import lo43.projet.utboheme.carte.GroupeCartes;
import lo43.projet.utboheme.carte.TypeCartes;

/**
 * Classe representant graphiquement les classes GroupeCartes et GroupeCartesDev
 * Herite de JPanel
 * 	- possede un attribut de type GroupeCartes pour savoir quel GroupeCarte est a representer
 * @author alexandreaugen
 *
 */
@SuppressWarnings("serial")
public class GroupeCartesView extends JPanel{
	
	private GroupeCartes gCartes;
	
	/**
	 * Constructeur parametre
	 */
	public GroupeCartesView(GroupeCartes pgc) {
		super();
		this.gCartes = pgc;
		this.setPreferredSize(new Dimension(60, 60));
	}
	
	/**
	 * Methode permettant de peindre le composant
	 */
	public void paintComponent(Graphics g) {
		Image img = null;
		
		// On teste le type du groupe de carte pour changer l'attribut image associee
		try {
			if(gCartes.getTypeCartes() == TypeCartes.BIERE) {
				img = ImageIO.read(new File("img/carte-biere.png"));
			}else if(gCartes.getTypeCartes() == TypeCartes.SOMMEIL) {
				img = ImageIO.read(new File("img/carte-lit.png"));
			}else if(gCartes.getTypeCartes() == TypeCartes.CAFE) {
				img = ImageIO.read(new File("img/carte-caffe.png"));
			}else if(gCartes.getTypeCartes() == TypeCartes.SUPPORT) {
				img = ImageIO.read(new File("img/carte-cours.png"));
			}else if(gCartes.getTypeCartes() == TypeCartes.NOURRITURE) {
				img = ImageIO.read(new File("img/carte-nourriture.png"));
			}else if(gCartes.getTypeCartes() == TypeCartes.DEVELOPPEMENT) {
				img = ImageIO.read(new File("img/carte-developpement.png"));
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		// On dessine l'image
		g.drawImage(img, 0, 0, 60, 60, this);
		// On dessine le nombre de cartes du groupe de cartes associe
		g.drawString("" + gCartes.getNombre(), 20, 10);
		
	}

}
