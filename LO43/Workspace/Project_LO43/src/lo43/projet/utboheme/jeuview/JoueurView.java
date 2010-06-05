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
		System.out.println(System.getProperty("user.dir"));
	}
	
	public void paintComponent(Graphics g) {
		
		//g.fillRect(10, 10, 10, 10);
		
		
		try {
			this.img = ImageIO.read(new File(this.url));
			g.drawImage(this.img, 0, 0, this);
			
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
