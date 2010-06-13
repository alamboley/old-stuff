package lo43.projet.utboheme.hexagone;

import lo43.projet.utboheme.jeu.Joueur;
import lo43.projet.utboheme.pion.Pion;

/**
 * Classe representant une arete
 * 	- possede un attribut de type Pion pour stocker un controle continu
 * 	- possede un attribut de type Sommet pour definir le sommet de debut
 * 	- possede un attribut de type Sommet pour definit les sommet de fin  
 * @author alexandreaugen
 *
 */
public class Arete {
	
	private Pion controleC;
	private Sommet sDebut;
	private Sommet sFin;
	
	/**
	 * Constructeur par defaut
	 */
	public Arete() {
		this.sDebut = null;
		this.sFin = null;
		this.controleC = null;
	}
	 
	/**
	 * Constructeur parametre
	 * @param psdebut
	 * @param psfin
	 */
	public Arete(Sommet psdebut, Sommet psfin){
		this.sDebut = psdebut;
		this.sFin = psfin;
	}
	
	/**
	 * Renvoi le pion stocke dans l'arete
	 * @return
	 */
	public Pion getControleC() {
		return controleC;
	}
	
	/**
	 * Attribut le pion passe en parametre a "controleC"
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
	 * Test si l'arete possede un pion
	 * @return
	 */
	public boolean hasCC() {
		if (controleC != null)
			return true;
		else {
			return false;
		}
	}
	
	public boolean hasUvOnSomm(Joueur j){
		boolean res = false;
		if(sDebut.hasUV() || sDebut.hasUVStar()) {
			if(sDebut.getUv().getProprietaire() == j) {
				res = true;
			}
		}else if(sFin.hasUV() || sFin.hasUVStar()){
			if(sFin.getUv().getProprietaire() == j) {
				res = true;
			}
		}
		return res;
	}

}
