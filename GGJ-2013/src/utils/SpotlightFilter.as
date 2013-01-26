/**
 *	Copyright (c) 2012 Devon O. Wolfgang
 *
 *	Permission is hereby granted, free of charge, to any person obtaining a copy
 *	of this software and associated documentation files (the "Software"), to deal
 *	in the Software without restriction, including without limitation the rights
 *	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *	copies of the Software, and to permit persons to whom the Software is
 *	furnished to do so, subject to the following conditions:
 *
 *	The above copyright notice and this permission notice shall be included in
 *	all copies or substantial portions of the Software.
 *
 *	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *	THE SOFTWARE.
 */
 
package utils {

	import starling.filters.FragmentFilter;
	import starling.textures.Texture;

	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Program3D;
 
	public class SpotlightFilter extends FragmentFilter
	{
		private var mCenter:Vector.<Number> = new <Number>[1, 1, 1, 1];
		private var mVars:Vector.<Number> = new <Number>[.50, .50, .50, .50];
		private var mVars2:Vector.<Number> = new <Number>[0.5, 1, 1, 1];
		private var mPixelSize:int;
		private var mShaderProgram:Program3D;
 
		private var mCenterX:Number;
		private var mCenterY:Number;
		private var mAmount:Number;
		private var mSize:Number;
		private var mRadius:Number;
		private var mUseFlicker:Boolean;
 
		/**
		 * Produces a spotlight or vignette like effect on Starling display objects.
		 * @param	cx			center x of spotlight. should be relative to display object being filtered
		 * @param	cy			center y of spotlight. should be relative to display object being filtered
		 * @param	amount		how much should the effect be applied.
		 * @param	radius		the amount of inner bright light.
		 * @param	size		the size of the effect
		 */
		public function SpotlightFilter(cx:Number = 0.0, cy:Number = 0.0, amount:Number = 1.0, radius:Number = .25, size:Number = .25, useFlicker:Boolean = false )
		{
			mCenterX	= cx;
			mCenterY	= cy;
			mAmount		= amount;
			mRadius		= radius;
			mSize		= size;
			mUseFlicker	= useFlicker;
		}
 
		public override function dispose():void
		{
			if (mShaderProgram) mShaderProgram.dispose();
			super.dispose();
		}
 
		protected override function createPrograms():void
		{
			var fragmentProgramCode:String =
				"sub ft0.xy, v0.xy, fc0.xy \n" +
				"mov ft2.x, fc1.w \n" +
				"mul ft2.x, ft2.x, fc1.z \n" +
				"sub ft3.xy, ft0.xy, ft2.x \n" +
				"dp3 ft4.x, ft3.xy, ft3.xy \n" +
				"sqt ft4.x, ft4.x \n" +
				"dp3 ft4.y, ft2.x, ft2.x \n" +
				"sqt ft4.y, ft4.y \n" +
				"div ft5.x, ft4.x, ft4.y \n" +
				"pow ft5.y, ft5.x, fc1.y \n" +
				"mul ft5.z, fc1.x, ft5.y \n" +
				"sat ft5.z, ft5.z \n" +
				"min ft5.z, ft5.z, fc0.z \n" +
				//"sub ft6, fc0.z, ft5.z \n" +
				"tex ft1, v0, fs0<2d, clamp, linear, nomip> \n" +

				//alpha mask
				"mov ft5.w, ft5.xyz \n" +
				//color from texture sample
				"mov ft5.xyz, ft1.xyz \n" +
				
				"mov oc, ft5";
 
			mShaderProgram = assembleAgal(fragmentProgramCode);
        }
 
		protected override function activate(pass:int, context:Context3D, texture:Texture):void
		{
			// already set by super class:
			//
			// vertex constants 0-3: mvpMatrix (3D)
			// vertex attribute 0:   vertex position (FLOAT_2)
			// vertex attribute 1:   texture coordinates (FLOAT_2)
			// texture 0:            input texture
 
			var halfSize:Number = mSize * .50;
			var cx:Number = mCenterX / texture.width - halfSize;
			var cy:Number = mCenterY / texture.height - halfSize;
			mCenter[0] = cx;
			mCenter[1] = cy;
 
			var radius:Number = mUseFlicker ? mRadius *(Math.random()*0.1 + 0.9) : mRadius;
 
			mVars[0] = mAmount;
			mVars[1] = radius;
			mVars[3] = mSize;
 
			context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, mCenter, 1);
			context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 1, mVars,   1);
		context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 2, mVars2,   1);
			context.setProgram(mShaderProgram);
        }
 
		public function get centerX():Number { return mCenterX; }
		public function set centerX(value:Number):void { mCenterX = value; }
 
		public function get centerY():Number { return mCenterY; }
		public function set centerY(value:Number):void { mCenterY = value; }
 
		public function get amount():Number { return mAmount; }
		public function set amount(value:Number):void { mAmount = value; }
 
		public function get size():Number { return mSize; }
		public function set size(value:Number):void { mSize = value; }
 
		public function get radius():Number { return mRadius; }
		public function set radius(value:Number):void { mRadius = value; }
 
		public function get useFlicker():Boolean { return mUseFlicker; }
		public function set useFlicker(value:Boolean):void { mUseFlicker = value; }
    }
}