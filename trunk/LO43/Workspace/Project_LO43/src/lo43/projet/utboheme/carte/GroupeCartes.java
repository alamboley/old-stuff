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
	 * Constructeur avec parametres : nombre et type de cartes
	 */
	public GroupeCartes(int pnb, TypeCartes ptypeC) {
		this.nombre = pnb;
		this.typeCartes = ptypeC;
	}
	
	/**
	 * Renvoie le nombre de cartes
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
	 * Renvoie le type du Groupe de cartes
	 * @return
	 * 	- typeCartes : TypeCartes
	 */
	public TypeCartes getTypeCartes() {
		return typeCartes;
	}
	
	/**
	 * Permet d'ajouter un nombre "pnb" de cartes a un groupe de cartes
	 */
	public void addCartes(int pnb) {
		this.nombre += pnb;
	}
	
	/**
	 * Permet de retirer un nombre "pnb" de cartes a un groupe de cartes
	 */
	public void remCartes(int pnb) {
		if(pnb <= nombre){
			this.nombre -= pnb;
		}else {
			this.nombre = 0;
		}
	}

}
