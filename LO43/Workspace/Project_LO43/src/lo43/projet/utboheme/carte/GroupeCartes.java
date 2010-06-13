package lo43.projet.utboheme.carte;

/**
 * Classe representant un groupes de cartes
 * 	- possede un nombre de cartes
 * 	- possede un type de cartes
 * @author alexandreaugen
 *
 */
public class GroupeCartes {

	private int nombre;
	private TypeCartes typeCartes;
	
	/**
	 * Constructeur par defaut
	 */
	public GroupeCartes() {
		this.nombre = 0;
		this.typeCartes = null;
	}
	
	/**
	 * Constructeur parametre
	 * @param pnb
	 * @param ptypeC
	 */
	public GroupeCartes(int pnb, TypeCartes ptypeC) {
		this.nombre = pnb;
		this.typeCartes = ptypeC;
	}
	
	/**
	 * Renvoi le nombre de cartes
	 * @return 
	 * 	- nombre : int
	 */
	public int getNombre() {
		return nombre;
	}
	
	public void setNombre(int nb) {
		this.nombre = nb;
	}

	
	/**
	 * Renvoi le type du Groupe de cartes
	 * @return
	 * 	- typeCartes : TypeCartes
	 */
	public TypeCartes getTypeCartes() {
		return typeCartes;
	}
	
	/**
	 * Permet d'ajouter un nombre "pnb" de cartes a un groupe de cartes
	 * @param pnb
	 */
	public void addCartes(int pnb) {
		this.nombre += pnb;
	}
	
	/**
	 * Permet de retirer un nombre "pnb" de cartes a un groupe de cartes
	 * @param pnb
	 */
	public void remCartes(int pnb) {
		this.nombre -= pnb;
	}

}
