package {
	import com.greensock.TweenLite;
	import flash.utils.Timer;
	import flash.display.MovieClip;
	import flash.events.TimerEvent;

	/**
	 * @author Aymeric
	 */
	public class Enemy extends MovieClip {
		
		private var enemy:MovieClip;
		private var myTimer:Timer;
		
		public function Enemy(posX:int, posY:int, rotate:int) {
			
			enemy = new Ennemi();
			addChild(enemy);
			enemy.x = posX;
			enemy.y = posY;
			enemy.rotationZ = rotate;
			
			myTimer = new Timer(2000, 0);
			myTimer.start();
			
			myTimer.addEventListener(TimerEvent.TIMER, move);
		}
		
		private function move(t:TimerEvent):void {
			//TweenLite.to(enemy, 2, {x:Math.random() * stage.stageWidth, y:Math.random() * stage.stageHeight});
			
			enemy.rotationZ = Math.abs(Math.random() * 360);
			trace(enemy.rotationZ);
			/*if (enemy.rotationZ < 90) {
				TweenLite.to(enemy, 2, {x:200 * Math.sin(enemy.rotationZ * Math.PI / 180), y:200 * Math.cos(enemy.rotationZ * Math.PI / 180)});
				trace("<90");
			} else if (enemy.rotationZ < 180 && enemy.rotationZ >= 90) {
				TweenLite.to(enemy, 2, {x:200 * Math.sin(enemy.rotationZ * Math.PI / 180), y:-200 * Math.cos(enemy.rotationZ * Math.PI / 180)});
				trace("<180");
			} else if (enemy.rotationZ < 270 && enemy.rotationZ >= 180) {
				TweenLite.to(enemy, 2, {x:-200 * Math.sin(enemy.rotationZ * Math.PI / 180), y:-200 * Math.cos(enemy.rotationZ * Math.PI / 180)});
				trace("<270");
			} else if (enemy.rotationZ <= 360 && enemy.rotationZ >= 270) {
				TweenLite.to(enemy, 2, {x:-200 * Math.sin(enemy.rotationZ * Math.PI / 180), y:200 * Math.cos(enemy.rotationZ * Math.PI / 180)});
				trace("<360");
			} else {
				trace("enemy.rotationZ -> ERROR !!");
			}*/
			TweenLite.to(enemy, 2, {x:200 * Math.sin(enemy.rotationZ * Math.PI / 180), y:200 * Math.cos(enemy.rotationZ * Math.PI / 180)});
		}
	}
}
