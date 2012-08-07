package flaras.model 
{
	public class AudioScene 
	{
		private var _audioFilePath:String;
		private var _repeatAudio:Boolean;
		
		private var _parentFlarasScene:FlarasScene;
		
		public function AudioScene(parentFlarasScene:FlarasScene, audioFilePath:String, repeatAudio:Boolean) 
		{
			_audioFilePath = audioFilePath;
			_repeatAudio = repeatAudio;
			_parentFlarasScene = parentFlarasScene;
		}
		
		public function getAudioFilePath():String { return _audioFilePath; }
		public function getRepeatAudio():Boolean { return _repeatAudio; }
		public function getParentPointID():uint { return _parentFlarasScene.getParentPoint().getID(); }	
		
		public function setAudioFilePath(audioFilePath:String):void
		{
			_audioFilePath = audioFilePath;
		}
		
		public function setRepeatAudio(repeatAudio:Boolean):void 
		{
			_repeatAudio = repeatAudio;
		}		
	}
}