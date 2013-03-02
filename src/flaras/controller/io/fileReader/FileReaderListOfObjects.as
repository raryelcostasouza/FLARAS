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

package flaras.controller.io.fileReader
{
	import flaras.controller.*;
	import flaras.controller.constants.*;
	import flaras.controller.io.*;
	import flaras.model.scene.AnimationScene;
	import flash.errors.*;
	import flash.events.*;
	import flash.filesystem.*;
	import flash.net.*;
	import org.papervision3d.core.math.*;
		
	public class FileReaderListOfObjects extends FileReader
	{		
		private var aIndexBuffer:uint;
		private var _filePath:String;
		
		public function FileReaderListOfObjects(pIndexBuffer:uint, pFilePath:String, pObjCtrPoint:CtrPoint)
		{
			super(pObjCtrPoint);
			aIndexBuffer = pIndexBuffer;
			_filePath = pFilePath;
			readFile(pFilePath);			
		}
		
		private function readFile(pFilePath:String):void
		{
			var fileLoader:URLLoader = new URLLoader(new URLRequest(pFilePath));
			
			fileLoader.addEventListener(Event.COMPLETE, onComplete);
            fileLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError); 
            fileLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError); 
		}
	
		private function onComplete(e:Event):void
		{	
			e.target.removeEventListener(Event.COMPLETE, onComplete);
			e.target.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			e.target.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			
			aXMLFile = XML(e.target.data);
			
			for each (var obj3D:XML in aXMLFile.object3D) 
			{			
				var hasAnimation:Boolean;
				var animationPeriod:Number;
				var animationAxis:uint;
				var animationRadiusA:Number;
				var animationRadiusB:Number;
				var animationRotDirection:int;
				var obj3DFile:File;
				var flarasTempFolder:File;
				var newFilePath:String;
				var label:String;	
				var idNumber:int;
				var animationType:String;
				var p2pAnimationDisplacement:Number3D;
				var p2pAnimationTime:Number;
				var p2pAnimationLoop:Boolean;
				
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
					
					if (obj3D.animation.type == undefined)
					{
						animationType = AnimationScene.TYPE_CIRCULAR;
						//flaras project with partial animation support	
						if (obj3D.animation.radius == undefined && obj3D.animation.rotationDirection == undefined)
						{
							animationPeriod = obj3D.animation.period;
							animationAxis = obj3D.animation.rotationAxis;
						
							animationRadiusA = 0;
							animationRadiusB = 0;
							animationRotDirection = 1;
						}
						//previous flaras project (support for radius and rotationDirection)
						else if (obj3D.animation.radiusB == undefined)
						{
							animationPeriod = obj3D.animation.period;
							animationAxis = obj3D.animation.rotationAxis;
						
							animationRadiusA = obj3D.animation.radius;
							animationRadiusB = obj3D.animation.radius;
							animationRotDirection = obj3D.animation.rotationDirection;
						}
						//elliptical animation
						else
						{
							animationPeriod = obj3D.animation.period;
							animationAxis = obj3D.animation.rotationAxis;
						
							
							animationRadiusA = obj3D.animation.radius;
							animationRadiusB = obj3D.animation.radiusB;
							animationRotDirection = obj3D.animation.rotationDirection;
						}
					}
					//after adding point 2 point animation support
					else
					{
						animationType = obj3D.animation.type;
						if (obj3D.animation.type == AnimationScene.TYPE_CIRCULAR)
						{
							p2pAnimationDisplacement = Number3D.ZERO;
							p2pAnimationTime = 0;
							p2pAnimationLoop = false;
							
							animationPeriod = obj3D.animation.circular.period;
							animationAxis = obj3D.animation.circular.rotationAxis;							
							animationRadiusA = obj3D.animation.circular.radius;
							animationRadiusB = obj3D.animation.circular.radiusB;
							animationRotDirection = obj3D.animation.circular.rotationDirection;
						}
						else
						{
							p2pAnimationDisplacement = new Number3D(obj3D.animation.point2point.displacement.x, 
																	obj3D.animation.point2point.displacement.y, 
																	obj3D.animation.point2point.displacement.z);
							p2pAnimationTime = obj3D.animation.point2point.time;
							p2pAnimationLoop = new Boolean(parseInt(obj3D.animation.point2point.loop));
							
							animationPeriod = 0;
							animationAxis = 0;
							animationRadiusA = 0;
							animationRadiusB = 0;
							animationRotDirection = 0;
						}
					}
				}
				
				if (obj3D.idNumber == undefined)
				{
					idNumber = -1;
				}
				else
				{
					idNumber = parseInt(obj3D.idNumber);
				}
				
				if (obj3D.label == undefined)
				{
					label = "";
				}
				else
				{
					label = obj3D.label;
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
												hasAnimation, animationPeriod, animationAxis, animationRadiusA, animationRadiusB, animationRotDirection, 
												animationType, p2pAnimationDisplacement, p2pAnimationTime, p2pAnimationLoop,
												label, idNumber, true);
			}
			aObjCtrPoint.finishedReadingListOfScenes();
		}
		
		private function onIOError(e:Event):void
		{
			ErrorHandler.onIOError("FileReaderListOfScenes", _filePath);
		}
		
		private function onSecurityError(e:Event):void
		{
			ErrorHandler.onSecurityError("FileReaderListOfScenes", _filePath);
		}
	}	
}