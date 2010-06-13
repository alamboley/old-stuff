package lo43.projet.utboheme.jeuview;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Image;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.swing.JPanel;

import lo43.projet.utboheme.carte.TypeCartes;
import lo43.projet.utboheme.jeu.Joueur;

/**
 * Classe representant graphiquement un joueur
 * Herite de JPanel
 * 	- possede un attribut de type joueur pour savoir le joueur a representer
 *  - possede une couleur
 *  - possede une image
 *  - possede une url pour l'image
 *  - possede une image pour savoir s'il est le joueur actif
 * @author alexandreaugen
 *
 */
@SuppressWarnings("serial")
public class JoueurView extends JPanel {

	private Joueur joueur;
	private Color color;
	private Image img;
	private String url;
	private Image imgActif;
	
	/**
	 * Constructeur par defaut
	 */
	public JoueurView() {
		this.joueur = null;
		this.color = null;
		this.img = null;
		this.url = null;
	}
	
	/**
	 * Constructeur parametre
	 * @param j
	 * @param col
	 * @param url
	 */
	public JoueurView(Joueur j, Color col, String url) {
		super();
		this.joueur = j;
		this.color = col;
		this.url = url;
		this.setPreferredSize(new Dimension(170, 120));
		
	}
	
	/**
	 * Methode pour peindre le composant
	 */
	public void paintComponent(Graphics g) {
		
		//Definition de font
		Font fontPion = new Font("Comics", Font.ITALIC, 9);
		Font fontRess = new Font("Comics", Font.BOLD, 14);
		Font fontNum = new Font("Comics", Font.PLAIN, 18);
		Font fontNom = new Font("Comics", Font.PLAIN, 12);
		
		// Lecture des images
		try {
			this.img = ImageIO.read(new File(this.url));
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		try {
			this.imgActif = ImageIO.read(new File("img/de-icone.png"));
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		// Joueur 1
		if(joueur.getIdent() == 1) {
			g.setColor(new Color(255, 102, 153));
			g.fillRoundRect(80, 10, 740, 120, 30, 30);
			g.drawImage(this.img, 110, 50, this);
			g.setColor(Color.black);
			g.setFont(fontPion);
			g.drawString("CCs : ", 170, 60);
			g.drawString(String.valueOf(joueur.getNbCC()), 200, 60);
			g.drawString("UVs : ", 170, 75);
			g.drawString(String.valueOf(joueur.getNbUV()), 200, 75);
			g.drawString("UVs** : ", 170, 90);
			g.drawString(String.valueOf(joueur.getNbUVStar()), 210, 90);
			g.setColor(this.color);
			g.setFont(fontNom);
			g.drawString(this.joueur.getNom(), 120, 110);
			g.setFont(fontRess);
			g.drawRoundRect(230, 50, 65, 60, 10, 10);
			g.drawRoundRect(310, 50, 455, 60, 10, 10);
			g.drawString("Points", 240, 100);
			g.drawString("Biere", 320, 100);
			g.drawString("Sommeil", 380, 100);
			g.drawString("Cafe", 490, 100);
			g.drawString("Support Cours", 550, 100);
			g.drawString("Nourriture", 670, 100);
			g.setColor(Color.black);
			g.setFont(fontNum);
			g.drawString(String.valueOf(joueur.getNbPoints()), 255, 75);
			g.drawString(String.valueOf(joueur.getNbCartes(TypeCartes.BIERE)), 330, 75);
			g.drawString(String.valueOf(joueur.getNbCartes(TypeCartes.SOMMEIL)), 420, 75);
			g.drawString(String.valueOf(joueur.getNbCartes(TypeCartes.CAFE)), 500, 75);
			g.drawString(String.valueOf(joueur.getNbCartes(TypeCartes.SUPPORT)), 600, 75);
			g.drawString(String.valueOf(joueur.getNbCartes(TypeCartes.NOURRITURE)), 700, 75);
			if(joueur.isActif()) {
				g.drawImage(imgActif, 90, 30, this);
			}
		
		// Joueur 2
		}else if(joueur.getIdent() == 2) {
			g.setColor(new Color(153, 255, 255));
			g.fillRoundRect(0, 5, 160, 508, 30, 30);
			g.drawImage(this.img, 30, 10, this);
			g.setColor(Color.black);
			g.setFont(fontPion);
			g.drawString("CCs : ", 90, 20);
			g.drawString(String.valueOf(joueur.getNbCC()), 120, 20);
			g.drawString("UVs : ", 90, 35);
			g.drawString(String.valueOf(joueur.getNbUV()), 120, 35);
			g.drawString("UVs** : ", 90, 50);
			g.drawString(String.valueOf(joueur.getNbUVStar()), 130, 50);
			g.setColor(this.color);
			g.setFont(fontNom);
			g.drawString(this.joueur.getNom(), 40, 70);
			g.setFont(fontRess);
			g.drawRoundRect(10, 100, 130, 50, 10, 10);
			g.drawRoundRect(10, 160, 130, 300, 10, 10);
			g.drawString("Points", 20, 140);
			g.drawString("Biere", 20, 210);
			g.drawString("Sommeil", 20, 270);
			g.drawString("Cafe", 20, 330);
			g.drawString("Support Cours", 20, 390);
			g.drawString("Nourriture", 20, 450);
			g.setColor(Color.black);
			g.setFont(fontNum);
			g.drawString(String.valueOf(joueur.getNbPoints()), 60, 120);
			g.drawString(String.valueOf(joueur.getNbCartes(TypeCartes.BIERE)), 60, 190);
			g.drawString(String.valueOf(joueur.getNbCartes(TypeCartes.SOMMEIL)), 60, 250);
			g.drawString(String.valueOf(joueur.getNbCartes(TypeCartes.CAFE)), 60, 310);
			g.drawString(String.valueOf(joueur.getNbCartes(TypeCartes.SUPPORT)), 60, 370);
			g.drawString(String.valueOf(joueur.getNbCartes(TypeCartes.NOURRITURE)), 60, 430);
			if(joueur.isActif()) {
				g.drawImage(imgActif, 2, 4, this);
			}
			
		// Joueur 3
		}else if(joueur.getIdent() == 3) {
			g.setColor(new Color(153, 255, 153));
			g.fillRoundRect(80, 0, 740, 118, 30, 30);
			g.drawImage(this.img, 110, 20, this);
			g.setColor(Color.black);
			g.setFont(fontPion);
			g.drawString("CCs : ", 170, 30);
			g.drawString(String.valueOf(joueur.getNbCC()), 200, 30);
			g.drawString("UVs : ", 170, 45);
			g.drawString(String.valueOf(joueur.getNbUV()), 200, 45);
			g.drawString("UVs** : ", 170, 60);
			g.drawString(String.valueOf(joueur.getNbUVStar()), 210, 60);
			g.setColor(this.color);
			g.setFont(fontNom);
			g.drawString(this.joueur.getNom(), 120, 80);
			g.setFont(fontRess);
			g.drawRoundRect(230, 10, 65, 70, 10, 10);
			g.drawRoundRect(310, 10, 455, 70, 10, 10);
			g.drawString("Points", 240, 30);
			g.drawString("Biere", 320, 30);
			g.drawString("Sommeil", 380, 30);
			g.drawString("Cafe", 490, 30);
			g.drawString("Support Cours", 550, 30);
			g.drawString("Nourriture", 670, 30);
			g.setColor(Color.black);
			g.setFont(fontNum);
			g.drawString(String.valueOf(joueur.getNbPoints()), 255, 60);
			g.drawString(String.valueOf(joueur.getNbCartes(TypeCartes.BIERE)), 330, 60);
			g.drawString(String.valueOf(joueur.getNbCartes(TypeCartes.SOMMEIL)), 420, 60);
			g.drawString(String.valueOf(joueur.getNbCartes(TypeCartes.CAFE)), 500, 60);
			g.drawString(String.valueOf(joueur.getNbCartes(TypeCartes.SUPPORT)), 600, 60);
			g.drawString(String.valueOf(joueur.getNbCartes(TypeCartes.NOURRITURE)), 700, 60);
			if(joueur.isActif()) {
				g.drawImage(imgActif, 85, 2, this);
			}
		}		
	}

	/**
	 * Renvoi le joueur associe a la representation graphique 
	 * @return
	 * 	- un joueur
	 */
	public Joueur getJoueur() {
		return joueur;
	}
	
}
