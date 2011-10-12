package afp.abstract
{
	import com.greensock.TweenMax;

	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author lbineau
	 */
	public class AbstractMobileButton extends Sprite
	{
		public function AbstractMobileButton()
		{
			addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, _onRemoveFromStage);
		}

		private function _onRemoveFromStage(event : Event) : void
		{
			this.removeEventListener(MouseEvent.MOUSE_DOWN, _onMouseDown);
			stage.removeEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
			_onUnStaged();
		}

		private function _onMouseUp(event : MouseEvent) : void
		{
			TweenMax.to(this, 0.3, {removeTint:true});
		}

		private function _onMouseDown(event : MouseEvent) : void
		{
			TweenMax.to(this, 0.3, {colorMatrixFilter:{colorize:0x0099ff, amount:0.5}});
		}

		protected function _onUnStaged() : void
		{
		}

		private function _onAddedToStage(event : Event) : void
		{
			this.addEventListener(MouseEvent.MOUSE_DOWN, _onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
			_onStaged();
		}

		protected function _onStaged() : void
		{
		}
	}
}
