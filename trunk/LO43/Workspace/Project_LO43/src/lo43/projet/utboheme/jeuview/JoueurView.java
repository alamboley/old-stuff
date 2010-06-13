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
import lo43.projet.utboheme.carte.SousTypeCartes;
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
	private Image imgVieu;
	private Image imgCursus;
	private Image imgAncien;
	private Image imgCc;
	private Image imgDecouv;
	private Image imgMono;
	private Image imgPoint;
	
	/**
	 * Constructeur par defaut
	 */
	public JoueurView() {
		super();
		this.joueur = null;
		this.color = null;
		this.img = null;
		this.url = null;
		this.imgActif = null;
		this.imgVieu = null;
		this.imgCursus = null;
		this.imgAncien = null;
		this.imgCc = null;
		this.imgDecouv = null;
		this.imgMono = null;
		this.imgPoint = null;
	}
	
	/**
	 * Constructeur parametre
	 * @param j
	 * @param col
	 * @param url
	 */
	public JoueurView(Joueur j, Color col, String url) {
		this();
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
		Font fontRess = new Font("Comics", Font.BOLD, 12);
		Font fontNum = new Font("Comics", Font.PLAIN, 14);
		Font fontNom = new Font("Comics", Font.PLAIN, 10);
		
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
		
		try {
			this.imgVieu = ImageIO.read(new File("img/carte-ancien-le-plus-vieux.png"));
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		try { 
			this.imgCursus = ImageIO.read(new File("img/carte-cursus-le-plus-long.png"));
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		try { 
			this.imgAncien = ImageIO.read(new File("img/carte-ancien.png"));
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		try { 
			this.imgCc = ImageIO.read(new File("img/carte-cc.png"));
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		try { 
			this.imgDecouv = ImageIO.read(new File("img/carte-decouverte.png"));
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		try { 
			this.imgMono = ImageIO.read(new File("img/carte-monopole.png"));
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		try { 
			this.imgPoint = ImageIO.read(new File("img/carte-point-victoire.png"));
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		// Joueur 1
		if(joueur.getIdent() == 1) {
			g.setColor(new Color(255, 102, 153));
			g.fillRoundRect(80, 20, 740, 110, 30, 30);
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
			g.drawRoundRect(230, 60, 65, 50, 10, 10);
			g.drawRoundRect(310, 60, 455, 50, 10, 10);
			g.drawString("Points", 240, 100);
			g.drawString("Biere", 320, 100);
			g.drawString("Sommeil", 380, 100);
			g.drawString("Cafe", 490, 100);
			g.drawString("Support Cours", 550, 100);
			g.drawString("Nourriture", 670, 100);
			g.setColor(Color.black);
			g.setFont(fontNum);
			g.drawString(String.valueOf(joueur.getNbPoints()), 255, 80);
			g.drawString(String.valueOf(joueur.getNbCartes(TypeCartes.BIERE)), 330, 80);
			g.drawString(String.valueOf(joueur.getNbCartes(TypeCartes.SOMMEIL)), 420, 80);
			g.drawString(String.valueOf(joueur.getNbCartes(TypeCartes.CAFE)), 500, 80);
			g.drawString(String.valueOf(joueur.getNbCartes(TypeCartes.SUPPORT)), 600, 80);
			g.drawString(String.valueOf(joueur.getNbCartes(TypeCartes.NOURRITURE)), 700, 80);
			if(joueur.isActif()) {
				g.drawImage(imgActif, 90, 30, this);
			}
			if(joueur.isAncien()) {
				g.drawImage(imgVieu, 220, 15, 45, 45, this);
			}
			if(joueur.isCursus()) {
				g.drawImage(imgCursus, 270, 15, 45, 45, this);
			}
			if(joueur.getNbCartesDev(SousTypeCartes.ANCIEN) > 0 || joueur.getNbCartesDevJoue(SousTypeCartes.ANCIEN) > 0) {
				g.drawImage(imgAncien, 320, 15, 45, 45, this);
				g.setColor(Color.orange);
				g.drawString(": "+joueur.getNbCartesDevJoue(SousTypeCartes.ANCIEN), 370, 35);
				g.setColor(Color.black);
				g.drawString(": "+joueur.getNbCartesDev(SousTypeCartes.ANCIEN), 370, 50);
			}
			if(joueur.getNbCartesDev(SousTypeCartes.CONSTRUCTIONCC) > 0 || joueur.getNbCartesDevJoue(SousTypeCartes.CONSTRUCTIONCC) > 0) {
				g.drawImage(imgCc, 400, 15, 45, 45, this);
				g.setColor(Color.orange);
				g.drawString(": "+joueur.getNbCartesDevJoue(SousTypeCartes.CONSTRUCTIONCC), 450, 35);
				g.setColor(Color.black);
				g.drawString(": "+joueur.getNbCartesDev(SousTypeCartes.CONSTRUCTIONCC), 450, 50);
			}
			if(joueur.getNbCartesDev(SousTypeCartes.DECOUVERTE) > 0 || joueur.getNbCartesDevJoue(SousTypeCartes.DECOUVERTE) > 0) {
				g.drawImage(imgDecouv, 480, 15, 45, 45, this);
				g.setColor(Color.orange);
				g.drawString(": "+joueur.getNbCartesDevJoue(SousTypeCartes.DECOUVERTE), 530, 35);
				g.setColor(Color.black);
				g.drawString(": "+joueur.getNbCartesDev(SousTypeCartes.DECOUVERTE), 530, 50);
			}
			if(joueur.getNbCartesDev(SousTypeCartes.MONOPOLE) > 0 || joueur.getNbCartesDevJoue(SousTypeCartes.MONOPOLE) > 0) {
				g.drawImage(imgMono, 560, 15, 45, 45, this);
				g.setColor(Color.orange);
				g.drawString(": "+joueur.getNbCartesDevJoue(SousTypeCartes.MONOPOLE), 610, 35);
				g.setColor(Color.black);
				g.drawString(": "+joueur.getNbCartesDev(SousTypeCartes.MONOPOLE), 610, 50);
			}
			if(joueur.getNbCartesDev(SousTypeCartes.POINTVICTOIRE) > 0  || joueur.getNbCartesDevJoue(SousTypeCartes.POINTVICTOIRE) > 0) {
				g.drawImage(imgPoint, 640, 15, 45, 45, this);
				g.setColor(Color.orange);
				g.drawString(": "+joueur.getNbCartesDevJoue(SousTypeCartes.POINTVICTOIRE), 690, 35);
				g.setColor(Color.black);
				g.drawString(": "+joueur.getNbCartesDev(SousTypeCartes.POINTVICTOIRE), 690, 50);
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
			g.drawRoundRect(10, 100, 110, 50, 10, 10);
			g.drawRoundRect(10, 160, 110, 300, 10, 10);
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
			if(joueur.isAncien()){
				g.drawImage(imgVieu, 120, 90, 45, 45, this);			
			}
			if(joueur.isCursus()) {
				g.drawImage(imgCursus, 120, 140, 45, 45, this);
			}
			if(joueur.getNbCartesDev(SousTypeCartes.ANCIEN) > 0 || joueur.getNbCartesDevJoue(SousTypeCartes.ANCIEN) > 0) {
				g.drawImage(imgAncien, 120, 190, 45, 45, this);
				g.setColor(Color.orange);
				g.drawString(": "+joueur.getNbCartesDevJoue(SousTypeCartes.ANCIEN), 145, 245);
				g.setColor(Color.black);
				g.drawString(": "+joueur.getNbCartesDev(SousTypeCartes.ANCIEN), 125, 245);
			}
			if(joueur.getNbCartesDev(SousTypeCartes.CONSTRUCTIONCC) > 0 || joueur.getNbCartesDevJoue(SousTypeCartes.CONSTRUCTIONCC) > 0) {
				g.drawImage(imgCc, 120, 250, 45, 45, this);
				g.setColor(Color.orange);
				g.drawString(": "+joueur.getNbCartesDevJoue(SousTypeCartes.CONSTRUCTIONCC), 145, 305);
				g.setColor(Color.black);
				g.drawString(": "+joueur.getNbCartesDev(SousTypeCartes.CONSTRUCTIONCC), 125, 305);
			}
			if(joueur.getNbCartesDev(SousTypeCartes.DECOUVERTE) > 0 || joueur.getNbCartesDevJoue(SousTypeCartes.DECOUVERTE) > 0) {
				g.drawImage(imgDecouv, 120, 310, 45, 45, this);
				g.setColor(Color.orange);
				g.drawString(": "+joueur.getNbCartesDevJoue(SousTypeCartes.DECOUVERTE), 145, 365);
				g.setColor(Color.black);
				g.drawString(": "+joueur.getNbCartesDev(SousTypeCartes.DECOUVERTE), 125, 365);
			}
			if(joueur.getNbCartesDev(SousTypeCartes.MONOPOLE) > 0 || joueur.getNbCartesDevJoue(SousTypeCartes.MONOPOLE) > 0) {
				g.drawImage(imgMono, 120, 370, 45, 45, this);
				g.setColor(Color.orange);
				g.drawString(": "+joueur.getNbCartesDevJoue(SousTypeCartes.MONOPOLE), 145, 425);
				g.setColor(Color.black);
				g.drawString(": "+joueur.getNbCartesDev(SousTypeCartes.MONOPOLE), 125, 425);
			}
			if(joueur.getNbCartesDev(SousTypeCartes.POINTVICTOIRE) > 0  || joueur.getNbCartesDevJoue(SousTypeCartes.POINTVICTOIRE) > 0) {
				g.drawImage(imgPoint, 120, 430, 45, 45, this);
				g.setColor(Color.orange);
				g.drawString(": "+joueur.getNbCartesDevJoue(SousTypeCartes.POINTVICTOIRE), 145, 485);
				g.setColor(Color.black);
				g.drawString(": "+joueur.getNbCartesDev(SousTypeCartes.POINTVICTOIRE), 125, 485);
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
			if(joueur.isAncien()){
				g.drawImage(imgVieu, 220, 80, 45, 45, this);
			}
			if(joueur.isCursus()) {
				g.drawImage(imgCursus, 270, 80, 45, 45, this);
			}
			if(joueur.getNbCartesDev(SousTypeCartes.ANCIEN) > 0 || joueur.getNbCartesDevJoue(SousTypeCartes.ANCIEN) > 0) {
				g.drawImage(imgAncien, 320, 80, 45, 45, this);
				g.setColor(Color.orange);
				g.drawString(": "+joueur.getNbCartesDevJoue(SousTypeCartes.ANCIEN), 370, 95);
				g.setColor(Color.black);
				g.drawString(": "+joueur.getNbCartesDev(SousTypeCartes.ANCIEN), 370, 110);
			}
			if(joueur.getNbCartesDev(SousTypeCartes.CONSTRUCTIONCC) > 0 || joueur.getNbCartesDevJoue(SousTypeCartes.CONSTRUCTIONCC) > 0) {
				g.drawImage(imgCc, 400, 80, 45, 45, this);
				g.setColor(Color.orange);
				g.drawString(": "+joueur.getNbCartesDevJoue(SousTypeCartes.CONSTRUCTIONCC), 450, 95);
				g.setColor(Color.black);
				g.drawString(": "+joueur.getNbCartesDev(SousTypeCartes.CONSTRUCTIONCC), 450, 110);
			}
			if(joueur.getNbCartesDev(SousTypeCartes.DECOUVERTE) > 0 || joueur.getNbCartesDevJoue(SousTypeCartes.DECOUVERTE) > 0) {
				g.drawImage(imgDecouv, 480, 80, 45, 45, this);
				g.setColor(Color.orange);
				g.drawString(": "+joueur.getNbCartesDevJoue(SousTypeCartes.DECOUVERTE), 530, 95);
				g.setColor(Color.black);
				g.drawString(": "+joueur.getNbCartesDev(SousTypeCartes.DECOUVERTE), 530, 110);
			}
			if(joueur.getNbCartesDev(SousTypeCartes.MONOPOLE) > 0 || joueur.getNbCartesDevJoue(SousTypeCartes.MONOPOLE) > 0) {
				g.drawImage(imgMono, 560, 80, 45, 45, this);
				g.setColor(Color.orange);
				g.drawString(": "+joueur.getNbCartesDevJoue(SousTypeCartes.MONOPOLE), 610, 95);
				g.setColor(Color.black);
				g.drawString(": "+joueur.getNbCartesDev(SousTypeCartes.MONOPOLE), 610, 110);
			}
			if(joueur.getNbCartesDev(SousTypeCartes.POINTVICTOIRE) > 0 || joueur.getNbCartesDevJoue(SousTypeCartes.POINTVICTOIRE) > 0) {
				g.drawImage(imgPoint, 640, 80, 45, 45, this);
				g.setColor(Color.orange);
				g.drawString(": "+joueur.getNbCartesDevJoue(SousTypeCartes.POINTVICTOIRE), 690, 95);
				g.setColor(Color.black);
				g.drawString(": "+joueur.getNbCartesDev(SousTypeCartes.POINTVICTOIRE), 690, 110);
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
