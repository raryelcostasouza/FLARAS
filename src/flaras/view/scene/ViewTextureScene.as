package flaras.view.scene 
{
	import flaras.constants.*;
	import flaras.controller.CtrMirror;
	import flaras.errorHandler.*;
	import flaras.io.*;
	import flaras.marker.*;
	import flaras.model.*;
	import flash.events.*;
	import flash.net.*;
	import org.papervision3d.core.math.*;
	import org.papervision3d.materials.*;
	import org.papervision3d.objects.*;
	import org.papervision3d.objects.primitives.*;

	public class ViewTextureScene extends ViewFlarasScene
	{
		private var _obj3DAlreadyLoaded:Boolean;
		
		private var _textureScene:TextureScene;
		
		public function ViewTextureScene(textureScene:TextureScene) 
		{
			super(this, textureScene);
			_textureScene = textureScene;
		}
		
		/*public function getObj3D():DisplayObject3D
		{
			return _obj3D;
		}*/
		
		override public function showScene(playAudio:Boolean):void 
		{
			if (_obj3DAlreadyLoaded)
			{
				_obj3D.visible = true;
			}
			else
			{
				load();
			}
			super.showScene(playAudio);
		}
		
		override public function hideScene():void
		{
			super.hideScene();
			if (_obj3DAlreadyLoaded)
			{
				_obj3D.visible = false;
			}
		}
		
		public function load():void
		{
			var plane:Plane;
			var bfm:BitmapFileMaterial;
			var urlLoader:URLLoader;
			
			//workaround to dispatch io and security exception if some problem happens
			urlLoader = new URLLoader(new URLRequest(FolderConstants.getFlarasAppCurrentFolder() + "/" + _textureScene.getTextureFilePath()));
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, ErrorHandler.onIOErrorAsynchronous);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, ErrorHandler.onSecurityErrorAsynchronous);
			urlLoader.addEventListener(Event.COMPLETE, GeneralIOEventHandler.onIOOperationComplete);			
			
			bfm = new BitmapFileMaterial(FolderConstants.getFlarasAppCurrentFolder() + "/" + _textureScene.getTextureFilePath());
			bfm.doubleSided = true;
			
			plane = new Plane(bfm, _textureScene.getWidth(), _textureScene.getHeight());
		
			_obj3D = plane;
			_obj3DAlreadyLoaded = true;
			
			//set position, rotation and scale
			setObj3DProperties(_textureScene, _obj3D);
			setMirrorScaleFactor(CtrMirror.MIRRORED_SCALE_FACTOR);
			
			MarkerNodeManager.addObj2MarkerNode(_obj3D, Marker.REFERENCE_MARKER, null);
		}
		
		override public function unLoad():void
		{
			super.unLoad();
			_obj3DAlreadyLoaded = false;
			_obj3D.removeEventListener(IOErrorEvent.IO_ERROR, ErrorHandler.onIOErrorAsynchronous);
			_obj3D.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, ErrorHandler.onSecurityErrorAsynchronous);
			
			MarkerNodeManager.removeObjFromMarkerNode(_obj3D, Marker.REFERENCE_MARKER);
		}
	}

}