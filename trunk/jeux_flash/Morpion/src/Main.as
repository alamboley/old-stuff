package {

	import model.TabGrille;

	import view.Grille;

	import com.base86.Tools;

	import flash.display.Sprite;
		
	/**
	 * @author Aymeric
	 */
	public class Main extends Sprite {
		
		private var _grille:Grille;

		public function Main() {
			
			_grille = new Grille();
			addChild(_grille);
			
			TabGrille.init();
			
			TabGrille.setCoup("cercle", 2, 1);
			TabGrille.setCoup("carre", 1, 0);
			
			Tools.pr(TabGrille.getInstance());
		}
	}

}
