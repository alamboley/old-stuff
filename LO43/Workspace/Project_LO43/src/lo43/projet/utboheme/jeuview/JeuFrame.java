package lo43.projet.utboheme.jeuview;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.util.ArrayList;
import java.util.List;

import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;

import lo43.projet.utboheme.jeu.Jeu;
import lo43.projet.utboheme.jeu.Joueur;

@SuppressWarnings("serial")
public class JeuFrame extends JFrame implements MouseListener{
	
	private Jeu j;
	private JLabel map;
	private PlateauView plat;
	private List<JoueurView> jv;
	
	public JeuFrame(Jeu pj) {
		this.j = pj;
		this.plat = new PlateauView(j.getPlateau());
		this.setTitle("Les colons de l'UTboHème");
		this.setSize(j.getPlateau().getWidth() + 500, j.getPlateau().getHeight() + 500);
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		this.setBackground(Color.white);
		this.setLocationRelativeTo(null);
		this.setLayout(new BorderLayout());
		
		map = new JLabel();
		plat.addMouseListener(this);
		map.add(plat);
		
		attribuerJoueur();
		
		this.getContentPane().add(jv.get(2), BorderLayout.NORTH);
		this.getContentPane().add(jv.get(1), BorderLayout.WEST);
		this.getContentPane().add(jv.get(0), BorderLayout.SOUTH);
		this.getContentPane().add(new JLabel("Cartes"), BorderLayout.EAST);
		this.getContentPane().add(map, BorderLayout.CENTER);
	}
	
	private void attribuerJoueur() {
		
		jv = new ArrayList<JoueurView>();
		ImageIcon imgJ1 = new ImageIcon("img/boy_1.png");
		ImageIcon imgJ2 = new ImageIcon("img/girl_1.png");
		ImageIcon imgJ3 = new ImageIcon("img/boy_3.png");
		
		String nom = (String) JOptionPane.showInputDialog(null, "Nom du joueur 1 ?", "Fiche d'inscription", JOptionPane.QUESTION_MESSAGE, imgJ1, null, null);
		j.setParticipant(new Joueur(1, nom, Color.red));
		jv.add(new JoueurView(j.getParticipants().get(0), j.getParticipants().get(0).getCouleur(), "img/boy_1.png"));
		
		nom = (String) JOptionPane.showInputDialog(null, "Nom du joueur 2 ?", "Fiche d'inscription", JOptionPane.QUESTION_MESSAGE, imgJ2, null, null);
		j.setParticipant(new Joueur(2, nom, Color.blue));
		jv.add(new JoueurView(j.getParticipants().get(1), j.getParticipants().get(1).getCouleur(), "img/girl_1.png"));
		
		nom = (String) JOptionPane.showInputDialog(null, "Nom du joueur 3 ?", "Fiche d'inscription", JOptionPane.QUESTION_MESSAGE, imgJ3, null, null);
		j.setParticipant(new Joueur(3, nom, new Color(0, 204, 0)));
		jv.add(new JoueurView(j.getParticipants().get(2), j.getParticipants().get(2).getCouleur(), "img/boy_3.png"));
	}
	
	public void mouseClicked(MouseEvent e) {
		plat.clicked(e.getPoint());
	}

	public void mouseEntered(MouseEvent e) {
		
	}

	public void mouseExited(MouseEvent e) {
		
	}

	public void mousePressed(MouseEvent e) {
		
	}

	public void mouseReleased(MouseEvent e) {
		
	}

}
