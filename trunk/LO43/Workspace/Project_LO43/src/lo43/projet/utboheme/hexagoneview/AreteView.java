package lo43.projet.utboheme.hexagoneview;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Rectangle;

import lo43.projet.utboheme.hexagone.Arete;

/**
 * Classe représentant graphiquement une arête
 * Hérite de la classe Rectangle
 *  - possède un attribut de type Arete pour savoir l'arete à représenter
 *  - possède une couleur qui prend la valeur du pion posé sur l'arête
 * @author alexandreaugen
 *
 */
@SuppressWarnings("serial")
public class AreteView extends Rectangle{
	
	private Arete arete;
	private Color color;
	
	/**
	 * Constructeur paramétré
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
	 * Méthode permettant de peindre le composant
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
	 * Renvoi l'arete lié à cette représentation graphique
	 * @return
	 */
	public Arete getArete() {
		return arete;
	}

}
