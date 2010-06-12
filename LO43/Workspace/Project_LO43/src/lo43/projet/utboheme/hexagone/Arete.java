package lo43.projet.utboheme.hexagone;

import lo43.projet.utboheme.pion.Pion;

/**
 * Classe repr�sentant une ar�te
 * 	- poss�de un attribut de type Pion pour stocker un contr�le continu
 * 	- poss�de un attribut de type Sommet pour d�finir le sommet de debut
 * 	- poss�de un attribut de type Sommet pour d�finit les sommet de fin  
 * @author alexandreaugen
 *
 */
public class Arete {
	
	private Pion controleC;
	private Sommet sDebut;
	private Sommet sFin;
	
	/**
	 * Constructeur par d�faut
	 */
	public Arete() {
		this.sDebut = null;
		this.sFin = null;
		this.controleC = null;
	}
	 
	/**
	 * Constructeur param�tr�
	 * @param psdebut
	 * @param psfin
	 */
	public Arete(Sommet psdebut, Sommet psfin){
		this.sDebut = psdebut;
		this.sFin = psfin;
	}
	
	/**
	 * Renvoi le pion stock� dans l'ar�te
	 * @return
	 */
	public Pion getControleC() {
		return controleC;
	}
	
	/**
	 * Attribut le pion pass� en param�tre � "controleC"
	 * @param pcontrolec
	 */
	public void setControleC(Pion pcontrolec) {
		this.controleC = pcontrolec;
	}

	/**
	 * Renvoi le sommet de debut
	 * @return
	 */
	public Sommet getsDebut() {
		return sDebut;
	}

	/**
	 * Renvoi le sommet de fin
	 * @return
	 */
	public Sommet getsFin() {
		return sFin;
	}
	
	/**
	 * Test si l'ar�te poss�de un pion
	 * @return
	 */
	public boolean hasCC() {
		if (controleC != null)
			return true;
		else {
			return false;
		}
	}

}
