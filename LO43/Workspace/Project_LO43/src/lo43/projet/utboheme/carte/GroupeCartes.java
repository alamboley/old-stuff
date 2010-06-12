package lo43.projet.utboheme.carte;

/**
 * Classe représentant un groupes de cartes
 * 	- possède un nombre de cartes
 * 	- possède un type de cartes
 * @author alexandreaugen
 *
 */
public class GroupeCartes {

	private int nombre;
	private TypeCartes typeCartes;
	
	/**
	 * Constructeur par défaut
	 */
	public GroupeCartes() {
		this.nombre = 0;
		this.typeCartes = null;
	}
	
	/**
	 * Constructeur paramétré
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
	
	/**
	 * Attribut le nombre passé en paramétre à "nombre" 
	 * @param nb
	 */
	public void setNombre(int nb){
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
	 * Permet d'ajouter un nombre "pnb" de cartes à un groupe de cartes
	 * @param pnb
	 */
	public void addCartes(int pnb) {
		this.setNombre(this.getNombre() + pnb);
	}
	
	/**
	 * Permet de retirer un nombre "pnb" de cartes à un groupe de cartes
	 * @param pnb
	 */
	public void remCartes(int pnb) {
		this.setNombre(this.getNombre() - pnb);
	}

}
