package FTK
{
	import org.libspark.flartoolkit.core.transmat.*;
	
	public class MarkerData
	{
		/**
		 * 最後に認識した時の一致率
		 */
		public var confidence:Number;
		
		/**
		 * マーカーのインデックス
		 */
		public var markerIndex:int;
		
		/**
		 * 
		 */
		public var resultMat:FLARTransMatResult;
		
		/**
		 * 認識中かどうかのフラグ
		 */
		public var isDetect:Boolean = false;
		
		/**
		 * 一つ前の段階で認識していたかどうかのフラグ
		 */
		public var isPrevDetect:Boolean = false;
		
		/**
		 * 
		 */
		public function MarkerData(_markerIndex:int)
		{
			this.markerIndex = _markerIndex;
			this.resultMat = new FLARTransMatResult();
		}
	}	
}