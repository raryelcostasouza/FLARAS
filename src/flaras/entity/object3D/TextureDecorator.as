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
	import flaras.constants.FolderConstants;
	import flaras.errorHandler.*;
	import flaras.io.*;
	import flaras.marker.*;
	import flash.events.*;
	import flash.net.*;
	import org.papervision3d.materials.*;
	import org.papervision3d.objects.primitives.*;
	
	public class TextureDecorator extends ComponentDecorator
	{
		private var aTexturePath:String;
		private var aWidth:Number;
		private var aHeight:Number;
		
		public function TextureDecorator(pObj3D:Object3D, pTexturePath:String, pWidth:Number, pHeight:Number) 
		{
			super(pObj3D);
			aTexturePath = pTexturePath;
			aWidth = pWidth;
			aHeight = pHeight;
		}
		
		public function getTexturePath():String
		{
			return aTexturePath;
		}
		
		public function setTexturePath(pTexturePath:String):void
		{
			unLoadAndRemoveFile(AudioDecorator.DONT_REMOVE_AUDIO_FILE);
			aTexturePath = pTexturePath;
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
		
		override public function enableObject(pPlayAudio:Boolean):void 
		{
			if (!isObject3DAlreadyLoaded())
			{
				load();
			}
			else
			{
				setVisible(true);
			}
			getAnimation().startObjectAnimation();
		}
		
		private function load():void
		{
			var plane:Plane;
			var bfm:BitmapFileMaterial;
			var urlLoader:URLLoader;
			
			//workaround to dispatch io and security exception if some problem happens
			urlLoader = new URLLoader(new URLRequest(FolderConstants.getFlarasAppCurrentFolder() + "/" + aTexturePath));
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, ErrorHandler.onIOErrorAsynchronous);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, ErrorHandler.onSecurityErrorAsynchronous);
			urlLoader.addEventListener(Event.COMPLETE, GeneralIOEventHandler.onIOOperationComplete);			
			
			setObject3DAlreadyLoaded(true);
			bfm = new BitmapFileMaterial(FolderConstants.getFlarasAppCurrentFolder() + "/" + aTexturePath);
			bfm.doubleSided = true;
			
			plane = new Plane(bfm, aWidth, aHeight);
			copyDisplayObject3DProperties(plane);
			setDisplayObject3D(plane);
			MarkerNodeManager.addObj2MarkerNode(getDisplayObject3D(), Marker.REFERENCE_MARKER, null);
		}	
		
		override public function unLoadAndRemoveFile(removeAudio:Boolean):void
		{	
			unLoad();
			FileRemover.removeFile(FolderConstants.getFlarasAppCurrentFolder() + "/" + aTexturePath);
		}
	}
}