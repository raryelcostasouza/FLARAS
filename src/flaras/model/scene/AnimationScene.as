package flaras.model.scene 
{
	public class AnimationScene 
	{
		private var _period:Number;
		private var _rotationAxis:uint;
		private var _radius:uint;
		private var _rotationDirection:int;
		
		public function AnimationScene(period:Number, rotationAxis:uint, radius:uint, rotationDirection:int) 
		{
			_period = period;
			_rotationAxis = rotationAxis;
			_radius = radius;
			_rotationDirection = rotationDirection;
		}
		
		public function getPeriod():Number { return _period; }
		public function getRotationAxis():uint { return _rotationAxis; }
		public function getRadius():uint { return _radius; }
		public function getRotationDirection():int { return _rotationDirection; }
		
		public function setAnimationProperties(period:Number, rotationAxis:uint, radius:uint, rotationDirection:int):void
		{
			_period = period;
			_rotationAxis = rotationAxis;
			_radius = radius;
			_rotationDirection = rotationDirection;
		}
	}
}