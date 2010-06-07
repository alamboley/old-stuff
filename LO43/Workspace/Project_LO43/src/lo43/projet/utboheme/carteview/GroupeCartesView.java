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

public class GroupeCartesView extends JPanel{
	
	private GroupeCartes gCartes;
	
	public GroupeCartesView(GroupeCartes pgc) {
		super();
		this.gCartes = pgc;
		this.setPreferredSize(new Dimension(100, 100));
	}
	
	public void paintComponent(Graphics g) {
		Image img = null;
		
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
		
		
		g.drawImage(img, 0, 0, this);
		g.drawString("" + gCartes.getNombre(), 40, 20);
		
	}

}
