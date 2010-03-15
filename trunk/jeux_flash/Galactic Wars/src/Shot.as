package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author Aymeric
	 */
	public class Shot extends MovieClip {
		
		private var shot:MovieClip;
		private var myTimer:Timer;
		
		public function Shot(rotate:int, posX:int, posY:int) {
			
			shot = new Fire();
			addChild(shot);
			shot.rotationZ = rotate;
			shot.x = posX;
			shot.y = posY;
			
			myTimer = new Timer(3000, 1);
			myTimer.start();
			
			myTimer.addEventListener(TimerEvent.TIMER_COMPLETE, endShot);
			shot.addEventListener(Event.ENTER_FRAME, loop);
		}
		
		public function die():void {
			myTimer.stop();
			shot.removeEventListener(Event.ENTER_FRAME, loop);
			myTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, endShot);
			removeChild(shot);
		}
		
		private function endShot(t:TimerEvent):void {
			myTimer.stop();
			shot.removeEventListener(Event.ENTER_FRAME, loop);
			myTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, endShot);
			removeChild(shot);
		}

		private function loop(e:Event):void {
			shot.x += 20 * Math.sin(shot.rotationZ * Math.PI / 180);
			shot.y -= 20 * Math.cos(shot.rotationZ * Math.PI / 180);
		}
	}
}
