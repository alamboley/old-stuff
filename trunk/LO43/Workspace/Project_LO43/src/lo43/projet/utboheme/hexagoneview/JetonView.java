package lo43.projet.utboheme.hexagoneview;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Rectangle;

import lo43.projet.utboheme.hexagone.Jeton;

/**
 * Classe representant graphiquement un jeton
 * Herite de Rectangle
 * 	- possede un attribut de type jeton pour connaitre le jeton a representer
 * 	- possede une couleur
 * @author alexandreaugen
 *
 */
@SuppressWarnings("serial")
public class JetonView extends Rectangle{
	
	private Jeton jeton;
	private Color color;
	
	/**
	 * Constructeur parametre
	 * @param pj
	 * @param px
	 * @param py
	 * @param ptaille
	 */
	public JetonView(Jeton pj, int px, int py, int ptaille) {
		super();
		this.jeton = pj;
		this.setLocation(px - ptaille/2, py - ptaille/2);
		this.setSize(ptaille, ptaille);
		this.color = Color.darkGray;
	}
	
	/**
	 * Methode permettant de peindre le composant
	 * @param g
	 */
	public void paint(Graphics g){
		
		g.setColor(this.color);
		g.fillOval((int)this.getX(), (int)this.getY(), (int)this.getWidth(), (int)this.getHeight());
		
		//selon la valeur le texte est rouge ou blanc
		if(this.jeton.getNumero() == 6 || this.jeton.getNumero() == 8) {
			g.setColor(Color.red);
		}else{
			g.setColor(Color.white);
		}
		
		g.setFont(new Font("Comics", Font.CENTER_BASELINE, (int)(this.getWidth()/1.5)));
		g.drawString(String.valueOf(jeton.getNumero()), (int)(this.getX() + this.getWidth()/5), (int)(this.getY() + this.getWidth()/1.5));
	}

}
