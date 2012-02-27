/**
 * FLARAS - Flash Augmented Reality Authoring System
 * --------------------------------------------------------------------------------
 * Copyright (C) 2011-2012 Raryel, Hipolito, Claudio
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * --------------------------------------------------------------------------------
 * Developers:
 * Raryel Costa Souza - raryel.costa[at]gmail.com
 * Hipolito Douglas Franca Moreira - hipolitodouglas[at]gmail.com
 * 
 * Advisor: Claudio Kirner - ckirner[at]gmail.com
 * http://www.ckirner.com/flaras
 * Developed at UNIFEI - Federal University of Itajuba (www.unifei.edu.br) - Minas Gerais - Brazil
 * Research scholarship by FAPEMIG - Fundação de Amparo à Pesquisa no Estado de Minas Gerais
 */

package flaras.entity.object3D
{
	import flaras.*;
	import flaras.constants.*;
	import flaras.entity.*;
	import flaras.errorHandler.*;
	import flaras.io.*;
	import flaras.marker.*;
	import flaras.util.*;
	import flaras.video.*;
	import flash.events.*;
	import flash.media.*;
	import flash.net.*;
	import org.papervision3d.core.math.*;
	import org.papervision3d.materials.*;
	import org.papervision3d.objects.*;
	import org.papervision3d.objects.primitives.*;
	
	public class VideoDecorator extends ComponentDecorator
	{
		private var aWidth:Number;
		private var aHeight:Number;
		private var aVideoPath:String;
		private var aRepeatVideo:Boolean;
		private var aObjNetStream:NetStream;
		
		public function VideoDecorator(pObj3D:Object3D, pVideoPath:String, pWidth:Number, pHeight:Number, pRepeatVideo:Boolean) 
		{
			super(pObj3D);
			aWidth = pWidth;
			aHeight = pHeight;
			aVideoPath = pVideoPath;
			aRepeatVideo = pRepeatVideo;
		}
		
		public function getVideoPath():String
		{
			return aVideoPath;
		}
		
		public function setVideoPath(pVideoPath:String):void
		{
			unLoadAndRemoveFile(AudioDecorator.DONT_REMOVE_AUDIO_FILE);
			aVideoPath = pVideoPath;
		}
		
		public function getWidth():Number
		{
			return aWidth;
		}
		
		public function setWidth(pWidth:Number):void
		{
			aWidth = pWidth;
			unLoad();
		}
		
		public function getHeight():Number
		{
			return aHeight;
		}
		
		public function setHeight(pHeight:Number):void
		{
			aHeight = pHeight;
			unLoad();
		}
		
		public function getRepeatVideo():Boolean
		{
			return aRepeatVideo;
		}
		
		public function setRepeatVideo(pRepeatVideo:Boolean):void
		{
			aRepeatVideo = pRepeatVideo;
		}
		
		private function load():void 
		{
			var nc:NetConnection;
			var v:Video;
			var plane:Plane;
			
			setObject3DAlreadyLoaded(true);
			
			var videoManagerElements:Array = VideoManager.playVideo(
					FolderConstants.getFlarasAppCurrentFolder()+ "/" + aVideoPath, aWidth, aHeight, aRepeatVideo);
			
			aObjNetStream = videoManagerElements[1];
			plane = new Plane(new VideoStreamMaterial(videoManagerElements[0], videoManagerElements[1]), aWidth, aHeight);
			
			copyDisplayObject3DProperties(plane);
			setDisplayObject3D(plane);
			
			MarkerNodeManager.addObj2MarkerNode(getDisplayObject3D(), Marker.REFERENCE_MARKER, null);
		}
		
		override public function unLoad():void
		{
			if (isObject3DAlreadyLoaded())
			{
				setObject3DAlreadyLoaded(false);
				aObjNetStream.pause();
				aObjNetStream.close();
				super.unLoad();
			}
		}
		
		override public function enableObject(pPlayAudio:Boolean):void 
		{
			load();
		}
		
		override public function disableObject():void 
		{
			unLoad();			
		}
	
		override public function unLoadAndRemoveFile(removeAudio:Boolean):void
		{	
			unLoad();
			FileRemover.removeFile(FolderConstants.getFlarasAppCurrentFolder()+ "/" + aVideoPath);
		}
	}
}