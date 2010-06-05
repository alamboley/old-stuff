package lo43.projet.utboheme.jeuview;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Image;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.swing.JPanel;

import lo43.projet.utboheme.jeu.Joueur;

@SuppressWarnings("serial")

public class JoueurView extends JPanel {

	private Joueur joueur;
	private Color color;
	private Image img;
	private String url;
	private Graphics g;
	
	public JoueurView() {
		
		super();
		this.setPreferredSize(new Dimension(100, 100));
	}
	
	public JoueurView(Joueur j, Color col, String url) {
		
		super();
		this.setPreferredSize(new Dimension(100, 100));
		this.joueur = j;
		this.color = col;
		this.url = url;
	}
	
	public void paintComponent(Graphics g) {
		
		try {
			
			switch (this.joueur.getIdJoueur()) {
			case 0 :
				this.img = ImageIO.read(new File(this.url));
				g.drawImage(this.img, 10, 10, this);
				System.out.println("Je suis 0");
				break;
				
			case 1 :
				this.img = ImageIO.read(new File(this.url));
				g.drawImage(this.img, 10, 100, this);
				System.out.println("Je suis 1");
				break;
			
			case 2 :
				this.img = ImageIO.read(new File(this.url));
				g.drawImage(this.img, 300, 600, this);
				System.out.println("Je suis 2");
				break;
				
			default:
				System.out.println("Problème affichage perso");
				break;
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
