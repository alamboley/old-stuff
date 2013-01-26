package objects
{ 

	import citrus.objects.NapePhysicsObject;
	import citrus.objects.platformer.nape.Hero;
	import nape.callbacks.CbType;
	import nape.phys.Material;

	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Polygon;

	import flash.events.TimerEvent;
	import flash.utils.Timer;
	 
	/**
	 * This class creates perpetual hills like games Tiny Wings, Ski Safari...
	 * Write a class to manage graphics, and extends this one to call graphics function.
	 * For more information, check out CE's Tiny Wings example.
	 * Thanks to <a href="http://www.lorenzonuvoletta.com/create-an-infinite-scrolling-world-with-starling-and-nape/">Lorenzo Nuvoletta</a>.
	 */
	public class Hills extends NapePhysicsObject {

		/**
		 * a JSON.
		 */		
		public var levelInformation:Object;
		
		/**
		 * This is the height of a slice. 
		 */
		public var sliceHeight:uint = 600;
		
		/**
		 * This is the width of a slice. 
		 */
		public var sliceWidth:uint = 30;
		
		/**
		 * This is the height of the first point.
		 */
		public var currentYPoint:Number = 200;
		
		/**
		 * This is the width of the hills visible. Most of the time your stage width. 
		 */
		public var widthHills:Number = 550;
		
		/**
		 * This is the physics object from which the Hills read its position and create/delete hills. 
		 */
		public var rider:NapePhysicsObject;
		
		protected var _slicesCreated:uint;
		protected var _currentAmplitude:Number;
		protected var _nextYPoint:Number;
		
		/**
		 * Une bosse toutes les x tranches.
		 */
		protected var _slicesInCurrentHill:uint;
		protected var _indexSliceInCurrentHill:uint;
		protected var _slices:Vector.<Body>;
		protected var _sliceVectorConstructor:Vector.<Vec2>;
		
		protected var _back:Boolean = false;
		protected var _forward:Boolean = false;
		
		protected var _prevBack:Boolean = false;
		protected var _prevForward:Boolean = false;
		
		private var _timer:Timer;
		private var _modifiedTimerCount:int;
		
	//	private var _pointsY:Array = [1004,1005,1005,1005,1004,1004,1004,1004,1002,987,980,987,995,999,1012,1020,997,1000,1006,1014,1021,1011,991,988,1005,1029,1039,1042,1040,1028,1001,950,892,879,899,930,954,974,979,977,969,931,827,811,835,878,1069,1128,1144,1147,1133,1116,1124,1143,1126,1082,1007,877,748,713,685,644,605,561,486,410,354,359,402,473,571,638,674,683,680,701,624,746,1003,1064,1092,1110,1108,1103,1095,1078,1050,995,920,845,751,701,694,706,749,810,852,860,865,850,831,748,813,873,930,1004,1089,1125,1140,1140,1127,1105,1077,1060,1065,1058,1082,1116,1131,1121,1103,1081,1038,988,917,1053,1091,1105,1108,1108,1090,1051,1005,921,889,931,960,967,970,938,910,918,946,967,967,940,924,931,962,1006,1028,1034,1028,986,930,878,708,689,717,748,754,744,746,736,762,776,789,759,731,743,760,786,821,861,938,1029,1128,1171,1177,1156,1126,1089,1032,965,894,844,840,860,897,957,1036,1114,1176,1187,1193,1188,1162,1112,1036,971,930,918,925,948,979,1020,1065,1111,1152,1168,1165,1122,1076,956,828,780,782,816,861,897,947,978,983,969,956,951,973,1003,1036,1070,1139,1256,1361,1391,1404,1411,1348,1358,1417,1419,1417,1407,1425,1410,1434,1430,1430,1435,1432,1333,1296,1336,1412,1750,1838,1856,1788,1661,1522,1397,1324,1336,1377,1433,1499,1590,1706,1787,1831,1831,1806,1765,1693,1583,1500,1508,1563,1669,1788,1883,1942,1970,1980,1977,1940,1896,1838,1757,1738,1738,1740,1740,1735,1737,1735,1739,1736,1738,1738];
		
		//private var HillsCBType:CbType = ALevel.;
		
	
		public static var _pointsY:Array = [1004,995,994,995,997,998,1001,1002,998,994,998,1005,1008,1009,1005,989,1001,1018,1023,1026,1021,1019,1001,1001,1015,1021,1023,1018,1001,990,987,1018,1037,1042,1045,1040,1025,979,925,873,822,788,798,831,878,938,994,1034,1052,1056,1054,1038,1018,998,989,1001,1026,1044,1043,1034,1022,1007,979,939,879,773,643,549,519,514,536,568,606,664,762,848];
	
		public var _indexPointsY:int = 0;

		public function Hills(name:String, params:Object = null) {
			
		
			
			super(name, params);
		}

			
		override public function initialize(poolObjectParams:Object = null):void {
			
			super.initialize(poolObjectParams);
			
			_prepareSlices();
		}
			
		override public function destroy ():void {
			
			 
			super.destroy();
		}
		
		protected function _prepareSlices():void {
			
			(_view as HillsTexture).init(sliceWidth, sliceHeight);
			
			_slices = new Vector.<Body>();

			// Generate a rectangle made of Vec2
			_sliceVectorConstructor = new Vector.<Vec2>();
			_sliceVectorConstructor.push(new Vec2(0, sliceHeight));
			_sliceVectorConstructor.push(new Vec2(0, 0));
			_sliceVectorConstructor.push(new Vec2(sliceWidth, 0));
			_sliceVectorConstructor.push(new Vec2(sliceWidth, sliceHeight));
			
			// fill the stage with slices of hills
			for (var i:uint = 0; i < widthHills / sliceWidth * 1.2; ++i) {
				_createSlice();
			}
		}
		
		protected function _createSlice():void {
			
			// Every time a new hill has to be created this algorithm predicts where the slices will be positioned
			if (_indexSliceInCurrentHill >= _slicesInCurrentHill) {
				
				// une "bosse" toutes les x tranches, ne peut-être inférieur à 0.
				_slicesInCurrentHill = _slicesInCurrentHill <= 0 ? 10 : _slicesInCurrentHill;
					
				_currentAmplitude = _modifiedTimerCount;
				
				_indexSliceInCurrentHill = 0;
			}
			// Calculate the position of the next slice
			_nextYPoint = currentYPoint + (Math.sin(((Math.PI / _slicesInCurrentHill) * _indexSliceInCurrentHill)) * _currentAmplitude);
			
			if (_nextYPoint < 100) {
					trace("le hills risque de dépasser le 0, on devrait inverser l'amplitude");
					//_nextYPoint = currentYPoint + (Math.sin(((Math.PI / _slicesInCurrentHill) * _indexSliceInCurrentHill)) * -_currentAmplitude);
			}
			
			if (_back) {
				
				if (_prevForward) {
					
					_indexPointsY -= _slicesCreated + 2;
					
					if (_indexPointsY <= -1)
						_indexPointsY = _pointsY.length - 1;
					
					_prevForward = false;
					
					currentYPoint = _pointsY[_indexPointsY--];										
				}
				
				_nextYPoint = _pointsY[_indexPointsY--];
				
				if (_indexPointsY <= -1)
					_indexPointsY = _pointsY.length - 1;
					
			} else {
				
				if (_prevBack) {
					
					_indexPointsY += _slicesCreated + 2;
										
					if (_indexPointsY >= _pointsY.length - 1)
						_indexPointsY = 0;
					
					_prevBack = false;
					
					currentYPoint = _pointsY[_indexPointsY++];					
				}
				
				_nextYPoint = _pointsY[_indexPointsY++];
				
				if (_indexPointsY >= _pointsY.length - 1)
					_indexPointsY = 0;
			}
			
			if (_back)
				_sliceVectorConstructor[2].y = currentYPoint - _nextYPoint;
			else
				_sliceVectorConstructor[2].y = _nextYPoint - currentYPoint;
						
			var slicePolygon:Polygon = new Polygon(_sliceVectorConstructor,new Material(0,2,2,1,0.01));
			
			_body = new Body(BodyType.STATIC);
			_body.userData.myData = this;
			_body.shapes.add(slicePolygon);
			_body.userData.name = "hills";
			
			
			var length:uint = _slices.length;
			
			if (_back) {
				
				_body.position.x = _slices[0].position.x - sliceWidth;
				_body.position.y = _nextYPoint;
								
			} else {
				
				_body.position.x = length > 0 ? _slices[length - 1].position.x + sliceWidth : 0;
				_body.position.y = currentYPoint;
			}
			
			// trou :			
			/*if (_back) {
				
				if (levelInformation.level.troncons[_indexPointsY + 3].trou) {
					
					// quick and dirty way, mais jamais utilisé pour le stockage ou en itération donc sans grande conséquence.
					//_slicesCreated = _indexPointsY == 118 ? _slicesCreated + 4 : _slicesCreated + 1;
					
					_body.position.x -= sliceWidth;
				}
				
			} else {
							
				if (levelInformation.level.troncons[_indexPointsY].trou) {
					
					// quick and dirty way, mais jamais utilisé pour le stockage ou en itération donc sans grande conséquence.
					//_slicesCreated = _indexPointsY == 118 ? _slicesCreated + 4 : _slicesCreated + 1;
					
					_body.position.x += sliceWidth;
				}
			}*/
			
			_body.space = _nape.space;
						
			_pushHill();
		}
		
		protected function _pushHill():void {
			
			(_view as HillsTexture).createSlice(_body, _nextYPoint, currentYPoint, _back, "troncon");
			
			_slicesCreated++;
			_indexSliceInCurrentHill++;
			
			currentYPoint = _nextYPoint;
			
			if (_back)
			 	_slices.unshift(_body);
			else 
				_slices.push(_body);
		}
		
		protected function _checkHills():void {
			
			if (!rider)
				rider = _ce.state.getFirstObjectByType(Hero) as Hero;
				
			_back = rider.x - _slices[0].position.x < _ce.stage.stageWidth >> 1;
			_forward = rider.x - _slices[0].position.x > _ce.stage.stageWidth;
			
			if (_forward || _back) {
				
				if (_forward)
					_prevForward = true;
				
				if (_back)
					_prevBack = true; 
				
				// _deleteHill(_back ? _slices.length - 1 : 0);
				_createSlice();
			}
		}
		
		protected function _deleteHill(index:uint):void {
			
			(_view as HillsTexture).deleteHill(index);
			
			_slicesCreated--;
			
			_nape.space.bodies.remove(_slices[index]);
			_slices.splice(index, 1);
		}
			
		override public function update(timeDelta:Number):void {
			
			super.update(timeDelta);
			
			//_checkHills();
		}
		
		/**
		 * Bodies are generated automatically, those functions aren't needed.
		 */
		override protected function defineBody():void {
		}
		
		override protected function createBody():void {
		}
		
		override protected function createMaterial():void {
		}
		
		override protected function createShape():void {
		}
		
		override protected function createFilter():void {
		}
		
		override protected function createConstraint():void {
		}
	}
}
