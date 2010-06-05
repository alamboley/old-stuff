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
import lo43.projet.utboheme.pion.Pion;

@SuppressWarnings("serial")

public class JoueurView extends JPanel {

	private Joueur joueur;
	private Color color;
	private Image img;
	private String url;
	
	
	public JoueurView(Joueur j, Color col, String url) {
		super();
		this.joueur = j;
		this.color = col;
		this.url = url;
		if (joueur.getIdent() == 1 || joueur.getIdent() == 3) {
			this.setPreferredSize(new Dimension(800, 120));
		}else {
			this.setPreferredSize(new Dimension(170, 800));
		}
	}
	
	public void paintComponent(Graphics g) {
		
		Font fontPion = new Font("Comics", Font.ITALIC, 9);
		Font fontRess = new Font("Comics", Font.BOLD, 14);
		Font fontNum = new Font("Comics", Font.PLAIN, 18);
		Font fontNom = new Font("Comics", Font.PLAIN, 12);
		
		try {
			this.img = ImageIO.read(new File(this.url));
		} catch (IOException e) {
			// TODO Auto-generated catch block
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
			g.drawRoundRect(230, 40, 65, 70, 10, 10);
			g.drawRoundRect(310, 40, 455, 70, 10, 10);
			g.drawString("Points", 240, 90);
			g.drawString("Bars", 320, 90);
			g.drawString("Lieux Repos", 380, 90);
			g.drawString("Cafés", 490, 90);
			g.drawString("Support Cours", 550, 90);
			g.drawString("Restaurants", 670, 90);
			g.setColor(Color.black);
			g.setFont(fontNum);
			g.drawString(String.valueOf(joueur.getNbPoints()), 255, 65);
			g.drawString(String.valueOf(joueur.getNbCartes(TypeCartes.BIERE)), 330, 65);
			g.drawString(String.valueOf(joueur.getNbCartes(TypeCartes.SOMMEIL)), 420, 65);
			g.drawString(String.valueOf(joueur.getNbCartes(TypeCartes.CAFE)), 500, 65);
			g.drawString(String.valueOf(joueur.getNbCartes(TypeCartes.SUPPORT)), 600, 65);
			g.drawString(String.valueOf(joueur.getNbCartes(TypeCartes.NOURRITURE)), 700, 65);
		
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
			g.drawRoundRect(10, 80, 130, 50, 10, 10);
			g.drawRoundRect(10, 140, 130, 300, 10, 10);
			g.drawString("Points", 20, 120);
			g.drawString("Bars", 20, 190);
			g.drawString("Lieux Repos", 20, 250);
			g.drawString("Cafés", 20, 310);
			g.drawString("Support Cours", 20, 370);
			g.drawString("Restaurants", 20, 430);
			g.setColor(Color.black);
			g.setFont(fontNum);
			g.drawString(String.valueOf(joueur.getNbPoints()), 60, 100);
			g.drawString(String.valueOf(joueur.getNbCartes(TypeCartes.BIERE)), 60, 170);
			g.drawString(String.valueOf(joueur.getNbCartes(TypeCartes.SOMMEIL)), 60, 230);
			g.drawString(String.valueOf(joueur.getNbCartes(TypeCartes.CAFE)), 60, 290);
			g.drawString(String.valueOf(joueur.getNbCartes(TypeCartes.SUPPORT)), 60, 350);
			g.drawString(String.valueOf(joueur.getNbCartes(TypeCartes.NOURRITURE)), 60, 410);
		
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
			g.drawString("Bars", 320, 30);
			g.drawString("Lieux Repos", 380, 30);
			g.drawString("Cafés", 490, 30);
			g.drawString("Support Cours", 550, 30);
			g.drawString("Restaurants", 670, 30);
			g.setColor(Color.black);
			g.setFont(fontNum);
			g.drawString(String.valueOf(joueur.getNbPoints()), 255, 60);
			g.drawString(String.valueOf(joueur.getNbCartes(TypeCartes.BIERE)), 330, 60);
			g.drawString(String.valueOf(joueur.getNbCartes(TypeCartes.SOMMEIL)), 420, 60);
			g.drawString(String.valueOf(joueur.getNbCartes(TypeCartes.CAFE)), 500, 60);
			g.drawString(String.valueOf(joueur.getNbCartes(TypeCartes.SUPPORT)), 600, 60);
			g.drawString(String.valueOf(joueur.getNbCartes(TypeCartes.NOURRITURE)), 700, 60);
		}		
	}

	public Joueur getJoueur() {
		return joueur;
	}

	public void setJoueur(Joueur joueur) {
		this.joueur = joueur;
	}
	
	
}
