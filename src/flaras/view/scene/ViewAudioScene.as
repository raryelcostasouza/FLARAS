package flaras.view.scene 
{
	import flaras.audio.*;
	import flaras.constants.*;
	import flaras.model.*;
	
	public class ViewAudioScene 
	{
		private var _audioScene:AudioScene;
				
		public function ViewAudioScene(audioScene:AudioScene) 
		{
			_audioScene = audioScene;
		}
		
		public function showScene():void
		{
			AudioManager.playAppAudio(FolderConstants.getFlarasAppCurrentFolder()+ "/"+ _audioScene.getAudioFilePath(), _audioScene.getRepeatAudio(), _audioScene.getParentPointID());
		}
		
		public function hideScene():void
		{
			AudioManager.stopAppAudio(_audioScene.getParentPointID());
		}		
		
		public function unLoad():void
		{
			AudioManager.stopAppAudio(_audioScene.getParentPointID());
		}		
	}
}