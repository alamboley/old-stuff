package lo43.projet.utboheme.jeuview;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Font;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;

import lo43.projet.utboheme.carte.GroupeCartes;
import lo43.projet.utboheme.carteview.GroupeCartesView;
import lo43.projet.utboheme.hexagone.HexaRessource;
import lo43.projet.utboheme.jeu.Jeu;
import lo43.projet.utboheme.jeu.Joueur;

@SuppressWarnings("serial")
public class JeuFrame extends JFrame {
	
	private Jeu j;
	private JLabel map;
	private PlateauView plat;
	private List<JoueurView> joueurV;
	private List<GroupeCartesView> reserveV;
	private JPanel containerCartes;
	private JPanel containerJeu;
	private JLabel valeurDes;
	private JButton btDes;
	private JButton btCursus;
	private JButton btOld;
	private JButton btExchange;
	private JButton btFinTour;
	
	public JeuFrame(Jeu pj) {
		this.j = pj;
		this.plat = new PlateauView(j.getPlateau());
		this.setTitle("Les colons de l'UTboHème");
		this.setSize(j.getPlateau().getWidth() + 550, j.getPlateau().getHeight() + 500);
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		this.setBackground(Color.white);
		this.setLocationRelativeTo(null);
		this.setLayout(new BorderLayout());
		
		containerJeu = new JPanel();
		containerJeu.setLayout(new GridBagLayout());
		GridBagConstraints gbc = new GridBagConstraints();
		
		containerCartes = new JPanel();
		containerCartes.setLayout(new GridBagLayout());
		
		creerCartes();
		creerCartesDev();
		
		gbc.fill = GridBagConstraints.BOTH;
		gbc.weighty = 1.0;
		gbc.weightx = 1.0;
		gbc.gridx = 0;
		gbc.gridy = 0;
		containerCartes.add(reserveV.get(0), gbc);
		
		gbc.fill = GridBagConstraints.BOTH;
		gbc.weighty = 1.0;
		gbc.weightx = 1.0;
		gbc.gridx = 1;
		gbc.gridy = 0;
		containerCartes.add(reserveV.get(1), gbc);
		
		gbc.fill = GridBagConstraints.BOTH;
		gbc.weighty = 1.0;
		gbc.weightx = 1.0;
		gbc.gridx = 2;
		gbc.gridy = 0;
		containerCartes.add(reserveV.get(2), gbc);
		
		gbc.fill = GridBagConstraints.BOTH;
		gbc.weighty = 1.0;
		gbc.weightx = 1.0;
		gbc.gridx = 0;
		gbc.gridy = 1;
		containerCartes.add(reserveV.get(3), gbc);
		
		gbc.fill = GridBagConstraints.BOTH;
		gbc.weighty = 1.0;
		gbc.weightx = 1.0;
		gbc.gridx = 1;
		gbc.gridy = 1;
		containerCartes.add(reserveV.get(4), gbc);
		
		gbc.fill = GridBagConstraints.BOTH;
		gbc.weighty = 1.0;
		gbc.weightx = 1.0;
		gbc.gridx = 2;
		gbc.gridy = 1;
		containerCartes.add(reserveV.get(5), gbc);
		
		gbc.fill = GridBagConstraints.HORIZONTAL;
		gbc.weighty = 1.0;
		gbc.gridx = 0;
		gbc.gridy = 0;
		gbc.gridwidth = 2;
		containerJeu.add(containerCartes, gbc);
		
		valeurDes = new JLabel("0");
		valeurDes.setFont(new Font("Comics", Font.BOLD, 16));
		valeurDes.setForeground(Color.blue);
		valeurDes.setHorizontalAlignment(JLabel.CENTER);
		gbc.fill = GridBagConstraints.HORIZONTAL;
		gbc.weighty = 0.5;
		gbc.gridx = 0;
		gbc.gridy = 1;
		gbc.gridwidth = 1;
		containerJeu.add(valeurDes, gbc);
		
		btDes = new JButton("Lancer Dés");
		btDes.addActionListener(new ActionButtonDes());
		gbc.fill = GridBagConstraints.HORIZONTAL;
		gbc.weighty = 0.5;
		gbc.ipadx = 30;
		gbc.ipady = 30;
		gbc.gridx = 0;
		gbc.gridy = 2;
		containerJeu.add(btDes, gbc);
		
		btCursus = new JButton("Cursus plus long");
		btCursus.addActionListener(new ActionButtonCursus());
		gbc.fill = GridBagConstraints.HORIZONTAL;
		gbc.ipadx = 30;
		gbc.ipady = 30;
		gbc.gridx = 1;
		gbc.gridy = 1;
		containerJeu.add(btCursus, gbc);
	
		btOld = new JButton("Ancien le plus vieu");
		btOld.addActionListener(new ActionButtonOld());
		gbc.fill = GridBagConstraints.HORIZONTAL;
		gbc.ipadx = 30;
		gbc.ipady = 30;
		gbc.gridx = 1;
		gbc.gridy = 2;
		containerJeu.add(btOld, gbc);
		
		btExchange = new JButton("Echanger");
		btExchange.addActionListener(new ActionExchange());
		gbc.fill = GridBagConstraints.VERTICAL;
		gbc.ipadx = 30;
		gbc.ipady = 30;
		gbc.gridx = 1;
		gbc.gridy = 3;
		containerJeu.add(btExchange, gbc);
		
		btFinTour = new JButton("Fin Tour");
		btFinTour.addActionListener(new ActionFinTour());
		gbc.fill = GridBagConstraints.HORIZONTAL;
		gbc.ipadx = 30;
		gbc.ipady = 30;
		gbc.gridx = 0;
		gbc.gridy = 3;
		containerJeu.add(btFinTour, gbc);
		
		map = new JLabel();
		plat.addMouseListener(new MapListener());
		map.add(plat);
		
		attribuerJoueur();
		
		this.getContentPane().add(joueurV.get(2), BorderLayout.NORTH);
		this.getContentPane().add(joueurV.get(1), BorderLayout.WEST);
		this.getContentPane().add(joueurV.get(0), BorderLayout.SOUTH);
		this.getContentPane().add(containerJeu, BorderLayout.EAST);
		this.getContentPane().add(map, BorderLayout.CENTER);

		
	}
	
	private void attribuerJoueur() {
		
		joueurV = new ArrayList<JoueurView>();
		ImageIcon imgJ1 = new ImageIcon("img/boy_1.png");
		ImageIcon imgJ2 = new ImageIcon("img/girl_1.png");
		ImageIcon imgJ3 = new ImageIcon("img/boy_3.png");
		
		String nom = (String) JOptionPane.showInputDialog(null, "Nom du joueur 1 ?", "Fiche d'inscription", JOptionPane.QUESTION_MESSAGE, imgJ1, null, null);
		j.setParticipant(new Joueur(1, nom, Color.red));
		joueurV.add(new JoueurView(j.getParticipants().get(0), j.getParticipants().get(0).getCouleur(), "img/boy_1.png"));
		
		nom = (String) JOptionPane.showInputDialog(null, "Nom du joueur 2 ?", "Fiche d'inscription", JOptionPane.QUESTION_MESSAGE, imgJ2, null, null);
		j.setParticipant(new Joueur(2, nom, Color.blue));
		joueurV.add(new JoueurView(j.getParticipants().get(1), j.getParticipants().get(1).getCouleur(), "img/girl_1.png"));
		
		nom = (String) JOptionPane.showInputDialog(null, "Nom du joueur 3 ?", "Fiche d'inscription", JOptionPane.QUESTION_MESSAGE, imgJ3, null, null);
		j.setParticipant(new Joueur(3, nom, new Color(0, 204, 0)));
		joueurV.add(new JoueurView(j.getParticipants().get(2), j.getParticipants().get(2).getCouleur(), "img/boy_3.png"));
		
		j.getParticipants().get(new Random().nextInt(3)).setActif(true);
	
	}
	
	private void creerCartes() {
		reserveV = new ArrayList<GroupeCartesView>();
		for(GroupeCartes gc : j.getCartesRess()) {
			reserveV.add(new GroupeCartesView(gc));
		}
	}
	
	private void creerCartesDev() {
		reserveV.add(new GroupeCartesView(j.getGroupeCartesDev()));
	}
	
	private class MapListener implements MouseListener {

		public void mouseClicked(MouseEvent e) {
			// TODO Auto-generated method stub
			plat.clicked(e.getPoint(), getViewJoueurActif());
		}
	

		public void mouseEntered(MouseEvent e) {
			// TODO Auto-generated method stub
			
		}

		public void mouseExited(MouseEvent e) {
			// TODO Auto-generated method stub
			
		}

		public void mousePressed(MouseEvent e) {
			// TODO Auto-generated method stub
			
		}

		public void mouseReleased(MouseEvent e) {
			// TODO Auto-generated method stub
			
		}
	}
	
	private class ActionButtonDes implements ActionListener {

		public void actionPerformed(ActionEvent e) {
			// TODO Auto-generated method stub
			j.lancerDes();
			valeurDes.setText("" + j.getValeurDes());
			for(HexaRessource h : j.getPlateau().getHexaRessWithUv(j.getValeurDes())) {
				for(Joueur jo : h.getSommetUVProprio()) {
					// Ajouter une methode d'ajout et de soustraction dans joeur comme dans Jeu
				}
			}
		}
	}
	
	private class ActionButtonCursus implements ActionListener {

		public void actionPerformed(ActionEvent e) {
			// TODO Auto-generated method stub
			j.getJoueurActif().setCursus(true);
			
		}
	}
	
	private class ActionButtonOld implements ActionListener {

		public void actionPerformed(ActionEvent e) {
			// TODO Auto-generated method stub
			j.getJoueurActif().setAncien(true);
			
		}
	}
	
	private class ActionExchange implements ActionListener {

		public void actionPerformed(ActionEvent e) {
			// TODO Auto-generated method stub
			
		}
		
	}
	
	private class ActionFinTour	implements ActionListener {

		public void actionPerformed(ActionEvent e) {
			// TODO Auto-generated method stub
			j.finirTour();
			for(JoueurView jv : joueurV) {
				jv.repaint();
			}			
		}
		
	}
	
	private JoueurView getViewJoueurActif() {
		JoueurView jView = new JoueurView();
		for(JoueurView jouer : joueurV) {
			if(jouer.getJoueur() == j.getJoueurActif()) {
				jView = jouer;
				break;
			}
		}
		return jView;
	}

}
