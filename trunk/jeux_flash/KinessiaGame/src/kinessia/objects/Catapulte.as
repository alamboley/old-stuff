package kinessia.objects {

	import Box2DAS.Common.V2;
	import Box2DAS.Dynamics.ContactEvent;
	import Box2DAS.Dynamics.Joints.b2RevoluteJoint;
	import Box2DAS.Dynamics.Joints.b2RevoluteJointDef;

	import kinessia.characters.Declik;

	import com.citrusengine.objects.PhysicsObject;

	import org.osflash.signals.Signal;

	/**
	 * @author Aymeric
	 */
	public class Catapulte extends PhysicsObject {

		public var onBeginContact:Signal;

		public function Catapulte(name:String, params:Object = null) {

			super(name, params);
			onBeginContact = new Signal(ContactEvent);
		}

		override public function destroy():void {

			onBeginContact.removeAll();
			_fixture.removeEventListener(ContactEvent.BEGIN_CONTACT, _handleBeginContact);
			super.destroy();
		}

		public function initJoint($platformJoint:BodyPlatform):void {

			var platformJoint:BodyPlatform = $platformJoint;

			var jointDefPlatform:b2RevoluteJointDef = new b2RevoluteJointDef();
			jointDefPlatform.Initialize(_body, platformJoint.body, new V2(15, 12));

			b2RevoluteJoint(_box2D.world.CreateJoint(jointDefPlatform));
		}

		override protected function createFixture():void {

			super.createFixture();
			_fixture.m_reportBeginContact = true;
			_fixture.addEventListener(ContactEvent.BEGIN_CONTACT, _handleBeginContact);
		}

		override protected function defineFixture():void {

			super.defineFixture();

			_fixtureDef.density = 0.1;
			_fixtureDef.restitution = 0;
		}

		private function _handleBeginContact(cEvt:ContactEvent):void {
			
			onBeginContact.dispatch(cEvt);

			if (cEvt.other.GetBody().GetUserData() is Declik) {

				cEvt.other.GetBody().GetUserData().velocityCatapulte = new V2(50, -5);
				cEvt.fixture.GetBody().ApplyImpulse(new V2(100, 50), new V2(width, 0));
			}
		}

	}
}