package lo43.projet.utboheme.hexagone;

/**
 * Classe representant un jeton
 * 	- possede un numero
 * @author alexandreaugen
 *
 */
public class Jeton {

	private int numero;
	
	/**
	 * Constructeur par defaut
	 */
	public Jeton() {
		this.numero = 0;
	}
	
	/**
	 * Constructeur parametre
	 * @param pnum
	 */
	public Jeton(int pnum) {
		this.numero = pnum;
	}

	/**
	 * Renvoi le numero du jeton
	 * @return
	 * 	- un entier
	 */
	public int getNumero() {
		return numero;
	}

}
