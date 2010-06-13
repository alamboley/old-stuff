package lo43.projet.utboheme.hexagoneview;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.Rectangle;

import lo43.projet.utboheme.hexagone.Sommet;

/**
 * Classe repr�sentant graphiquement un sommet
 * H�rite de Rectangle
 * 	- poss�de un attribut de type sommet pour connaitre le sommet � repr�senter
 *  - poss�de une couleur qui prend la valeur de l'uv pos� sur le sommet
 * @author alexandreaugen
 *
 */
@SuppressWarnings("serial")
public class SommetView extends Rectangle{
	
	private Sommet sommet;
	private Color color;
	
	/**
	 * Constructeur param�tr�
	 * @param ps
	 * @param ptaille
	 */
	public SommetView(Sommet ps, int ptaille){
		super();
		this.sommet = ps;
		this.setLocation(sommet.getXSom() - ptaille/2, sommet.getYSom() - ptaille/2);
		this.setSize(ptaille, ptaille);
		this.color = Color.white;
	}
	
	/**
	 * M�thode permettant de peindre le composant
	 * @param g
	 */
	public void paint(Graphics g){
		if(sommet.hasUV()) {
			g.setColor(sommet.getUv().getProprietaire().getCouleur());
			g.fillOval((int)this.getX(), (int)this.getY(), (int)this.getWidth(), (int)this.getHeight());
		}else if(sommet.hasUVStar()) {
			g.setColor(sommet.getUv().getProprietaire().getCouleur());
			int[] ptsX1 = {(int)this.getX()+((int)getWidth()/2), (int)this.getX()+(int)getWidth(), (int)this.getX()};
			int[] ptsY1 = {(int)this.getY(), (int)this.getY()+(int)getHeight(), (int)this.getY()+(int)getHeight()};
			g.fillPolygon(ptsX1, ptsY1, 3);
		}else{
			g.setColor(this.color);
			g.fillOval((int)this.getX(), (int)this.getY(), (int)this.getWidth(), (int)this.getHeight());
		}
	}
	
	/**
	 * Renvoi le sommet associ� � cette repr�sentation graphique
	 * @return
	 * 	- un sommet
	 */
	public Sommet getSommet() {
		return this.sommet;
	}
	
}
