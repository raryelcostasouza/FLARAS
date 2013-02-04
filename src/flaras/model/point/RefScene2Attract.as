package flaras.model.point 
{
	public class RefScene2Attract 
	{
		private var _indexPoint:uint;
		private var _indexScene:uint;
		
		public function RefScene2Attract(pIndexPoint:uint, pIndexScene:uint) 
		{
			_indexPoint = pIndexPoint;
			_indexScene = pIndexScene;
		}
		
		public function getIndexPoint():uint { return _indexPoint; }
		public function getIndexScene():uint { return _indexScene; }
		
		public function setIndexScene(pIndexScene:uint):void
		{
			_indexScene = pIndexScene;
		}
	}
}