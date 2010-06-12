package lo43.projet.utboheme.carte;

/**
 * Classes représentant groupes de cartes de développement
 * Hérite de la classe GroupeCartes
 * 	- possède les attributs et méthodes de la classe GroupeCartes
 * 	- possède un sous type de carte de développement 
 * @author alexandreaugen
 *
 */
public class GroupeCartesDev extends GroupeCartes {
	
	private SousTypeCartes sousTypeCartes;
	
	/**
	 * Constructeur par défaut
	 */
	public GroupeCartesDev() {
		super();
		this.sousTypeCartes = null;
	}
	
	/**
	 * Constructeur paramétré
	 * @param nb
	 * @param type
	 * @param sstype
	 */
	public GroupeCartesDev(int nb, TypeCartes type, SousTypeCartes sstype) {
		super(nb, type);
		this.sousTypeCartes = sstype;
	}

	/**
	 * Renvoi le sous type de cartes du groupe de cartes de dévellopement
	 * @return
	 * 	- sousTypeCartes : SousTypesCartes
	 */
	public SousTypeCartes getSousTypeCartes() {
		return sousTypeCartes;
	}

}
