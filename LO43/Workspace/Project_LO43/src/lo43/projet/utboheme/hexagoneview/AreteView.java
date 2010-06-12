package lo43.projet.utboheme.hexagoneview;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Rectangle;

import lo43.projet.utboheme.hexagone.Arete;

/**
 * Classe repr�sentant graphiquement une ar�te
 * H�rite de la classe Rectangle
 *  - poss�de un attribut de type Arete pour savoir l'arete � repr�senter
 *  - poss�de une couleur qui prend la valeur du pion pos� sur l'ar�te
 * @author alexandreaugen
 *
 */
@SuppressWarnings("serial")
public class AreteView extends Rectangle{
	
	private Arete arete;
	private Color color;
	
	/**
	 * Constructeur param�tr�
	 * @param pa
	 * @param ptaille
	 */
	public AreteView(Arete pa, int ptaille) {
		super();
		this.arete = pa;
		this.color = Color.white;
		this.setLocation((int)(((arete.getsDebut().getXSom() + arete.getsFin().getXSom())/2) - ptaille/2), (int)(((arete.getsDebut().getYSom() + arete.getsFin().getYSom())/2) - ptaille/2));
		this.setSize(new Dimension(ptaille, ptaille));
	}

	/**
	 * M�thode permettant de peindre le composant
	 * @param g
	 */
	public void paint(Graphics g){
		g.setColor(this.color);
		if(arete.hasCC()) {
			g.setColor(arete.getControleC().getProprietaire().getCouleur());
		}
		g.fillRect((int)this.getX(), (int)this.getY(), (int)this.getWidth(), (int)this.getHeight());
	}
	
	/**
	 * Renvoi l'arete li� � cette repr�sentation graphique
	 * @return
	 */
	public Arete getArete() {
		return arete;
	}

}
