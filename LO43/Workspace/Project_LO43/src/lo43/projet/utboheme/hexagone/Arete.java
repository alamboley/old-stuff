package lo43.projet.utboheme.hexagone;

import lo43.projet.utboheme.jeu.Joueur;
import lo43.projet.utboheme.pion.Pion;

/**
 * Classe representant une arete
 * 	- possede un attribut de type Pion pour stocker un controle continu
 * 	- possede un attribut de type Sommet pour definir le sommet de debut
 * 	- possede un attribut de type Sommet pour definir les sommets de fin  
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
	 */
	public Arete(Sommet psdebut, Sommet psfin){
		this.sDebut = psdebut;
		this.sFin = psfin;
	}
	
	/**
	 * Renvoie le pion stocke dans l'arete
	 * @return l'objet controle continu associe a l'arete
	 */
	public Pion getControleC() {
		return controleC;
	}
	
	/**
	 * Attribue le pion passe en parametre a "controleC"
	 */
	public void setControleC(Pion pcontrolec) {
		this.controleC = pcontrolec;
	}

	/**
	 * Renvoie le sommet de debut
	 */
	public Sommet getsDebut() {
		return sDebut;
	}

	/**
	 * Renvoie le sommet de fin
	 */
	public Sommet getsFin() {
		return sFin;
	}
	
	/**
	 * Teste si l'arete possede un pion
	 * @return true si c'est le cas, false sinon
	 */
	public boolean hasCC() {
		if (controleC != null)
			return true;
		else {
			return false;
		}
	}
	
	/**
	 * Teste si l'arete possede une uv ou uv** du joueur j sur ces sommets
	 * @param j
	 * @return
	 * 	- un boolean
	 */
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
