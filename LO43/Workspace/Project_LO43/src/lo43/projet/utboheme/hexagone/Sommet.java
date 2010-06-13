package lo43.projet.utboheme.hexagone;

import lo43.projet.utboheme.pion.UV;

/**
 * Classe representant un sommet
 * 	- possede une coordonnee x
 * 	- possede une coordonnee y
 * 	- possede un attribut de type UV pour stocker une uv
 * @author alexandreaugen
 *
 */
public class Sommet {
	
	private int xSom;
	private int ySom;
	private UV uv;
	
	/**
	 * Constructeur par defaut
	 */
	public Sommet() {
		this.xSom = 0;
		this.xSom = 0;
		this.uv = null;
	}
	
	/**
	 * Constructeur parametre 
	 * @param px
	 * @param py
	 */
	public Sommet(int px, int py){
		this.xSom = px;
		this.ySom = py;
		System.out.println("Creation d'un sommet a la position x: " + this.getXSom() + " et y: " + this.getYSom());
	}
	
	/**
	 * Renvoi la position du sommet sur x
	 * @return
	 * 	- un entier
	 */
	public int getXSom() {
		return xSom;
	}

	/**
	 * Renvoi la position du sommet sur y
	 * @return
	 * 	- un entier
	 */
	public int getYSom() {
		return ySom;
	}

	/**
	 * Renvoi l'uv stocke
	 * @return
	 * 	- une uv
	 */
	public UV getUv() {
		return uv;
	}
	
	/**
	 * Attribut le parametre a l'uv du sommet
	 * @param puv
	 */
	public void setUv(UV puv) {
		this.uv = puv;
	}
	 
	/**
	 * Test si le sommet possede une UV
	 * @return
	 */
	public boolean hasUV() {
		if(uv != null && !uv.isDoubleEtoile()) 
			return true;
		else {
			return false;
		}
	}
	
	/**
	 * Test si le sommet possede une UV**
	 * @return
	 */
	public boolean hasUVStar() {
		if(uv != null && uv.isDoubleEtoile()) 
			return true;
		else {
			return false;
		}
	}

}
