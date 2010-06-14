package lo43.projet.utboheme.hexagone;

import lo43.projet.utboheme.carte.TypeCartes;

/**
 * Classe representant les hexagones de ressources
 * Herite de Hexagone
 * 	- possede un jeton 
 * 	- possede un type de cartes associe a son type de terrain
 * @author alexandreaugen
 *
 */
public class HexaRessource extends Hexagone {
	
	private Jeton jeton;
	private TypeCartes typeCartes;
	
	/**
	 * Constructeur par defaut
	 */
	public HexaRessource() {
		super();
		this.jeton = null;
		this.typeCartes = null;
		System.out.println("Creation d'un hexagone de ressource avec constructeur par defaut");
	}
	
	/**
	 * Constructeur parametre
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
		System.out.println("Creation d'un hexagone de ressource '" + this.getTypeTerr() + "' avec constructeur par recopie");
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
	 * Attribut un jeton a l'hexagone
	 * @param pjeton
	 * @return
	 * 	- un hexagone de ressource
	 */
	public HexaRessource setJeton(Jeton pjeton) {
		this.jeton = pjeton;
		return this;
	}
	
	/**
	 * Renvoi le type de cartes associe a l'hexagone
	 * @return
	 * 	- un type de cartes
	 */
	public TypeCartes getTypeCartes() {
		return typeCartes;
	}

	/**
	 * Methode de positionnement d'un hexagone de ressource
	 */
	public HexaRessource setPosition(int pxHex, int pyHex) {
		this.setXHex(pxHex);
		this.setYHex(pyHex);
		this.InitHexa();
		return this;
	}
}
