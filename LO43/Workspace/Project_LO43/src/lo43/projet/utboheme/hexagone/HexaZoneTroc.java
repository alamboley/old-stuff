package lo43.projet.utboheme.hexagone;

import lo43.projet.utboheme.carte.TypeCartes;

/**
 * Classe representant les hexagone de zone de troc
 *  - possede un type de troc
 *  - possede un type de carte associe
 * @author alexandreaugen
 *
 */
public class HexaZoneTroc extends Hexagone {
	
	private int typeTroc;
	private TypeCartes typeC;
	
	/**
	 * Constructeur par defaut
	 */
	public HexaZoneTroc() {
		super();
		this.typeTroc = 0;
		this.typeC = null;
		//System.out.println("Creation d'une zone de troc avec constructeur par defaut");
	}
	
	/**
	 * Constructeur parametre
	 * @param pindX
	 * @param pindY
	 * @param psize
	 * @param pbinome
	 * @param ptypeT
	 * @param ptype
	 * @param ptypeC
	 */
	public HexaZoneTroc(int pindX, int pindY, int psize, boolean pbinome, TypeTerrain ptypeT, int ptype, TypeCartes ptypeC) {
		super(pindX, pindY, psize, pbinome, ptypeT);
		this.typeTroc = ptype;
		this.typeC = ptypeC;
		//System.out.println("Creation d'une zone de troc '" + this.getTypeTerr() + "' avec constructeur par recopie");
	}

	/**
	 * Renvoi le type de troc de l'hexagone
	 * @return
	 * 	- un entier
	 */
	public int getTypeTroc() {
		return typeTroc;
	}

	/**
	 * Renvoi le type de carte
	 * @return
	 * 	- un type de carte
	 */
	public TypeCartes getTypeCarte() {
		return typeC;
	}	

}
