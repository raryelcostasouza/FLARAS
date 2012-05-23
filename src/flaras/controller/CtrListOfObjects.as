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

package flaras.controller 
{
	import flaras.entity.*;
	import flaras.entity.object3D.*;
	import org.papervision3d.core.math.*;
	
	public class CtrListOfObjects 
	{
		private var listOfObjects:Vector.<Object3D> = new Vector.<Object3D>();
		private var point:Point;
		
		public function CtrListOfObjects(point:Point)
		{
			this.point = point;
		}
	
		public function addObject(pFilePath:String, pTranslation:Number3D, pRotation:Number3D, 
										pScale:Number3D, pHasTexture:Boolean, pTexturePath:String, pTextureWidth:Number, pTextureHeight:Number, 
										pHasAudio:Boolean, pAudioPath:String, pRepeatAudio:Boolean, pHasVideo:Boolean, pVideoPath:String,
										pVideoWidth:Number, pVideoHeight:Number, pRepeatVideo:Boolean,
										pHasAnimation:Boolean = false, pAnimationPeriod:Number = 10, pAnimationRotationAxis:uint = Animation.X_ROTATION_AXIS):void
		{
			var obj3D:Object3D = buildObject3D(pFilePath, pTranslation, pRotation,
									pScale, pHasTexture, pTexturePath, pTextureWidth, pTextureHeight, 
									pHasAudio, pAudioPath, pRepeatAudio, 
									pHasVideo, pVideoPath, pVideoWidth, pVideoHeight, pRepeatVideo,
									pHasAnimation, pAnimationPeriod, pAnimationRotationAxis);

			listOfObjects.push(obj3D);
		}
		
		//function used to rebuild a new object 3D with the right decorators 
		//for example if the object is initially a texture, and the user want to change it to a video
		public function rebuildObject3D(pObjectIndex:uint, pFilePath:String, pTranslation:Number3D, pRotation:Number3D, 
										pScale:Number3D, pHasTexture:Boolean, pTexturePath:String, pTextureWidth:Number, pTextureHeight:Number, 
										pHasAudio:Boolean, pAudioPath:String, pRepeatAudio:Boolean, pHasVideo:Boolean, pVideoPath:String,
										pVideoWidth:Number, pVideoHeight:Number, pRepeatVideo:Boolean,
										pHasAnimation:Boolean, pAnimationPeriod:Number, pAnimationRotationAxis:uint):void
		{
			var obj3DBefore:Object3D;
			var obj3DNew:Object3D;
			var fullRebuildNeeded:Boolean = false;
							
			obj3DBefore = listOfObjects[pObjectIndex];
			var facObj3DBefore:FacadeObject3D = new FacadeObject3D(obj3DBefore);
			
			// if there has been no changes (add or remove changes only) regarding audio files
			if ((!facObj3DBefore.hasAudio() && !pHasAudio) || (facObj3DBefore.hasAudio() && pHasAudio))
			{
				trace("no Add or Remove AudioChange");
				
				//if just changed the texture file path
				if (facObj3DBefore.hasTexture() && pHasTexture && facObj3DBefore.getTexturePath() != pTexturePath)
				{
					trace("TextureUpdate")
					facObj3DBefore.setTexturePath(pTexturePath);
				}
				//if just changed the video file path
				else if (facObj3DBefore.hasVideo() && pHasVideo && facObj3DBefore.getVideoPath() != pVideoPath)
				{
					trace("videoUpdate")
					facObj3DBefore.setVideoPath(pVideoPath);
				}
				//if just changed the object3d file path
				else if ((!facObj3DBefore.hasVideo() && !pHasVideo) &&
							(!facObj3DBefore.hasTexture() && !pHasTexture) &&
							(facObj3DBefore.getFilePath() != pFilePath))
				{
					trace("object3D update" )
					facObj3DBefore.setFilePath(pFilePath);
				}
				// if just changed the audio file path
				else if (facObj3DBefore.getAudioPath() != pAudioPath)
				{
					trace("audio update")
					facObj3DBefore.setAudioPath(pAudioPath);
				}
				/*
				 * a critical changed happened:
			     * object type before -> object type after
				 * 1) Object3D -> Texture or
				 * 2) Object3D -> Video or
				 * 3) Texture -> Object3D or
				 * 4) Texture -> Video or
				 * 5) Video -> Object3D or
				 * 6) Video -> Texture
				*/				
				else 
				{
					trace("critical change")
					fullRebuildNeeded = true;
					// if the object is associated with an audio file, the audio file must not be deleted
					if (facObj3DBefore.hasAudio())
					{
						trace("critical not remove audio")
						facObj3DBefore.unLoadAndRemoveFile(AudioDecorator.DONT_REMOVE_AUDIO_FILE);
					}
					//if the object is not associated with an audio file, everything can be removed
					else
					{
						trace("critical remove audio")
						// as the object is not associated with any audio file, we can remove everything
						facObj3DBefore.unLoadAndRemoveFile(AudioDecorator.REMOVE_AUDIO_FILE);
					}
				}
			}
			//if audio file was added or removed
			else
			{
				fullRebuildNeeded = true;
				//if it was added an audio file
				if (!facObj3DBefore.hasAudio() && pHasAudio)
				{
					trace("audio added")
					facObj3DBefore.unLoad();
				}
				//if the audio file was removed
				else
				{
					trace("audio removed")
					facObj3DBefore.unLoad();
					facObj3DBefore.removeAudioFile();	
				}
			}
			
			if (fullRebuildNeeded)
			{
				obj3DNew = buildObject3D(pFilePath, pTranslation, pRotation,
									pScale, pHasTexture, pTexturePath, pTextureWidth, pTextureHeight, 
									pHasAudio, pAudioPath, pRepeatAudio, 
									pHasVideo, pVideoPath, pVideoWidth, pVideoHeight, pRepeatVideo,
									pHasAnimation, pAnimationPeriod, pAnimationRotationAxis);
				obj3DBefore.disableObject();
				listOfObjects[pObjectIndex] = obj3DNew;
			}
		}
		
		private function buildObject3D(pFilePath:String, pTranslation:Number3D, pRotation:Number3D, 
										pScale:Number3D, pHasTexture:Boolean, pTexturePath:String, pTextureWidth:Number, pTextureHeight:Number, 
										pHasAudio:Boolean, pAudioPath:String, pRepeatAudio:Boolean, pHasVideo:Boolean, pVideoPath:String,
										pVideoWidth:Number, pVideoHeight:Number, pRepeatVideo:Boolean,
										pHasAnimation:Boolean, pAnimationPeriod:Number, pAnimationRotationAxis:uint):Object3D
		{
			var obj3D:Object3D;
			var animation:Animation;
			
			animation = new Animation(pHasAnimation, pAnimationPeriod, pAnimationRotationAxis);
			obj3D = new ConcreteObject3D(this.point, pFilePath, pTranslation, pRotation, pScale, animation);
			
			//It's essential to apply Video Decorator or Texture Decorator before Audio Decorator because on them we don't call super statement
			//on the overriden methods because there is no Collada file associated to the point.
			if (pHasVideo && !pHasTexture)
			{
				obj3D = new VideoDecorator(obj3D, pVideoPath, pVideoWidth, pVideoHeight, pRepeatVideo);
			}
			else
			{
				if (!pHasVideo && pHasTexture)
				{
					obj3D = new TextureDecorator(obj3D, pTexturePath, pTextureWidth, pTextureHeight);
				}
			}
			
			if (pHasAudio)
			{
				obj3D = new AudioDecorator(obj3D, pAudioPath, pRepeatAudio);
			}
			
			return obj3D;
		}
		
		public function removeObject(pIndex:uint):void
		{
			var facObj3D:FacadeObject3D;
			
			facObj3D = new FacadeObject3D(listOfObjects[pIndex]);
			facObj3D.unLoadAndRemoveFile(AudioDecorator.REMOVE_AUDIO_FILE);
			
			point.setIndexActiveObject(0);
			point.setIndexLastActiveObject(0);
			
			//remove from the list of objects 1 element, starting from the pIndex position
			listOfObjects.splice(pIndex, 1);
		}
		
		public function swapObjectPositionTo(indexObjSource:uint, indexObjDestination:uint):void
		{
			var sourceObject:Object3D;
			var destinationObject:Object3D;
			
			sourceObject = listOfObjects[indexObjSource];
			sourceObject.disableObject();
			destinationObject = listOfObjects[indexObjDestination];
			
			listOfObjects[indexObjSource] = destinationObject;
			listOfObjects[indexObjDestination] = sourceObject;
		}
		
		public function getListOfObjects():Vector.<Object3D>
		{
			return listOfObjects;
		}		
	}
}