package jeu.personnages.monsters {		import flash.display.MovieClip;	import flash.display.Sprite;	import flash.events.Event;	/**	 * @author Aymeric	 */	public class Momie extends Sprite {				public const force : int=10;				private const vitesse:int=10;				private var monPersoMomie : MovieClip = new PersoMomie();				private var vie : int=200;		private var mort : Boolean=false;		private var arretMouvement:Boolean=false;				public function Momie():void {						addChild(monPersoMomie);			monPersoMomie.scaleX=0.05;			monPersoMomie.scaleY=0.05;			monPersoMomie.x=50;			monPersoMomie.y=400;						monPersoMomie.addEventListener(Event.ENTER_FRAME, deplacementMomie, false, 0, true);		}				public function attaqueBase():void {						monPersoMomie.removeEventListener(Event.ENTER_FRAME, deplacementMomie);						if (arretMouvement==false) {				monPersoMomie.stop();				arretMouvement=true;			}		}				public function combat(degatSubit:int):Boolean {						monPersoMomie.removeEventListener(Event.ENTER_FRAME, deplacementMomie);						if (arretMouvement==false) {				monPersoMomie.stop();				arretMouvement=true;			}						vie=vie-degatSubit;						if (vie<1) {				removeChild(monPersoMomie);				mort=true;			}						return mort;		}				public function victoire():void {						monPersoMomie.play();			monPersoMomie.addEventListener(Event.ENTER_FRAME, deplacementMomie, false, 0, true);			arretMouvement=false;		}		private function deplacementMomie(e:Event):void {						monPersoMomie.x+=vitesse;						if (monPersoMomie.x>1200) {				monPersoMomie.removeEventListener(Event.ENTER_FRAME, deplacementMomie);				removeChild(monPersoMomie);			}		}	}}