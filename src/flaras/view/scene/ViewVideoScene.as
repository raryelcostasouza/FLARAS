package flaras.view.scene 
{
	import flaras.constants.*;
	import flaras.controller.*;
	import flaras.controller.constants.*;
	import flaras.controller.video.*;
	import flaras.errorHandler.*;
	import flaras.marker.*;
	import flaras.model.*;
	import flaras.model.scene.*;
	import flaras.video.*;
	import flaras.view.marker.*;
	import flash.events.*;
	import flash.media.*;
	import flash.net.*;
	import org.papervision3d.core.math.*;
	import org.papervision3d.materials.*;
	import org.papervision3d.objects.*;
	import org.papervision3d.objects.primitives.*;

	public class ViewVideoScene extends ViewFlarasScene
	{
		private var _obj3DAlreadyLoaded:Boolean;
		
		private var _netStream:NetStream;
		private var _videoScene:VideoScene;
		
		public function ViewVideoScene(videoScene:VideoScene) 
		{
			super(this, videoScene);
			_videoScene = videoScene;
		}
		
		override public function showScene(playAudio:Boolean):void 
		{
			if (!_obj3D)
			{
				load();
				super.showScene(playAudio);
			}			
		}
		
		override public function hideScene():void
		{
			super.hideScene();
			if (_obj3D)
			{
				unLoad();
			}			
		}
		
		public function load():void
		{
			var plane:Plane;
			var vsm:VideoStreamMaterial;
			
			var videoManagerElements:Array = VideoManager.playVideo(
					FolderConstants.getFlarasAppCurrentFolder()+ "/" + _videoScene.getVideoFilePath(), _videoScene.getWidth(), _videoScene.getHeight(), _videoScene.getRepeatVideo());
			
			_netStream = videoManagerElements[1];
			vsm = new VideoStreamMaterial(videoManagerElements[0], videoManagerElements[1]);
			vsm.doubleSided = true;
			
			plane = new Plane(vsm, _videoScene.getWidth(), _videoScene.getHeight());
			
			_obj3D = plane;
			_obj3DAlreadyLoaded = true;
			
			//set position, rotation and scale
			setObj3DProperties(_videoScene, _obj3D);	
			setMirrorScaleFactor(CtrMirror.MIRRORED_SCALE_FACTOR);
			
			MarkerNodeManager.addObj2MarkerNode(_obj3D, Marker.REFERENCE_MARKER, null);
		}
		
		override public function unLoad():void
		{
			if (_obj3D)
			{
				super.unLoad();
				_obj3DAlreadyLoaded = false;
				_netStream.pause();
				_netStream.close();	
				
				_obj3D.removeEventListener(IOErrorEvent.IO_ERROR, ErrorHandler.onIOErrorAsynchronous);
				_obj3D.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, ErrorHandler.onSecurityErrorAsynchronous);
				MarkerNodeManager.removeObjFromMarkerNode(_obj3D, Marker.REFERENCE_MARKER);
				_obj3D = null;			
			}			
		}
	}
}

