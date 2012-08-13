package flaras.controller.io.fileReader 
{
	import flaras.controller.*;
	import flaras.controller.io.*;
	import flash.events.*;
	import flash.net.*;
	
	public class FileReaderRefMarker 
	{		
		private var _ctrMarker:CtrMarker;
		private var _filePath:String;
		
		public function FileReaderRefMarker(ctrMarker:CtrMarker, filePath:String) 
		{
			this._ctrMarker = ctrMarker;
			_filePath = filePath;
			read(filePath);
		}
		
		private function read(filePath:String):void
		{
			var fileLoader:URLLoader = new URLLoader(new URLRequest(filePath));
			
			fileLoader.addEventListener(Event.COMPLETE, onComplete);
            fileLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError); 
            fileLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
		}
		
		private function onComplete(e:Event):void
		{
			e.target.removeEventListener(Event.COMPLETE, onComplete);
			e.target.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			e.target.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			
			var xml:XML = XML(e.target.data);
			this._ctrMarker.finishedLoadingRefMarkerData(xml.baseType);
		}
		
		private function onIOError(e:Event):void
		{
			ErrorHandler.onIOError("FileReaderRefMarker", _filePath);
		}
		
		private function onSecurityError(e:Event):void
		{
			ErrorHandler.onSecurityError("FileReaderRefMarker", _filePath);
		}
	}
}