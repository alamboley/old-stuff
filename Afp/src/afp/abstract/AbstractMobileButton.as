package afp.abstract
{
	import com.greensock.TweenMax;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * @author lbineau
	 */
	public class AbstractMobileButton extends Sprite
	{
		private var _tween:TweenMax;
		public function AbstractMobileButton()
		{
			mouseChildren = false;
			mouseEnabled = true;
			addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, _onRemoveFromStage);
		}

		private function _onRemoveFromStage(event : Event) : void
		{
			this.removeEventListener(MouseEvent.MOUSE_DOWN, _onMouseDown);
			this.removeEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
			_onUnStaged();
		}

		private function _onMouseUp(event : MouseEvent) : void
		{
			_tween.reverse(true);
		}

		private function _onMouseDown(event : MouseEvent) : void
		{
			_tween = new TweenMax(this, 0.3, {colorMatrixFilter:{colorize:0x0099ff, amount:0.5}});
		}

		protected function _onUnStaged() : void
		{
		}

		private function _onAddedToStage(event : Event) : void
		{
			this.addEventListener(MouseEvent.MOUSE_DOWN, _onMouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
			_onStaged();
		}

		protected function _onStaged() : void
		{
		}
	}
}
