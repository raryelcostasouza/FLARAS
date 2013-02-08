package flaras.model.point 
{
	public class RefScene2Attract 
	{
		private var _pointIDNumber:uint;
		private var _sceneIDNumber:uint;
		
		public function RefScene2Attract(pPointIDNumber:uint, pSceneIDNumber:uint) 
		{
			_pointIDNumber = pPointIDNumber;
			_sceneIDNumber = pSceneIDNumber;
		}
		
		public function getPointIDNumber():uint { return _pointIDNumber; }
		public function getSceneIDNumber():uint { return _sceneIDNumber; }
	}
}