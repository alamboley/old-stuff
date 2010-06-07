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

public class Jeu {
	
	private int tour;
	private int valeurDes;
	private Plateau plateau;
	private List<Joueur> participants;
	private List<GroupeCartes> reserve;
	
	public Jeu(){
		this.setTour(0);
		this.setValeurDes(0);
		this.setPlateau(null);
		this.setParticipants(null);
		this.setReserve(null);
	}
	
	public Jeu(Plateau pp) {
		this();
		this.setTour(0);
		this.setValeurDes(0);
		this.setPlateau(pp);
		
		this.participants = new ArrayList<Joueur>();
		
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
	
	public int getTour() {
		return tour;
	}

	public void setTour(int ptour) {
		this.tour = ptour;
	}

	public int getValeurDes() {
		return valeurDes;
	}

	public void setValeurDes(int pvdes) {
		this.valeurDes = pvdes;
	}

	public Plateau getPlateau() {
		return plateau;
	}

	public void setPlateau(Plateau pp) {
		this.plateau = pp;
	}

	public List<Joueur> getParticipants() {
		return participants;
	}

	public void setParticipants(List<Joueur>plp) {
		this.participants = plp;
	}

	public List<GroupeCartes> getReserve() {
		return reserve;
	}

	public void setReserve(List<GroupeCartes> plr) {
		this.reserve = plr;
	}
	 
	public void setParticipant(Joueur pj) {
		if(participants.size() < 4) {
			participants.add(pj);
		}else{
			System.out.println("Le nombre maximun de participant est atteint : " + participants.size());
		}
	}
	 
	public GroupeCartes getGroupeCarte(TypeCartes ptypeC) {
		GroupeCartes newGroupCart = new GroupeCartes(0, ptypeC);
		for(GroupeCartes gc : reserve) {
			if(gc.getTypeCartes() == ptypeC) {
				newGroupCart = gc;
			}
		}
		return newGroupCart;
	}
	
	public List<GroupeCartes> getCartesRess() {
		List<GroupeCartes> lgcRess = new ArrayList<GroupeCartes>();
		for (GroupeCartes g : this.reserve) {
			if(g.getTypeCartes() != TypeCartes.DEVELOPPEMENT) {
				lgcRess.add(g);
			}
		}
		return lgcRess;
	}
	
	public List<GroupeCartes> getCartesDev() {
		List<GroupeCartes> lgcDev = new ArrayList<GroupeCartes>();
		for(GroupeCartes g : this.reserve) {
			if(g.getTypeCartes() == TypeCartes.DEVELOPPEMENT) {
				lgcDev.add(g);
			}
		}
		return lgcDev;
	}
	
	public int nbCartesDev() {
		int res = 0;
		for(GroupeCartes g : this.getCartesDev()) {
			res += g.getNombre();
		}
		return res;
	}
	
	public GroupeCartes getGroupeCartesDev() {
		return new GroupeCartes(this.nbCartesDev(), TypeCartes.DEVELOPPEMENT);
	}
	
	public void AugmGroupeCarte(TypeCartes ptypeC, int pnb) {
		this.getGroupeCarte(ptypeC).addCartes(pnb);
	}
	
	public void DimGroupeCarte(TypeCartes ptypeC, int pnb) {
		this.getGroupeCarte(ptypeC).remCartes(pnb);
		if(getGroupeCarte(ptypeC).getNombre() < 0) 
			this.getGroupeCarte(ptypeC).setNombre(0);
	}
	 
	public void finirTour() {
		// si on a pas atteint le dernier joueur on passe au suivant, sinon on revient au premier
		int index = this.participants.indexOf(getJoueurActif());
		
		index++;
		this.getJoueurActif().setActif(false);
		index = (index >= 3) ? 0 : index;
		this.participants.get(index).setActif(true);
	}
	 
	public void phaseFondation() {
	 
	}
	 
	public void lancerDes() {
		int des1 = 1 + new Random().nextInt(6);
		int des2 = 1 + new Random().nextInt(6);
		this.setValeurDes(des1 + des2);
	}
	
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
	
	
	public static void main(String[] args) {
		
		new JeuFrame(new Jeu(new Plateau(40))).setVisible(true);

	}

}
