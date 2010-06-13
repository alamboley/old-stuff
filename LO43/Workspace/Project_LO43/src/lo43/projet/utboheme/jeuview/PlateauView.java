package lo43.projet.utboheme.jeuview;

import java.awt.Canvas;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Point;
import java.util.ArrayList;
import java.util.List;

import lo43.projet.utboheme.hexagone.Hexagone;
import lo43.projet.utboheme.hexagoneview.AreteView;
import lo43.projet.utboheme.hexagoneview.HexagoneView;
import lo43.projet.utboheme.hexagoneview.SommetView;
import lo43.projet.utboheme.jeu.Jeu;
import lo43.projet.utboheme.jeu.Plateau;

/**
 * Classe repr�sentant graphiquement un plateau
 * 	- poss�de un attribut de type plateau pour savoir le plateau � repr�senter
 *  - poss�de une liste de repr�sentation graphique des hexagones du plateau
 * @author alexandreaugen
 *
 */
@SuppressWarnings("serial")
public class PlateauView extends Canvas{

	private Plateau plateau;
	private List<HexagoneView> lHexaV;
	
	/**
	 * Constructeur param�tr�
	 * @param pp
	 */
	public PlateauView(Plateau pp) {
		super();
		this.plateau = pp;
		this.lHexaV = new ArrayList<HexagoneView>();
		
		this.setLocation(new Point(0,0));
		this.setSize(new Dimension(plateau.getWidth(), plateau.getHeight()));
		for(Hexagone h : plateau.getHexagones()) {
			lHexaV.add(new HexagoneView(h));
		}
	}
	
	/**
	 * M�thode pour peindre le composant
	 */
	public void paint(Graphics g) {
		g.setColor(new Color(255, 255, 204));
		g.fillRoundRect(0, 0, this.getWidth(), this.getHeight(), 100, 100);
		for(HexagoneView hv : this.lHexaV) {
			hv.paint(g);
		}
	}
	
	/**
	 * M�thode pour repeindre le composant
	 */
	public void update() {
		this.repaint();
	}
	
	/**
	 * M�thode qui permet d'affecter un sommet lors de la phase de fondation
	 * @param mousePosition
	 * @param jv
	 */
	public boolean fonder(Point mousePosition, JoueurView jv) {
		boolean hasSommet = false; 
		
		//Parcours les hexagonesView
		for(HexagoneView hv : lHexaV) {
			//Parcours les sommetView
			for(SommetView s : hv.getLSommetV()) {
				//on recupere le sommet correspondant pour l'utiliser dans le jeu
				if (s.contains(mousePosition)) {
					if(!s.getSommet().hasUV()) {
						s.getSommet().setUv(jv.getJoueur().getUV());
						hasSommet = true;
					}
				}
			}
		}
		if(hasSommet){
			jv.getJoueur().addNbPoints(1);
			jv.getJoueur().remUV();
		}
		this.update();
		return hasSommet;
	}
	
	/**
	 * M�thode qui permet d'affecter un pion � un sommet ou une ar�te
	 * @param mousePosition
	 * @param jv
	 */
	public boolean ajouter(Point mousePosition, Jeu j) {
		boolean hasUvStar = false;
		boolean hasUv = false;
		boolean hasCc = false;
		boolean res = false;
		
		//Parcours les hexagonesView
		for(HexagoneView hv : lHexaV) {
			//Parcours les sommetView
			for(SommetView s : hv.getLSommetV()) {
				//on recupere le sommet correspondant pour l'utiliser dans le jeu
				if (s.contains(mousePosition)) {
					if(!s.getSommet().hasUV()) {
						//if(hv.getHexa().hasCC(s.getSommet(), jv.getJoueur())){
							if(j.getJoueurActif().TestRess(j.getJoueurActif().getUV())) {
								s.getSommet().setUv(j.getJoueurActif().getUV());
								hasUv = s.getSommet().hasUV();
							}
						//}
					}else if(!s.getSommet().hasUVStar() && s.getSommet().getUv().getProprietaire() == j.getJoueurActif()) {
						if(j.getJoueurActif().TestRess(j.getJoueurActif().getUVStar())) {
							s.getSommet().setUv(j.getJoueurActif().getUVStar());
							hasUvStar = s.getSommet().hasUVStar();
						}
					}
				}
			}
			//Parcours les areteView
			for(AreteView a : hv.getLAreteV()) {
				// on recupere l'arete correspondante pour l'utiliser dans le jeu
				if(a.contains(mousePosition)) {
					if(!a.getArete().hasCC() && a.getArete().hasUvOnSomm(j.getJoueurActif())) {
						if(j.getJoueurActif().TestRess(j.getJoueurActif().getCC())) {
							a.getArete().setControleC(j.getJoueurActif().getCC());
							hasCc = a.getArete().hasCC();
						}
					}
				}
			}
		}
		if(hasUvStar){
			j.getJoueurActif().addNbPoints(2);
			j.getJoueurActif().remRess(j.getJoueurActif().getUVStar());
			j.getJoueurActif().remUVStar();
			j.putRess(j.getJoueurActif().getUVStar());
			res = hasUvStar;
		}else if(hasUv){
			j.getJoueurActif().addNbPoints(1);
			j.getJoueurActif().remRess(j.getJoueurActif().getUV());
			j.getJoueurActif().remUV();
			j.putRess(j.getJoueurActif().getUV());
			res = hasUv;
		}else if(hasCc){
			j.getJoueurActif().remRess(j.getJoueurActif().getCC());
			j.getJoueurActif().remCC();
			j.putRess(j.getJoueurActif().getCC());
			res = hasCc;
		}
		
		this.update();
		return res;
	}
	
	/**
	 * Renvoi le plateau associ� � la repr�sentation graphique
	 * @return
	 * 	- un plateau
	 */
	public Plateau getPlateau() {
		return plateau;
	}

}
