package flaras.model.point 
{
	public class RefScene2Attract 
	{
		private var _indexPoint:uint;
		private var _sceneIDNumber:uint;
		
		public function RefScene2Attract(pIndexPoint:uint, pSceneIDNumber:uint) 
		{
			_indexPoint = pIndexPoint;
			_sceneIDNumber = pSceneIDNumber;
		}
		
		public function getIndexPoint():uint { return _indexPoint; }
		public function getSceneIDNumber():uint { return _sceneIDNumber; }
		
		
	}
}