package lo43.projet.utboheme.hexagone;

import lo43.projet.utboheme.carte.TypeCartes;

/**
 * Classe représentant les hexagone de zone de troc
 *  - possède un type de troc
 *  - possède un type de carte associé
 * @author alexandreaugen
 *
 */
public class HexaZoneTroc extends Hexagone {
	
	private int typeTroc;
	private TypeCartes typeC;
	
	/**
	 * Constructeur par défaut
	 */
	public HexaZoneTroc() {
		super();
		this.typeTroc = 0;
		this.typeC = null;
		System.out.println("Création d'une zone de troc avec constructeur par défaut");
	}
	
	/**
	 * Constructeur paramétré
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
		System.out.println("Création d'une zone de troc '" + this.getTypeTerr() + "' avec constructeur par recopie");
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
