package afp.pages
{
	import afp.core.Config;
	import afp.core.User;
	import afp.remoting.Service;
	import afp.remoting.vo.EventVO;
	import com.adobe.serialization.json.JSON;
	import com.greensock.TweenMax;
	import com.thanksmister.touchlist.controls.TouchList;
	import com.thanksmister.touchlist.events.ListItemEvent;
	import com.thanksmister.touchlist.renderers.TouchListItemRenderer;


	/**
	 * @author lbineau
	 */
	public class PageEventSelection extends APage
	{
		public static const ID : String = PagePaths.EVENT_SELECTION;
		private var _elements : Vector.<EventVO>;
		private var _touchList : TouchList;
		private var _service : Service;
		private var _asset : EventPageAsset;
		

		public function PageEventSelection($options : Object = null)
		{
			super($options);
		}

		override protected function _onStaged() : void
		{
			super._onStaged();
			_initialize();
		}

		private function _initialize() : void
		{
			_asset = new EventPageAsset();
			addChild(_asset);
			_service = new Service(Config.SERVICES_URL + 'usereventlinkservice.php');
			_service.onResult.add(_onResult);
			_service.onError.add(_onError);
			_service.geteventsforuser(User.getInstance().id);
		}

		private function _onResult(result : Object) : void
		{
			var json : Object = JSON.decode(String(result)).AFPResponse;
			if (json.success == 0)
			{
				_onError(result);
			}
			else if (json.success == 1)
			{
				_elements = new Vector.<EventVO>();

				for each (var event : Object in json.dataObject)
				{
					_elements.push(new EventVO(event));
				}

				_touchList = new TouchList(stage.stageWidth, stage.stageHeight - _asset.container.y);
				_touchList.addEventListener(ListItemEvent.ITEM_SELECTED, _handlelistItemSelected);
				_asset.container.addChild(_touchList);

				var item : TouchListItemRenderer;

				for each (var eventVO:EventVO in _elements)
				{
					item = new TouchListItemRenderer();
					item.index = uint(eventVO.id);
					item.data = eventVO.nom;
					item.itemHeight = 80;

					_touchList.addListItem(item);
				}
			}
		}

		private function _handlelistItemSelected(liEvt : ListItemEvent) : void
		{
			_options.eventId = liEvt.renderer.index;
			gotoPage.dispatch(PagePaths.IMAGE_UPLOAD, _options);
			trace("List item selected: " + liEvt.renderer.index);
		}

		private function _onError(result : Object) : void
		{
			trace('error', result);
		}

		override public function hide() : void
		{
			super.hide();
			TweenMax.to(this, 0.3, {autoAlpha:0, onComplete:hidden});
		}

		override public function show() : void
		{
			super.show();
			TweenMax.to(this, 0.5, {autoAlpha:1, onComplete:shown});
		}

		override public function hidden() : void
		{
			resume();
			super.hidden();
		}

		override public function dispose() : void
		{
			super.dispose();
		}
	}
}
