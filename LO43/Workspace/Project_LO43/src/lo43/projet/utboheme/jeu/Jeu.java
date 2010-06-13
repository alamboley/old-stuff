package lo43.projet.utboheme.jeu;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import lo43.projet.utboheme.carte.GroupeCartes;
import lo43.projet.utboheme.carte.GroupeCartesDev;
import lo43.projet.utboheme.carte.SousTypeCartes;
import lo43.projet.utboheme.carte.TypeCartes;
import lo43.projet.utboheme.hexagone.HexaRessource;
import lo43.projet.utboheme.jeuview.JeuFrame;
import lo43.projet.utboheme.pion.Pion;
import lo43.projet.utboheme.pion.UV;

/**
 * Classe repr�sentant le jeu
 * 	- poss�de un attribut tour 
 * 	- poss�de un attribut pour la valeur du d�
 * 	- poss�de un attribut plateau ou se d�roule les actions
 *  - poss�de une liste de joueurs (participants)
 *  - poss�de une liste de groupe de cartes (r�serve)
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
	 * Constructeur par d�faut
	 */
	public Jeu(){
		this.tour = 1;
		this.valeurDes = 0;
		this.plateau = null;
		this.participants = null;
		this.reserve = null;
	}
	
	/**
	 * Constructeur param�tr�
	 * @param pp
	 */
	public Jeu(Plateau pp) {
		this();
		this.plateau = pp;
		
		this.participants = new ArrayList<Joueur>();
		
		//Cr�ation par d�faut des groupes de cartes qui composent la r�serve
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
	 * M�thode permettant d'incr�menter le nombre de tour
	 */
	public void addTours() {
		this.tour += 1;
	}

	/**
	 * Renvoi la valeur du d�
	 * @return
	 * 	- un entier
	 */
	public int getValeurDes() {
		return valeurDes;
	}

	/**
	 * Attribut le param�tre � la valeur du d�
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
	 * M�thode permettant d'ajouter un joueur � la liste des participants
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
	 * M�thode permettant de renvoyer un groupe de cartes de la r�serve selon le type de carte pass� en param�tre 
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
	 * M�thode permettant de renvoyer la liste de tout les groupes de cartes de type ressource
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
	 * M�thode permettant de renvoyer la liste de tout les groupes de cartes de type developpement
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
	 * Renvoi le nombre de cartes de d�veloppement
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
	 * M�thode permettant de renvoyer un groupe de cartes de toutes les cartes de developpement
	 * @return
	 * 	- un groupe de cartes de type developpement
	 */
	public GroupeCartes getGroupeCartesDev() {
		return new GroupeCartes(this.nbCartesDev(), TypeCartes.DEVELOPPEMENT);
	}
	
	public GroupeCartes getGroupeCartesDev(SousTypeCartes sstype) {
		GroupeCartes gc = new GroupeCartes();
		for(GroupeCartes g : getCartesDev()) {
			GroupeCartesDev gcd = (GroupeCartesDev) g;
			if(gcd.getSousTypeCartes() == sstype) {
				gc = gcd;
				break;
			}
		}
		return gc;
	}

	/**
	 * M�thode permettant d'augmenter un groupe de cartes de la reserve selon le type de carte et le nombre pass�s en param�tre
	 * @param ptypeC
	 * @param pnb
	 */
	public void AugmGroupeCarte(TypeCartes ptypeC, int pnb) {
		this.getGroupeCarte(ptypeC).addCartes(pnb);
	}
	
	/**
	 * M�thode permettant de diminuer un groupe de cartes de la reserve selon le type de carte et le nombre pass�s en param�tre
	 * @param ptypeC
	 * @param pnb
	 */
	public void DimGroupeCarte(TypeCartes ptypeC, int pnb) {
		this.getGroupeCarte(ptypeC).remCartes(pnb);
		if(getGroupeCarte(ptypeC).getNombre() < 0) 
			this.getGroupeCarte(ptypeC).setNombre(0);
	}
	
	public void DimGroupeCarteDev(SousTypeCartes sstype, int pnb) {
		this.getGroupeCartesDev(sstype).remCartes(pnb);
		if(getGroupeCartesDev(sstype).getNombre() < 0)
			this.getGroupeCartesDev(sstype).setNombre(0);
	}
	
	/**
	 * M�thode permettant de connaitre le nombre total d'uv pour l'ensemble des participants
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
	 * M�thode permettant de passer d'un joueur actif � un autre
	 * selon le nombre de tours effectu�, le d�roulement se fait dans un sens puis dans l'autre
	 */
	public void finirTour() {
		//Phase de fondation : Au tour 3 le joueur actif reste le mm
		if(tour == 3) {
			this.participants.get(this.participants.indexOf(getJoueurActif())).setActif(true);
		//Phase de fondation : Entre le tour 3 et 6, d�roulement en sens inverse	
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
	 * M�thode permettant de simuler le lancement de deux d�s � six faces
	 */
	public void lancerDes() {
		int des1 = 1 + new Random().nextInt(6);
		int des2 = 1 + new Random().nextInt(6);
		this.setValeurDes(des1 + des2);
	}
	
	/**
	 * M�thode permettant de renvoyer le joueur actif du jeu
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
	
	public void putRess(Pion p) {
		if(p.getClass() == UV.class) {
			UV uv = (UV) p;
			if(uv.isDoubleEtoile()) {
				this.AugmGroupeCarte(TypeCartes.SUPPORT, 2);
				this.AugmGroupeCarte(TypeCartes.SOMMEIL, 3);
			}else{
				this.AugmGroupeCarte(TypeCartes.BIERE, 1);
				this.AugmGroupeCarte(TypeCartes.NOURRITURE, 1);
				this.AugmGroupeCarte(TypeCartes.SUPPORT, 1);
				this.AugmGroupeCarte(TypeCartes.CAFE, 1);
			}
		}else if(p.getClass() == Pion.class) {
			this.AugmGroupeCarte(TypeCartes.BIERE, 1);
			this.AugmGroupeCarte(TypeCartes.NOURRITURE, 1);
		}
	}
	
	public void payCartesDev() {
		this.AugmGroupeCarte(TypeCartes.SUPPORT, 1);
		this.AugmGroupeCarte(TypeCartes.CAFE, 1);
		this.AugmGroupeCarte(TypeCartes.SOMMEIL, 1);
		GroupeCartesDev gcd = (GroupeCartesDev) getCartesDev().get(new Random().nextInt(getCartesDev().size()));
		getJoueurActif().AugmenterGroupeCarteDev(gcd.getSousTypeCartes(), 1);
		DimGroupeCarteDev(gcd.getSousTypeCartes(), 1);
	}
	
	public boolean deplacerBinome() {
		boolean res = false;
		HexaRessource hexa = new HexaRessource();
		hexa = (HexaRessource) plateau.getHexaRess().get(new Random().nextInt(plateau.getHexaRess().size()));
		plateau.getHexaBinomeG().setBinomeG(false);
		hexa.setBinomeG(true);
		if(!hexa.getSommetsUV().isEmpty()){
			GroupeCartes gc = hexa.getSommetUVProprio().get(new Random().nextInt(hexa.getSommetUVProprio().size())).MoveAllCartes(hexa.getTypeCartes());
			getJoueurActif().AugmGroupeCarte(gc.getTypeCartes(), gc.getNombre());
		}
		return res;
	}
	
	public boolean gagnerPartie() {
		return (getJoueurActif().getNbPoints() >= 10) ? true : false;
	}
	
	public boolean attribuerAncien() {
		boolean res = false;
		if (getJoueurActif().getNbCartesDev(SousTypeCartes.ANCIEN) >= 3) {
			for(Joueur j : participants) {
				if(!j.equals(getJoueurActif()) && j.getNbCartesDev(SousTypeCartes.ANCIEN) < getJoueurActif().getNbCartesDev(SousTypeCartes.ANCIEN)){
					getJoueurActif().setAncien(true);
					getJoueurActif().addNbPoints(2);
					res = true;
				}else{
					j.setAncien(false);
				}
			}
		}else{
			res = false;
		}
		return res;
	} 
	
	public boolean attribuerCursus() {
		boolean res = false;
			int nbpion = getJoueurActif().getNbCC() + getJoueurActif().getNbUV() + getJoueurActif().getNbUVStar();
			if(nbpion <= 19) {
				for(Joueur j : participants) {
					if(j.equals(getJoueurActif())){
						getJoueurActif().setCursus(true);
						getJoueurActif().addNbPoints(2);
						res = true;
					}else{
						j.setCursus(false);
					}
				}
			}
		return res;
	} 
	
	public boolean attribuerRess(TypeCartes type, Joueur j) {
		boolean res = false;
		if(getGroupeCarte(type).getNombre() >= 0) {
			DimGroupeCarte(type,1);
			j.AugmGroupeCarte(type, 1);
			res = true;
		}else{
			res = false;
		}
		return res;
	}
	
	public boolean acheterCartesDev() {
		boolean res = false;
		if(getJoueurActif().payCartesDev()) {
			payCartesDev();
			res = true;
		}else{
			res = false;
		}
		return res;
	}
	
	/**
	 * Programme principal
	 * @param args
	 */
	public static void main(String[] args) {
		
		new JeuFrame(new Jeu(new Plateau(40))).setVisible(true);
		
	}

}
