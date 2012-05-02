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

package flaras.io.fileReader
{
	import flaras.controller.*;
	import flaras.errorHandler.*;
	import flaras.io.GeneralIOEventHandler;
	import flash.errors.*;
	import flash.events.*;
	import flash.filesystem.*;
	import flash.net.*;
	import org.papervision3d.core.math.*;
		
	public class FileReaderListOfObjects extends FileReader
	{		
		private var aIndexBuffer:uint;
		
		public function FileReaderListOfObjects(pIndexBuffer:uint, pFilePath:String, pObjCtrPoint:CtrPoint)
		{
			super(pObjCtrPoint);
			aIndexBuffer = pIndexBuffer;
			readFile(pFilePath);			
		}
		
		private function readFile(pFilePath:String):void
		{
			var fileLoader:URLLoader = new URLLoader(new URLRequest(pFilePath));
			
			fileLoader.addEventListener(Event.COMPLETE, GeneralIOEventHandler.onIOOperationComplete)
			fileLoader.addEventListener(Event.COMPLETE, onComplete);
            fileLoader.addEventListener(IOErrorEvent.IO_ERROR, ErrorHandler.onIOErrorAsynchronous); 
            fileLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, ErrorHandler.onSecurityErrorAsynchronous); 
		}
	
		private function onComplete(e:Event):void
		{	
			e.target.removeEventListener(Event.COMPLETE, onComplete);
			aXMLFile = XML(e.target.data);
			
			for each (var obj3D:XML in aXMLFile.object3D) 
			{
				var hasAnimation:String;
				
				//if the string has length = 0  means that this project file is from a older version of flaras
				//that did not support animation. So it's necessary to interpret it in a little different way, to keep compatibility.
				hasAnimation = obj3D.animation.hasAnimation.toString();				
				
				//if the project is on the new xml format (animations on flaras)
				if (hasAnimation.length != 0)
				{
					aObjCtrPoint.getCtrListOfObjects(aIndexBuffer).addObject(obj3D.filePath, 
												new Number3D(obj3D.translation.x, obj3D.translation.y, obj3D.translation.z),
												new Number3D(obj3D.rotation.x, obj3D.rotation.y, obj3D.rotation.z),
												new Number3D(obj3D.scale.x, obj3D.scale.y, obj3D.scale.z),
												Boolean(parseInt(obj3D.texture.hasTexture)), obj3D.texture.texturePath,
												obj3D.texture.width, obj3D.texture.height,
												Boolean(parseInt(obj3D.audio.hasAudio)), obj3D.audio.audioPath, 
												Boolean(parseInt(obj3D.audio.repeatAudio)), Boolean(parseInt(obj3D.video.hasVideo)),
												obj3D.video.videoPath, obj3D.video.width, obj3D.video.height, Boolean(parseInt(obj3D.video.repeatVideo)),
												Boolean(parseInt(obj3D.animation.hasAnimation)), obj3D.animation.period, obj3D.animation.rotationAxis);
				}
				//old project
				else
				{
					aObjCtrPoint.getCtrListOfObjects(aIndexBuffer).addObject(obj3D.filePath, 
												new Number3D(obj3D.translation.x, obj3D.translation.y, obj3D.translation.z),
												new Number3D(obj3D.rotation.x, obj3D.rotation.y, obj3D.rotation.z),
												new Number3D(obj3D.scale.x, obj3D.scale.y, obj3D.scale.z),
												Boolean(parseInt(obj3D.texture.hasTexture)), obj3D.texture.texturePath,
												obj3D.texture.width, obj3D.texture.height,
												Boolean(parseInt(obj3D.audio.hasAudio)), obj3D.audio.audioPath, 
												Boolean(parseInt(obj3D.audio.repeatAudio)), Boolean(parseInt(obj3D.video.hasVideo)),
												obj3D.video.videoPath, obj3D.video.width, obj3D.video.height, Boolean(parseInt(obj3D.video.repeatVideo)));
				}
			}
		}
	}	
}