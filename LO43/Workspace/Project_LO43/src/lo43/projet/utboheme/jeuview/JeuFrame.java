package lo43.projet.utboheme.jeuview;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;

import java.util.ArrayList;
import java.util.List;

import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;

import lo43.projet.utboheme.jeu.Jeu;

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
		this.setSize(j.getPlateau().getLargPlat() + 300, j.getPlateau().getHautPlat() + 200);
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		this.setLocationRelativeTo(null);
		this.setLayout(new BorderLayout());
		
		map = new JLabel();
		plat.addMouseListener(this);
		map.add(plat);
		
		attribuerJoueur();
		
		this.getContentPane().add(jv.get(0), BorderLayout.NORTH);
		this.getContentPane().add(jv.get(0), BorderLayout.SOUTH);
		this.getContentPane().add(jv.get(0), BorderLayout.WEST);
		this.getContentPane().add(new JLabel("Cartes"), BorderLayout.EAST);
		this.getContentPane().add(map, BorderLayout.CENTER);
	}
	
	private void attribuerJoueur() {
		
		jv = new ArrayList<JoueurView>(); 
		
		String nom = JOptionPane.showInputDialog(null, "Nom du joueur 1 ?", null, JOptionPane.QUESTION_MESSAGE);
		j.getParticipants().get(0).setNom(nom);
		
		jv.add(new JoueurView(j.getParticipants().get(0), Color.RED, "../src/boy_1.png"));
		
		nom = JOptionPane.showInputDialog(null, "Nom du joueur 2 ?", null, JOptionPane.QUESTION_MESSAGE);
		j.getParticipants().get(1).setNom(nom);
		
		jv.add(new JoueurView(j.getParticipants().get(1), Color.CYAN, "../src/girl_1.png"));
		
		nom = JOptionPane.showInputDialog(null, "Nom du joueur 3 ?", null, JOptionPane.QUESTION_MESSAGE);
		j.getParticipants().get(2).setNom(nom);
		
		jv.add(new JoueurView(j.getParticipants().get(2), Color.BLUE, "../src/boy_3.png"));
	}

	public Jeu getJ() {
		return j;
	}

	public void setJ(Jeu pj) {
		this.j = pj;
	}
	
	public void mouseClicked(MouseEvent e) {
		// TODO Auto-generated method stub
		plat.clicked(e.getPoint());
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
