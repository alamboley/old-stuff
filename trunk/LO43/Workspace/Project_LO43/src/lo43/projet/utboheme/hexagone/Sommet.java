package lo43.projet.utboheme.hexagone;

import lo43.projet.utboheme.pion.UV;

/**
 * Classe représentant un sommet
 * 	- possède une coordonnée x
 * 	- possède une coordonnée y
 * 	- possède un attribut de type UV pour stocker une uv
 * @author alexandreaugen
 *
 */
public class Sommet {
	
	private int xSom;
	private int ySom;
	private UV uv;
	
	/**
	 * Constructeur par défaut
	 */
	public Sommet() {
		this.xSom = 0;
		this.xSom = 0;
		this.uv = null;
	}
	
	/**
	 * Constructeur paramétré 
	 * @param px
	 * @param py
	 */
	public Sommet(int px, int py){
		this.xSom = px;
		this.ySom = py;
		System.out.println("Création d'un sommet a la position x: " + this.getXSom() + " et y: " + this.getYSom());
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
	 * Renvoi l'uv stocké
	 * @return
	 * 	- une uv
	 */
	public UV getUv() {
		return uv;
	}
	
	/**
	 * Attribut le paramétre à l'uv du sommet
	 * @param puv
	 */
	public void setUv(UV puv) {
		this.uv = puv;
	}
	 
	/**
	 * Test si le sommet possède une UV
	 * @return
	 */
	public boolean hasUV() {
		if(uv != null) 
			return true;
		else {
			return false;
		}
	}

}
