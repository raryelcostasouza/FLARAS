package flaras.view.scene 
{
	import flaras.constants.*;
	import flaras.errorHandler.*;
	import flaras.io.*;
	import flaras.marker.*;
	import flaras.model.*;
	import flash.events.*;
	import flash.filesystem.*;
	import org.papervision3d.core.math.*;
	import org.papervision3d.objects.*;
	import org.papervision3d.objects.parsers.*;
	
	public class ViewVirtualObjectScene extends ViewFlarasScene
	{
		private var _obj3DAlreadyLoaded:Boolean;
		
		private var _virtualObjectScene:VirtualObjectScene;
		
		public function ViewVirtualObjectScene(virtualObjectScene:VirtualObjectScene) 
		{
			super(this, virtualObjectScene);
			_virtualObjectScene = virtualObjectScene;
			_obj3DAlreadyLoaded = false;
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
			var objDAE:DAE;
			var objMax3DS:Max3DS;
			
			if (_virtualObjectScene.getPath3DObjectFile().toLowerCase().indexOf(".dae") != -1)
			{
				objDAE = new DAE(true, null, true);
				objDAE.addEventListener(IOErrorEvent.IO_ERROR, ErrorHandler.onIOErrorAsynchronous);
				objDAE.addEventListener(SecurityErrorEvent.SECURITY_ERROR, ErrorHandler.onSecurityErrorAsynchronous);
				//objDAE.addEventListener(FileLoadEvent.LOAD_COMPLETE, onLoadComplete);
				
				objDAE.load(FolderConstants.getFlarasAppCurrentFolder() + "/" + _virtualObjectScene.getPath3DObjectFile());	
				_obj3D = objDAE;
			}
			else
			{
				objMax3DS = new Max3DS();
				objMax3DS.addEventListener(IOErrorEvent.IO_ERROR, ErrorHandler.onIOErrorAsynchronous);
				objMax3DS.addEventListener(SecurityErrorEvent.SECURITY_ERROR, ErrorHandler.onSecurityErrorAsynchronous);
				
				objMax3DS.load(FolderConstants.getFlarasAppCurrentFolder() + "/" + _virtualObjectScene.getPath3DObjectFile());
				_obj3D = objMax3DS;
			}
			_obj3DAlreadyLoaded = true;
			
			setObj3DProperties(_virtualObjectScene, _obj3D);
			
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