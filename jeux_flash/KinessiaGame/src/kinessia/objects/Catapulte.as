package kinessia.objects {

	import Box2DAS.Common.V2;
	import Box2DAS.Dynamics.ContactEvent;
	import Box2DAS.Dynamics.Joints.b2RevoluteJoint;
	import Box2DAS.Dynamics.Joints.b2RevoluteJointDef;

	import kinessia.characters.Declik;

	import com.citrusengine.objects.PhysicsObject;

	/**
	 * @author Aymeric
	 */
	public class Catapulte extends PhysicsObject {

		private var _platformJoint:BodyPlatform;
		
		private var _heroLinearVelocity:V2;

		public function Catapulte(name:String, params:Object = null) {

			super(name, params);
		}

		override public function destroy():void {
			
			_fixture.removeEventListener(ContactEvent.BEGIN_CONTACT, _handleBeginContact);
			super.destroy();
		}

		public function initJoint(platformJoint:BodyPlatform):void {

			_platformJoint = platformJoint;

			var jointDefPlatform:b2RevoluteJointDef = new b2RevoluteJointDef();
			jointDefPlatform.Initialize(_body, _platformJoint.body, new V2(15, 12));

			var jointPlatform:b2RevoluteJoint = b2RevoluteJoint(_box2D.world.CreateJoint(jointDefPlatform));
		}

		override protected function createFixture():void {

			super.createFixture();
			_fixture.m_reportBeginContact = true;
			_fixture.addEventListener(ContactEvent.BEGIN_CONTACT, _handleBeginContact);
		}

		override protected function defineFixture():void {

			super.defineFixture();
			
			_fixtureDef.restitution = 0;
			_fixtureDef.density = 0.1;
		}

		private function _handleBeginContact(cEvt:ContactEvent):void {

			if (cEvt.other.GetBody().GetUserData() is Declik) {
				
				//TODO Improving catapult
				_body.ApplyImpulse(new V2(500, 20), new V2(width, 0));
			}
		}

	}
}
