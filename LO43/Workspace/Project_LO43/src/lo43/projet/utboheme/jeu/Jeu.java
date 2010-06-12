package lo43.projet.utboheme.jeu;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import lo43.projet.utboheme.carte.GroupeCartes;
import lo43.projet.utboheme.carte.GroupeCartesDev;
import lo43.projet.utboheme.carte.SousTypeCartes;
import lo43.projet.utboheme.carte.TypeCartes;
import lo43.projet.utboheme.hexagone.Arete;
import lo43.projet.utboheme.hexagone.Sommet;
import lo43.projet.utboheme.jeuview.JeuFrame;

/**
 * Classe représentant le jeu
 * 	- possède un attribut tour 
 * 	- possède un attribut pour la valeur du dé
 * 	- possède un attribut plateau ou se déroule les actions
 *  - possède une liste de joueurs (participants)
 *  - possède une liste de groupe de cartes (réserve)
 * @author alexandreaugen
 *
 */
public class Jeu {
	
	private int tour;
	private int valeurDes;
	private Plateau plateau;
	private List<Joueur> participants;
	private List<GroupeCartes> reserve;
	
	/**
	 * Constructeur par défaut
	 */
	public Jeu(){
		this.tour = 1;
		this.valeurDes = 0;
		this.plateau = null;
		this.participants = null;
		this.reserve = null;
	}
	
	/**
	 * Constructeur paramétré
	 * @param pp
	 */
	public Jeu(Plateau pp) {
		this();
		this.plateau = pp;
		
		this.participants = new ArrayList<Joueur>();
		
		//Création par défaut des groupes de cartes qui composent la réserve
		this.reserve = new ArrayList<GroupeCartes>();
		this.reserve.add(new GroupeCartes(19, TypeCartes.BIERE));
		this.reserve.add(new GroupeCartes(19, TypeCartes.SOMMEIL));
		this.reserve.add(new GroupeCartes(19, TypeCartes.CAFE));
		this.reserve.add(new GroupeCartes(19, TypeCartes.SUPPORT));
		this.reserve.add(new GroupeCartes(19, TypeCartes.NOURRITURE));
		this.reserve.add(new GroupeCartesDev(2, TypeCartes.DEVELOPPEMENT, SousTypeCartes.CONSTRUCTIONCC));
		this.reserve.add(new GroupeCartesDev(2, TypeCartes.DEVELOPPEMENT, SousTypeCartes.DECOUVERTE));
		this.reserve.add(new GroupeCartesDev(2, TypeCartes.DEVELOPPEMENT, SousTypeCartes.MONOPOLE));
		this.reserve.add(new GroupeCartesDev(5, TypeCartes.DEVELOPPEMENT, SousTypeCartes.POINTVICTOIRE));
		this.reserve.add(new GroupeCartesDev(14, TypeCartes.DEVELOPPEMENT, SousTypeCartes.ANCIEN));
	}
		
	/**
	 * Méthode permettant d'incrémenter le nombre de tour
	 */
	public void addTours() {
		this.tour += 1;
	}

	/**
	 * Renvoi la valeur du dé
	 * @return
	 * 	- un entier
	 */
	public int getValeurDes() {
		return valeurDes;
	}

	/**
	 * Attribut le paramétre à la valeur du dé
	 * @param pvdes
	 */
	public void setValeurDes(int pvdes) {
		this.valeurDes = pvdes;
	}

	/**
	 * Renvoi le plateau du jeu
	 * @return
	 */
	public Plateau getPlateau() {
		return plateau;
	}

	/**
	 * Renvoi les participant
	 * @return
	 * 	- une liste de joueurs
	 */
	public List<Joueur> getParticipants() {
		return participants;
	}

	/**
	 * Renvoi la reserve 
	 * @return
	 * 	- une liste de groupe de cartes
	 */
	public List<GroupeCartes> getReserve() {
		return reserve;
	}

	/**
	 * Méthode permettant d'ajouter un joueur à la liste des participants
	 * @param pj
	 */
	public void setParticipant(Joueur pj) {
		if(participants.size() < 4) {
			participants.add(pj);
		}else{
			System.out.println("Le nombre maximun de participant est atteint : " + participants.size());
		}
	}
	 
	/**
	 * Méthode permettant de renvoyer un groupe de cartes de la réserve selon le type de carte passé en paramétre 
	 * @param ptypeC
	 * @return
	 * 	- un groupe de cartes
	 */
	public GroupeCartes getGroupeCarte(TypeCartes ptypeC) {
		GroupeCartes newGroupCart = new GroupeCartes(0, ptypeC);
		for(GroupeCartes gc : reserve) {
			if(gc.getTypeCartes() == ptypeC) {
				newGroupCart = gc;
			}
		}
		return newGroupCart;
	}
	
	/**
	 * Méthode permettant de renvoyer la liste de tout les groupes de cartes de type ressource
	 * @return
	 *  - une liste de groupe de cartes de type ressource
	 */
	public List<GroupeCartes> getCartesRess() {
		List<GroupeCartes> lgcRess = new ArrayList<GroupeCartes>();
		for (GroupeCartes g : this.reserve) {
			if(g.getTypeCartes() != TypeCartes.DEVELOPPEMENT) {
				lgcRess.add(g);
			}
		}
		return lgcRess;
	}
	
	/**
	 * Méthode permettant de renvoyer la liste de tout les groupes de cartes de type developpement
	 * @return
	 * 	- une liste de groupe de cartes de type developpement
	 */
	public List<GroupeCartes> getCartesDev() {
		List<GroupeCartes> lgcDev = new ArrayList<GroupeCartes>();
		for(GroupeCartes g : this.reserve) {
			if(g.getTypeCartes() == TypeCartes.DEVELOPPEMENT) {
				lgcDev.add(g);
			}
		}
		return lgcDev;
	}
	
	/**
	 * Renvoi le nombre de cartes de développement
	 * @return
	 * 	- un entier
	 */
	public int nbCartesDev() {
		int res = 0;
		for(GroupeCartes g : this.getCartesDev()) {
			res += g.getNombre();
		}
		return res;
	}
	
	/**
	 * Méthode permettant de renvoyer un groupe de cartes de toutes les cartes de developpement
	 * @return
	 * 	- un groupe de cartes de type developpement
	 */
	public GroupeCartes getGroupeCartesDev() {
		return new GroupeCartes(this.nbCartesDev(), TypeCartes.DEVELOPPEMENT);
	}

	/**
	 * Méthode permettant d'augmenter un groupe de cartes de la reserve selon le type de carte et le nombre passés en paramétre
	 * @param ptypeC
	 * @param pnb
	 */
	public void AugmGroupeCarte(TypeCartes ptypeC, int pnb) {
		this.getGroupeCarte(ptypeC).addCartes(pnb);
	}
	
	/**
	 * Méthode permettant de diminuer un groupe de cartes de la reserve selon le type de carte et le nombre passés en paramétre
	 * @param ptypeC
	 * @param pnb
	 */
	public void DimGroupeCarte(TypeCartes ptypeC, int pnb) {
		this.getGroupeCarte(ptypeC).remCartes(pnb);
		if(getGroupeCarte(ptypeC).getNombre() < 0) 
			this.getGroupeCarte(ptypeC).setNombre(0);
	}
	
	/**
	 * Méthode permettant de connaitre le nombre total d'uv pour l'ensemble des participants
	 * @return
	 * 	- un entier
	 */
	public int totalUVParticipants() {
		int res = 0;
		for(Joueur j : participants) {
			res += j.getNbUV();
		}
		return res;
	}
	 
	/**
	 * Méthode permettant de passer d'un joueur actif à un autre
	 * selon le nombre de tours effectué, le déroulement se fait dans un sens puis dans l'autre
	 */
	public void finirTour() {
		//Phase de fondation : Au tour 3 le joueur actif reste le mm
		if(tour == 3) {
			this.participants.get(this.participants.indexOf(getJoueurActif())).setActif(true);
		//Phase de fondation : Entre le tour 3 et 6, déroulement en sens inverse	
		}else if (tour > 3 && tour < 6) {
			int index = this.participants.indexOf(getJoueurActif());
			
			index--;
			this.getJoueurActif().setActif(false);
			index = (index < 0) ? 2 : index;
			this.participants.get(index).setActif(true);
		//Debut partie : Le dernier joueur reste le joueur actif
		}else if(tour == 6) {
			this.participants.get(this.participants.indexOf(getJoueurActif())).setActif(true);
		// Sinon sens normale (avant tour 3 et apres tour 6)
		}else{
			int index = this.participants.indexOf(getJoueurActif());
			
			index++;
			this.getJoueurActif().setActif(false);
			index = (index >= 3) ? 0 : index;
			this.participants.get(index).setActif(true);
		}
		this.addTours();
	}
	 
	/**
	 * Méthode permettant de simuler le lancement de deux dés à six faces
	 */
	public void lancerDes() {
		int des1 = 1 + new Random().nextInt(6);
		int des2 = 1 + new Random().nextInt(6);
		this.setValeurDes(des1 + des2);
	}
	
	/**
	 * Méthode permettant de renvoyer le joueur actif du jeu
	 * @return
	 * 	- un joueur
	 */
	public Joueur getJoueurActif() {
		Joueur jactif = new Joueur();
		for(Joueur j: this.participants) {
			if (j.isActif()) {
				jactif = j;
				break;
			}
		}
		return jactif;
	}

	
	public boolean distribuerRess(){
		
		return false;
	}
	
	public boolean hasCursusPlusLong(Joueur pj) {
		return false;
	}
	 
	public boolean hasAncientPlusVieu(Joueur pj) {
		return false;
	}
	
	// TODO construction uv
	public boolean constructionUV (Sommet s) {
		return false;
	}
	
	// TODO construction controle continue
	public boolean constructionCC (Arete a) {
		return false;
	}
	
	/**
	 * Programme principal
	 * @param args
	 */
	public static void main(String[] args) {
		
		new JeuFrame(new Jeu(new Plateau(40))).setVisible(true);

	}

}
