package {
	import com.greensock.TweenLite;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author Aymeric
	 */
	public class Enemy extends MovieClip {
		
		private var enemy:MovieClip;
		private var myTimer:Timer;
		private var statusTimer:Boolean = false;
		
		public function Enemy(posX:int, posY:int, rotate:int, time:int) {
			
			enemy = new Ennemi();
			addChild(enemy);
			enemy.x = posX;
			enemy.y = posY;
			enemy.rotationZ = rotate;
			
			myTimer = new Timer(time, 0);
			myTimer.start();
			statusTimer = true;
			
			myTimer.addEventListener(TimerEvent.TIMER, move);
			enemy.addEventListener(Event.ENTER_FRAME, loop);
		}
		
		public function posX():int {
			return enemy.x;
		}
		
		public function posY():int {
			return enemy.y;
		}
		
		public function rotatePosition():int {
			return enemy.rotationZ;
		}
		
		public function goOnPoint(starshipX:int, starshipY:int):void {
			myTimer.stop();
			statusTimer = false;
			enemy.rotationZ = Math.atan2((starshipX - enemy.x), -(starshipY - enemy.y)) * 180 / Math.PI;
		}

		public function startAgainTimer():void {
			if (statusTimer == false) {
				myTimer.start();
				statusTimer = true;
			}
		}

		public function die():void {
			myTimer.stop();
			statusTimer = false;
			myTimer.removeEventListener(TimerEvent.TIMER, move);
			enemy.removeEventListener(Event.ENTER_FRAME, loop);
			TweenLite.to(enemy, 0.5, {alpha:0, onComplete:remove});
		}
		
		private function remove():void {
			removeChild(enemy);
		}

		private function move(t:TimerEvent):void {
			TweenLite.to(enemy, 0.5, {rotationZ:Math.round(Math.random() * 360)});
		}
		
		private function loop(e:Event):void {
			enemy.x += 7 * Math.sin(enemy.rotationZ * Math.PI / 180);
			enemy.y -= 7 * Math.cos(enemy.rotationZ * Math.PI / 180);
		}
	}
}
