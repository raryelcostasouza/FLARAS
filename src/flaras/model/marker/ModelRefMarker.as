package flaras.model.marker 
{
	public class ModelRefMarker 
	{
		private var _baseType:uint;
		
		//after removing the marker from the camera field the 3D Viewport keeps being shown
		private var _persistence:Boolean;
		
		public function ModelRefMarker(pBaseType:uint, pPersistence:Boolean) 
		{
			_baseType = pBaseType;
			_persistence = pPersistence;
		}
		
		public function getBaseType():uint
		{ 
			return _baseType;
		}
		
		public function getPersistence():Boolean 
		{
			return _persistence;
		}
		
		public function setBaseType(pBaseType:uint):void 
		{
			_baseType = pBaseType;
		}		
		
		public function setPersistence(value:Boolean):void 
		{
			_persistence = value;
		}
	}
}