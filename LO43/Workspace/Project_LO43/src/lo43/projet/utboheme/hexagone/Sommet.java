package lo43.projet.utboheme.hexagone;

import lo43.projet.utboheme.pion.UV;

/**
 * Classe repr�sentant un sommet
 * 	- poss�de une coordonn�e x
 * 	- poss�de une coordonn�e y
 * 	- poss�de un attribut de type UV pour stocker une uv
 * @author alexandreaugen
 *
 */
public class Sommet {
	
	private int xSom;
	private int ySom;
	private UV uv;
	
	/**
	 * Constructeur par d�faut
	 */
	public Sommet() {
		this.xSom = 0;
		this.xSom = 0;
		this.uv = null;
	}
	
	/**
	 * Constructeur param�tr� 
	 * @param px
	 * @param py
	 */
	public Sommet(int px, int py){
		this.xSom = px;
		this.ySom = py;
		System.out.println("Cr�ation d'un sommet a la position x: " + this.getXSom() + " et y: " + this.getYSom());
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
	 * Renvoi l'uv stock�
	 * @return
	 * 	- une uv
	 */
	public UV getUv() {
		return uv;
	}
	
	/**
	 * Attribut le param�tre � l'uv du sommet
	 * @param puv
	 */
	public void setUv(UV puv) {
		this.uv = puv;
	}
	 
	/**
	 * Test si le sommet poss�de une UV
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
