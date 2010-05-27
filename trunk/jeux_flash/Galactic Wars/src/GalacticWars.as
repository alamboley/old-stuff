package {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	/**
	 * @author Aymeric
	 */
	public class GalacticWars extends Sprite {
		
		private const MAX_STARS:uint = 60;
		private const MAX_ENEMIES:uint = 4;
		
		private var vaisseau:Starship;
		private var containerShot:Array;
		
		private var conteneur:Sprite;
		
		private var enemies:Array;
		private var vitesseEtoileX:Array;
		private var vitesseEtoileY:Array;
		
		private var gauche:Boolean = false;
		private var droite:Boolean = false;
		private var haut:Boolean = false;
		private var bas:Boolean = false;
		private var vitesseX:int = 15;
		private var vitesseY:int = 15;
		
		private var countDestroyed:uint = 0;
		private var countShot:uint = 0;
		private var countCollision:uint = 0;

		public function GalacticWars() {
			
			vaisseau = new Starship();
			addChild(vaisseau);
			vaisseau.x = stage.stageWidth/2;
			vaisseau.y = stage.stageHeight/2;
			
			containerShot = new Array();
			
			addStars();
			addEnemies();
			
			starshipDestroyed.text = String(countDestroyed + "/" + MAX_ENEMIES);
			byShot.text = String(countShot + "/" + MAX_ENEMIES);
			byCollision.text = String(countCollision + "/" + MAX_ENEMIES);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, toucheDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, toucheUP);
			stage.addEventListener(Event.ENTER_FRAME, deplacement);
		}
		
		private function addStars():void {
			
			conteneur = new Sprite();
			addChild(conteneur);
			
			var star:Star;
			vitesseEtoileX = new Array();
			vitesseEtoileY = new Array();
			
			for (var i:uint = 0; i < MAX_STARS; i++) {
				star = new Star(Math.random() * 0xFFFFFF, Math.random());
				star.name = "star" + i;
				vitesseEtoileX.push(star.vitesseX);
				vitesseEtoileY.push(star.vitesseY);
				conteneur.addChildAt(star, i);
				star.x = Math.random() * 600;
				star.y = Math.random() * 500;
			}
		}
		
		private function addEnemies():void {
			
			var enemy:Enemy;
			enemies = new Array();
			
			for (var i:uint = 0; i < MAX_ENEMIES; i++) {
				enemy = new Enemy(Math.random()*stage.stageWidth, Math.random()*stage.stageHeight, Math.random()*360, Math.round(Math.random()*4000)+500);
				enemy.name = "enemy" + i;
				conteneur.addChild(enemy);;
				enemies.push(enemy);
			}
		}

		private function toucheDown(k:KeyboardEvent):void {
			
			if (k.keyCode == Keyboard.LEFT) {
				gauche = true;
			}
			if (k.keyCode == Keyboard.RIGHT) {
				droite = true;
			}
			if (k.keyCode == Keyboard.UP) {
				haut = true;
			}
			if (k.keyCode == Keyboard.DOWN) {
				bas = true;
			}
			if (k.keyCode == Keyboard.SPACE) {
				var shot:Shot = new Shot(vaisseau.rotatePosition(), vaisseau.x, vaisseau.y);
				addChild(shot);
				containerShot.push(shot);
			}
		}
		
		private function toucheUP(k:KeyboardEvent):void {
			
			if (k.keyCode == Keyboard.LEFT) {
				gauche = false;
			}
			if (k.keyCode == Keyboard.RIGHT) {
				droite = false;
			}
			if (k.keyCode == Keyboard.UP) {
				haut = false;
			}
			if (k.keyCode == Keyboard.DOWN) {
				bas = false;
			}
		}
		
		private function deplacement(e:Event):void {
			
			if (gauche) {
				vaisseau.rotateLeft();
			}
			if (droite) {
				vaisseau.rotateRight();
			}
			
			if (haut) {
				// Sin(0) = 0, Cos(0) = 1, conversion en radian
				conteneur.x -= (vitesseX * Math.sin(vaisseau.rotatePosition() * Math.PI / 180));
				conteneur.y += (vitesseY * Math.cos(vaisseau.rotatePosition() * Math.PI / 180));
			}
			
			if (bas) {
				
				conteneur.x += (vitesseX * Math.sin(vaisseau.rotatePosition() * Math.PI / 180));
				conteneur.y -= (vitesseY * Math.cos(vaisseau.rotatePosition() * Math.PI / 180));
			}
			
			perpetualMovement();
			shotManagement();
			collisionManagement();
			calculatePosition();
		}
		
		private function perpetualMovement():void {
			
			for (var i:uint = 0; i < MAX_STARS; i++) {
				conteneur.getChildByName("star" + i).x -= vitesseEtoileX[i];
				conteneur.getChildByName("star" + i).y += vitesseEtoileY[i];
				limites(conteneur.getChildByName("star" + i));
			}
		}
		
		private function shotManagement():void {
			
			for (var j:uint = 0; j < containerShot.length; j++) {
				for (var k:uint = 0; k < enemies.length; k++) {
					if ((containerShot[j] as Shot).hitTestObject(enemies[k] as Enemy)) {
						//conteneur.removeChild(enemies[k] as Enemy);
						//conteneur.removeChild(conteneur.getChildByName("enemy" + k)); identique mais bug ??
						var killed:Enemy = enemies[k] as Enemy;
						killed.die();
						enemies.splice(k, 1);
						
						removeChild(containerShot[j] as Shot);
						var shotEnd:Shot = containerShot[j] as Shot;
						shotEnd.die();
						
						countDestroyed++;
						countShot++;
						addScores();
					}	
				}
			}
		}
		
		private function collisionManagement():void {
			
			for (var i:uint = 0; i < enemies.length; i++) {
				if (vaisseau.hitTestObject(enemies[i] as Enemy)) {
					
					var killed:Enemy = enemies[i] as Enemy;
					killed.die();
					enemies.splice(i, 1);
					
					countDestroyed++;
					countCollision++;
					addScores();
				}
					
				/*for (var j:uint = 0; j < enemies.length; j++) {
					if ((enemies[i] as Enemy).hitTestObject(enemies[j] as Enemy)) {
						var dying1:Enemy = enemies[i] as Enemy;
						dying1.die();
						enemies.splice(i, 1);
						
						var dying2:Enemy = enemies[j] as Enemy;
						dying2.die();
						enemies.splice(j, 1);
						
						trace("crash");
					}
				}*/
			}
		}
		
		private function calculatePosition():void {
			
			for (var i:uint = 0; i < enemies.length; i ++) {
				var enemy:Enemy = enemies[i] as Enemy;
				
				// Calcul de la distance entre 2 points
				if ((Math.sqrt(Math.pow((-conteneur.x + stage.stage.width / 2 - enemy.posX()), 2) + Math.pow((-conteneur.y + stage.stage.height / 2 - enemy.posY()), 2)) < 250)) {
					
					if (Math.random() > 0.6) {
						enemy.goOnPoint(-conteneur.x + stage.stage.width/2, -conteneur.y + stage.stage.height / 2);
						//var shot:Shot = new Shot(enemy.rotatePosition(), enemy.posX(), enemy.posY());
						//conteneur.addChild(shot);
					}	
				} else {
					enemy.startAgainTimer();
				}
			}
		}

		private function limites(etoile:DisplayObject):void {
			
			if (etoile.x < -conteneur.x) {
				etoile.x = -conteneur.x + stage.stageWidth;
			}
			
			if (etoile.x > stage.stageWidth - conteneur.x) {
				etoile.x = -conteneur.x;
			}
			
			if (etoile.y < -conteneur.y) {
				etoile.y = -conteneur.y + stage.stageHeight;
			}
			
			if (etoile.y > stage.stageHeight - conteneur.y) {
				etoile.y = -conteneur.y;
			}
		}
		
		private function addScores():void {
			
			starshipDestroyed.text = String(countDestroyed + "/" + MAX_ENEMIES);
			byShot.text = String(countShot + "/" + MAX_ENEMIES);
			byCollision.text = String(countCollision + "/" + MAX_ENEMIES);
		}
	}
}