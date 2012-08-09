package flaras.view.scene 
{
	import flaras.controller.audio.*;
	import flaras.controller.constants.*;
	import flaras.model.*;
	import flaras.model.scene.*;
	
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
			unLoad();
		}		
		
		public function unLoad():void
		{
			AudioManager.stopAppAudio(_audioScene.getParentPointID());
		}		
		
		public function destroy():void
		{
			unLoad();
			_audioScene = null;
		}
	}
}