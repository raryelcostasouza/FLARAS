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
	import flaras.constants.*;
	import flaras.controller.*;
	import flaras.controller.constants.*;
	import flaras.controller.io.*;
	import flaras.errorHandler.*;
	import flaras.io.*;
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
				var hasAnimation:Boolean;
				var animationPeriod:Number;
				var animationAxis:uint;
				var animationRadius:uint;
				var animationRotDirection:int;
				var obj3DFile:File;
				var flarasTempFolder:File;
				var newFilePath:String;
				
				//old flaras project withoud animation support
				if (obj3D.animation.hasAnimation == undefined)
				{
					hasAnimation = false;
					animationPeriod = 10;
					animationAxis = 0;
				}
				else
				{
					hasAnimation = Boolean(parseInt(obj3D.animation.hasAnimation));
					animationPeriod = obj3D.animation.period;
					animationAxis = obj3D.animation.rotationAxis;
					
					//flaras project with partial animation support	
					if (obj3D.animation.radius == undefined && obj3D.animation.rotationDirection == undefined)
					{
						animationRadius = 0;
						animationRotDirection = 1;
					}
					//latest flaras project (support for radius and rotationDirection)
					else
					{
						animationRadius = obj3D.animation.radius;
						animationRotDirection = obj3D.animation.rotationDirection
					}
				}
				
				//only on FLARAS Developer
				//import compatibility of old projects that used KMZ loader
				//unzip files and then use DAE loader
				flarasTempFolder = new File(FolderConstants.getFlarasAppCurrentFolder());
				obj3DFile = flarasTempFolder.resolvePath(obj3D.filePath);
				if (obj3DFile.extension.toLowerCase() == "zip" || obj3DFile.extension.toLowerCase() == "kmz" )
				{
					newFilePath = Zipped3DFileImporter.importFile(obj3DFile);
				}
				else
				{
					newFilePath = obj3D.filePath;
				}				
				//end only on FLARAS Developer
												
				aObjCtrPoint.getCtrScene(aIndexBuffer).addScene(newFilePath, 
												new Number3D(obj3D.translation.x, obj3D.translation.y, obj3D.translation.z),
												new Number3D(obj3D.rotation.x, obj3D.rotation.y, obj3D.rotation.z),
												new Number3D(obj3D.scale.x, obj3D.scale.y, obj3D.scale.z),
												Boolean(parseInt(obj3D.texture.hasTexture)), obj3D.texture.texturePath,
												obj3D.texture.width, obj3D.texture.height,
												Boolean(parseInt(obj3D.audio.hasAudio)), obj3D.audio.audioPath, 
												Boolean(parseInt(obj3D.audio.repeatAudio)), Boolean(parseInt(obj3D.video.hasVideo)),
												obj3D.video.videoPath, obj3D.video.width, obj3D.video.height, Boolean(parseInt(obj3D.video.repeatVideo)),
												hasAnimation, animationPeriod, animationAxis, animationRadius, animationRotDirection);
			}
		}
	}	
}