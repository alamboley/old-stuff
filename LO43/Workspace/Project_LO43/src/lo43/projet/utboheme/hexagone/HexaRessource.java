package lo43.projet.utboheme.hexagone;

import lo43.projet.utboheme.carte.TypeCartes;

/**
 * Classe repr�sentant les hexagones de ressources
 * H�rite de Hexagone
 * 	- poss�de un jeton 
 * 	- poss�de un type de cartes associ� � son type de terrain
 * @author alexandreaugen
 *
 */
public class HexaRessource extends Hexagone {
	
	private Jeton jeton;
	private TypeCartes typeCartes;
	
	/**
	 * Constructeur par d�faut
	 */
	public HexaRessource() {
		super();
		this.jeton = null;
		this.typeCartes = null;
		System.out.println("Cr�ation d'un hexagone de ressource avec constructeur par d�faut");
	}
	
	/**
	 * Constructeur param�tr�
	 * @param pindX
	 * @param pindY
	 * @param psize
	 * @param pbinome
	 * @param ptypeT
	 * @param ptypeC
	 * @param pjeton
	 */
	public HexaRessource(int pindX, int pindY, int psize, boolean pbinome, TypeTerrain ptypeT, TypeCartes ptypeC, Jeton pjeton) {
		super(pindX, pindY, psize, pbinome, ptypeT);
		this.jeton = pjeton;
		this.typeCartes = ptypeC;
		System.out.println("Cr�ation d'un hexagone de ressource '" + this.getTypeTerr() + "' avec constructeur par recopie");
	}

	/**
	 * Renvoi le jeton de l'hexagone
	 * @return
	 * 	- un jeton
	 */
	public Jeton getJeton() {
		return this.jeton;
	}

	/**
	 * Attribut un jeton � l'hexagone
	 * @param pjeton
	 * @return
	 * 	- un hexagone de ressource
	 */
	public HexaRessource setJeton(Jeton pjeton) {
		this.jeton = pjeton;
		return this;
	}
	
	/**
	 * Renvoi le type de cartes associ� � l'hexagone
	 * @return
	 * 	- un type de cartes
	 */
	public TypeCartes getTypeCartes() {
		return typeCartes;
	}

	/**
	 * M�thode de positionnement d'un hexagone de ressource
	 */
	public HexaRessource setPosition(int pxHex, int pyHex) {
		this.setXHex(pxHex);
		this.setYHex(pyHex);
		this.InitHexa();
		return this;
	}
	 
	

}
